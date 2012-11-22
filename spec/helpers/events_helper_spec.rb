require 'spec_helper'

describe EventsHelper do
  describe "#comment_raw" do
    it "return empty string when text is blank" do
      text = ""
      comment_raw(text).should == ""
    end

    it "replace \r\n to <br>" do
      text = "Before\r\nafter"
      comment_raw(text).should == "Before<br>after"
    end

    it "replace @foo to a link" do
      text = "Before@foo after"
      comment_raw(text).should =~ /^Before<a href=.*@foo <\/a>after$/
    end
  end

end
