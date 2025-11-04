#!/bin/bash


set -euo pipefail

WEBSITES_FILE="websites.txt"
WARNING_DAYS="${1:-30}"  # Default 30 days if not provided


# Function to check certificate expiry
check_cert() {
    local host=$1
    local port=443

    # Get expiry date using openssl
    expiry_date=$(echo | openssl s_client -servername "$host" -connect "$host:$port" 2>/dev/null \
                  | openssl x509 -noout -dates 2>/dev/null | grep 'notAfter' | cut -d= -f2)

    if [ -z "$expiry_date" ]; then
        echo "$host | N/A | ERROR"
        return
    fi

    # Convert to seconds both expire date and now. 
    expiry_seconds=$(date -d "$expiry_date" +%s)
    now_seconds=$(date +%s)
    # Calculate the difference and convert to days
    days_left=$(( (expiry_seconds - now_seconds) / 86400 ))

    status="OK"
    if [ $days_left -le 0 ]; then
        status="EXPIRED"
    elif [ $days_left -le $WARNING_DAYS ]; then
        status="WARNING"
    fi

    printf "%-30s %-25s %-10s\n" "$host" "$expiry_date" "$status"
}

# Check if config file exists
if [[ ! -f "$WEBSITES_FILE" ]]; then
    echo -e "Config file $WEBSITES_FILE not found!"
    exit 1
fi

echo "Checking SSL certificates..."
echo "Warning threshold: ${WARNING_DAYS} days"
echo
echo -e "Website                        Expiry Date               Status"
echo "------------------------------------------------------------------"

# Loop through websites
while IFS= read -r site; do
    [ -z "$site" ] && continue
    check_cert "$site"
done < "$WEBSITES_FILE"