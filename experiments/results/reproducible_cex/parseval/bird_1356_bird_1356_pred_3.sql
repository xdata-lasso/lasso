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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_1', 'tti', 'bnp', 'mdpos', 'President', 'ie5', 'nw6klf', -2147483648, 't1__92541a');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_2', 'u', '4nrq', 'rofqyp5s5b', 'President', 'p', '02eutliqa11r', -2147483648, 't1__92541a');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_3', 'au2dwy', 'q13py', '78d99r', 'President', 'jsl', 'b4yp5qi', -2147483648, 't1__65b6d5');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_4', 'h2gn', 'q', 'nqcx5h', 'President', 'cprj', 'u0dz7', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_5', 'gq8', 'n2f3dqv0gcb9', 'ozk3zbily', 'President', 'kn6vc', '6ah', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_6', '8j', 'wwlq7', 'xb72fxa7ryfd', 'President', 'z16ni', 'jai', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', 'h', 'ogrgjd8y', 't1afgog', 'President', 'itsj3', 'y', -2147483648, 't1__92541a');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', '1q43', '1jh3den', 'c68x8vacx', 'President', 'afu5w1of7', 'pzo72ctdc', -2147483648, 't1__92541a');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('_', 'mfg62g0v5q8q', 'j', 'e1io', 'President', '278507cv', 'jpttg', -2147483648, 't1__92541a');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('?', 'u5zi', '6c4bfkfo', 'c', 'President', '0', '7z2zezjo7wg', -2147483648, 't1__92541a');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_11', 'ysxcmr0o', 'ztdgj5i3lq5l', 'pim5', 't1__575a0b', '58q', 's27p2r94gth2', -2147483648, 't1__92541a');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_12', 'tmu2ne578l', 'vy', '7zzbe8y', 'President', 'kv42q7', 'x58b4', -2147483648, 't1__92541a');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 'u7', 'fe4hri', 'a2ypuzhsrwbb', NULL, 'p6luhvdlttil', 'n', -2147483648, '@');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('D', 'ia2yp', 'uzhsrwbbp6lu', 'hvdlttilbnpr', 'President', 'dpos', 'ie5', -2147483648, '!');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('H', 'eutliqa11r', 'ytoo3o9', 'l7', 'President', 'klex14ji', '7zwau2dwyr', -2147483648, 'B');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('B', 'vy9uxj4', 'wb', 'v', 'President', 'ph2', 'nd', -2147483648, '"');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('`', 'kn6vck6ah0f8', 'sww', 'q7x', 'President', '7', '2fxa7ryfdrz', -2147483648, 'C');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('a', '1q43', '1jh3den', 'c68x8vacx', 'President', 'afu5w1of7', 'pzo72ctdc', -2147483648, 'D');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('"', 'tg6bnou5zi', '6c4bfkfo', 'c', 'President', '0', '7z2zezjo7wg', -2147483648, 'F');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t1__92541a', '5k5swwqcgs', 't2__ca386d', '9n8');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_2', 'a9000t5c4eci', 't2__ca386d', 'gce376nium52');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t1__65b6d5', 'ytoo3o9', 'l7', 'klex14ji');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('O', 'rkf9vqx5', 't2__ca386d', 'pz0f8jegd');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('A', '1vy9uxj4', 'wb', 'v');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t2__e40579', 'najj', 'a3o', 'v8u');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('@', '5k5swwqcgs', '9n8', '4');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('!', '5k5swwqcgs', '9n8', '4');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_9', 'gu7v', NULL, 'e4');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('B', 'nw6klf', 'a9000t5c4eci', 'gce376nium52');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_11', 'zbuo4nrqrof', NULL, 'qyp5s5bbp0');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('"', '13pyu', '8d99rljsl', 'b4yp5qi');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_13', 'rkf9vqx5', NULL, 'pz0f8jegd');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('C', 'wnqcx', '5hncprjtu0d', '79fjgq8');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_15', 'n2f3dqv0gcb9', NULL, 'ozk3zbily');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('D', '16nijjai5dh', 'ogrgjd8y', 't1afgog');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_17', 'itsj3', NULL, 'y');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('F', 'mfg62', '0v', 'q8qdjpe1');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_19', 'o22', NULL, '8507cvtjp');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, '4', 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.department FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id WHERE T1.position = 'President';

/*
Gold Result:
('t2__ca386d',)
('t2__ca386d',)
('l7',)
('wb',)
('wb',)
('wb',)
('t2__ca386d',)
('t2__ca386d',)
('t2__ca386d',)
('t2__ca386d',)
('t2__ca386d',)
('9n8',)
('a9000t5c4eci',)
('8d99rljsl',)
('5hncprjtu0d',)
('ogrgjd8y',)
('0v',)
*/

-- Prediction Query
SELECT DISTINCT T2.department FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id WHERE T1.position = 'President';

/*
Prediction Result:
('t2__ca386d',)
('l7',)
('wb',)
('9n8',)
('a9000t5c4eci',)
('8d99rljsl',)
('5hncprjtu0d',)
('ogrgjd8y',)
('0v',)
*/