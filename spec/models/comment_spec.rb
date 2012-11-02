require 'spec_helper'

describe Comment do
  let(:user) {create(:user)}
  let(:user1) {create(:user, email: "test1@test.com", username: "username1")}
  let :attrs do
    {
      title: "Title of event",
      category: 'life',
      location: 'Center lake',
      content: 'This is a content',
      fee: '0',
      start_date: Time.now,
      end_date: Time.now,
    }
  end
  let(:event) {user.events.build(attrs)}
  before do
    @comment = event.comments.build(content: "This is a comment for #{event.title}")
    user1.comments << @comment
  end

  subject {@comment}

  it {should respond_to(:content)}

  describe "creation" do
    it "should reject content which is blank" do
      @comment.content = ""
      @comment.should_not be_valid
    end

    it "rejects when event_id is not present" do
      @comment.event_id = nil
      @comment.should_not be_valid
    end

    it "rejects when user_id is not present" do
      @comment.user_id = nil
      @comment.should_not be_valid
    end
    
  end

  describe "after creation" do
    it "the message will increase by 1" do
      expect do
        @comment.save
      end.should change(Message, :count).by(1)
    end
  end
end
