#!/bin/bash


[ -z "$(which brew)" ] && /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew analytics off

[ -z "$(which nix)" ] && /bin/bash -c "$(curl -L https://nixos.org/nix/install)"
rm -r ~/.config/nvim
ln -s ./nvim ~/.config/nvim
cp ./plist/limit.maxfiles.plist /Library/LaunchDaemons/limit.maxfiles.plist
sudo launchctl load -w /Library/LaunchDaemons/limit.maxfiles.plist

