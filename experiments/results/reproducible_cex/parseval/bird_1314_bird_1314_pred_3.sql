-- Schema DDL
CREATE TABLE event (event_id TEXT CONSTRAINT event_pk PRIMARY KEY, event_name TEXT, event_date TEXT, type TEXT, notes TEXT, location TEXT, status TEXT);

CREATE TABLE major (major_id TEXT CONSTRAINT major_pk PRIMARY KEY, major_name TEXT, department TEXT, college TEXT);

CREATE TABLE zip_code (zip_code INTEGER CONSTRAINT zip_code_pk PRIMARY KEY, type TEXT, city TEXT, county TEXT, state TEXT, short_state TEXT);

CREATE TABLE "attendance" (link_to_event TEXT, link_to_member TEXT, PRIMARY KEY (link_to_event, link_to_member), FOREIGN KEY (link_to_event) REFERENCES event (event_id), FOREIGN KEY (link_to_member) REFERENCES member (member_id));

CREATE TABLE "budget" (budget_id TEXT PRIMARY KEY, category TEXT, spent REAL, remaining REAL, amount INTEGER, event_status TEXT, link_to_event TEXT, FOREIGN KEY (link_to_event) REFERENCES event (event_id));

CREATE TABLE "expense" (expense_id TEXT PRIMARY KEY, expense_description TEXT, expense_date TEXT, cost REAL, approved TEXT, link_to_member TEXT, link_to_budget TEXT, FOREIGN KEY (link_to_budget) REFERENCES budget (budget_id), FOREIGN KEY (link_to_member) REFERENCES member (member_id));

CREATE TABLE "income" (income_id TEXT CONSTRAINT income_pk PRIMARY KEY, date_received TEXT, amount INTEGER, source TEXT, notes TEXT, link_to_member TEXT, FOREIGN KEY (link_to_member) REFERENCES member (member_id));

CREATE TABLE "member" (member_id TEXT CONSTRAINT member_pk PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, position TEXT, t_shirt_size TEXT, phone TEXT, zip INTEGER, link_to_major TEXT, FOREIGN KEY (link_to_major) REFERENCES major (major_id), FOREIGN KEY (zip) REFERENCES zip_code (zip_code));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: member --
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_1', 't1__a0da3e', 't1__292f05', 'tti', 'bnp', 'mdpos', 'ie5', -2147483648, 't1__dbdff9');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 't1__a0da3e', 't1__292f05', 'e', '76nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', -2147483648, 't1__dbdff9');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('C', 't1__a0da3e', 't1__292f05', 'lex', '4ji7zwa', '2dwyrq', '3pyu78d', -2147483648, 't1__e149d5');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_4', 't1__a0da3e', 't1__292f05', 'y9uxj4', 'wb', 'v', 'ph2', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_5', 't1__a0da3e', 't1__292f05', 'dqwn', 'cx5hn', 'p', 'jtu0d', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_6', 't1__a0da3e', 't1__292f05', 'k3zbily', 'kn6vc', '6ah', 'f8jswwl', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('_', 't1__a0da3e', 't1__292f05', 'xb72fxa7r', 'fdrz16n', 'jja', '5dh', -2147483648, 't1__dbdff9');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('Q', 't1__a0da3e', 't1__292f05', 'rg', 'd8y', 't1afgog', 'itsj3', -2147483648, 't1__dbdff9');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', 't1__a0da3e', 't1__292f05', 'p1q430', 'jh3den8', 'c68x8vacx7', 'f', -2147483648, 't1__dbdff9');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_10', 't1__a0da3e', 't1__292f05', '1of77p', 'o72ctdc', 'mfg62', '0v', -2147483648, 't1__dbdff9');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_11', 't1__a0da3e', NULL, 'tg6bnou5zi', '6c4bfkfo', 'c', '0', -2147483648, 't1__dbdff9');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_12', NULL, 't1__292f05', 'zezjo7wg', 'd5ysxc', 'r0oz', 'dgj5i', -2147483648, 't1__dbdff9');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 'pgu7vfe4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'bnp', 'mdpos', -2147483648, '@');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t1__dbdff9', '5k5swwqcgs', 'Art and Design Department', '9n8');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_2', 'nw6klf', 'Art and Design Department', 'a9000t5c4eci');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t1__e149d5', '2eutliqa11r', 'ytoo3o9', 'l7');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('G', '9rljsl0b4', 'Art and Design Department', 'p5qi2rk');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('A', '9v', 'x58pz', 'f8jegd2');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('C', '79fjgq8', 'Art and Design Department', 'n2f3dqv0gcb9');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t2__286d41', 'q8qdjpe1', 'o22', '8507cvtjp');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('@', '5k5swwqcgs', NULL, '9n8');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, '4', 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.first_name, T1.last_name FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id WHERE T2.department = 'Art and Design Department';

/*
Gold Result:
('t1__a0da3e', 't1__292f05')
('t1__a0da3e', 't1__292f05')
('t1__a0da3e', 't1__292f05')
('t1__a0da3e', 't1__292f05')
('t1__a0da3e', 't1__292f05')
('t1__a0da3e', 't1__292f05')
('t1__a0da3e', None)
(None, 't1__292f05')
*/

-- Prediction Query
SELECT T1.first_name, T1.last_name FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id WHERE T2.department = 'Art and Design Department' AND T1.position = 'Member';

/*
Prediction Result:
*/