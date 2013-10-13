# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = %w(Willem Saskia Ava Anthony Amy Wells Abdel Lyndon Rami Angela Kate Alexa Tim Kirsten Jeff James Krister Glenn Will Alex)
teams = %w(dayteam nightteam greenteam)
projects = %w(one two three)
items = %w(item1 item2 item3 item4)
description = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin venenatis diam eu dignissim congue. Curabitur ornare dolor et aliquam sollicitudin. Proin a purus ornare, ultrices augue eget, elementum velit. Nulla facilisi. Quisque interdum est non orci lacinia, ac congue risus bibendum. Nulla at sodales lacus, id auctor diam. Fusce non ipsum sem. Mauris sollicitudin neque ac metus eleifend, et tincidunt massa porta. Fusce ultricies odio ut mi consequat, sed interdum nibh feugiat. Nulla ac urna a ligula varius sodales a et nulla. Duis et est tempus, imperdiet mauris at, tristique odio. Vivamus quis scelerisque ipsum, sit amet mattis mauris.'

users.map! do |user|
	User.create(name: user)
end

teams.map! do |team|
	Team.create(
		name: team
		)
end

projects.map! do |proj|
	Project.create(
		title: proj,
		description: description,
		team_id: 1
		)
end

items.each do |item|
	Item.create(
		title: item,
		description: description,
		project_id: 1
		)
end
