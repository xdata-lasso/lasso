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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__d26ee7', 't1__ef07ce', 't1__976bcb', 'bnp', 'mdpos', 'ie5', 'nw6klf', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__de9f5f', 't1__ef07ce', 't1__976bcb', '5bbp0', '2eutliqa11r', 'ytoo3o9', 'l7', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', 't1__ef07ce', 't1__976bcb', 'f8jegd2', 'vy9uxj4', 'wb', 'v', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 'h2gndqwnqcx5', 'hncprjtu0dz', '9fjgq8n2f', 'dqv0gcb9', 'ozk3zbily', 'kn6vc', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('G', 't1__ef07ce', 't1__976bcb', 'rg', 'd8y', 't1afgog', 'itsj3', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t2__8795b5', 't1__ef07ce', 't1__976bcb', 'vacx7afu5', '1of77p', 'o72ctdc', 'mfg62', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 'swwqcgsk', '9n8c4pgu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('D', NULL, 'swwqcgsk', '9n8c4pgu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('B', '5u', NULL, 'w6kl', 'a9', '00t5c4e', 'cigce376nium', -2147483648, 'major_id_1');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', '5k5swwqcgs', '9n8', '4');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti');

-- Inserting into table: income --
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_1', 'a9000t5c4eci', 41, 'gce376nium52', 'zbuo4nrqrof', 't1__d26ee7');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_2', 'klex14ji', 41, '7zwau2dwyr', '13pyu', 't1__d26ee7');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_3', '8d99rljsl', 41, 'b4yp5qi', 'rkf9vqx5', 't1__d26ee7');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_4', '6ah', 41, 'f8jswwl', '7xb72', 'A');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_5', '7', 41, 'yfdrz', '16nijjai5dh', 'A');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_6', 'y', 41, 'p1q430', 'jh3den8', 'A');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('_', '0v', 41, 'q8qdjpe1', 'o22', 't2__8795b5');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('A', '8507cvtjp', 41, 'ttg6bnou5zi3', 'c4bfkfoac', 't2__8795b5');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('O', '7z2zezjo7wg', 41, 'd5ysxc', 'r0oz', 't2__8795b5');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_10', '5i3lq5lnpim5', 40, '58q', 's27p2r94gth2', 't1__d26ee7');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_11', 'ajjla3okv8u', 41, 'tmu2n', '57', 't1__d26ee7');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_12', 'yz7zzb', 41, '8y', 'kv42q7', 't1__d26ee7');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('@', 'bnp', NULL, 'mdpos', 'ie5', '@');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('B', 'tti', 41, 'bnp', 'mdpos', 'D');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('"', '52zbuo4nrq', 41, 'rofqyp5s5b', 'p', 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.first_name, T1.last_name FROM member AS T1 INNER JOIN income AS T2 ON T1.member_id = T2.link_to_member WHERE T2.amount > 40;

/*
Gold Result:
('t1__ef07ce', 't1__976bcb')
('t1__ef07ce', 't1__976bcb')
('t1__ef07ce', 't1__976bcb')
('h2gndqwnqcx5', 'hncprjtu0dz')
('h2gndqwnqcx5', 'hncprjtu0dz')
('h2gndqwnqcx5', 'hncprjtu0dz')
('t1__ef07ce', 't1__976bcb')
('t1__ef07ce', 't1__976bcb')
('t1__ef07ce', 't1__976bcb')
('t1__ef07ce', 't1__976bcb')
('t1__ef07ce', 't1__976bcb')
(None, 'swwqcgsk')
('5u', None)
*/

-- Prediction Query
SELECT DISTINCT member.first_name, member.last_name FROM member INNER JOIN income ON member.member_id = income.link_to_member WHERE income.amount > 40;

/*
Prediction Result:
('t1__ef07ce', 't1__976bcb')
('h2gndqwnqcx5', 'hncprjtu0dz')
(None, 'swwqcgsk')
('5u', None)
*/