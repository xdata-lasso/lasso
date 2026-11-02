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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_1', 'Brent', 'Thomason', 'tti', 'bnp', 'mdpos', 'ie5', -2147483648, 't1__45b4d3');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_2', 'Brent', 'Thomason', 'e', '76nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', -2147483648, 't1__45b4d3');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_3', 'Brent', 'Thomason', 'lex', '4ji7zwa', '2dwyrq', '3pyu78d', -2147483648, 'C');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_4', 'Brent', 'Thomason', 'y9uxj4', 'wb', 'v', 'ph2', -2147483648, '_');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_5', 'Brent', 'Thomason', '9fjgq8n2f', 'dqv0gcb9', 'ozk3zbily', 'kn6vc', -2147483648, 'G');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_6', 'Brent', 'Thomason', 'ah0f8jsww', 'q7x', '7', '2fxa7ryfdrz', -2147483648, 'G');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', 'Brent', 'Thomason', '6nijjai5dh', 'ogrgjd8y', 't1afgog', 'itsj3', -2147483648, 't1__45b4d3');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 'Brent', 'Thomason', 'xp1q430', 'jh3den8', 'c68x8vacx7', 'f', -2147483648, 't1__45b4d3');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('I', 'Brent', 'Thomason', 'w1of77pz', '72ct', 'c', 'mfg62', -2147483648, 't1__45b4d3');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_10', 't1__6739e6', 'Thomason', 'q8qdjpe1io22', '8507cvtjp', 'ttg6bnou5zi3', 'c4bfkfoac', -2147483648, 't1__45b4d3');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_11', 'Brent', 't1__57686c', '7z2zezj', '7wgx', '5', 'sxcmr0o', -2147483648, 't1__45b4d3');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_12', 'Brent', 'Thomason', '7p2r94gt', '2m', 'ajjl', '3', -2147483648, 't1__45b4d3');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 'Brent', NULL, 'u7', 'fe4hri', 'a2ypuzhsrwbb', 'p6luhvdlttil', -2147483648, '@');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('H', 't1__6739e6', 't1__57686c', 'nw6klf', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof', -2147483648, 'B');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('B', 't1__6739e6', NULL, '72k', 'ex1', 'ji7zwau2', 'dwyrq13pyu78', -2147483648, 'D');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('C', NULL, 'Thomason', 'x58pz0f8je', 'd2', 'vy9uxj4', 'wb', -2147483648, 'c');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('D', NULL, 't1__57686c', 'nqcx5h', 'cprj', 'u0dz7', 'fjgq8n2f3', -2147483648, 'F');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('F', NULL, NULL, 'lq7xb7', '2fxa7ryfdrz', '16nijjai5dh', 'ogrgjd8y', -2147483648, 'E');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('`', 'Brent', 'Thomason', 'ia2yp', 'uzhsrwbbp6lu', 'hvdlttilbnpr', 'dpos', -2147483648, '?');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t1__45b4d3', 't2__ca739e', '5k5swwqcgs', '9n8');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_2', 't2__ca739e', 'nw6klf', 'a9000t5c4eci');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('C', '2eutliqa11r', 'ytoo3o9', 'l7');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('A', 't2__ca739e', '9rljsl0b4', 'p5qi2rk');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('_', '9v', 'x58pz', 'f8jegd2');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('G', 'nd', 'wnqcx', '5hncprjtu0d');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t2__1667fa', 'ztdgj5i3lq5l', 'pim5', '58q');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('@', '5k5swwqcgs', '9n8', '4');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('B', 'n', 'rmdp', 'siie');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('D', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('c', '9', 'rljsl0b4y', 'p5qi2rkf9v');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('F', 'v', 'ph2', 'nd');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('E', 'dqv0gcb98ozk', 'zbilyrkn', '6vck6ah0f8js');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_14', NULL, '5k5swwqcgs', '9n8');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('?', '4', 'gu7v', 'e4');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, '4', 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.major_name FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id WHERE T1.first_name = 'Brent' AND T1.last_name = 'Thomason';

/*
Gold Result:
('t2__ca739e',)
('t2__ca739e',)
('2eutliqa11r',)
('9v',)
('nd',)
('nd',)
('t2__ca739e',)
('t2__ca739e',)
('t2__ca739e',)
('t2__ca739e',)
('4',)
*/

-- Prediction Query
SELECT T2.major_name FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id WHERE T1.last_name = 'Thomason';

/*
Prediction Result:
('t2__ca739e',)
('t2__ca739e',)
('2eutliqa11r',)
('9v',)
('nd',)
('nd',)
('t2__ca739e',)
('t2__ca739e',)
('t2__ca739e',)
('t2__ca739e',)
('t2__ca739e',)
('9',)
('4',)
*/