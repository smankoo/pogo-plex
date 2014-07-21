#!/bin/bash
date
echo Restarting ddclient
systemctl restart ddclient
systemctl status ddclient

