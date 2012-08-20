require 'spec_helper'

describe SessionsController do

  describe "GET 'login'" do
    it "returns http success" do
      get 'login'
      response.should be_success
    end
  end

  describe "GET 'logout'" do
    it "redirects to root path" do
      get 'logout'
      response.should redirect_to(root_path)
    end
  end

end
