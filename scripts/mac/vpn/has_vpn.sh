#!/usr/bin/env bash

# Command to check if VPN exists
# ip addr show | grep tun
#
# Example output of no VPN:
# utun0: flags=8051<UP,POINTOPOINT,RUNNING,MULTICAST> mtu 1380
# utun1: flags=8051<UP,POINTOPOINT,RUNNING,MULTICAST> mtu 2000
# utun2: flags=8051<UP,POINTOPOINT,RUNNING,MULTICAST> mtu 1000
# utun3: flags=8051<UP,POINTOPOINT,RUNNING,MULTICAST> mtu 1500
#
# Example output with VPN:
# utun0: flags=8051<UP,POINTOPOINT,RUNNING,MULTICAST> mtu 1380
# utun1: flags=8051<UP,POINTOPOINT,RUNNING,MULTICAST> mtu 2000
# utun2: flags=8051<UP,POINTOPOINT,RUNNING,MULTICAST> mtu 1000
# utun3: flags=8051<UP,POINTOPOINT,RUNNING,MULTICAST> mtu 1500
# utun4: flags=8051<UP,POINTOPOINT,RUNNING,MULTICAST> mtu 1280
#         inet 100.78.7.139 --> 100.78.7.139/32 utun4



function has_vpn() {
    ip addr show | grep tun | grep '\-->' &> /dev/null
}
