# OpenVPN Docker Mod

An s6 v3 [docker-mod][linuxserver/docker-mods] for [LinuxServer.io] containers that establishes an OpenVPN connection on container startup.

## Usage

To use this mod, add the following environment variables to your [LinuxServer.io] container:

In docker arguments, set an environment variable `DOCKER_MODS=ghcr.io/eshork/universal-openvpn:latest` to enable.

If adding multiple mods, enter them in an array separated by `|`, such as `DOCKER_MODS=user/repo:tag|user/repo:tag`


## Settings
### Environment variables
- `OVPN_CONFIG`: Full path to the OpenVPN configuration file to use. Default is `/etc/openvpn/config`. (Provide this file to your container as a volume mount.)
- `OVPN_CREDENTIALS`: Full path to the credentials file to pass via `--auth-user-pass`. Default is `/etc/openvpn/credentials`. If not present, will not pass credentials. (Provide this file to your container as a volume mount.)
- `OVPN_KILLSWITCH`: If set to `true` or `1`, will implement a route-based traffic kill switch, attempting to prevent traffic leaking beyond your local network when the VPN tunnel is down.
- `OVPN_SPLIT_PRIVATE`: If set to `true` or `1`, will inject routes to preserve access to private network addresses (RFC1918) via the initial default route. Default is `false`.
- `OVPN_HALT_ON_FAILURE`: If set to `true` or `1`, will issue `halt` command to stop the container if the OpenVPN connection is lost or could not be established. Default will not attempt to stop the container.
- `OVPN_OPTS_ADD`: Additional options to append to the `openvpn` command. Default is empty.
- `OVPN_OPTS_OVERRIDE`: If set, will completely override the generated `openvpn` command arguments with the provided value. This is useful for advanced users who want full control over the `openvpn` command arguments, but is often not necessary. Default is empty.

## Misc

ONLY TESTED ON AN ALPINE BASED CONTAINER

Based on documentation from
- [linuxserver/docker-mods]
- [man 8 openvpn]
- [protonvpn linux-openvpn]
- [s6]
- [just-containers/s6-overlay]

[LinuxServer.io]: https://www.linuxserver.io/
[protonvpn linux-openvpn]: https://protonvpn.com/support/linux-openvpn
[linuxserver/docker-mods]: https://github.com/linuxserver/docker-mods
[just-containers/s6-overlay]: https://github.com/just-containers/s6-overlay
[man 8 openvpn]: https://manpages.org/openvpn/8
[s6]: https://skarnet.org/software/s6/index.html
