require 'spec_helper'
describe 'rtadvd' do

  context 'with defaults for all parameters' do
    it { should contain_class('rtadvd') }
  end
end
