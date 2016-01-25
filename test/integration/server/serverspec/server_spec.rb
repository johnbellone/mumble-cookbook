require 'serverspec'
set :backend, :exec

describe service('murmur') do
  it { should be_enabled }
  it { should be_running }
end
