# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

%w(Orange Brown Black Gray White).each do |color|
  Color.create!(name: color)
end

%w(Wigle Judith Jonathan Christi Stacy).each do |human|
  Human.create!(name: human)
end

Cat.create!({
  name: "Sennacy",
  birthday: "2007-04-01",
  biography: "I am a cat and I can open doors.",
  color_id: Color.find_by_name("Brown").id,
  gender: "M",
  human_ids: [Human.find_by_name("Jonathan").id,
              Human.find_by_name("Christi").id]
})

