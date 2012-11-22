require 'spec_helper'

describe Event do
  let(:user) {FactoryGirl.create(:user)}
  let(:event) {FactoryGirl.create(:event)}
  let(:school) {FactoryGirl.create(:school)}
  before(:each) do
    @events = FactoryGirl.create_list(:event, 10, node: school)
  end
  describe "#complex_find" do
    describe "when node exists" do
      let(:params) { {:short_name => school.short_name} }
      it "based on category" do
        params[:category] = ['Life', 'Course', 'Speek'].sample
        events = Event.complex_find(params)
        #binding.pry
        events.each do |e| 
          e.category.should == params[:category]
          e.node.short_name.should == school.short_name
        end
      end

      it "based on tag" do
        tag = FactoryGirl.create(:tag)
        params[:tag] = tag.name
        events = Event.complex_find(params)
        events.each do |e| 
          e.tags.map(&:name).should include(tag.name)
          e.node.short_name.should == school.short_name
        end
      end

      it "no based on tag or category" do
        events = Event.complex_find(params)
        events.each do |e|
          e.node.short_name.should == school.short_name
        end
      end
    end

    describe "when node doesn't exists" do
      let(:params) { {} }
      it "based on category" do
        params[:category] = ['Life', 'Course', 'Speek'].sample
        events = Event.complex_find(params)
        #binding.pry
        events.each do |e| 
          e.category.should == params[:category]
        end
      end

      it "based on tag" do
        tag = FactoryGirl.create(:tag)
        params[:tag] = tag.name
        events = Event.complex_find(params)
        events.each do |e| 
          e.tags.map(&:name).should include(tag.name)
        end
      end

      it "no based on tag or category" do
        events = Event.complex_find(params)
        events.should == @events
      end
    end

  end
end
