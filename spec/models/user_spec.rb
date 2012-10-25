require 'spec_helper'

describe User do
  let :user do
    FactoryGirl::build(:user)
  end

  let :existing_user do
    FactoryGirl::create(:existing_user)
  end

  it 'should have valid factories' do
    user.should be_valid
    existing_user.should be_valid
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
      existing_user.save
    end

    it 'should not allow duplicate usernames' do
      user.username = existing_user.username
      user.valid?.should == false
    end

    it 'should not allow duplicate emails' do
      user.email = existing_user.email
      user.valid?.should == false
    end
  end
end
