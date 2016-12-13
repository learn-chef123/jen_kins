#
# Cookbook Name:: jen_kins
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

#installs oracle java
include_recipe 'my_java::default'

package 'wget' do
  not_if "rpm -qa | grep -i wget"
end

directory "#{node['jenkins']['install_dir']}"

remote_file "#{node['jenkins']['install_dir']}/jenkins.war" do
  source "http://mirrors.jenkins-ci.org/war/#{node['jenkins']['war_ver']}/jenkins.war"
  not_if { ::File.exist?('/opt/jenkins/jenkins.war') }
end

template '/etc/systemd/system/jenkins.service'do
  source 'jenkins.service.erb'
  variables(
   :war => "#{node['jenkins']['install_dir']}/jenkins.war"
  )
end

service 'jenkins' do
  action [ :enable, :start ]
  subscribes :reload, 'template[/etc/systemd/system/jenkins.service]', :immediately
end
