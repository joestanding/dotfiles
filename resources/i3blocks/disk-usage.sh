#!/bin/bash

SIZE=`df -h | grep /dev/sda1 | sed 's/ \+/ /g' | sed 's/G/GB/g' | cut -d ' ' -f2`
USED=`df -h | grep /dev/sda1 | sed 's/ \+/ /g' | sed 's/G/GB/g' | cut -d ' ' -f3`
AVAIL=`df -h | grep /dev/sda1 | sed 's/ \+/ /g' | sed 's/G/GB/g' | cut -d ' ' -f4`
PERCENT=`df -h | grep /dev/sda1 | sed 's/ \+/ /g' | sed 's/G/GB/g' | cut -d ' ' -f5`

echo "$AVAIL left ($PERCENT)"
