#!/bin/bash

# System stuff
echo "Adding ppas and other pre-update packages..."
sudo add-apt-repository ppa:martin-frost/thoughtbot-rcm
wget http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
sudo dpkg -i erlang-solutions_1.0_all.deb

echo "Updating apt..."
sudo apt-get update

echo "Installing system packages."
sudo apt-get install -y git vim tmux zsh rbenv rcm redis-server elixir

# Ruby environment
echo "Setting up Ruby installer."
git clone https://github.com/sstephenson/ruby-build.git $HOME/ruby-build
sudo $HOME/ruby-build/install.sh

# User files
echo "Entering userspace."
mkdir $HOME/src
rbenv install 2.2.1
gem install bundler mustache

# Install dotfiles
echo "Installing dotfiles..."
git clone https://github.com/dysnomian/polka.git $HOME/src/polka
cd $HOME/src/polka
yes | env RCRC=$HOME/src/polka/rcrc rcup

# Install project
echo "Installing project..."
git clone https://github.com/dysnomian/ex_twitter_worker.git $HOME/src/ex_twitter_worker

# Configure project
echo "Configuring project..."
cd $HOME/src/ex_twitter_worker
yes 'Y' | mix deps.get
redis-server &
