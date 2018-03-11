#require 'random_data'
require 'faker'

#Create non-random users
    User.find_or_create_by!(email: 'mlopez@fundacionidea.org.mx') do |user|
      user.password = 'helloworld'
      user.password_confirmation= 'helloworld'
      user.skip_confirmation!
    end

    User.find_or_create_by!(email: 'mlopez@c-230.com') do |user|
      user.password = 'helloworld'
      user.password_confirmation= 'helloworld'
      user.skip_confirmation!
      user.role = :admin
    end

    User.find_or_create_by!(email: 'marcoalopezsilva@gmail.com') do |user|
      user.password = 'helloworld'
      user.password_confirmation= 'helloworld'
      user.skip_confirmation!
      user.role = :premium
    end

    User.find_or_create_by!(email: 'marcoalopezsilva2@gmail.com') do |user|
      user.password = 'helloworld'
      user.password_confirmation= 'helloworld'
      user.skip_confirmation!
      user.role = :premium
    end

    User.find_or_create_by!(email: 'marcoalopezsilva3@gmail.com') do |user|
      user.password = 'helloworld'
      user.password_confirmation= 'helloworld'
      user.skip_confirmation!
      user.role = :premium
    end

    User.find_or_create_by!(email: 'marcoalopezsilva4@gmail.com') do |user|
      user.password = 'helloworld'
      user.password_confirmation= 'helloworld'
      user.skip_confirmation!
      user.role = :premium
    end

  #Create random users
  3.times do
    user = User.new(
      email: Faker::Internet.email,
      password: 'helloworld',
      password_confirmation: 'helloworld'
    )
    user.skip_confirmation!
    user.save!
  end

  #Create random wikis
  8.times do
    wiki = Wiki.create!(
      user: User.all.sample,
      title: Faker::Lorem.sentence(4),
      body: Faker::Lorem.paragraph(5),
      private: [true, false].sample
    )
  end

  #Create test markdown-ed wiki
  wiki = Wiki.create!(
    user: User.all.sample,
    title: "This is a Wiki to try markdown",
    body:   %Q{### There Is Something You Should Know!
            This is my very first post using markdown!
            How do you like it?  I learned this from [RichOnRails.com](http://richonrails.com/articles/rendering-markdown-with-redcarpet)!} ,
    private: false
  )

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
