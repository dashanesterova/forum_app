DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS topics CASCADE;
DROP TABLE IF EXISTS comments CASCADE;

CREATE TABLE users(
  id        SERIAL PRIMARY KEY,
  username  VARCHAR NOT NULL,
  email     VARCHAR NOT NULL,
  password  VARCHAR NOT NULL
);

CREATE TABLE topics(
  id        SERIAL PRIMARY KEY,
  name      VARCHAR NOT NULL,
  description   VARCHAR,
  user_id   INTEGER REFERENCES users(id)
);

CREATE TABLE comments(
  id        SERIAL PRIMARY KEY,
  text      VARCHAR NOT NULL,
  votes     INTEGER,
  topic_id  INTEGER REFERENCES topics(id),
  user_id   INTEGER REFERENCES users(id)
);

INSERT INTO users
  (username, email, password)

VALUES
( 'RobSmith', 'rob@smith.com', '12345');


INSERT INTO topics
  (name, description, user_id)

VALUES
( 'Cooking', 'Salads', 1),
( 'Dancing', 'Salsa', 1);

INSERT INTO comments
  (text, votes, topic_id, user_id)

VALUES
( 'boiling', 3, 1, 1),
( 'frying', 2, 1, 1),
( 'ballet', 4, 2, 1),
( 'salsa', -2, 2, 1);

