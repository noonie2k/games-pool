require 'spec_helper'

describe "Pools" do
  describe "while logged out" do
    describe "GET /pools" do
      it "redirects to the login page" do
        get pools_path
        response.should redirect_to(login_path)
      end
    end
  end

  describe "while logged in" do
    before(:each) do
      user = FactoryGirl::create(:user)
      post login_path, { username: user.username, password: user.password }
    end

    describe "GET /pools" do
      it "should be successful" do
        get pools_path
        response.should be_success
      end
    end
  end
end
