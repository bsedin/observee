require 'spec_helper'

describe Observee do
  it 'has a version number' do
    expect(Observee::VERSION).not_to be nil
  end

  it 'should work' do
    expect(true).to eq(true)
  end
end
