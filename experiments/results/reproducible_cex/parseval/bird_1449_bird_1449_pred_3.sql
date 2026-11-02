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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__38cc61', 't1__c6f0a7', 't1__0b361a', 'tti', 'bnp', 'mdpos', 'ie5', -2147483648, 'C');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('C', 't1__c6f0a7', 't1__0b361a', 'u', '4nrq', 'rofqyp5s5b', 'p', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 't1__c6f0a7', 't1__0b361a', 'xa', '7ryfdrz16n', 'jja', '5dh', -2147483648, '?');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 't1__c6f0a7', 't1__0b361a', '68x8vacx7a', 'u5', '1of77p', 'o72ctdc', -2147483648, 'O');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('?', 't1__c6f0a7', 't1__0b361a', 'mfg62g0v5q8q', 'j', 'e1io', '278507cv', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_6', 't1__c6f0a7', 't1__0b361a', 'w5chn9mo705a', '9n0jxfofwsz', 'o', '2zobb0q0k32o', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t3__2efa1c', 't1__c6f0a7', 't1__0b361a', 'bc3t', 'u', 'bd0w9603v', 'xw1rxe9', -2147483648, 'G');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_7', 't1__c6f0a7', 't1__0b361a', 'k7', 'k162n', '55', '3dohvu0', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_9', 't1__c6f0a7', 't1__0b361a', 'dqrhm', 'wlic7dn2', 'p490', 'dmsqtg', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_10', 't1__c6f0a7', 't1__0b361a', 'uu', 'sj8kjh', '5wpxlvris', 'urz0kaqtncg', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('B', 'u7', 'fe4hri', 'a2ypuzhsrwbb', 'p6luhvdlttil', 'n', 'rmdp', -2147483648, 'B');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_1', '02eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr', '13pyu');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('C', 't2__fa365d', '5k5swwqcgs', '9n8');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('A', 'nw6klf', 'a9000t5c4eci', 'gce376nium52');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('O', 't2__fa365d', 'z', '9fjgq8n2f');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('@', 'dqv0gcb9', 'ozk3zbily', 'kn6vc');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('?', 'ah0f8jsww', 'q7x', '7');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('G', 't2__fa365d', '1gwnlas6', 'elboeowii1');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('_', 't2__fa365d', 'h33p6sto1', 'j');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t2__112500', 'z2o20', 'pj6ddlysu6ip', 'dk');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('I', 't2__fa365d', 'u2gir31vwq5', 'oa2sb3u');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Q', NULL, 'zg3r', 'jkwns47j2j');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('B', '5k5swwqcgs', '9n8', '4');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, '4', 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd');

-- Inserting into table: budget --
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_1', '8d99rljsl', 419.361606, 470.165282, 1692174491, 'qi2rkf9v', 'event_id_1');

-- Inserting into table: expense --
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_1', 'x58pz', 'f8jegd2', 100.01, 'vy9uxj4', 't1__38cc61', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_2', 'bdvlph', 'gndqwnqc', 100.01, 'x5hncprjtu0', 't1__38cc61', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_3', 'grgj', '8', 100.01, 'yzt1afgogrit', 't1__38cc61', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_4', '3ay', 'p1q430', 100.01, 'jh3den8', 't1__38cc61', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_5', 'ptt', '6b', 100.01, 'ou5z', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_6', '6c4bfkfo', 'c', 100.01, '0', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_7', 'zj', '7wgx', 100.01, '5', 't1__38cc61', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_8', 'xcmr0', 'ztdg', 100.01, '5i3', 't1__38cc61', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_9', 'npi', '5k58', 100.01, 's27p2', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_10', '4gth2mnaj', 'la3', 100.01, 'okv8uttmu2', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_11', '78lfvyz7zz', 'be8yvkv42q7', 100.01, 'x58b4', 't1__38cc61', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_12', 'aus3', 'u', 100.01, 'mkrpdj', 't1__38cc61', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_13', 'cl5ams', 'orlwyngc1dj', 100.01, '9erhizgk1yoe', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_14', 'o6l0hdt6fu', 'yxuzk', 100.01, '5', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_15', 'xih662q2xly', 'otow9oaawg', 100.01, '6aqb0tbin', 't1__38cc61', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_16', '39tajz9', 'd8n5w', 100.01, 'g', 't1__38cc61', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('O', 'a35rmki', '18ri', 100.01, 'hy08ftp6', 't3__2efa1c', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('A', 'tqxxnj', 'b', 100.01, 'mzn2mfx', 't3__2efa1c', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_19', 'nzy', '7dyyd', 100.01, 'jmgjach', 't1__38cc61', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_20', 'ta8y3a17v4', 'ygmayq3qdpu', 100.01, 'p', 't1__38cc61', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('Q', 'cuq', '9', 100.01, 'i9f2ccukjq1q', 't3__2efa1c', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_22', 'yhb08hlst1pq', 'mizt', 100.01, 'vb6m4iz78aq', 't1__38cc61', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_23', 'ud8', 'tb', 100.01, 'r9114qbre', 't1__38cc61', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('G', 's3b7v88kw', 'm', 100.01, 'b', 't3__2efa1c', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_25', '7nxar50h', 'sjhanzxdpu', 100.0, 'mwfw', 't1__38cc61', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_26', 'rlawk', '14r5dqt', 100.0, 'mg97a', 't1__38cc61', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_27', 'avcv', 'wnyqrouirlrp', 100.01, 'ouit63xyfvmj', 't1__38cc61', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_28', 'p26m', '3', 100.01, 'j', 't1__38cc61', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_29', '0h3r133ir1ax', 'yhpl2i9', 100.01, 'sa', 't1__38cc61', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_30', 'pgckqwtsr', '54o6qjektb1', 100.01, '2', 't1__38cc61', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_31', 'y', 'vjwq49yr', 100.01, 'nxs6dvdxdo2v', 't1__38cc61', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_32', 'gvplj9fj', 'uun7k1', 100.01, 'z2my1og', 't1__38cc61', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('@', 'siie5unw6k', 'fa9', NULL, '00t5c4e', 'B', 'budget_id_1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.first_name, T1.last_name, T2.major_name FROM member AS T1 INNER JOIN major AS T2 ON T2.major_id = T1.link_to_major INNER JOIN expense AS T3 ON T1.member_id = T3.link_to_member WHERE T3.cost > 100;

/*
Gold Result:
('t1__c6f0a7', 't1__0b361a', 't2__fa365d')
('t1__c6f0a7', 't1__0b361a', 'ah0f8jsww')
*/

-- Prediction Query
SELECT m.first_name, m.last_name, major.major_name FROM member AS m INNER JOIN expense AS e ON m.member_id = e.link_to_member INNER JOIN major ON m.link_to_major = major.major_id WHERE e.cost > 100;

/*
Prediction Result:
('t1__c6f0a7', 't1__0b361a', 't2__fa365d')
('t1__c6f0a7', 't1__0b361a', 't2__fa365d')
('t1__c6f0a7', 't1__0b361a', 't2__fa365d')
('t1__c6f0a7', 't1__0b361a', 't2__fa365d')
('t1__c6f0a7', 't1__0b361a', 'ah0f8jsww')
('t1__c6f0a7', 't1__0b361a', 'ah0f8jsww')
('t1__c6f0a7', 't1__0b361a', 't2__fa365d')
('t1__c6f0a7', 't1__0b361a', 't2__fa365d')
('t1__c6f0a7', 't1__0b361a', 'ah0f8jsww')
('t1__c6f0a7', 't1__0b361a', 'ah0f8jsww')
('t1__c6f0a7', 't1__0b361a', 't2__fa365d')
('t1__c6f0a7', 't1__0b361a', 't2__fa365d')
('t1__c6f0a7', 't1__0b361a', 'ah0f8jsww')
('t1__c6f0a7', 't1__0b361a', 'ah0f8jsww')
('t1__c6f0a7', 't1__0b361a', 't2__fa365d')
('t1__c6f0a7', 't1__0b361a', 't2__fa365d')
('t1__c6f0a7', 't1__0b361a', 't2__fa365d')
('t1__c6f0a7', 't1__0b361a', 't2__fa365d')
('t1__c6f0a7', 't1__0b361a', 't2__fa365d')
('t1__c6f0a7', 't1__0b361a', 't2__fa365d')
('t1__c6f0a7', 't1__0b361a', 't2__fa365d')
('t1__c6f0a7', 't1__0b361a', 't2__fa365d')
('t1__c6f0a7', 't1__0b361a', 't2__fa365d')
('t1__c6f0a7', 't1__0b361a', 't2__fa365d')
('t1__c6f0a7', 't1__0b361a', 't2__fa365d')
('t1__c6f0a7', 't1__0b361a', 't2__fa365d')
('t1__c6f0a7', 't1__0b361a', 't2__fa365d')
('t1__c6f0a7', 't1__0b361a', 't2__fa365d')
('t1__c6f0a7', 't1__0b361a', 't2__fa365d')
('t1__c6f0a7', 't1__0b361a', 't2__fa365d')
*/