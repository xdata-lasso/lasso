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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t2__458e6a', 'gce376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9', 't3__2e3e6e', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_2', 'p5qi2rkf9v', 'x58pz', 'f8jegd2', 'vy9uxj4', 'wb', 't3__2e3e6e', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('C', 'ph2', 'nd', 'wnqcx', '5hncprjtu0d', '79fjgq8', 'n2f3dqv0gcb9', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 'q4301jh', 'den8c68x', 'vacx7afu5', '1of77p', 'o72ctdc', 'mfg62', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('G', 'foa', 'cd07z2zezjo7', 'wgxd5ysxcm', '0oztd', 'j5', 't3__2e3e6e', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', '5lnpim5k58qs', '7p2r94gt', '2m', 'ajjl', '3', 't3__2e3e6e', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t3__5ce162', 'rpdjwzw5ch', '9mo7', '5a9n0jx', 'of', 'szdo2z', 'obb0q0k32o', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 'a2y', 'uzhs', 'rwbbp6luhvd', 'tti', 'bnp', 'mdpos', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('H', 'a2y', 'uzhs', 'rwbbp6luhvd', 'tti', 'bnp', 'mdpos', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_10', '5u', 'w6kl', 'a9', '00t5c4e', 'cigce376nium', NULL, -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('`', '72klex14ji7z', 'au2dwy', 'q13py', '78d99r', 'jsl', 'b4yp5qi', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_12', 'f9v', 'x58pz', 'f8jegd2', 'vy9uxj4', 'wb', NULL, -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('B', 'gq8', 'n2f3dqv0gcb9', 'ozk3zbily', 'kn6vc', '6ah', 'f8jswwl', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_14', '7', '2fxa7ryfdrz', '16nijjai5dh', 'ogrgjd8y', 't1afgog', NULL, -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('D', '5w1of7', 'pzo72ctdc', 'mfg62', '0v', 'q8qdjpe1', 'o22', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_16', '7cvtjpttg6b', 'ou5z', '36c', 'bfkfoacd', '7z2zezj', NULL, -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('!', 'qs27p2r94', 'th', '2mnajjla3o', 'v8u', 'tmu2n', '57', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_18', 'yz7zzb', '8y', 'kv42q7', 'x58b4', 'pmaus3auvmkr', NULL, -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('F', '5am', 'sorlwyngc1', 'j', '9erhizgk1yoe', 'o6l0hdt', 'fuqyxuzkb', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_20', 'gwnlas6', 'elboeowii1', '5nxih66', 'q2xlyoto', '9oaawg', NULL, -2147483648, 'major_id_1');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__6bebd6', 'Women''s Soccer', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__14683a', 'Women''s Soccer', 'l7', 'klex14ji', '7zwau2dwyr', '13pyu', '8d99rljsl');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('O', 'Women''s Soccer', 'ozk3zbily', 'kn6vc', '6ah', 'f8jswwl', '7xb72');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', '7', 'yfdrz', '16nijjai5dh', 'ogrgjd8y', 't1afgog', 'itsj3');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('G', 'Women''s Soccer', '0v', 'q8qdjpe1', 'o22', '8507cvtjp', 'ttg6bnou5zi3');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__96c6c9', 'Women''s Soccer', 'okv8uttmu2', 'e578', 'fvy', '7zzbe8y', 'kv42q7');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('@', NULL, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('H', 'Women''s Soccer', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('B', 'Women''s Soccer', '52zbuo4nrq', 'rofqyp5s5b', 'p', '02eutliqa11r', 'ytoo3o9');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('C', 'Women''s Soccer', 'v', 'ph2', 'nd', 'wnqcx', '5hncprjtu0d');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('I', 'Women''s Soccer', 'itsj3', 'y', 'p1q430', 'jh3den8', 'c68x8vacx7');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('E', 'Women''s Soccer', '7wgx', '5', 'sxcmr0o', 'ztdgj5i3lq5l', 'pim5');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('b', 'Women''s Soccer', 'pdjwzw5chn9', 'o705', 'a9n0jxfofws', 'do2zobb', 'q0k32od');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'bnp', 'mdpos', 'ie5', 'nw6klf', 'a9000t5c4eci');

-- Inserting into table: attendance --
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__6bebd6', 't2__458e6a');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__6bebd6', 'C');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 't2__458e6a');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__6bebd6', 'A');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__96c6c9', 't2__458e6a');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', '@');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('H', 'H');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('B', '`');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('C', 'B');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('I', 'D');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('E', '!');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('b', 'F');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.phone FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event INNER JOIN member AS T3 ON T2.link_to_member = T3.member_id WHERE T1.event_name = 'Women''s Soccer';

/*
Gold Result:
('t3__2e3e6e',)
('n2f3dqv0gcb9',)
('mfg62',)
('t3__2e3e6e',)
('mdpos',)
('b4yp5qi',)
('f8jswwl',)
('o22',)
('57',)
('fuqyxuzkb',)
*/

-- Prediction Query
SELECT DISTINCT member.phone FROM member INNER JOIN attendance ON member.member_id = attendance.link_to_member INNER JOIN event ON attendance.link_to_event = event.event_id WHERE event.event_name = 'Women''s Soccer';

/*
Prediction Result:
('t3__2e3e6e',)
('n2f3dqv0gcb9',)
('mfg62',)
('mdpos',)
('b4yp5qi',)
('f8jswwl',)
('o22',)
('57',)
('fuqyxuzkb',)
*/