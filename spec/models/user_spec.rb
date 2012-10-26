require 'spec_helper'

describe User do
  
  before do 
    @user = User.new(username: 'tony612', name: 'Tony', email: 'test@example.com', password: 'password')
  end

  subject {@user}

  it {should respond_to(:name)}
  it {should respond_to(:email)}
  it {should respond_to(:username)}
  it {should respond_to(:password)}

  it {should be_valid}

  describe "when username is not present" do
    before {@user.username = ""}
    it {should_not be_valid}
  end

  describe "when username is too long" do
    before {@user.username = "a" * 51}
    it {should_not be_valid}
  end

  describe "when username address is already taken" do
    before do
      user_with_same_username = @user.dup
      user_with_same_username.save
    end

    it {should_not be_valid}
  end

  let :attrs do {username: 'tony', name: 'Tony', email: 'test@test.com', password: 'password'} end
  let :attrs2 do {username: 'tony2', name: 'Tony2', email: 'test2@test.com', password: 'password'} end

  describe 'creation' do
    it "creates a user given valid attributes" do
      User.new(attrs).should be_valid
    end

    it "requires a usernmae" do
      User.new(attrs.merge(username: '')).should_not be_valid
    end

    it "rejects a usernmae that contains illegal characters" do
      User.new(attrs.merge(username: 'tony_')).should be_valid
      User.new(attrs.merge(username: 'tony.')).should_not be_valid
      User.new(attrs.merge(username: 'tony-')).should_not be_valid
      User.new(attrs.merge(username: '2tony')).should_not be_valid
    end

    it "rejects duplicated username" do
      User.create!(attrs)
      User.new(attrs2.merge(username: attrs[:username])).should_not be_valid
    end

    it "accepts duplicated case-insensitive usernmae" do
      User.create!(attrs)
      User.new(attrs2.merge(username: attrs[:username].upcase)).should be_valid
    end

    it "rejects a usernmae which is too short" do
      User.new(attrs.merge(username: 'aaa')).should_not be_valid
    end

    it "rejects a username which is too long" do
      User.new(attrs.merge(username: 'a' * 51)).should_not be_valid
    end

    it "rejects an invalid email address" do
      User.new(attrs.merge(:email => 'invalid_email')).should_not be_valid
    end
         
    it "rejects duplicated email addresses" do
      User.create!(attrs)
      User.new(attrs2.merge(:email => attrs[:email])).should_not be_valid
    end
  end

  describe "persistence" do
    it "normalises the email address" do
      user = User.new(attrs.merge(email: 'TESt@test.com'))
      user.save(:validate => false)

      user.email.should == 'test@test.com'
    end
  end
  
  describe "password validation" do
    def test_invalid_user_password(password, password_confirmation = nil)
      User.new(attrs.merge(password: password, password_confirmation: password_confirmation)).should_not be_valid
    end

    it "requires a password" do
      test_invalid_user_password('')
    end

    it "requires a matching password confirmation" do
      test_invalid_user_password('password', 'password2')
    end

    it "rejects a password that is too short" do
      test_invalid_user_password('a')
    end
  end
end
