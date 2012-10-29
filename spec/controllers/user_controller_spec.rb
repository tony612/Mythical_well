require 'spec_helper'

describe UsersController do
  let(:user) {create(:user)}
  let(:other_user) {create(:user, username: 'username2', email: 'test2@test.com')}

  before {sign_in user}

  describe "follow a user with ajax" do
    it "should increment the Followship count" do
      expect do
        xhr :post, :follow, id: other_user.id
      end.should change(Followship, :count).by(1)
    end

    it "should respond with success" do
      xhr :post, :follow, id: other_user.id
      response.should be_success
    end
  end

  describe "unfollow a user with ajax" do
    before {user.follow!(other_user)}
    
    it "should decrement the Followship count" do
      expect do
        xhr :post, :unfollow, id: other_user.id
      end.should change(Followship, :count).by(-1)
    end

    it "should respond with success" do
      xhr :post, :unfollow, id: other_user.id 
      response.should be_success
    end
  end


end
