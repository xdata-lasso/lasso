-- Schema DDL
CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE posts (id INTEGER PRIMARY KEY, user_id INTEGER, title TEXT, FOREIGN KEY (user_id) REFERENCES users (id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: users --
INSERT INTO "users" ("id", "name") VALUES (1, 'u_s_58d80a');

INSERT INTO "users" ("id", "name") VALUES (2, 'u_s_58d80a');

INSERT INTO "users" ("id", "name") VALUES (3, 'u_s_58d80a');

INSERT INTO "users" ("id", "name") VALUES (4, '5k5swwqcgs');

-- Inserting into table: posts --
INSERT INTO "posts" ("id", "user_id", "title") VALUES (-2147483648, 1, 'p_s_c6e42d');

INSERT INTO "posts" ("id", "user_id", "title") VALUES (2, 2, 'p_s_c6e42d');

INSERT INTO "posts" ("id", "user_id", "title") VALUES (3, 2, 'p_s_c6e42d');

INSERT INTO "posts" ("id", "user_id", "title") VALUES (-2147483645, 4, 'p_s_c6e42d');

INSERT INTO "posts" ("id", "user_id", "title") VALUES (-2147483644, 4, 'p_s_c6e42d');

INSERT INTO "posts" ("id", "user_id", "title") VALUES (-2147483643, 1, NULL);

INSERT INTO "posts" ("id", "user_id", "title") VALUES (-2147483642, 1, 'p_s_c6e42d');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, p.title FROM users AS u LEFT JOIN posts AS p ON u.id = p.user_id;

/*
Gold Result:
('u_s_58d80a', None)
('u_s_58d80a', 'p_s_c6e42d')
('u_s_58d80a', 'p_s_c6e42d')
('u_s_58d80a', 'p_s_c6e42d')
('u_s_58d80a', 'p_s_c6e42d')
('u_s_58d80a', None)
('5k5swwqcgs', 'p_s_c6e42d')
('5k5swwqcgs', 'p_s_c6e42d')
*/

-- Prediction Query
SELECT u.name, p.title FROM users AS u CROSS JOIN posts AS p ON u.id = p.user_id;

/*
Prediction Result:
('u_s_58d80a', None)
('u_s_58d80a', 'p_s_c6e42d')
('u_s_58d80a', 'p_s_c6e42d')
('u_s_58d80a', 'p_s_c6e42d')
('u_s_58d80a', 'p_s_c6e42d')
('5k5swwqcgs', 'p_s_c6e42d')
('5k5swwqcgs', 'p_s_c6e42d')
*/