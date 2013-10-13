1.1
User
class_name: :posts
primary_key: :id in :posts
foreign_key: :post_id in :users

1.2
User
class_name: :posts
primary_key: :id in :posts
foreign_key: :post_id in :users

Post
class_name: :users
primary_key: :id in :users
foreign_key: :user_id in :posts

1.3
User
class_name: :writings
primary_key: :id in :writings
foreign_key: :writing_id in :users

Post
class_name: :authors
primary_key: :id in :authors
foreign_key: :author_id

1.4
Spaceman
class_name: :minions
primary_key: :id in :minions
foreign_key: :spaceman_id in :minions

class_name: :planet_visits
primary_key: :id in :planet_visits
foreign_key: :spaceman_id in :planet_visits

class_name: :spaceships
primary_key: :id


2.3
class User
  has_many :writings, class_name: :posts, foreign_key: :author_id
end

class Post
  belongs_to :author, class_name: :users
end

2.4
class Spaceman
  has_many :minions
  has_many :planet_visits, class_name: :visits
  has_one :spaceship, foreign_key: :owner_id
  belongs_to :race
end

2.5
class Minion
  belongs_to :overlord, class_name: :spacemans(:spacemen?)
end

class Visit
  belongs_to :visitor, class_name: :spacemans
  belongs_to :planet
end

class Spaceship
  belongs_to :owner, class_name: :spaceman
end

class Race
  has_many :people, class_name: :spacemans, foreign_key: :race_id
end

class Planet
end

3.
class Spaceman
  has_many :visited_planets, through: :planet_visits, source: :planets
end

class Planet
  has_many :visits
end

4.
class User
  has_many :memberships
  has_many :my_teams, through: :memberships, source: :teams
end

class Memberships
  belongs_to :user
  belongs_to :team
end

class Teams
  has_many :memberships
  has_many :players, through: :memberships, source: :users
end

5.1
Yes

5.2
The :user_id field of the posts with ids [3,4,5] have changed from 1 to 2

5.3
Yes, these changes are persisted in the database

6.
User.first.post_ids = [5]

7.
class Team
  has_many :memberships
  has_many :users, through: :memberships
end

class Memberships
  belongs_to :team
  belongs_to :user
end

class User
  has_many :memberships
  has_many :teams, through: :memberships
end

7.1
Yes

7.2
3 new membership associations have been created with user_id: 1 and team_id: 3, 4, and 5

8.
u = User.new(name: 'Jim')
u.save
u.posts.build(title: 'My first post')

9.1
params = {user: {name: "Jim", password: "****", address: {street: "1234 Cherry Lane", city: "San Francisco", state: "CA"}}}

9.2
params = {user: {name: "Bob"}, comment: {title: "Bye"}, post: {body: "Hi"}}

9.3
params = {bob: {patient_ids: 5}}
They probably intended:
<input name='bob[patient_ids][]' value='1'></input>
<input name='bob[patient_ids][]' value='2'></input>
<input name='bob[patient_ids][]' value='3'></input>
<input name='bob[patient_ids][]' value='4'></input>
<input name='bob[patient_ids][]' value='5'></input>

9.4
params = {bill: {neverland: {'0' => 1, '1' => 2, '2' => 3}, user_attributes: {name: "Lalala", age: 5}}}

or (if the params hash for :neverland is converted to an array):

params = {bill: {neverland: [1,2,3]}, user_attributes: {name: "Lalala", age: 5}}}

9.5
params = {boom: 1, aqualung: {artist: "Jethro Tull"}, am_i_real: 3, yes: {no: 5}}

10.1
<form action="http://www.google.com", method="post">

10.2
<form action="<%= i-have-something-to-show-you_path %>" method="post">
  <input type="hidden" name="_method" value="get">

10.3
<form action="<%= users_path %>", method="post">

10.4
<form action="http://blahblah.com", method="post">

10.5
<form action="<%= tolstoy-went-soft_path %>" method="post">
  <input type="hidden" name="_method" value="get">

11.1
<form action="/people" method="post">
  <label for="user_name">My Very Special Name</label>
  <input id="user_name" name="user[name][super-name]">
  <input id="user_email" name="user[email]">

  <label for="post_body">Body</label>
  <textarea id="post_body" name="post[body]"></textarea>

  <label for="post_title">Title</label>
  <input id="post_title" name="post[title]">

  <input type="hidden" name="authenticity_token" value="akfdshj23987EKsadfs">
  <input type="submit" value="Submit"
</form>

11.2
params = {user: {name: {super-name: "Name"}, email: "name@name.na.me"}, posts: {body: "somebody", title: "sometitle"}}

12.0
class UsersController
  def create
    @user = User.create(params[:user])
  end

  def new
    @user = User.new
  end
end

mass-assigned: users email and name

12.1
This setup will work in that it will create the user from the given email and name, but it will not create the nested posts since there is no such assignment in the controller.


12.3
class UsersController
  def create
    @user = User.create(params[:user])
    @user.posts.build(params[:posts]).save
  end

  def new
    @user = User.new
  end
end

13.1
<%= form_for @user, url: '/people' do |f| %>
  <%= f.label :name, 'My Very Special Name' %>
  <%= f.text_field :name, class: 'super-name' %>
  <%= f.text_field :email %>
  <%= f.fields_for :projects do |proj_f| %>
    <%= proj_f.checkbox :id %>
    <%= proj_f.label :id %>
  <% end %>
<% end %>
%>

13.2
<form action="/users" method="post">
  <label for="user_name">My Very Special Name</label>
  <input id="user_name" name="user[name][super-name]">
  <input id="user_email" name="user[email]">

  <input type="checkbox" id="project1_id" name="projects[id][]" value="1">
  <label for="project1_id">Project1</label>

    ...

  <input type="checkbox" id="project10_id" name="projects[id][]" value="10">
  <label for="project10_id">Project1</label>

  <input type="hidden" name="authenticity_token" value="akfdshj23987EKsadfs">
  <input type="submit" value="Submit"
</form>


13.3
params = {user: {name: {super-name: "Name"}, email: "name@name.na.me"}, projects: {id: [1,2,3,4...]}}

14.1
The controller action will create the user but nothing else; assuming that users to projects is a many-to-many relationship, new code would need to added to build the join-table association between the two.

14.2
class UsersController
  def create
    @user = User.create(params[:user])
    @user.project_ids = params[:projects]
  end

  def new
    @user = User.new
  end
end