DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS topics CASCADE;
DROP TABLE IF EXISTS comments CASCADE;

CREATE TABLE users(
  id        SERIAL PRIMARY KEY,
  username  VARCHAR NOT NULL,
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
