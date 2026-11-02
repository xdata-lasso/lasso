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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t2__4d611a', 'Sacha', 'Harrison', 'gce376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 'Sacha', 'Harrison', 'ph2', 'nd', 'wnqcx', '5hncprjtu0d', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('C', 'gq8', 'n2f3dqv0gcb9', 'ozk3zbily', 'kn6vc', '6ah', 'f8jswwl', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('G', '8', 'yzt1afgogrit', 'sj3ayxp1q430', 'jh3den8', 'c68x8vacx7', 'f', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t3__b2f004', 'dgj5i', 'lq5lnpim', 'k58qs27p', 'r94gth2m', 'ajjl', '3', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 'Sacha', 'Harrison', 'a2y', 'uzhs', 'rwbbp6luhvd', 'tti', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('`', 'Sacha', 't3__a9fc4f', 'e376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('!', 'Sacha', 't3__a9fc4f', 'jsl', 'b4yp5qi', 'rkf9vqx5', 'pz0f8jegd', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('B', 'Sacha', 't3__a9fc4f', 'qcx5', 'hncprjtu0dz', '9fjgq8n2f', 'dqv0gcb9', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('J', 'Sacha', NULL, '7', 'yfdrz', '16nijjai5dh', 'ogrgjd8y', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('a', 'Sacha', NULL, 'vacx7afu5', '1of77p', 'o72ctdc', 'mfg62', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('D', 'Sacha', NULL, 'f', 'foa', 'cd07z2zezjo7', 'wgxd5ysxcm', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('b', 't3__9514f6', 'Harrison', 'najj', 'a3o', 'v8u', 'tmu2n', -2147483648, 'major_id_1');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__213be5', '5k5swwqcgs', '2019-01-01', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('C', 'ytoo3o9', '2019-01-01', 'l7', 'klex14ji', '7zwau2dwyr', '13pyu');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', 'jsl', 'b4yp5qi', 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4', 'wb');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('O', '7xb72', '2019-01-01', 'xa', '7ryfdrz16n', 'jja', '5dh');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('_', '5w1of7', '2019-01-01', 'pzo72ctdc', 'mfg62', '0v', 'q8qdjpe1');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__6745be', 'jpttg', '2019-01-01', 'bnou5zi36', '4', 'f', 'foa');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Q', '5k5swwqcgs', NULL, '9n8', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('@', 'bnp', '2019-01-01', 'mdpos', 'ie5', 'nw6klf', 'a9000t5c4eci');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('B', 'ytoo3o9', 'A;1IG', 'l7', 'klex14ji', '7zwau2dwyr', '13pyu');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('D', '1vy9uxj4', NULL, 'wb', 'v', 'ph2', 'nd');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('#', 'ozk3zbily', '2019-01-01', 'kn6vc', '6ah', 'f8jswwl', '7xb72');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('H', 't1afgog', 'A3!G?', 'itsj3', 'y', 'p1q430', 'jh3den8');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('"', '0v', NULL, 'q8qdjpe1', 'o22', '8507cvtjp', 'ttg6bnou5zi3');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('E', '0oztd', '2019-01-01', 'j5', '3lq', '5lnpim5k58qs', '7p2r94gt');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'bnp', 'mdpos', 'ie5', 'nw6klf', 'a9000t5c4eci');

-- Inserting into table: attendance --
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__213be5', 't2__4d611a');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 't2__4d611a');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__213be5', 'C');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__213be5', 'G');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__6745be', 't2__4d611a');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Q', '@');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', '`');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('B', '!');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('D', 'B');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('#', 'J');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('H', 'a');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('"', 'D');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('E', 'b');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.event_id) FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event INNER JOIN member AS T3 ON T2.link_to_member = T3.member_id WHERE T3.first_name = 'Sacha' AND T3.last_name = 'Harrison' AND SUBSTRING(T1.event_date, 1, 4) = '2019';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(*) FROM attendance AS T1 INNER JOIN event AS T2 ON T1.link_to_event = T2.event_id INNER JOIN member AS T3 ON T1.link_to_member = T3.member_id WHERE STRFTIME('%Y', T2.event_date) = '2019' AND T3.first_name = 'Sacha' AND T3.last_name = 'Harrison' AND T2.event_name = 'Student_Club';

/*
Prediction Result:
(0,)
*/