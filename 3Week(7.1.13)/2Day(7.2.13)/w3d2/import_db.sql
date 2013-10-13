CREATE TABLE users (

  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL

);

CREATE TABLE questions (

  id INTEGER PRIMARY KEY,
  author_id INTEGER NOT NULL,
  title VARCHAR(255),
  body TEXT NOT NULL,

  FOREIGN KEY(author_id) REFERENCES users(id)

);

CREATE TABLE questions_followers (

  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY(user_id) REFERENCES users(id),
  FOREIGN KEY(question_id) REFERENCES questions(id)

);

CREATE TABLE replies (

  id INTEGER PRIMARY KEY,
  author_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  parent_id INTEGER,
  body TEXT NOT NULL,

  FOREIGN KEY(author_id) REFERENCES users(id),
  FOREIGN KEY(question_id) REFERENCES questions(id),
  FOREIGN KEY(parent_id) REFERENCES replies(id)

);

CREATE TABLE question_likes (

  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY(user_id) REFERENCES users(id),
  FOREIGN KEY(question_id) REFERENCES questions(id)

);

INSERT INTO users (fname, lname)
VALUES  ('Willem', 'van Daalen'),
        ('Wells', 'Johnston'),
        ('Abdel', 'Soumahoro');

INSERT INTO questions(author_id, title, body)
VALUES  (1, 'How many?', 'At least a bushel.'),
        (2, 'Is it enough?', 'Not nearly.'),
        (3, 'Will there be more?', 'Not bloody likely.');

INSERT INTO questions_followers (user_id, question_id)
VALUES  (1, 1), (2, 2), (3, 3), (2, 1);

INSERT INTO replies(author_id, question_id, parent_id, body)
VALUES  (2, 1, null, 'Two bushels would be best.'),
        (1, 1, 1, 'Three would be better.'),
        (3, 2, null, 'Maybe almost enough.');

INSERT INTO question_likes(user_id, question_id)
VALUES  (1, 2), (2, 2), (3, 2), (2, 1);