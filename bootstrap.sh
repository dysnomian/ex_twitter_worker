#!/bin/bash

#####
# Elixir bootstrap
#####

# System stuff
echo "Adding ppas and other pre-update packages..."
sudo add-apt-repository ppa:martin-frost/thoughtbot-rcm
wget http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
sudo dpkg -i erlang-solutions_1.0_all.deb

echo "Updating apt..."
sudo apt-get update

echo "Installing system packages."
sudo apt-get install -y git vim tmux zsh rcm redis-server elixir

# Ruby environment
echo "Setting up Ruby installer."
mkdir $HOME/bin
cd $HOME/bin
curl -O ruby-install-0.5.0.tar.gz https://github.com/postmodern/ruby-install/archive/v0.5.0.tar.gz
curl -O chruby-0.3.9.tar.gz https://github.com/postmodern/chruby/archive/v0.3.9.tar.gz
tar -xzvf chruby-0.3.9.tar.gz
tar -xzvf ruby-install-0.5.0.tar.gz
cd ruby-install
sudo make install
cd chruby-0.3.9/
sudo make install
sudo ./scripts/setup.sh

# Install dotfiles (assumes Ruby for rcm)
echo "Installing dotfiles..."
gem install bundler mustache
git clone https://github.com/dysnomian/polka.git $HOME/src/polka
cd $HOME/src/polka
yes | env RCRC=$HOME/src/polka/rcrc rcup
sudo chsh -s $(which zsh) vagrant

# Install project
echo "Installing project..."
git clone https://github.com/dysnomian/ex_twitter_worker.git $HOME/src/ex_twitter_worker

# Configure project
echo "Configuring project..."
cd $HOME/src/ex_twitter_worker
mix deps.get -y
redis-server &

echo "All done! Connect with vagrant ssh."
