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

describe PoolsController do
  
  before(:each) do
    @user = FactoryGirl::create(:user)
  end

  # This should return the minimal set of attributes required to create a valid
  # Pool. As you add validations to Pool, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    FactoryGirl::attributes_for(:pool)
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PoolsController. Be sure to keep this updated too.
  def valid_session
    { user_id: @user.id }
  end

  describe "GET index" do
    it "assigns all pools as @pools" do
      pool = FactoryGirl::create(:pool)
      get :index, {}, valid_session
      assigns(:pools).should eq([pool])
    end
  end

  describe "GET show" do
    describe "when user is not a member" do
      it "redirects to the pools page" do
        pool = FactoryGirl::create(:pool)
        get :show, {:id => pool.to_param}, valid_session
        response.should redirect_to root_path
      end
    end
    describe "when user is a member" do
      it "assigns the requested pool as @pool" do
        pool = FactoryGirl::create(:pool)
        pool.memberships.build({ user: @user })
        get :show, {:id => pool.to_param}, valid_session
        assigns(:pool).should eq(pool)
      end
    end
  end

  describe "GET new" do
    it "assigns a new pool as @pool" do
      get :new, {}, valid_session
      assigns(:pool).should be_a_new(Pool)
    end
  end

  describe "GET edit" do
    it "assigns the requested pool as @pool" do
      pool = FactoryGirl::create(:pool)
      get :edit, {:id => pool.to_param}, valid_session
      assigns(:pool).should eq(pool)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Pool and creates a membership for the user" do
        expect {
          post :create, {:pool => valid_attributes}, valid_session
        }.to change(Pool, :count).by(1)
        Pool.last.members.should include(@user)
      end

      it "assigns a newly created pool as @pool" do
        post :create, {:pool => valid_attributes}, valid_session
        assigns(:pool).should be_a(Pool)
        assigns(:pool).should be_persisted
      end

      it "redirects to the created pool" do
        post :create, {:pool => valid_attributes}, valid_session
        response.should redirect_to(Pool.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved pool as @pool" do
        # Trigger the behavior that occurs when invalid params are submitted
        Pool.any_instance.stub(:save).and_return(false)
        post :create, {:pool => {}}, valid_session
        assigns(:pool).should be_a_new(Pool)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Pool.any_instance.stub(:save).and_return(false)
        post :create, {:pool => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested pool" do
        pool = FactoryGirl::create(:pool)
        # Assuming there are no other pools in the database, this
        # specifies that the Pool created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Pool.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => pool.to_param, :pool => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested pool as @pool" do
        pool = FactoryGirl::create(:pool)
        put :update, {:id => pool.to_param, :pool => valid_attributes}, valid_session
        assigns(:pool).should eq(pool)
      end

      it "redirects to the pool" do
        pool = FactoryGirl::create(:pool)
        put :update, {:id => pool.to_param, :pool => valid_attributes}, valid_session
        response.should redirect_to(pool)
      end
    end

    describe "with invalid params" do
      it "assigns the pool as @pool" do
        pool = FactoryGirl::create(:pool)
        # Trigger the behavior that occurs when invalid params are submitted
        Pool.any_instance.stub(:save).and_return(false)
        put :update, {:id => pool.to_param, :pool => {}}, valid_session
        assigns(:pool).should eq(pool)
      end

      it "re-renders the 'edit' template" do
        pool = FactoryGirl::create(:pool)
        # Trigger the behavior that occurs when invalid params are submitted
        Pool.any_instance.stub(:save).and_return(false)
        put :update, {:id => pool.to_param, :pool => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested pool" do
      pool = FactoryGirl::create(:pool)
      expect {
        delete :destroy, {:id => pool.to_param}, valid_session
      }.to change(Pool, :count).by(-1)
    end

    it "redirects to the pools list" do
      pool = FactoryGirl::create(:pool)
      delete :destroy, {:id => pool.to_param}, valid_session
      response.should redirect_to(pools_url)
    end
  end

  describe "POST join" do
    describe "with valid invite code" do
      it "creates a membership and redirects to the pool" do
        pool = FactoryGirl::create(:pool)
        expect {
          post :create_membership, { invite_code: pool.invite_code }, valid_session
        }.to change(Membership, :count).by(1)
        response.should redirect_to(pool_path(pool))
      end
    end

    describe "with invalid invite code" do
      it "re-renders the 'join' template" do
        pool = FactoryGirl::create(:pool)
        post :create_membership, { invite_code: 'This is incorrect' }, valid_session
        response.should render_template('join')
      end
    end
  end
end
