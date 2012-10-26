require 'spec_helper'

describe Loan do
  let :loan do
    FactoryGirl::build(:loan)
  end

  it 'has valid factories' do
    loan.should be_valid
  end

  it "should have a default status of 'on hold'" do
    loan.save
    loan.status.should == Loan::STATUS_ONHOLD
  end

  context 'validations' do
    it 'should be invalid if user is nil' do
      loan.user = nil
      loan.should be_invalid
    end

    it 'should be invalid if user is nil' do
      loan.user = nil
      loan.should be_invalid
    end
  end
end
