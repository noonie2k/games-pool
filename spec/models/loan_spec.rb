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

    it 'should be invalid if the user is the owner of the game' do
      loan.user = loan.game.owner
      loan.should be_invalid
    end

    it 'should be invalid if the user owns the same game on the same platform' do
      loan.user.games.build({
          title: loan.game.title,
          platform_id: loan.game.platform.id
        }).save
      loan.should be_invalid
    end

    it 'should be invalid if the user has an active hold on the same game elsewhere' do
      loans = stub
      loans.should_receive(:md5).with(loan.game.md5) { [1] }
      loan.user.should_receive(:loans) { loans }
      loan.should be_invalid
    end
  end
end
