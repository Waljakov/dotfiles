#!/bin/sh

sudo tlp-stat -b | grep -oP '(power_now *= *)\K(\d+ \[mW\])'
