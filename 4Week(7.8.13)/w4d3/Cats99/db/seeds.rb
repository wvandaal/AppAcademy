# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create([
  {username: "User1", password: "password"},
  {username: "User2", password: "password"}
])

Cat.create([
  {name: "Fluffy", birth_date: (Date.today - 5.years), color: "orange", sex: "male", user_id: 1},
  {name: "Chester", birth_date: (Date.today - 3.years), color: "black", sex: "male", user_id: 1},
  {name: "Agnes", birth_date: (Date.today - 12.years), color: "gray", sex: "female", user_id: 1}
])

CatRentalRequest.create([
  {cat_id: 1, begin_date: (Date.today - 6.weeks), end_date: (Date.today - 2.days), status: "approved"},
  {cat_id: 1, begin_date: (Date.today - 8.weeks), end_date: (Date.today - 7.weeks)}
])