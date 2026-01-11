#!/bin/bash
c=$(swaync-client -c)
echo "{\"text\":\"$c\"}"