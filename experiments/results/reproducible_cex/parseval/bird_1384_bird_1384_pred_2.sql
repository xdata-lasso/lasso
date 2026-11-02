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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__3c9043', 'Grant', 'Gilmour', 'bnp', 'mdpos', 'ie5', 'nw6klf', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__b21848', 'Grant', 'Gilmour', '5bbp0', '2eutliqa11r', 'ytoo3o9', 'l7', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('G', 'Grant', 'Gilmour', 'f8jegd2', 'vy9uxj4', 'wb', 'v', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 'h2gndqwnqcx5', 'hncprjtu0dz', '9fjgq8n2f', 'dqv0gcb9', 'ozk3zbily', 'kn6vc', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', 'Grant', 'Gilmour', '7', 'yfdrz', '16nijjai5dh', 'ogrgjd8y', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t2__68dfce', 'Grant', 'Gilmour', 'f77p', 'o72ctdc', 'mfg62', '0v', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 'Grant', 't1__c36ec8', 'swwqcgsk', '9n8c4pgu7v', 'e4', 'hria2ypuzhs', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('H', 'Grant', NULL, '5u', 'w6kl', 'a9', '00t5c4e', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('B', 't1__c701e2', 'Gilmour', '02eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('C', 't1__c701e2', NULL, 'yp5qi2rk', '9v', 'x58pz', 'f8jegd2', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('`', NULL, 'Gilmour', 'nqcx5h', 'cprj', 'u0dz7', 'fjgq8n2f3', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('D', NULL, 't1__c36ec8', 'k', 'ah0f8jsww', 'q7x', '7', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('a', NULL, NULL, 'rg', 'd8y', 't1afgog', 'itsj3', -2147483648, 'major_id_1');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', '5k5swwqcgs', '9n8', '4');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti');

-- Inserting into table: income --
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_1', 'a9000t5c4eci', 1, 'gce376nium52', 'zbuo4nrqrof', 't1__3c9043');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('A', 'klex14ji', 1, '7zwau2dwyr', '13pyu', 't1__3c9043');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('C', '8d99rljsl', 1, 'b4yp5qi', 'rkf9vqx5', 't1__3c9043');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_4', '6ah', 1, 'f8jswwl', '7xb72', 'A');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_5', 't1afgog', 1, 'itsj3', 'y', 'A');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_6', 'q4301jh', 1, 'den8c68x', 'vacx7afu5', 'A');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('G', 'q8qdjpe1', 1, 'o22', '8507cvtjp', 't2__68dfce');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('O', '6b', 1, 'ou5z', '36c', 't2__68dfce');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('Q', 'kf', 1, 'oacd07z2zez', 'o7w', 't2__68dfce');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_10', '5', 1, 'sxcmr0o', 'ztdgj5i3lq5l', 't1__3c9043');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_11', 'm5k', 1, '8qs27p2r', '4gth2mnaj', 't1__3c9043');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_12', 'okv8uttmu2', NULL, 'e578', 'fvy', 't1__3c9043');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('@', 'rwbbp6luhvd', -1377057208, 'ilbnp', 'mdpos', '@');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('!', 'cigce376nium', 283598170, 'zbuo4nrq', 'rofqyp5s5b', 'H');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('B', '7zwau2dwyr', -1021749117, '3pyu78d99r', 'jsl', 'B');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('H', 'vy9uxj4', -1612443122, 'd', 'lph2gn', 'C');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('"', 'dqv0gcb98ozk', -155284187, 'i', 'yrk', '`');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('`', '2fxa7ryfdrz', 61479715, 'jja', '5dh', 'D');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('a', 'y', -598313376, 'q4301jh', 'den8c68x', 'a');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.amount FROM member AS T1 INNER JOIN income AS T2 ON T1.member_id = T2.link_to_member WHERE T1.first_name = 'Grant' AND T1.last_name = 'Gilmour';

/*
Gold Result:
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(None,)
*/

-- Prediction Query
SELECT SUM(income.amount) AS total_income FROM income INNER JOIN member ON income.link_to_member = member.member_id WHERE member.first_name = 'Grant' AND member.last_name = 'Gilmour';

/*
Prediction Result:
(8,)
*/