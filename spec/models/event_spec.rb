require 'spec_helper'

describe Event do
  let(:user) {create(:user)}

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

  before do
    @event = user.events.build(attrs)
  end

  def built_by_user(attrs)
    user.events.build(attrs)
  end

  subject {@event}
  
  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Event.new(attrs.merge(user_id: user.id))
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)

    end

  end
  

  describe "creation" do
    it "creates a event given valid attrs" do
      @event.should be_valid
    end

    it "requires a title" do
      built_by_user(attrs.merge(title: '')).should_not be_valid
    end

    it "requires a content" do
      built_by_user(attrs.merge(title: '')).should_not be_valid
    end

    it "reject when user_id is not present" do
      @event.user_id = nil
      @event.should_not be_valid
    end
  end


end
