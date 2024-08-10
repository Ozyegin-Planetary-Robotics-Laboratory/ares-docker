#!/usr/bin/bash

trap "kill 0" SIGINT

# Start the broadcast
ssh kaine@ares 'bash -s' < /broadcast

# Start the reception
