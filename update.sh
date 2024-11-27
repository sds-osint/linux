#!/bin/sh

sudo bash -c 'apt update && apt upgrade -y && apt autoremove -y && apt autoclean'