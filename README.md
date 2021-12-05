# image_boinc-client

Dockerfile for BOINC client on Debian 11 with VirtualBox, AMD and Nvidia GPGPU support.

## Building

Build the image `debian-gpgpu` first. See https://github.com/michaelfranzl/image_debian-gpgpu

Then:

```sh
docker build -t boinc-client .
```

## Host preparation for VirtualBox support (optional)

Some BOINC projects require VirtualBox (e.g. LHC@home, Rosetta@home). To support those, you need to
set up a working Linux kernel module for VirtualBox in the *host* system first:

```sh
apt install virtualbox-dkms
```

## Running

The data directory and all its contents need to be read- and writeable to the `boinc` user of the
container.

```sh
docker run -name boincclient0 -v /path/to/boinc-client-data:/var/lib/boinc-client boinc-client
```

* To expose AMD GPU(s) to the container, add the Docker argument `--device /dev/dri:/dev/dri`.
* To expose Nvidia GPU(s) to the container, add the Docker argument `--gpus all`. You need an
addition to Docker for the `--gpus` argument. See
https://github.com/michaelfranzl/image_debian-gpgpu#exposing-nvidia-gpus-to-containers
* To expose the VirtualBox kernel module to the container, add the Docker argument `--device
/dev/vboxdrv:/dev/vboxdrv`.

The configuration of BOINC (authentication, remote-controlling, etc.) is out of scope for this
README; however, I can recommend installing `boinctui` to control BOINC inside the container from
your host's terminal. See also https://boinc.berkeley.edu/wiki/Controlling_BOINC_remotely . If you
do want to allow remote control, you need to pass boinc's argument `--allow_remote_gui_rpc` to the
end of `docker run`.
