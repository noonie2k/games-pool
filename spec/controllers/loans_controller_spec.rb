require 'spec_helper'

describe LoansController do
  before(:each) do
    @user = FactoryGirl::create(:user)
    @game = FactoryGirl::create(:game)
  end

  describe "POST issue" do
    describe "for an invalid loan id" do
      it "redirects to the root path" do
        post :issue, { id: 999 }, { user_id: @game.owner.id }
        response.should redirect_to root_path
      end
    end

    describe "for a loan with status of on loan" do
      before(:each) do
        @loan = @game.loans.build({ user: @user })
        @loan.status = Loan::STATUS_ONLOAN
        @loan.save
      end

      it "redirects to the root path" do
        post :issue, { id: @loan.id }, { user_id: @game.owner.id }
        response.should redirect_to root_path
      end
    end

    describe "for a loan with status of completed" do
      before(:each) do
        @loan = @game.loans.build({ user: @user })
        @loan.status = Loan::STATUS_COMPLETED
        @loan.save
      end

      it "redirects to the root path" do
        post :issue, { id: @loan.id }, { user_id: @game.owner.id }
        response.should redirect_to root_path
      end
    end

    describe "for a second hold on a game" do
      before(:each) do
        @first_loan = @game.loans.build({ user: @user })
        @first_loan.save

        @second_loan = @game.loans.build({ user: @user })
        @second_loan.save
      end

      it "indicates an earlier hold" do
        post :issue, { id: @second_loan.id }, { user_id: @game.owner.id }
        response.should redirect_to account_user_path(@game.owner)
        flash[:notice].should eq('There are earlier holds on this game, process them first')
      end
    end

    describe "for a loan on a game not belonging to the logged in user" do
      before(:each) do
        @other_users_game = FactoryGirl::create(:game_with_same_title_and_platform)
        @loan_on_other_game = @other_users_game.loans.build({ user: @user })
        @loan_on_other_game.status = Loan::STATUS_ONHOLD
        @loan_on_other_game.save
      end

      it "redirects to the root path" do
        post :issue, { id: @loan_on_other_game.id }, { user_id: @game.owner.id }
        response.should redirect_to root_path
      end
    end

    describe "for a loan with status of on hold" do
      before(:each) do
        @loan = @game.loans.build({ user: @user })
        @loan.status = Loan::STATUS_ONHOLD
        @loan.save
      end

      it "redirects to the root path" do
        post :issue, { id: @loan.id }, { user_id: @game.owner.id }
        response.should redirect_to(root_path)
      end
    end
  end
  
  describe "POST complete" do
    describe "for an invalid loan id" do
      it "redirects to the root path" do
        post :complete, { id: 999 }, { user_id: @game.owner.id }
        response.should redirect_to root_path
      end
    end

    describe "for a loan with status of on hold" do
      before(:each) do
        @loan = @game.loans.build({ user: @user })
        @loan.status = Loan::STATUS_ONHOLD
        @loan.save
      end

      it "redirects to the root path" do
        post :complete, { id: @loan.id }, { user_id: @game.owner.id }
        response.should redirect_to root_path
      end
    end

    describe "for a loan with status of completed" do
      before(:each) do
        @loan = @game.loans.build({ user: @user })
        @loan.status = Loan::STATUS_COMPLETED
        @loan.save
      end

      it "redirects to the root path" do
        post :complete, { id: @loan.id }, { user_id: @game.owner.id }
        response.should redirect_to root_path
      end
    end

    describe "for a loan on a game not belonging to the logged in user" do
      before(:each) do
        @other_users_game = FactoryGirl::create(:game_with_same_title_and_platform)
        @loan_on_other_game = @other_users_game.loans.build({ user: @user })
        @loan_on_other_game.status = Loan::STATUS_ONLOAN
        @loan_on_other_game.save
      end

      it "redirects to the root path" do
        post :issue, { id: @loan_on_other_game.id }, { user_id: @game.owner.id }
        response.should redirect_to root_path
      end
    end

    describe "for a loan with status of on loan" do
      before(:each) do
        @loan = @game.loans.build({ user: @user })
        @loan.status = Loan::STATUS_ONHOLD
        @loan.save
      end

      it "redirects to the root path" do
        post :complete, { id: @loan.id }, { user_id: @game.owner.id }
        @loan.reload
        @loan.status.should eq(Loan::STATUS_COMPLETED)
        flash[:success].should eq("The hold on #{@loan.game.title} for #{@loan.user.name} has been completed")
      end
    end
  end
end
