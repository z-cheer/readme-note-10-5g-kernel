ARG TAG=latest
FROM archlinux/archlinux:${TAG}

LABEL description="readme-note-10-5g-kernel" 

ARG HOSTNAME=0.0.0.0
ENV HOSTNAME=$HOSTNAME

ARG PORT=80
ENV PORT=$PORT

ARG GIT_NAME=zero
ENV GIT_NAME=$GIT_NAME

ARG GIT_EMAIL=zero.js.dev@gmai.com
ENV GIT_EMAIL=$GIT_EMAIL

# ARG NB_USER="builder"
# ARG NB_PASSWORD="builder"
# ARG NB_UID="1001"
# ARG NB_GID="100"
# RUN useradd -l -m -s /bin/bash -N -u "${NB_UID}" "${NB_USER}" -p $(openssl passwd -1 ${NB_PASSWORD})
# USER ${NB_USER}

USER root

RUN pacman-key --init && \
    pacman -Syu --noconfirm 

RUN pacman -S wget git ccache lzop python-networkx squashfs-tools \
pngcrush schedtool optipng maven pwgen minicom bc zip unzip --noconfirm 

RUN mkdir -p /opt/app/ && \
    mkdir -p /opt/app/dist/

COPY ./scripts /opt/app/
Run chmod -R 777 /opt/app/

RUN cd /opt/app/

RUN chmod +x /opt/app/entrypoint.sh
EXPOSE ${PORT}

ARG NB_USER="lfs"
ARG NB_PASSWORD="lfs"
ARG NB_UID="1000"
ARG NB_GID="1000"
RUN useradd -l -m -s /bin/bash -N -u "${NB_UID}" "${NB_USER}" -p $(openssl passwd -1 ${NB_PASSWORD})

# USER ${NB_USER}
ENTRYPOINT ["/opt/app/entrypoint.sh"]
