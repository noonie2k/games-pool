require 'spec_helper'

describe User do
  let :user do
    FactoryGirl::build(:user)
  end

  let :second_user do
    FactoryGirl::create(:second_user)
  end

  it 'should have valid factories' do
    user.should be_valid
    second_user.should be_valid
  end

  context 'validations' do
    it 'should be invalid if the username is blank' do
      user.username = ''
      user.should_not be_valid
    end

    it 'should be invalid if the name is blank' do
      user.name = ''
      user.should_not be_valid
    end

    it 'should be invalid if the email is blank' do
      user.email = ''
      user.should_not be_valid
    end

    it 'should be invalid if the password is blank' do
      user.password = ''
      user.should_not be_valid
    end

    it 'should be invalid if the password confirmation is incorrect' do
      user.password_confirmation = ''
      user.should_not be_valid
    end
  end

  context 'with an existing user in the system' do
    before :each do
      second_user.save
    end

    it 'should not allow duplicate usernames' do
      user.username = second_user.username
      user.valid?.should == false
    end

    it 'should not allow duplicate emails' do
      user.email = second_user.email
      user.valid?.should == false
    end
  end
end
