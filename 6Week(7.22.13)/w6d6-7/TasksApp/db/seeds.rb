# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
titles = [
	'Think of task titles',
	'start building an array',
	'use array to seed the db with tasks',
	'complete aforementioned tasks',
	'a programmers work is never done'
]

titles.each {|title| Task.create(title: title)}