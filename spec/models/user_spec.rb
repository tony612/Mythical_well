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


  
end
