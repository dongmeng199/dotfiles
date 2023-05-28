#!/bin/bash

ln -s ./nvim ~/.config/nvim
cp ./plist/limit.maxfiles.plist /Library/LaunchDaemons/limit.maxfiles.plist
sudo launchctl load -w /Library/LaunchDaemons/limit.maxfiles.plist

