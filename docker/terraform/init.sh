#!/bin/bash

source /root/.bashrc


if [[ ! -e /root/.aws/config ]]; then
    mv /root/.aws/config.default /root/.aws/config
fi
