require 'spec_helper'

describe Platform do
  let :platform do
    FactoryGirl::build(:platform)
  end

  let :second_platform do
    FactoryGirl::build(:second_platform)
  end

  it 'should have valid factories' do
    platform.should be_valid
  end

  context 'validations' do
    it 'should be invalid if the color_code is blank' do
      platform.color_code = ''
      platform.should be_invalid
    end

    it 'should be invalid if the color_code is incorrectly formatted - not a hex' do
      platform.color_code = '123'
      platform.should be_invalid
    end

    it 'should be invalid if the color_code is incorrectly formatted - invalid hex' do
      platform.color_code = '#g1i'
      platform.should be_invalid
    end

    it 'should be invalid if the color_code is correctly formatted - 6 digit hex' do
      platform.color_code = '#a1b2c3'
      platform.should be_valid
    end

    it 'should be invalid if the color_code is correctly formatted - 3 digit hex' do
      platform.color_code = '#a1b'
      platform.should be_valid
    end

    it 'should be invalid if the name is blank' do
      platform.name = ''
      platform.should be_invalid
    end
  end

  context 'with an existing platform in the system' do
    before :each do
      platform.save
    end

    it 'does not allow duplacate names' do
      second_platform.name = platform.name
      second_platform.should be_invalid
    end

    it 'does not allow duplacate color codes' do
      second_platform.color_code = platform.color_code
      second_platform.should be_invalid
    end
  end
end
