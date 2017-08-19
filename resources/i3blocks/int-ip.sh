#!/bin/bash

ip addr show dev eth0 | grep 'inet ' | xargs | cut -d ' ' -f2
