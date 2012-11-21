require 'spec_helper'

describe Followship do
  let (:follower) {FactoryGirl.create(:user)}
  let (:followed) {FactoryGirl.create(:user, username: 'username2', email: 'test2@test.com')}
  let (:followship) {follower.followships.build(followed_id: followed.id)}

  subject {followship}

  it {should be_valid}

  describe "accessible attrs" do
    it "should not allow access to follower.id" do
      expect do
        Followship.new(follower_id: follower.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "follower methods" do
    it {should respond_to(:follower)}
    it {should respond_to(:followed)}
    its(:follower) {should == follower}
    its(:followed) {should == followed}
  end

  describe "when followed is not present" do
    before {followship.followed_id = nil}
    it {should_not be_valid}
  end

  describe "when follower is not present" do
    before {followship.follower_id = nil}
    it {should_not be_valid}
  end
end
