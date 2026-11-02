-- Schema DDL
CREATE TABLE users (user_id INTEGER PRIMARY KEY, name TEXT, points INTEGER);

CREATE TABLE comments (comment_id INTEGER PRIMARY KEY, user_id INTEGER, score INTEGER, FOREIGN KEY (user_id) REFERENCES users (user_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (user_id, name, points) VALUES (1, 'Alice', 10);
INSERT INTO comments (comment_id, user_id, score) VALUES (1, 1, 5);
INSERT INTO comments (comment_id, user_id, score) VALUES (2, 1, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c.score FROM users AS u INNER JOIN comments AS c ON u.user_id = c.user_id ORDER BY u.points ASC, u.user_id, c.comment_id LIMIT 1;

/*
Gold Result:
(5,)
*/

-- Prediction Query
SELECT c.score FROM comments AS c WHERE c.user_id IN (SELECT u.user_id FROM users AS u ORDER BY u.points ASC, u.user_id LIMIT 1);

/*
Prediction Result:
(5,)
(10,)
*/