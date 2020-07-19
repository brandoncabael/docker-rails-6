# Use Brandon's Ruby base image (includes jemalloc)
FROM brandoncabael/docker-ruby-2.7:2.7.1-slim

# Baller maintainer
LABEL maintainer "Brandon Cabael <brandon.cabael@gmail.com>"

# Set EDITOR default to vim (used when editing env via sops)
ENV EDITOR vim

# Use generic /app path for working directory
ENV INSTALL_PATH /app
RUN mkdir -p $INSTALL_PATH
WORKDIR $INSTALL_PATH

# Run system package installations
RUN set -eux; \
  apt-get update; \
  apt-get install -y --no-install-recommends \
    build-essential \
    ghostscript \
    git \
    gnupg2 \
    graphviz \
    libvips \
    libvips-dev \
    libpq-dev \
    vim \
  ; \
  gem install bundler;

COPY vimrc /root/.vimrc

CMD bundle exec puma -C config/puma.rb