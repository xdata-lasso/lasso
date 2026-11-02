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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_1', 'hria2ypuzhs', 't2__1c917f', 'rwbbp6luhvd', 'Member', 'tti', 'bnp', -2147483648, 't1__5823ed');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('C', 'dpos', 't2__1c917f', 'ie5', 'Member', 'nw6klf', 'a9000t5c4eci', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 'e', 't2__1c917f', '76nium52', 'Member', 'zbuo4nrqrof', 'qyp5s5bbp0', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_4', 'lex', 't2__1c917f', '4ji7zwa', 'Member', '2dwyrq', '3pyu78d', -2147483648, 'G');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_5', 'jsl', 't2__1c917f', 'b4yp5qi', 'Member', 'rkf9vqx5', 'pz0f8jegd', -2147483648, 'G');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_6', 'vy9uxj4', 't2__1c917f', 'wb', 'Member', 'v', 'ph2', -2147483648, 'G');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('G', 'dqwn', 't2__1c917f', 'cx5hn', 'Member', 'p', 'jtu0d', -2147483648, 't2__4b9343');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', 'gq8', 't2__1c917f', 'n2f3dqv0gcb9', 'Member', 'ozk3zbily', 'kn6vc', -2147483648, 't2__4b9343');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_9', '8j', 't2__1c917f', 'wwlq7', 't2__e6c0f5', 'xb72fxa7ryfd', 'z16ni', -2147483648, 't1__5823ed');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_10', 'ai5', 't2__1c917f', 'h', 'Member', 'ogrgjd8y', 't1afgog', -2147483648, 't1__5823ed');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_11', 'tsj', 't2__1c917f', 'ayxp1q43', 'Member', '1jh3den', 'c68x8vacx', -2147483648, 't1__5823ed');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_12', 'u5', 't2__1c917f', '1of77p', 'Member', 'o72ctdc', 'mfg62', -2147483648, 't1__5823ed');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_13', 'v5q8qdj', NULL, 'e1io', 'Member', '278507cv', 'jpttg', -2147483648, 't1__5823ed');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 'pgu7vfe4', 'hria2ypuzhs', 'rwbbp6luhvd', 'Member', 'tti', 'bnp', -2147483648, '@');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('D', 'w6kl', 'a9', '00t5c4e', 't2__49bcf0', 'cigce376nium', '52zbuo4nrq', -2147483648, 'O');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('B', '2eutliqa11r', 'ytoo3o9', 'l7', 't2__49bcf0', 'klex14ji', '7zwau2dwyr', -2147483648, 'B');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('`', '4', 'p5qi2rk', '9v', NULL, 'x58pz', 'f8jegd2', -2147483648, 'H');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('"', 'lph2gn', 'q', 'nqcx5h', NULL, 'cprj', 'u0dz7', -2147483648, 'F');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('K', 'bilyrkn', '6vck6ah0f8js', 'wlq7xb', NULL, '72fxa7ryfd', 'z16ni', -2147483648, '`');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('a', '9n8c4pgu7v', 'e4', 'hria2ypuzhs', 'Member', 'rwbbp6luhvd', 'tti', -2147483648, 'D');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t1__5823ed', 'Environmental Engineering', 't1__845288', 't1__c8086d');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('A', 'Environmental Engineering', 't1__845288', 't1__c8086d');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('C', 'Environmental Engineering', 't1__845288', 't1__c8086d');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('G', '2eutliqa11r', 'ytoo3o9', 'l7');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t2__4b9343', 'Environmental Engineering', 't1__845288', 't1__c8086d');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('@', NULL, '5k5swwqcgs', '9n8');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('O', 't1__10c8a9', 'mdpos', 'ie5');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('B', NULL, 'rofqyp5s5b', 'p');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('H', 'Environmental Engineering', '13pyu', '8d99rljsl');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('F', 't1__10c8a9', 'vy9uxj4', 'wb');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('`', NULL, 'fjgq8n2f3', 'dqv0gcb98ozk');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('D', 'Environmental Engineering', NULL, '5k5swwqcgs');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.last_name, T1.department, T1.college FROM major AS T1 INNER JOIN member AS T2 ON T1.major_id = T2.link_to_major WHERE T2.position = 'Member' AND T1.major_name = 'Environmental Engineering';

/*
Gold Result:
('t2__1c917f', 't1__845288', 't1__c8086d')
('t2__1c917f', 't1__845288', 't1__c8086d')
('t2__1c917f', 't1__845288', 't1__c8086d')
('t2__1c917f', 't1__845288', 't1__c8086d')
('t2__1c917f', 't1__845288', 't1__c8086d')
('t2__1c917f', 't1__845288', 't1__c8086d')
('t2__1c917f', 't1__845288', 't1__c8086d')
('t2__1c917f', 't1__845288', 't1__c8086d')
(None, 't1__845288', 't1__c8086d')
('e4', None, '5k5swwqcgs')
*/

-- Prediction Query
SELECT m.last_name, maj.department, maj.college FROM member AS m JOIN major AS maj ON m.link_to_major = maj.major_id WHERE maj.major_name = 'Environmental Engineering';

/*
Prediction Result:
('t2__1c917f', 't1__845288', 't1__c8086d')
('t2__1c917f', 't1__845288', 't1__c8086d')
('t2__1c917f', 't1__845288', 't1__c8086d')
('t2__1c917f', 't1__845288', 't1__c8086d')
('t2__1c917f', 't1__845288', 't1__c8086d')
('t2__1c917f', 't1__845288', 't1__c8086d')
('t2__1c917f', 't1__845288', 't1__c8086d')
('t2__1c917f', 't1__845288', 't1__c8086d')
('t2__1c917f', 't1__845288', 't1__c8086d')
(None, 't1__845288', 't1__c8086d')
('p5qi2rk', '13pyu', '8d99rljsl')
('e4', None, '5k5swwqcgs')
*/