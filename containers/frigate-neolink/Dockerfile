FROM ghcr.io/blakeblackshear/frigate:0.17.1

# --- install runtime deps needed for neolink ---
RUN apt-get update && apt-get install -y --no-install-recommends \
    gstreamer1.0 \
    gstreamer1.0-tools \
    gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-plugins-ugly \
    ffmpeg \
    ca-certificates \
    bash \
    curl \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# --- install neolink binary ---
ARG NEOLINK_VERSION=v0.4.0

RUN curl -L \
    -o /tmp/neolink.zip \
    https://github.com/thirtythreeforty/neolink/releases/download/${NEOLINK_VERSION}/release-ubuntu-20.04.zip \
    && unzip /tmp/neolink.zip -d /tmp/neolink \
    && cp /tmp/neolink/neolink /usr/local/bin/neolink \
    && chmod +x /usr/local/bin/neolink \
    && rm -rf /tmp/neolink.zip /tmp/neolink

# --- create config directory ---
RUN mkdir -p /config/neolink

# --- copy talk script ---
COPY neolink_talk.sh /bin/neolink_talk.sh
RUN chmod +x /bin/neolink_talk.sh

# --- copy entrypoint ---
COPY docker/entrypoint.sh /docker/entrypoint.sh
RUN chmod +x /docker/entrypoint.sh

ENV NEOLINK_CONFIG=/config/neolink/neolink.toml

ENTRYPOINT ["/docker/entrypoint.sh"]
