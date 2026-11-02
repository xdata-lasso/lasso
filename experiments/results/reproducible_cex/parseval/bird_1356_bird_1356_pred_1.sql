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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_1', 'tti', 'bnp', 'mdpos', 'President', 'ie5', 'nw6klf', -2147483648, 't1__091c51');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_2', 'eutliqa11r', 'ytoo3o9', 'l7', 'President', 'klex14ji', '7zwau2dwyr', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_3', 'kf9vq', 'x58pz0f8je', 'd2', 'President', 'vy9uxj4', 'wb', -2147483648, 't1__71169b');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_4', 'dqwn', 'cx5hn', 'p', 'President', 'jtu0d', '79fjgq8', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_5', 'f3dqv0gc', '9', 'ozk3zbily', 'President', 'kn6vc', '6ah', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_6', 'a7ryfd', 'z16ni', 'jai', 'President', 'dh5ogrgj', '8', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('Q', 't1afgog', 'itsj3', 'y', 'President', 'p1q430', 'jh3den8', -2147483648, 't1__091c51');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', '68x8vacx7a', 'u5', '1of77p', 'President', 'o72ctdc', 'mfg62', -2147483648, 't1__091c51');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', 'v5q8qdj', 'e1io', '278507cv', 'President', 'jpttg', 'bnou5zi36', -2147483648, 't1__091c51');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_10', 'foa', 'cd07z2zezjo7', 'wgxd5ysxcm', 't1__9830a9', '0oztd', 'j5', -2147483648, 't1__091c51');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_11', '2mnajjla3o', 'v8u', 'tmu2n', 'President', '57', 'lfvyz7zzb', -2147483648, 't1__091c51');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 'u7', 'fe4hri', 'a2ypuzhsrwbb', NULL, 'p6luhvdlttil', 'n', -2147483648, '@');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('H', 'ia2yp', 'uzhsrwbbp6lu', 'hvdlttilbnpr', 'President', 'dpos', 'ie5', -2147483648, 'B');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('B', 'eutliqa11r', 'ytoo3o9', 'l7', 'President', 'klex14ji', '7zwau2dwyr', -2147483648, '`');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('C', 'vy9uxj4', 'wb', 'v', 'President', 'ph2', 'nd', -2147483648, '"');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('`', 'kn6vck6ah0f8', 'sww', 'q7x', 'President', '7', '2fxa7ryfdrz', -2147483648, 'a');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('_', '1q43', '1jh3den', 'c68x8vacx', 'President', 'afu5w1of7', 'pzo72ctdc', -2147483648, 'b');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('"', 'tg6bnou5zi', '6c4bfkfo', 'c', 'President', '0', '7z2zezjo7wg', -2147483648, 'D');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t1__091c51', '5k5swwqcgs', 't2__01fab0', '9n8');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('A', 'a9000t5c4eci', 't2__01fab0', 'gce376nium52');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_2', 'zbuo4nrqrof', 't2__01fab0', 'qyp5s5bbp0');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t1__71169b', '13pyu', '8d99rljsl', 'b4yp5qi');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('O', 'v', 't2__01fab0', 'ph2');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('G', 'f8jswwl', 't2__01fab0', '7xb72');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t2__b26675', '3lq', '5lnpim5k58qs', '7p2r94gt');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('@', '5k5swwqcgs', '9n8', '4');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('B', '5k5swwqcgs', '9n8', '4');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_10', 'gu7v', NULL, 'e4');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('`', 'nw6klf', 'a9000t5c4eci', 'gce376nium52');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_12', 'zbuo4nrqrof', NULL, 'qyp5s5bbp0');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('"', '13pyu', '8d99rljsl', 'b4yp5qi');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_14', 'rkf9vqx5', NULL, 'pz0f8jegd');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('a', 'wnqcx', '5hncprjtu0d', '79fjgq8');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_16', 'n2f3dqv0gcb9', NULL, 'ozk3zbily');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('b', '16nijjai5dh', 'ogrgjd8y', 't1afgog');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_18', 'itsj3', NULL, 'y');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('D', 'mfg62', '0v', 'q8qdjpe1');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_20', 'o22', NULL, '8507cvtjp');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, '4', 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.department FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id WHERE T1.position = 'President';

/*
Gold Result:
('t2__01fab0',)
('t2__01fab0',)
('8d99rljsl',)
('t2__01fab0',)
('t2__01fab0',)
('t2__01fab0',)
('t2__01fab0',)
('t2__01fab0',)
('t2__01fab0',)
('t2__01fab0',)
('9n8',)
('a9000t5c4eci',)
('8d99rljsl',)
('5hncprjtu0d',)
('ogrgjd8y',)
('0v',)
*/

-- Prediction Query
SELECT DISTINCT major.department FROM member INNER JOIN major ON member.link_to_major = major.major_id WHERE member.position = 'President';

/*
Prediction Result:
('t2__01fab0',)
('8d99rljsl',)
('9n8',)
('a9000t5c4eci',)
('5hncprjtu0d',)
('ogrgjd8y',)
('0v',)
*/