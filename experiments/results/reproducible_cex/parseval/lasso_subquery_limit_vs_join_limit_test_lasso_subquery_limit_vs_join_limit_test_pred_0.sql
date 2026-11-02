-- Schema DDL
CREATE TABLE users (user_id INTEGER PRIMARY KEY, name TEXT, points INTEGER);

CREATE TABLE comments (comment_id INTEGER PRIMARY KEY, user_id INTEGER, score INTEGER, FOREIGN KEY (user_id) REFERENCES users (user_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: users --
INSERT INTO "users" ("user_id", "name", "points") VALUES (1, '5k5swwqcgs', 247012447);

INSERT INTO "users" ("user_id", "name", "points") VALUES (-2147483647, '8c4pgu7vfe', -1633151678);

INSERT INTO "users" ("user_id", "name", "points") VALUES (-1, 'a2y', -1);

INSERT INTO "users" ("user_id", "name", "points") VALUES (-2147483645, 'uzhs', 1);

INSERT INTO "users" ("user_id", "name", "points") VALUES (-2147483644, 'rwbbp6luhvd', 1);

INSERT INTO "users" ("user_id", "name", "points") VALUES (-2147483643, 'tti', 1);

-- Inserting into table: comments --
INSERT INTO "comments" ("comment_id", "user_id", "score") VALUES (1, 1, 1);

INSERT INTO "comments" ("comment_id", "user_id", "score") VALUES (2, 1, 1);

INSERT INTO "comments" ("comment_id", "user_id", "score") VALUES (3, 1, 1);

INSERT INTO "comments" ("comment_id", "user_id", "score") VALUES (-2147483645, 1, 1);

INSERT INTO "comments" ("comment_id", "user_id", "score") VALUES (-2147483644, 1, 1);

INSERT INTO "comments" ("comment_id", "user_id", "score") VALUES (-2147483643, 1, 1);

INSERT INTO "comments" ("comment_id", "user_id", "score") VALUES (-2147483642, 1, 1);

INSERT INTO "comments" ("comment_id", "user_id", "score") VALUES (-2147483641, 1, 1);

INSERT INTO "comments" ("comment_id", "user_id", "score") VALUES (-2147483640, 1, 1);

INSERT INTO "comments" ("comment_id", "user_id", "score") VALUES (-2147483639, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c.score FROM users AS u INNER JOIN comments AS c ON u.user_id = c.user_id ORDER BY u.points ASC, u.user_id, c.comment_id LIMIT 1;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT c.score FROM comments AS c WHERE c.user_id IN (SELECT u.user_id FROM users AS u ORDER BY u.points ASC, u.user_id LIMIT 1);

/*
Prediction Result:
*/