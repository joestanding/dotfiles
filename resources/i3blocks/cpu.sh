#!/bin/bash

mpstat 1 1 | awk '{print $3,$4,$5,$6,$7,$8,$9,$10,$11}' | tail -n 1 | printf "%0.2f%%" "`awk '{print $1 + $3}'`"
