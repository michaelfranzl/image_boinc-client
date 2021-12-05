# See https://github.com/michaelfranzl/image_debian-gpgpu
FROM debian-gpgpu

# Install BOINC client with OpenCL support.
RUN apt install -y --no-install-recommends boinc-client-opencl boinc-client; \
    usermod -a -G render boinc

# Install VirtualBox for BOINC projects which require it (e.g. LHC@home, Rosetta@home).
# For more information, see https://wiki.debian.org/VirtualBox
RUN echo "deb https://fasttrack.debian.net/debian-fasttrack/ bullseye-fasttrack main contrib" >> /etc/apt/sources.list; \
    echo "deb https://fasttrack.debian.net/debian-fasttrack/ bullseye-backports-staging main contrib" >> /etc/apt/sources.list; \
    apt install -y fasttrack-archive-keyring && apt update && apt install -y --no-install-recommends boinc-virtualbox virtualbox

EXPOSE 31416

USER boinc

# You can append --allow_remote_gui_rpc by passing it to `docker run`
ENTRYPOINT ["boinc", "--dir", "/var/lib/boinc"]

LABEL license="MIT"
LABEL author="Copyright 2022 Michael K. Franzl <michael@franzl.name>"
LABEL description="BOINC client with VirtualBox, AMD and Nvidia GPGPU support"
