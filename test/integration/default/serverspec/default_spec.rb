require 'serverspec'
set :backend, :exec

describe package('mumble') do
  it { should be_installed }
end
