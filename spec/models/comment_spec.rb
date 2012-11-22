require 'spec_helper'

describe Comment do
  let(:user) {FactoryGirl.create(:user)}
  let(:user1) {FactoryGirl.create(:user)}
  let(:school) {FactoryGirl.create(:school)}
  let(:event) {FactoryGirl.create(:event, :user => user)}

  context "messages" do
    it "should send event comment message to event author and the followers" do
      expect do
        FactoryGirl.create(:comment, :event => event, :user => user1)
      end.to change(Message.where(:msg_type => Message.EVENT_TYPE), :count).by(1 + event.followers.count)
    end

    it "send mention messages to mentioners" do
      expect do
        FactoryGirl.create(:comment, :event => event, :user => user1, :content => "Hey, @#{user.username} Hey")
      end.to change(Message.where(:msg_type => Message.MENTION_TYPE), :count).by(1)
    end

    it "delete mention messages after destoyed" do
      #comment = 
      expect do
        FactoryGirl.create(:comment, :event => event, :user => user1, :content => "Hey, @#{user.username} Hey").destroy
      end.not_to change(Message, :count)
    end
  end
end
