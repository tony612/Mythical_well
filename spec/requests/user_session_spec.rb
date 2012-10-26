# -*- coding: utf-8 -*-
require 'spec_helper'

describe "user_session" do
  let(:user) do
    u = create(:user)
    #u.confirm!
    u
  end

  let(:user_unconfirmed) {User.make!}

  def sign_in_user(login = user.email)
    post user_session_path, :user => {login: login, password: 'password'}
  end

  it "sees sign in page" do
    get new_user_session_path
    
    response.status.should == 200
    response.body.should include('登录')
  end

  it "signs in using email" do
    sign_in_user

    response.should redirect_to(root_path)
    follow_redirect!
    response.body.should include(user.username)
  end

  it "signs in using username" do
    sign_in_user(user.username)

    response.should redirect_to(root_path)
    follow_redirect!
    response.body.should include(user.username)
  end

  it "rejects signing in with incorrect login" do
    sign_in_user('dummy')

    response.body.should include ("邮箱或密码错误")
  end

  it "signs out" do
    sign_in_user

    delete destroy_user_session_path

    response.should redirect_to(root_path)
    follow_redirect!
    response.body.should_not include(user.username)
  end

  #it "sends reset password instructions" do
  #  post user_password_path, :user => { :login => user.email }
  #  
  #  response.should redirect_to(new_user_session_path)
  #end                                                         

end
