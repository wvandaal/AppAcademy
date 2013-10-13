# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Band.create([{name: "Mouse"}, {name: "Rat"}])
u = User.new({email: "bob", password: "123"})
u.admin = true
u.save!
u.activation_token = nil
u.save!

album = Band.first.albums.build({title: "Untitled", pub_date: Date.today}).save
track = Album.first.tracks.build({title: "Something", lyrics: "nah nah nah na \n na na na na\n hey hey hey\n gooodbye"}).save
