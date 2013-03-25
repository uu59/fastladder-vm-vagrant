# flvm cookbook

VM for [Fastladder](https://github.com/fastladder/fastladder).

# Requirements

* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* [Vagrant](http://downloads.vagrantup.com/)(Maybe 1.1+ required)

# Usage

    $ vagrant plugin install berkshelf-vagrant 
    $ git clone https://github.com/uu59/fastladder-vm-vagrant flvm
    $ cd flvm
    $ berks install
    $ vagrant up
    .. takes 30 minitues on my machine ..
    $ vagrant ssh
    [vagrant@flvm-berkshelf ~]$ cd fastladder
    [vagrant@flvm-berkshelf ~]$ bundle
    [vagrant@flvm-berkshelf ~]$ cp config/database.yml{.sqlite3,}
    [vagrant@flvm-berkshelf ~]$ bundle exec rake db:create db:migrate
    [vagrant@flvm-berkshelf ~]$ bundle exec rake setup
    [vagrant@flvm-berkshelf ~]$ bundle exec rails s

After that, visit "http://localhost:30000"

# Known issue

## Q. port forwarding fails

https://github.com/mitchellh/vagrant/issues/1481
