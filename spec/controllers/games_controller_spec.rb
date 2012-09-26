require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe GamesController do

  # This should return the minimal set of attributes required to create a valid
  # Game. As you add validations to Game, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    FactoryGirl::attributes_for(:game)
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # GamesController. Be sure to keep this updated too.
  def valid_session
    { user_id: User.first.id }
  end

  describe "GET index" do
    it "assigns all games as @games" do
      game = FactoryGirl::create(:game)
      get :index, {}, valid_session
      assigns(:games).should eq([game])
    end
  end

  describe "GET show" do
    it "assigns the requested game as @game" do
      game = FactoryGirl::create(:game)
      get :show, {:id => game.to_param}, valid_session
      assigns(:game).should eq(game)
    end
  end

  describe "GET new" do
    it "assigns a new game as @game" do
      FactoryGirl::create(:user)
      get :new, {}, valid_session
      assigns(:game).should be_a_new(Game)
    end
  end

  describe "GET edit" do
    it "assigns the requested game as @game" do
      game = FactoryGirl::create(:game)
      get :edit, {:id => game.to_param}, valid_session
      assigns(:game).should eq(game)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Game and sets an md5 hash" do
        FactoryGirl::create(:user)
        platform = FactoryGirl::create(:platform)
        expect {
          post :create, {:game => valid_attributes.merge({ platform_id: platform.id })}, valid_session
        }.to change(Game, :count).by(1)

        game = Game.last
        game.md5.should eq(Digest::MD5.hexdigest("#{game.title}-#{game.platform.id}"))
      end

      it "assigns a newly created game as @game" do
        FactoryGirl::create(:user)
        platform = FactoryGirl::create(:platform)
        post :create, {:game => valid_attributes.merge({ platform_id: platform.id })}, valid_session
        assigns(:game).should be_a(Game)
        assigns(:game).should be_persisted
      end

      it "redirects to the user account" do
        FactoryGirl::create(:user)
        platform = FactoryGirl::create(:platform)
        post :create, {:game => valid_attributes.merge({ platform_id: platform.id })}, valid_session
        response.should redirect_to(account_user_path(valid_session[:user_id]))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved game as @game" do
        FactoryGirl::create(:user)
        # Trigger the behavior that occurs when invalid params are submitted
        Game.any_instance.stub(:save).and_return(false)
        post :create, {:game => {}}, valid_session
        assigns(:game).should be_a_new(Game)
      end

      it "re-renders the 'new' template" do
        FactoryGirl::create(:user)
        # Trigger the behavior that occurs when invalid params are submitted
        Game.any_instance.stub(:save).and_return(false)
        post :create, {:game => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested game" do
        game = FactoryGirl::create(:game)
        # Assuming there are no other games in the database, this
        # specifies that the Game created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Game.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => game.to_param, :game => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested game as @game" do
        game = FactoryGirl::create(:game)
        put :update, {:id => game.to_param, :game => valid_attributes}, valid_session
        assigns(:game).should eq(game)
      end

      it "redirects to the user account" do
        game = FactoryGirl::create(:game)
        put :update, {:id => game.to_param, :game => valid_attributes}, valid_session
        response.should redirect_to(account_user_path(valid_session[:user_id]))
      end
    end

    describe "with invalid params" do
      it "assigns the game as @game" do
        game = FactoryGirl::create(:game)
        # Trigger the behavior that occurs when invalid params are submitted
        Game.any_instance.stub(:save).and_return(false)
        put :update, {:id => game.to_param, :game => {}}, valid_session
        assigns(:game).should eq(game)
      end

      it "re-renders the 'edit' template" do
        game = FactoryGirl::create(:game)
        # Trigger the behavior that occurs when invalid params are submitted
        Game.any_instance.stub(:save).and_return(false)
        put :update, {:id => game.to_param, :game => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested game" do
      game = FactoryGirl::create(:game)
      expect {
        delete :destroy, {:id => game.to_param}, valid_session
      }.to change(Game, :count).by(-1)
    end

    it "redirects to the user account" do
      game = FactoryGirl::create(:game)
      delete :destroy, {:id => game.to_param}, valid_session
      response.should redirect_to(account_user_path(valid_session[:user_id]))
    end
  end

end
