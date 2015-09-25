require 'spec_helper'

describe file('/usr/bin/server') do
  it { is_expected.to be_file }
  it { is_expected.to be_executable }
end

describe file('/etc/init.d/server') do
  it { is_expected.to be_file }
  it { is_expected.to be_executable }
end

describe service('server') do
  it { should be_running }
  it { is_expected.to be_running.under('supervisor') }
end

describe port(8080) do
  it { should be_listening }
end

describe command('curl http://localhost:8080/Docker') do
  its(:exit_status) { is_expected.to eq 0 }
  its(:stdout) { is_expected.to eq 'Hi there, I love Docker!' }
end
