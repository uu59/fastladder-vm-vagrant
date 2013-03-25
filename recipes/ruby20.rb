save_to = "/home/vagrant/ruby-2.0.0-p0.tar.gz"

remote_file save_to do
  source "http://core.ring.gr.jp/archives/lang/ruby/2.0/ruby-2.0.0-p0.tar.bz2"
  user "vagrant"
  action :create_if_missing
end

execute "compile ruby" do
  cwd File.dirname(save_to)
  user "vagrant"
  group "vagrant"
  command "tar xvf ./#{File.basename(save_to)} && cd ./ruby-2.0.0-p0 && ./configure --prefix=/home/vagrant && make && make install"
  not_if do
    ::File.exists?("/home/vagrant/bin/ruby")
  end
end

execute "install gems" do
  user "vagrant"
  path ["/home/vagrant/bin"]
  command "/home/vagrant/bin/gem install bundler"

  not_if do
    `/home/vagrant/bin/gem list | grep bundler`
  end
end

