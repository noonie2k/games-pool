require 'spec_helper'

describe Game do

  context 'user already owns this game' do
    before :each do
      @user = User.new
      @user.username = 'someuser'
      @user.name = 'Some User'
      @user.password = 'password'
      @user.password_confirmation = 'password'
      @user.save

      @game = @user.games.build({
          title: 'Some Game',
          platform_id: 1
        })
      @game.save
    end

    it 'should not allow multiple games with the same title & platform for the same user' do
      game = @user.games.build({
          title: 'Some Game',
          platform_id: 1
        })

      game.save.should == false
    end
  end
end
