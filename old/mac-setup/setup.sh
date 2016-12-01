#!/bin/bash

# Remove dock show/hide delay
defaults write com.apple.Dock autohide-delay -float 0 && killall Dock
# Disable opening and closing window animations
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
# Disable Mission Control animations
defaults write com.apple.dock expose-animation-duration -int 0
# Increase window resize speed for Cocoa applications
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
# Don't animate applications opening from the dock
defaults write com.apple.dock launchanim -bool false
