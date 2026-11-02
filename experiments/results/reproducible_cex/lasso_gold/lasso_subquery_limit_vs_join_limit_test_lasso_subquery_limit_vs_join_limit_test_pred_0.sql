-- Schema DDL
CREATE TABLE users (user_id INTEGER PRIMARY KEY, name TEXT, points INTEGER);

CREATE TABLE comments (comment_id INTEGER PRIMARY KEY, user_id INTEGER, score INTEGER, FOREIGN KEY (user_id) REFERENCES users (user_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "users" ("user_id", "name", "points") VALUES (1001, 'Allison Hill', 1005);
INSERT INTO "users" ("user_id", "name", "points") VALUES (1002, 'Noah Rhodes', 1012.0);
INSERT INTO "users" ("user_id", "name", "points") VALUES (1003, 'Angie Henderson', 1019.0);
INSERT INTO "users" ("user_id", "name", "points") VALUES (1004, 'Daniel Wagner', 1026.0);
INSERT INTO "comments" ("comment_id", "user_id", "score") VALUES (1009, 1001, 1013);
INSERT INTO "comments" ("comment_id", "user_id", "score") VALUES (1010, 1001, 1020.0);
INSERT INTO "comments" ("comment_id", "user_id", "score") VALUES (1011, 1001, 1027.0);
INSERT INTO "comments" ("comment_id", "user_id", "score") VALUES (1012, 1001, 1034.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c.score FROM users AS u INNER JOIN comments AS c ON u.user_id = c.user_id ORDER BY u.points ASC, u.user_id, c.comment_id LIMIT 1;

/*
Gold Result:
(1013,)
*/

-- Prediction Query
SELECT c.score FROM comments AS c WHERE c.user_id IN (SELECT u.user_id FROM users AS u ORDER BY u.points ASC, u.user_id LIMIT 1);

/*
Prediction Result:
(1013,)
(1020,)
(1027,)
(1034,)
*/