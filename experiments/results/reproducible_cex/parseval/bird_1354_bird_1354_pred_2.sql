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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_1', 'tti', 'bnp', 'mdpos', 'Vice President', 'ie5', 'nw6klf', -2147483648, 't1__250b08');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_2', 'u', '4nrq', 'rofqyp5s5b', 'Vice President', 'p', '02eutliqa11r', -2147483648, 't1__250b08');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_3', 'au2dwy', 'q13py', '78d99r', 'Vice President', 'jsl', 'b4yp5qi', -2147483648, 't1__f85e4b');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_4', 'h2gn', 'q', 'nqcx5h', 'Vice President', 'cprj', 'u0dz7', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_5', 'gq8', 'n2f3dqv0gcb9', 'ozk3zbily', 'Vice President', 'kn6vc', '6ah', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_6', 'a7ryfd', 'z16ni', 'jai', 'Vice President', 'dh5ogrgj', '8', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', 't1afgog', 'itsj3', 'y', 'Vice President', 'p1q430', 'jh3den8', -2147483648, 't1__250b08');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', '68x8vacx7a', 'u5', '1of77p', 'Vice President', 'o72ctdc', 'mfg62', -2147483648, 't1__250b08');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_9', 'qdjpe1io2', '78507cvt', 'ptt', 't1__7a1f41', '6b', 'ou5z', -2147483648, 't1__250b08');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_10', 'wgxd5ysxc', 'r0oz', 'dgj5i', 'Vice President', 'lq5lnpim', 'k58qs27p', -2147483648, 't1__250b08');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 'u7', 'fe4hri', 'a2ypuzhsrwbb', NULL, 'p6luhvdlttil', 'n', -2147483648, '@');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('H', 'ia2yp', 'uzhsrwbbp6lu', 'hvdlttilbnpr', 'Vice President', 'dpos', 'ie5', -2147483648, 'B');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('I', 'eutliqa11r', 'ytoo3o9', 'l7', 'Vice President', 'klex14ji', '7zwau2dwyr', -2147483648, 'C');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('!', 'vy9uxj4', 'wb', 'v', 'Vice President', 'ph2', 'nd', -2147483648, '"');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('E', 'kn6vck6ah0f8', 'sww', 'q7x', 'Vice President', '7', '2fxa7ryfdrz', -2147483648, 'F');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('D', '1q43', '1jh3den', 'c68x8vacx', 'Vice President', 'afu5w1of7', 'pzo72ctdc', -2147483648, '#');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('`', 'tg6bnou5zi', '6c4bfkfo', 'c', 'Vice President', '0', '7z2zezjo7wg', -2147483648, '&');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t1__250b08', 't2__ea6e87', '5k5swwqcgs', '9n8');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_2', 't2__ea6e87', 'a9000t5c4eci', 'gce376nium52');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t1__f85e4b', 'ytoo3o9', 'l7', 'klex14ji');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('O', 't2__ea6e87', 'rkf9vqx5', 'pz0f8jegd');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('A', '1vy9uxj4', 'wb', 'v');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('G', 't2__ea6e87', 'f8jswwl', '7xb72');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t2__d00fce', '36c', 'bfkfoacd', '7z2zezj');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('@', '5k5swwqcgs', '9n8', '4');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('B', '5k5swwqcgs', '9n8', '4');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_10', NULL, 'gu7v', 'e4');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('C', 'nw6klf', 'a9000t5c4eci', 'gce376nium52');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_12', NULL, 'zbuo4nrqrof', 'qyp5s5bbp0');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('"', '13pyu', '8d99rljsl', 'b4yp5qi');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_14', NULL, 'rkf9vqx5', 'pz0f8jegd');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('F', 'wnqcx', '5hncprjtu0d', '79fjgq8');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_16', NULL, 'n2f3dqv0gcb9', 'ozk3zbily');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('#', '16nijjai5dh', 'ogrgjd8y', 't1afgog');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_18', NULL, 'itsj3', 'y');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('&', 'mfg62', '0v', 'q8qdjpe1');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_20', NULL, 'o22', '8507cvtjp');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, '4', 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.major_name FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id WHERE T1.position = 'Vice President';

/*
Gold Result:
('t2__ea6e87',)
('t2__ea6e87',)
('ytoo3o9',)
('1vy9uxj4',)
('1vy9uxj4',)
('1vy9uxj4',)
('t2__ea6e87',)
('t2__ea6e87',)
('t2__ea6e87',)
('5k5swwqcgs',)
('nw6klf',)
('13pyu',)
('wnqcx',)
('16nijjai5dh',)
('mfg62',)
*/

-- Prediction Query
SELECT DISTINCT major.major_name FROM major INNER JOIN member ON major.major_id = member.link_to_major WHERE member.position = 'Vice President';

/*
Prediction Result:
('t2__ea6e87',)
('ytoo3o9',)
('1vy9uxj4',)
('5k5swwqcgs',)
('nw6klf',)
('13pyu',)
('wnqcx',)
('16nijjai5dh',)
('mfg62',)
*/