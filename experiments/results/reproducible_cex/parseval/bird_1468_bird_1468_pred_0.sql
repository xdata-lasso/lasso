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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_1', 'Garrett', 'Gerke', 'tti', 'bnp', 'mdpos', 'ie5', 1, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_2', 'Garrett', 'Gerke', 'p5s5bbp', '02eutliqa11r', 'ytoo3o9', 'l7', 1, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_3', 'Garrett', 'Gerke', 'p5qi2rk', '9v', 'x58pz', 'f8jegd2', 3, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_4', 'Garrett', 'Gerke', 'dqwn', 'cx5hn', 'p', 'jtu0d', 3, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_5', 'Garrett', 'Gerke', '9fjgq8n2f', 'dqv0gcb9', 'ozk3zbily', 'kn6vc', 3, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_6', 'Garrett', 'Gerke', 'ah0f8jsww', 'q7x', '7', '2fxa7ryfdrz', 3, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 'Garrett', 'Gerke', '6nijjai5dh', 'ogrgjd8y', 't1afgog', 'itsj3', 1, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('C', 'Garrett', 'Gerke', 'xp1q430', 'jh3den8', 'c68x8vacx7', 'f', 1, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('Q', 'Garrett', 'Gerke', 'w1of77pz', '72ct', 'c', 'mfg62', 1, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', 'Garrett', 'Gerke', '5q8qdj', 'e1io', '278507cv', 'jpttg', 1, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_11', 't1__ba0ae2', 'Gerke', 'u5zi', '6c4bfkfo', 'c', '0', 1, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_12', 'Garrett', 't1__2600aa', 'zezjo7wg', 'd5ysxc', 'r0oz', 'dgj5i', 1, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_13', 'Garrett', 'Gerke', 'q5l', 'pim5', '58q', 's27p2r94gth2', 1, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 'Garrett', NULL, 'ia2yp', 'uzhsrwbbp6lu', 'hvdlttilbnpr', 'dpos', 4, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('H', 't1__ba0ae2', 't1__2600aa', 'p5s5bbp', '02eutliqa11r', 'ytoo3o9', 'l7', 5, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('B', 't1__ba0ae2', NULL, 'kf9vq', 'x58pz0f8je', 'd2', 'vy9uxj4', 6, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('`', NULL, 'Gerke', 'hncprjtu0dz', '9fjgq8n2f', 'dqv0gcb9', 'ozk3zbily', 7, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('D', NULL, 't1__2600aa', 'fdrz16n', 'jja', '5dh', 'ogrgjd8y', 8, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('F', NULL, NULL, '68x8vacx7a', 'u5', '1of77p', 'o72ctdc', 9, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('a', 'Garrett', 'Gerke', 'dpos', 'ie5', 'nw6klf', 'a9000t5c4eci', 10, 'major_id_1');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1, '5k5swwqcgs', 't2__beb766', '9n8', '4', 'gu7v');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483647, 'nw6klf', 't2__beb766', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (3, 'lex', '4ji7zwa', '2dwyrq', '3pyu78d', '9rljsl0b4');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (2, 'vy9uxj4', 't2__beb766', 'wb', 'v', 'ph2');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (4, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (5, 'ie5', 'nw6klf', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (6, 'klex14ji', '7zwau2dwyr', '13pyu', '8d99rljsl', 'b4yp5qi');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (7, 'wb', 'v', 'ph2', 'nd', 'wnqcx');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (8, 'kn6vc', '6ah', 'f8jswwl', '7xb72', 'xa');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (9, 't1afgog', 'itsj3', 'y', 'p1q430', 'jh3den8');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (10, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483637, 'hria2ypuzhs', NULL, 'rwbbp6luhvd', 'tti', 'bnp');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.city FROM member AS T1 INNER JOIN zip_code AS T2 ON T2.zip_code = T1.zip WHERE T1.first_name = 'Garrett' AND T1.last_name = 'Gerke';

/*
Gold Result:
('t2__beb766',)
('t2__beb766',)
('4ji7zwa',)
('4ji7zwa',)
('4ji7zwa',)
('4ji7zwa',)
('t2__beb766',)
('t2__beb766',)
('t2__beb766',)
('t2__beb766',)
('t2__beb766',)
('9n8',)
*/

-- Prediction Query
SELECT T1.city FROM zip_code AS T1 INNER JOIN member AS T2 ON T1.zip_code = T2.zip WHERE T2.first_name = 'Garrett' AND T2.last_name = 'Girke';

/*
Prediction Result:
*/