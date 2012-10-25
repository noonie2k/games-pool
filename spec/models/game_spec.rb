require 'spec_helper'

describe Game do
  let :game do
    FactoryGirl::build(:game)
  end

  it 'should have a valid factory' do
    game.should be_valid
  end

  context 'validations' do
    it 'should be invalid if the title is blank' do
      game.title = ''
      game.should be_invalid
    end

    it 'should be invalid if the owner is blank' do
      game.owner = nil
      game.should be_invalid
    end

    it 'should be invalid if the platform is blank' do
      game.platform = nil
      game.should be_invalid
    end

    it 'should have a generated md5 hash after validations' do
      game.md5.should be_nil
      game.valid?
      game.md5.should match(/\A[a-f0-9]{32}\z/)
    end
  end

  context 'with an existing loan in the system' do
    let :loans do
      stub(:loan, messages: [ :where ])
    end

    context "with a status of 'on hold'" do
      it "should have an availability of 'on hold'" do
        loans.should_receive(:where).and_return([1], [])
        game.should_receive(:loans).twice { loans }
        game.availability.should == Game::AVAILABILITY_ONHOLD
      end
    end

    context "with a status of 'on loan'" do
      it "should have an availability of 'on loan'" do
        loans.should_receive(:where).and_return([], [1])
        game.should_receive(:loans).twice { loans }
        game.availability.should == Game::AVAILABILITY_ONLOAN
      end
    end

    context "with a status of 'completed'" do
      it "should have an availability of 'available'" do
        loans.should_receive(:where).and_return([], [])
        game.should_receive(:loans).twice { loans }
        game.availability.should == Game::AVAILABILITY_AVAILABLE
      end
    end
  end

  context "images" do
    it 'should return a tiny image on request' do
      game.image(Game::SIZE_TINY).should == game.img_tiny_url
    end

    it 'should return a thumb image on request' do
      game.image(Game::SIZE_THUMB).should == game.img_thumb_url
    end

    it 'should return a placeholder image if the requested size is invalid' do
      game.image('not a valid size').should == '/assets/placeholder.png'
    end

    it 'should return a placeholder image if the requested size is empty' do
      game.img_thumb_url = ''
      game.image(Game::SIZE_THUMB).should == '/assets/placeholder.png'
    end
  end
end
