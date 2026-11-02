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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_1', 'tti', 'Guidi', 'bnp', 'mdpos', 'ie5', 'nw6klf', -2147483648, 't1__539e73');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_2', 'u', 'Guidi', '4nrq', 'rofqyp5s5b', 'p', '02eutliqa11r', -2147483648, 't1__539e73');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_3', 'au2dwy', 'Guidi', 'q13py', '78d99r', 'jsl', 'b4yp5qi', -2147483648, 't1__cea93d');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_4', 'h2gn', 'Guidi', 'q', 'nqcx5h', 'cprj', 'u0dz7', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_5', 'bilyrkn', 'Guidi', '6vck6ah0f8js', 'wlq7xb', '72fxa7ryfd', 'z16ni', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_6', 'yzt1afgog', 'Guidi', 'itsj3', 'y', 'p1q430', 'jh3den8', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', '68x8vacx7a', 'Guidi', 'u5', '1of77p', 'o72ctdc', 'mfg62', -2147483648, 't1__539e73');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 'v5q8qdj', 'Guidi', 'e1io', '278507cv', 'jpttg', 'bnou5zi36', -2147483648, 't1__539e73');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('I', 'kf', 'Guidi', 'oacd07z2zez', 'o7w', 'xd', 'ysxcmr0o', -2147483648, 't1__539e73');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_10', 'g', 't1__7cc662', '5i3', 'q5l', 'pim5', '58q', -2147483648, 't1__539e73');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_11', '8uttmu', 'Guidi', 'ne578lfv', 'yz7zzbe8yvk', 'v42q7sx58b4p', 'aus3', -2147483648, 't1__539e73');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 'a9n0jxfofws', 'Pierce', 'do2zobb', 'q0k32od', 'cl5ams', 'orlwyngc1dj', -2147483648, '@');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('H', 'u7', NULL, 'fe4hri', 'a2ypuzhsrwbb', 'p6luhvdlttil', 'n', -2147483648, 'B');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('_', '00t5c4ecigc', NULL, 'e376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', -2147483648, 'D');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('B', 'au2dwy', NULL, 'q13py', '78d99r', 'jsl', 'b4yp5qi', -2147483648, 'E');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('C', 'bdvlph', NULL, 'gndqwnqc', 'x5hncprjtu0', 'z', '9fjgq8n2f', -2147483648, '`');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('`', 'ah0f8jsww', NULL, 'q7x', '7', '2fxa7ryfdrz', '16nijjai5dh', -2147483648, '"');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('0', 'xp1q430', NULL, 'jh3den8', 'c68x8vacx7', 'f', '5w1of7', -2147483648, 'b');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t1__539e73', '5k5swwqcgs', 't2__64a2a5', '9n8');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_2', 'a9000t5c4eci', 't2__64a2a5', 'gce376nium52');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t1__cea93d', 'ytoo3o9', 'l7', 'klex14ji');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('C', 'rkf9vqx5', 't2__64a2a5', 'pz0f8jegd');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('A', '1vy9uxj4', 'wb', 'v');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('G', 'fjgq8n2f3', 't2__64a2a5', 'dqv0gcb98ozk');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('O', 'jai', 't2__64a2a5', 'dh5ogrgj');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t2__be5e56', 's27p2r94gth2', 'najj', 'a3o');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('@', 'u', 'mkrpdj', 'wzw5chn9mo70');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('B', '5k5swwqcgs', '9n8', '4');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('D', 'rmdp', 'siie', 'unw6klfa');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('E', 'ytoo3o9', 'l7', 'klex14ji');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('`', 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('"', 'dqv0gcb9', 'ozk3zbily', 'kn6vc');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('b', 'ogrgjd8y', 't1afgog', 'itsj3');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, '4', 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.department FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id WHERE T1.last_name = 'Pierce' OR T1.last_name = 'Guidi';

/*
Gold Result:
('t2__64a2a5',)
('t2__64a2a5',)
('l7',)
('wb',)
('wb',)
('wb',)
('t2__64a2a5',)
('t2__64a2a5',)
('t2__64a2a5',)
('t2__64a2a5',)
('mkrpdj',)
*/

-- Prediction Query
SELECT major.department FROM major INNER JOIN member ON major.major_id = member.link_to_major WHERE member.first_name = 'Pierce' OR member.last_name = 'Guidi';

/*
Prediction Result:
('t2__64a2a5',)
('t2__64a2a5',)
('l7',)
('wb',)
('wb',)
('wb',)
('t2__64a2a5',)
('t2__64a2a5',)
('t2__64a2a5',)
('t2__64a2a5',)
*/