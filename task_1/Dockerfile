# Use official Debian base image
FROM debian:bookworm-slim

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    openssl \
    curl \
    coreutils \
    ca-certificates \
 && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy files(script and websites.txt)
COPY cert_checker.sh websites.txt ./

# Make script executable
RUN chmod +x cert_checker.sh

# Default command
ENTRYPOINT ["./cert_checker.sh"]