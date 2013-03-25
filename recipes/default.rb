%w[zlib-devel openssl-devel readline-devel libxml2-devel libxslt-devel libcurl-devel sqlite-devel].each do |pkg|
  yum_package pkg do
    action :install
  end
end

file "/home/vagrant/.gemrc" do
  content %Q!gem: --no-ri --no-rdoc!
end

git "/home/vagrant/fastladder" do
  user "vagrant"
  repository "https://github.com/fastladder/fastladder"
  reference "master"
  action :sync

  not_if do
    ::File.directory?("/home/vagrant/fastladder")
  end
end


# Install node.js for execjs
execute "nodebrew" do
  user "vagrant"
  environment({"HOME" => "/home/vagrant"})
  command "curl -L git.io/nodebrew | perl - setup"

  not_if do
    ::File.exists?("/home/vagrant/.nodebrew")
  end
end

execute "install node" do
  user "vagrant"
  cwd "/home/vagrant"
  environment({"HOME" => "/home/vagrant"})
  nodebrew = "/home/vagrant/.nodebrew/current/bin/nodebrew"
  version = "v0.10.1"

  command "#{nodebrew} install-binary #{version}; #{nodebrew} alias default #{version}; #{nodebrew} use default"

  not_if do
    ::File.exists?("/home/vagrant/.nodebrew/current/bin/node")
  end
end

file "/home/vagrant/.bashrc" do
  content <<BASH
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

export PATH="$HOME/.nodebrew/current/bin:$HOME/bin:$PATH"
BASH
end

