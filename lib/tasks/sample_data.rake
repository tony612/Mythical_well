namespace :db do
  desc 'Fill database with sample data' 
  task populate: :environment do
    make_users
    make_followships
  end

  def make users
    100.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@test.com"
      password = "password"
      tagline = "This is a tagline"
      User.create!(name:
                   name,
                   email:
                   email,
                   password: password,
                   password confirmation: password)
    end
  end

end
