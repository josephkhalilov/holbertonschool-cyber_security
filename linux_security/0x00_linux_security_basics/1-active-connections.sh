#!/bin/bash
# 1. Privileged user (sudo)
# 2. All sockets (listening and non-listening) -> -a
# 3. Numerical addresses (IP and Port) -> -n
# 4. TCP sockets -> -t
# 5. Process information -> -p
sudo ss -antp
