#!/usr/bin/env bash

# Xcode
if `ls /Applications/ | grep Xcode &> /dev/null`; then
  echo "Found Xcode"
else
  echo "Please go to https://developer.apple.com/xcode/downloads/ and install Xcode."
  exit 0;
fi

# Command line tools
if `type -P llvm-gcc &> /dev/null`; then
  echo "Found command line tools"
else
  echo "Please open Xcode and install command line tools. Then run the script again."
  open /Applications/Xcode.app
  exit 0;
fi

# Homebrew
if `type -P brew &> /dev/null`; then
  echo "Found Homebrew"
else
  echo "Installing Homebrew..."
  ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
  brew update
  brew doctor
fi

# Brew cask
if `type -P brew-cask &> /dev/null`; then
  echo "Found brew-cask"
else
  echo "Installing brew-cask..."
  brew install caskroom/cask/brew-cask
fi

# rbenv
rake brew:install[rbenv]
rake brew:install[ruby-build]

if ! `type -P rbenv &> /dev/null`; then
  echo "Put rbenv init in shell profile (Bash by default)..."
  echo "if which rbenv > /dev/null; then eval \"\$(rbenv init -)\"; fi" >> ~/.bash_profile
  source ~/.bash_profile
fi

# Ruby 2.1.5
RUBY_VERSION="2.1.5"

if [[ `rbenv versions` =~ $RUBY_VERSION ]]; then
  echo "Found Ruby $RUBY_VERSION"
else
  brew upgrade ruby-build
  rbenv install $RUBY_VERSION
  rbenv rehash
fi

rbenv global $RUBY_VERSION


FORMULAE=( "git" "hub" "git-flow" "xctool" "xcproj" "ios-sim" )
for formula in "${FORMULAE[@]}"
do
  rake brew:install[$formula]
done

APPS=( "Crashlytics" "MacDown" )
for app in "${APPS[@]}"
do
  rake brew:cask:install[$app]
done

GEMS=( "cocoapods" "xcpretty" "slather" )
for gem in "${GEMS[@]}"
do
  rake gem:install[$gem]
done
