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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_1', 'tti', 'Guidi', 'bnp', 'mdpos', 'ie5', 'nw6klf', -2147483648, 't1__a48662');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_2', 'eutliqa11r', 'Guidi', 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr', -2147483648, 'O');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_3', 'kf9vq', 'Guidi', 'x58pz0f8je', 'd2', 'vy9uxj4', 'wb', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_4', 'nqcx5h', 'Guidi', 'cprj', 'u0dz7', 'fjgq8n2f3', 'dqv0gcb98ozk', -2147483648, '_');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_5', 'xa', 'Guidi', '7ryfdrz16n', 'jja', '5dh', 'ogrgjd8y', -2147483648, 'G');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_6', '1afgo', 'Guidi', 'ri', 'tsj3ayxp1q4', '01jh3den', 'c68x8vacx', -2147483648, 'O');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', 'u5', 'Guidi', '1of77p', 'o72ctdc', 'mfg62', '0v', -2147483648, 't1__a48662');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 'q8qdjpe1io22', 'Guidi', '8507cvtjp', 'ttg6bnou5zi3', 'c4bfkfoac', '0', -2147483648, 't1__a48662');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('Q', 'zj', 'Guidi', '7wgx', '5', 'sxcmr0o', 'ztdgj5i3lq5l', -2147483648, 't1__a48662');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_10', 'm5k', 't1__c14eef', '8qs27p2r', '4gth2mnaj', 'la3', 'okv8uttmu2', -2147483648, 't1__a48662');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_11', 'v42', 'Guidi', '7sx58', 'b4pmaus3auv', 'krpd', 'wzw', -2147483648, 't1__a48662');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 'o', 'Pierce', '2zobb0q0k32o', 'w', 'l', '5amsorlwyngc', -2147483648, '@');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('B', 'u7', NULL, 'fe4hri', 'a2ypuzhsrwbb', 'p6luhvdlttil', 'n', -2147483648, 'B');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('`', '00t5c4ecigc', NULL, 'e376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', -2147483648, '`');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('a', 'au2dwy', NULL, 'q13py', '78d99r', 'jsl', 'b4yp5qi', -2147483648, 'a');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('D', 'bdvlph', NULL, 'gndqwnqc', 'x5hncprjtu0', 'z', '9fjgq8n2f', -2147483648, '!');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('!', 'ah0f8jsww', NULL, 'q7x', '7', '2fxa7ryfdrz', '16nijjai5dh', -2147483648, 'C');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('b', 'xp1q430', NULL, 'jh3den8', 'c68x8vacx7', 'f', '5w1of7', -2147483648, '$');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t1__a48662', '5k5swwqcgs', 't2__bf0939', '9n8');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('O', 'a9000t5c4eci', 't2__bf0939', 'gce376nium52');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_2', 'zbuo4nrqrof', 't2__bf0939', 'qyp5s5bbp0');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('A', '13pyu', '8d99rljsl', 'b4yp5qi');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('_', 'v', 'ph2', 'nd');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('G', 'zbilyrkn', '6vck6ah0f8js', 'wlq7xb');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t2__fc5a78', 'e578', 'fvy', '7zzbe8y');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('@', 'chn9mo70', 'a9n0jxfo', 'ws');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('B', '5k5swwqcgs', '9n8', '4');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('`', 'rmdp', 'siie', 'unw6klfa');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('a', 'ytoo3o9', 'l7', 'klex14ji');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('!', 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('C', 'dqv0gcb9', 'ozk3zbily', 'kn6vc');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('$', 'ogrgjd8y', 't1afgog', 'itsj3');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, '4', 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.department FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id WHERE T1.last_name = 'Pierce' OR T1.last_name = 'Guidi';

/*
Gold Result:
('t2__bf0939',)
('t2__bf0939',)
('8d99rljsl',)
('ph2',)
('6vck6ah0f8js',)
('t2__bf0939',)
('t2__bf0939',)
('t2__bf0939',)
('t2__bf0939',)
('t2__bf0939',)
('a9n0jxfo',)
*/

-- Prediction Query
SELECT T1.department FROM major AS T1 INNER JOIN member AS T2 ON T1.major_id = T2.link_to_major WHERE T2.last_name = 'Guidi' OR T2.last_name = 'Pierce' GROUP BY T1.department;

/*
Prediction Result:
('6vck6ah0f8js',)
('8d99rljsl',)
('a9n0jxfo',)
('ph2',)
('t2__bf0939',)
*/