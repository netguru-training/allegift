# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(name: "John Lennon",
             email: "example@railstutorial.org",
             password:              "johnlennon",
             password_confirmation: "johnlennon")

(1..10).each do |i|
  pass = Faker::Internet.password
  User.create!(email: Faker::Internet.free_email,
               password:              pass,
               password_confirmation: pass)
end

allegro_links = ['http://allegro.pl/show_item.php?item=4834149511&sh_dwh_token=d0b6dd74a8394345128e20d296cb1c5e',
                 'http://allegro.pl/show_item.php?item=4831973018&sh_dwh_token=d0b6dd74a8394345128e20d296cb1c5e',
                 'http://allegro.pl/show_item.php?item=4881862490&sh_dwh_token=d0b6dd74a8394345128e20d296cb1c5e',
                 'http://allegro.pl/show_item.php?item=4881571713&sh_dwh_token=d0b6dd74a8394345128e20d296cb1c5e']
(1..40).each do |i|
  Gift.create!(name: Faker::Lorem.word,
               allegro_link: allegro_links[i%4],
               user_id: i%10)
end
