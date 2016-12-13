# # encoding: utf-8

# Inspec test for recipe jen_kins::default

# The Inspec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec_reference.html

# unless os.windows?
#   describe user('root') do
#     it { should exist }
#     skip 'This is an example test, replace with your own test.'
#   end
# end
#
# describe port(80) do
#   it { should_not be_listening }
#   skip 'This is an example test, replace with your own test.'
# end

describe command('java -version') do
  its('exit_status') { should eq 0 }
end

describe package('wget') do
  it { should be_installed }
end


describe file('/opt/jenkins/jenkins.war') do
  it { should exist }
end
