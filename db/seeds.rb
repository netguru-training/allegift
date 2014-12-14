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
Importance.create!([{name: 'Very important gift'}, {name: 'Important gift'}, {name: 'Would be nice to have'}])

(1..10).each do |i|
  pass = Faker::Internet.password(8)
  User.create!(name: Faker::Internet.user_name,
               email: Faker::Internet.free_email,
               password:              pass,
               password_confirmation: pass)
end

allegro_links = ['http://allegro.pl/zb61-samochod-auto-autko-twister-zdalnie-sterowany-i4864531202.html',
                 'http://allegro.pl/zestaw-noze-fiskars-6-elementow-5-nozy-blok-857197-i4846772420.html',
                 'http://allegro.pl/40-x-bateria-duracell-industrial-lr6-r6-aa-2021-i4862411358.html',
                 'http://allegro.pl/1503-keyboard-37-klawiszy-organy-mikrofon-radio-i4842746484.html']
(1..40).each do |i|
  Gift.create!(name: Faker::Lorem.word,
               allegro_link: allegro_links[i%4],
               user_id: i%10+1,
               importance_id: i%3+1)
end
