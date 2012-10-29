# -*- coding: utf-8 -*-
namespace :db do
  desc 'Fill database with sample data' 
  task populate: :environment do
    make_users
    make_followships
    make_events_comments
    #make_event_association
  end

  def make_users
    100.times do |n|
      username = "username#{n+1}"
      name = Faker::Name.name
      email = "example-#{n+1}@test.com"
      password = "password"
      tagline = "This is a tagline #{n+1}"
      User.create!(username: username,
                   name:name,
                   email:email,
                   tagline: tagline,
                   password: password,
                   password_confirmation: password)
    end
  end

  def make_followships
    users = User.all
    user = users.first
    followed_users = users[2..50]
    followers = users[3..40]
    followed_users.each {|followed| user.follow!(followed)}
    followers.each {|follower| follower.follow!(user)}
  end

  def make_events_comments
    users = User.all
    20.times do |n|
      title = "Title of event #{n}"
      category = ["生活", "课程", "讲座", "聚会", "运动", "聊天"][n%6]
      start_date = Time.now
      end_date = Time.now + 3.hours
      location = "Location #{n}"
      content = "This is content of the event<br/>" * 10
      fee = 0
      user_id = n
      users[user_id].events.build(title: title,
                   category: category,
                   start_date: start_date,
                   end_date: end_date,
                   location: location,
                   content: content,
                   fee: fee).save
    end
    events = Event.all
    200.times do |n|
      content = "This is content of the comment #{n}<br/>" * 10
      event_id = n % 20
      user_id = (199 - n)%100
      comment = events[event_id].comments.build(content: content)
      users[user_id].comments << comment
      comment.save
    end
  end

  def make_event_association
    users = User.all
    events = Event.all
    comments = Comment.all
    20.times do |n|
      users[n].events << events[n]
      10.times do |m|
        events[n].comments << comments[n*m+1]
      end
    end
    100.times do |n|
      users[n].comments << comments[199 - n*2]
      users[n].comments << comments[199 - n*2 - 1]
    end
  end

end
