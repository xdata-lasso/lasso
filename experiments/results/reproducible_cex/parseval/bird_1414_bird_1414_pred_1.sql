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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_1', 'Phillip', 'Cullen', 'tti', 'bnp', 'mdpos', 'ie5', -2147483648, 't1__ecee0d');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_2', 'Phillip', 'Cullen', 'p5s5bbp', '02eutliqa11r', 'ytoo3o9', 'l7', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_3', 'Phillip', 'Cullen', 'lex', '4ji7zwa', '2dwyrq', '3pyu78d', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_4', 'Phillip', 'Cullen', 'vqx58pz0f', '8jegd21vy9ux', 'j4hwbdvlph', 'gndqwnqc', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_5', 'Phillip', 'Cullen', '5hncprjtu0d', '79fjgq8', 'n2f3dqv0gcb9', 'ozk3zbily', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_6', 'Phillip', 'Cullen', '8j', 'wwlq7', 'xb72fxa7ryfd', 'z16ni', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('G', 'Phillip', 'Cullen', 'yzt1afgog', 'itsj3', 'y', 'p1q430', -2147483648, 't2__4849c8');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 'Phillip', 'Cullen', 'jh3den8c68', '8vacx7', 'f', '5w1of7', -2147483648, 't2__4849c8');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', 'Phillip', 'Cullen', '72ctdctmfg62', '0v', 'q8qdjpe1', 'o22', -2147483648, 't2__4849c8');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_10', 't2__258fa9', 'Cullen', '7cvtjpttg6b', 'ou5z', '36c', 'bfkfoacd', -2147483648, 't1__ecee0d');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_11', 'Phillip', 't2__b0bca1', '7z2zezjo7wg', 'd5ysxc', 'r0oz', 'dgj5i', -2147483648, 't1__ecee0d');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_12', 'Phillip', 'Cullen', 'q5l', 'pim5', '58q', 's27p2r94gth2', -2147483648, 't1__ecee0d');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 'Phillip', NULL, 'u7', 'fe4hri', 'a2ypuzhsrwbb', 'p6luhvdlttil', -2147483648, '@');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('H', 't2__5d705a', 't2__28cdd4', 'nw6klf', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof', -2147483648, '`');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('I', 't2__5d705a', NULL, '72k', 'ex1', 'ji7zwau2', 'dwyrq13pyu78', -2147483648, 'H');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('D', NULL, 'Cullen', 'x58pz0f8je', 'd2', 'vy9uxj4', 'wb', -2147483648, 'a');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('E', NULL, 't2__28cdd4', 'nqcx5h', 'cprj', 'u0dz7', 'fjgq8n2f3', -2147483648, '!');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('`', NULL, NULL, 'lq7xb7', '2fxa7ryfdrz', '16nijjai5dh', 'ogrgjd8y', -2147483648, '"');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('a', 'Phillip', 'Cullen', 'pgu7vfe4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', -2147483648, 'B');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t1__ecee0d', 't1__587495', '5k5swwqcgs', '9n8');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('A', 't1__587495', 'nw6klf', 'a9000t5c4eci');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t1__0a5745', 't1__587495', 'gce376nium52', 'zbuo4nrqrof');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('O', 't1__587495', '9rljsl0b4', 'p5qi2rk');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('G', 't1__587495', 'kn6vc', '6ah');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t2__4849c8', 't1__587495', 'jai', 'dh5ogrgj');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('@', '5k5swwqcgs', '9n8', '4');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('`', 'n', 'rmdp', 'siie');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('H', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('a', '9', 'rljsl0b4y', 'p5qi2rkf9v');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('!', 'v', 'ph2', 'nd');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('"', 'dqv0gcb98ozk', 'zbilyrkn', '6vck6ah0f8js');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('B', NULL, '5k5swwqcgs', '9n8');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, '4', 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.major_name FROM major AS T1 INNER JOIN member AS T2 ON T1.major_id = T2.link_to_major WHERE T2.first_name = 'Phillip' AND T2.last_name = 'Cullen';

/*
Gold Result:
('t1__587495',)
('t1__587495',)
('t1__587495',)
('t1__587495',)
('t1__587495',)
('t1__587495',)
('t1__587495',)
('t1__587495',)
('t1__587495',)
('t1__587495',)
(None,)
*/

-- Prediction Query
SELECT T2.major_name FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id WHERE T1.first_name = 'Phillip';

/*
Prediction Result:
('t1__587495',)
('t1__587495',)
('t1__587495',)
('t1__587495',)
('t1__587495',)
('t1__587495',)
('t1__587495',)
('t1__587495',)
('t1__587495',)
('t1__587495',)
('t1__587495',)
('5k5swwqcgs',)
(None,)
*/