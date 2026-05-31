# Dockerfile with SteamRT3
FROM        registry.gitlab.steamos.cloud/steamrt/sniper/platform:latest-container-runtime-depot
LABEL       author="K4ryuu @ KitsuneLab" \
            maintainer="k4ryuu@icloud.com" \
            org.opencontainers.image.description="The SteamRT3 Platform image for Pterodactyl CS2 servers is packed with numerous features, designed to simplify server management and reduce hassle." \
            org.opencontainers.image.source="https://github.com/K4ryuu/CS2-Egg"

# Prep OS
RUN         mkdir -p /etc/sudoers.d && \
            echo "%sudo ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/flatdeb && \
            chmod 0440 /etc/sudoers.d/flatdeb

ENV         DEBIAN_FRONTEND=noninteractive
RUN apt update && \
    apt install -y \
        libgtk-3-0=3.24.24-4+steamrt3.2 \
        libpango-1.0-0=1.46.2-3+steamrt3.2 \
        libpangoft2-1.0-0 \
        libpangocairo-1.0-0 \
        zenity \
        binutils && \
	apt-get clean

# Create directories and copy files
RUN         mkdir -p /scripts /utils
COPY        ./scripts /scripts/
COPY        ./utils /utils/
COPY        ./entrypoint.sh /entrypoint.sh

# Set permissions (read-only + executable)
RUN         chmod 555 /scripts/*.sh && \
            chmod 555 /scripts/updaters/*.sh && \
            chmod 555 /utils/*.sh && \
            chmod 555 /entrypoint.sh

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

CMD         [ "/bin/bash", "/entrypoint.sh" ]
