FROM mesopotamia/alpine:3.6
MAINTAINER Guillermo Rodríguez Cano <gurc@kth.se>

# What do you want to install?
# Note that texlive is not yet available in Alpine 3.6, only in edge:testing
ENV PACKAGES="texlive \
              biber \
              fontconfig"
 
# Backup the current repository sources list
# It could be done with ENV if it was supported (see https://github.com/moby/moby/issues/29110)
RUN cp /etc/apk/repositories /tmp/

# Configure resositories sources list to edge
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" > /etc/apk/repositories \
    && echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
    && echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

# Install TeXLive
RUN apk add --no-cache --update \
        ${PACKAGES} \
    && rm -rf /var/cache/apk/*

# Restore the repository sources list
RUN cp /tmp/repositories /etc/apk/repositories \
    && rm /tmp/repositories
