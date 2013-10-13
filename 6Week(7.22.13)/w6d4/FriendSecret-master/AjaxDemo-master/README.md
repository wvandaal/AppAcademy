# First Ajax Project

This project is a simple secret sharing project. I've written two
models: `User` and `Secret`. I've also built `UsersController` and
`SessionsController` to do login for you.

## Phase I: secrets form

Write a `/users/123/secrets/new` form. You'll need to create a nested
route.

When you post a secret, you are sharing it to someone's 'wall'. The
recipient's user id is in the URL. For example,
`/users/123/secrets/new` is going to create a secret where `User` 123
is the recipient. You should not need any hidden fields or other form
fields to accomplish this. The sender can be found through
`current_user`.

## Phase II: Add friendships

Write a `Friendship` model to join `User` to `User`. Friendship is
one-way in this application. Write a simple `Friendships` controller
(the only action needed is `create`, I think). Nest a `friendship`
resource inside the `users` resource. Friending someone should be as
simple as POSTing to `/users/123/friendship`.

On the `/users` page, list all users, and add a `friend` button for
each. Since you don't need a full-fledged form (there should be no
params to POST), your form can be empty except for the submit button.

Make the form a "remote" form: submit it via AJAX.

When clicked, change the button text to "Friending..." and disable the
submit button. When the request succeeds, change the text to
"Friended".

When the template is first rendered, appropriately grey-out the button
if a user has already been friended.

## Phase III: Remove friendships

All things must end; you grow apart. You're still proud of your
friend, but you don't stay in touch anymore.

Add a second button, to unfriend a user. You'll need a `destroy`
action on `FriendshipsController`.

You now want the unfriend button to appear when you are friends, and
the friend button to appear when you are not. The cleanest way to do
this is to:

0. Write both buttons (and forms), display them both.
0. Place the two buttons in a div or span, give this a CSS class of
   `friend_buttons`. Likewise, give your buttons classes of `friend`
   and `unfriend`.
0. If we are friends, set a second class on your div:
   `friended`. Otherwise, set `unfriended` as the class.
0. Write a CSS rule so that `.friend_buttons.friended friend` is
   `visibility: hidden`. Do likewise for `.friend_buttons.unfriended
   unfriend`.
0. Lastly, when either button is pressed, swap the class of of the div
   (see `$.toggleClass`).

## Interlude: RESTful design and nested resources

Notice how the friend/unfriend action has been written in terms of a
nested `friendship` resource. This is a common pattern: take a verb
action, think of the noun that might be created by that action, and
nest that as a resource. This is one of the secrets to nice, RESTful
designs.

## Phase IV: Remote secrets form

We have a `/users/123/secrets/new` page that displays a form. I'd like
to be able to post a new secret directly from the `/users/123` page.

Move the `new.html.erb` template into a partial (perhaps
`_form.html.erb`). Use AJAX to make the form remote. Render the
partial in `users/show.html.erb` page.

On successful submission, add the new secret to the `ul` listing all
the secrets. Clear the form so the user can submit more secrets! :-)

## Phase V: Simple dynamic form (no nesting)

Let's allow users to tag secrets when they create them. Add `Tag` and
`SecretTagging` models. Set up appropriate associations.

Because `Secret` `has_many :tags, :through => :secret_taggings`, we
can use `Secret#tag_ids=`. We saw how to tag a secret with many tags
through a set of checkboxes. But what if there are lots of tags to
choose from? Do we really want to present 100 checkboxes?

Instead, let's present a single `select` tag. Let's also present a
link "Add another tag". Clicking this link should invoke a JS function
that will add another `select` tag.

### JSON data script trick

Creating new `select` tags means you'll have to create `option` tags:
one for each `Tag`. To give your JavaScript code access to the list of
`Tag`s, I'd store the JSONified `Tag`s in an HTML script tag. Check
out the [bootstrapping data][bootstrapping-data] chapter for hints.

[bootstrapping-data]: https://github.com/appacademy/js-curriculum/blob/master/client-side-js/bootstrapping-data.md

### Underscore template trick

When the user clicks the "Add another tag" link, we need to insert
another select box into the form. Since this involves building HTML to
inject into the form, we can use an underscore template. Recall how to
do this by referring to the
[underscore templates][underscore-templates] reading.

[underscore-templates]: https://github.com/appacademy/js-curriculum/blob/master/client-side-js/underscore-templates.md
