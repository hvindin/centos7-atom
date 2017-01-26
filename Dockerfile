FROM docker.io/centos:latest
ENV ATOM_VERSION=1.13.0 TERM=xterm-256color
COPY dumb-init /usr/bin/dumb-init
RUN yum fs filter languages en:US && yum fs filter documentation \
    && yum install -y epel-release && chmod +x /usr/bin/dumb-init \
    && yum install -y libXScrnSaver ca-certificates curl mesa-dri-drivers \
      GConf2 gtk2 git glib2 libconfig libxkbfile nss alsa-plugins-pulseaudio \
      libnotify xdg-utils dbus-libs dbus-x11 dbus dbus-glib PackageKit-gtk3-module \
      libcanberra-gtk2 webkitgtk webkitgtk3 pulseaudio-utils xulrunner-devel \
      python-libs liberation-fonts-common liberation-sans-fonts libcap redhat-lsb \
      libgnome-keyring-devel ibus-gtk2 gtk+ libXtst fakeroot libwebkit2gtk \
      mesa-libglapi mesa-libGL llvm-libs mesa-libGL-devel xorg-x11-server-Xorg libdrm \
      "https://github.com/atom/atom/releases/download/v${ATOM_VERSION}/atom.x86_64.rpm" 2>&1 \
    && yum clean all -y 2>&1 && useradd --shell /usr/bin/bash -d /home/atom -m atom 2>&1 && dbus-uuidgen > /etc/machine-id
LABEL base.os="centos7" base.version="7.3.1611" atom.version=$ATOM_VERSION
USER atom
ENTRYPOINT ["/usr/bin/dumb-init","--","dbus-launch","--exit-with-session","--sh-syntax","--close-stderr", "/usr/bin/atom"]
CMD ["--foreground"]
