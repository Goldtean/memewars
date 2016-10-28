# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(email: "jp@jp.jp", username: "jp", password: "jpjpjpjp")
User.create(email: "jt@jt.jt", username: "jt", password: "jtjtjtjt")
User.create(email: "jb@jb.jb", username: "jb", password: "jbjbjbjb")

Picture.create(category: "Jordan", url: "/memepics/1.jpg")
Picture.create(category: "Kanye Taylor", url: "/memepics/2.jpg")
Picture.create(category: "Puppy Horse", url: "/memepics/3.jpg")
Picture.create(category: "Usain Bolt", url: "/memepics/4.jpg")
Picture.create(category: "Girls", url: "/memepics/5.jpg")
Picture.create(category: "Oltean Obama", url: "/memepics/6.jpg")
Picture.create(category: "Prince Charles Brazil", url: "/memepics/7.jpg")
Picture.create(category: "Rapist Search", url: "/memepics/8.jpg")