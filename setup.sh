#! /usr/bin/env bash

# llvm-gcc
if `type -P llvm-gcc &>/dev/null`; then
  echo "Command Line Tools found."
else
  echo "Command Line Tools not found."
  echo "Please go https://developer.apple.com/downloads and install **Command Line Tools for Xcode**" && exit 0;
fi

# xcode-select (Used by gems like libv8)
if `xcode-select --print-path &>/dev/null`; then
  echo "Xcode path detected."
else
  echo "Xcode path not detected. Setting a fake one..."
  sudo xcode-select --switch /
fi

# Homebrew
if `type -P brew &>/dev/null`; then
  echo "Homebrew found."
else
  echo "Homebrew not found. Installing..."
  ruby <(curl -fsS https://raw.github.com/mxcl/homebrew/go)

  echo "Put Homebrew location earlier in PATH (Bash by default)..."
  echo "export PATH='/usr/local/bin:$PATH'" >> ~/.bash_profile
  source ~/.bash_profile

  brew update
fi

# rbenv
if `type -P wget &>/dev/null`; then
  echo "wget found."
else
  echo "wget not found. Installing..."
  brew install wget
fi

# rbenv
if `type -P rbenv &>/dev/null`; then
  echo "rbenv found."
else
  echo "rbenv not found. Installing..."
  brew install rbenv

  echo "Put rbenv init in shell profile (Bash by default)..."
  echo "if which rbenv > /dev/null; then eval \"\$(rbenv init -)\"; fi" >> ~/.bash_profile
  source ~/.bash_profile
fi

# Ruby 1.9.3-p327
if [[ `rbenv versions` =~ '1.9.3-p327' ]]; then
  echo "Ruby 1.9.3-p327 found."
else
  echo "Ruby 1.9.3-p327 not found. Installing..."

  # ruby-build
  if `type -P ruby-build &>/dev/null`; then
    echo "ruby-build found."
  else
    echo "ruby-build not found. Installing..."
    brew install ruby-build
  fi

  rbenv install 1.9.3-p327
fi

echo "Set current ruby version to 1.9.3-p327"
rbenv global 1.9.3-p327

# MySQL
if `type -P mysqld &>/dev/null`; then
  echo "MySQL found."
else
  echo "MySQL not found. Installing..."
  brew install mysql
  unset TMPDIR
  mysql_install_db --verbose --user=`whoami` --basedir="$(brew --prefix mysql)" --datadir=/usr/local/var/mysql --tmpdir=/tmp
fi

# Starting MySQL
if [[ `ps x` =~ 'mysqld' ]]; then
  echo "MySQL process found."
else
  echo "MySQL process not found. Setting up..."
  if [[ -e ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist ]]; then
    echo "MySQL launch agent plist found."
  else
    echo "MySQL launch agent plist not found. Installing..."
    mkdir -p ~/Library/LaunchAgents
    cp `ls /usr/local/Cellar/mysql/*/homebrew.mxcl.mysql.plist | tail -1` ~/Library/LaunchAgents/
  fi
  launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist
fi

# ImageMagick
if `type -P convert &>/dev/null`; then
  echo "ImageMagick found."
else
  echo "ImageMagick not found. Installing..."
  brew install imagemagick
fi

# Redis
if `type -P redis-server &>/dev/null`; then
  echo "Redis found."
else
  echo "Redis not found. Installing..."
  brew install redis
fi

# Starting Redis
if [[ `ps x` =~ 'redis-server' ]]; then
  echo "Redis process found."
else
  echo "Redis process not found. Setting up..."
  if [[ -e ~/Library/LaunchAgents/homebrew.mxcl.redis.plist ]]; then
    echo "Redis launch agent plist found."
  else
    echo "Redis launch agent plist not found. Installing..."
    mkdir -p ~/Library/LaunchAgents
    cp `ls /usr/local/Cellar/redis/*/homebrew.mxcl.redis.plist | tail -1` ~/Library/LaunchAgents/
  fi
  launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.redis.plist
fi

# Git config
echo "Enabling git color output..."
git config --global color.ui true

# Bundler
if `type -P bundle &>/dev/null`; then
  echo "Bundler found."
else
  echo "Bundler not found. Installing..."
  gem install bundler --no-rdoc --no-ri
  rbenv rehash
fi

# Rails
if `type -P rails &>/dev/null` && [[ ! `which rails` =~ '/usr/bin/rails' ]]; then
  echo "Rails found."
else
  echo "Rails not found. Installing..."
  gem install rails --no-rdoc --no-ri
  rbenv rehash
fi

# Powder
if `type -P powder &>/dev/null`; then
  echo "Powder found."
else
  echo "Powder not found. Installing..."
  gem install powder
  rbenv rehash
fi

# Powconfig
echo "Writing rbenv pathes to ~/.powconfig..."
echo "export PATH=/Users/$USER/.rbenv/shims:/Users/$USER/.rbenv/bin:\$PATH" >> ~/.powconfig 

# Pow
if [[ `powder up` =~ 'missing' ]]; then
  echo "Pow not found. Installing..."
  powder install
else
  echo "Pow was already started."
fi

echo "Everyting done. You're ready to go!"
