#!/bin/bash

rsync -avz -e "ssh -i <private-keypair.pem>" /path/to/local/static.zip <username>@<server-ip>:~
