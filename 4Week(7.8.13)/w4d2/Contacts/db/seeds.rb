# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create([
  {name: "Tom", email: "tom@tom.tom", phone: "203.123.4567", address: "Anytown, USA"},
  {name: "Rob", email: "rob@tom.rob", phone: "555.567.8900", address: "Hicksville, AZ"},
  {name: "Thompson Robert", email: "robsonthombert@tom.tom", phone: "800.123.4567", address: "Bumf*ck Canada"}
])

Listing.create([
  {user_id: 1, contact_id: 2},    #tom has rob as contact
  {user_id: 1, contact_id: 3, favorite: true},    #tom has thompson as contact
  {user_id: 2, contact_id: 1},    #rob has tom as contact
  {user_id: 3, contact_id: 2}     #thompson has rob as contact
])