require 'spec_helper'

describe Pool do
  let :pool do
    FactoryGirl::build(:pool)
  end

  let :second_pool do
    FactoryGirl::build(:second_pool)
  end

  it 'should have valid factories' do
    pool.should be_valid
    second_pool.should be_valid
  end

  it 'should generate an invite code before save' do
    pool.invite_code.should be_nil
    pool.save
    pool.invite_code.should match(/\A[0-9a-f]{8}\z/)
  end

  context 'validations' do
    it 'should be invalid if the name is blank' do
      pool.name = ''
      pool.should be_invalid
    end
  end

  context 'with an existing pool in the system' do
    before :each do
      pool.save
    end

    it 'should not allow duplicate names' do
      second_pool.name = pool.name
      second_pool.should be_invalid
    end

    context 'authentication' do
      it 'should fail for an incorrect invite code' do
        pool.authenticate('incorrect').should == false
      end

      it 'should pass for the correct invite code' do
        pool.authenticate(pool.invite_code).should == true
      end
    end
  end
end
