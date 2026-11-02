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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__c95559', 'nw6klf', 'a9000t5c4eci', 'gce376nium52', 'Vice President', 'zbuo4nrqrof', 'qyp5s5bbp0', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_2', 'x14ji7zwau2d', 'yrq13p', 'u78d99r', 'Vice President', 'jsl', 'b4yp5qi', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__683ac4', 'q', 'nqcx5h', 'cprj', 'u0dz7', 'fjgq8n2f3', 'dqv0gcb98ozk', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('G', 'ayxp1q43', '1jh3den', 'c68x8vacx', 'Vice President', 'afu5w1of7', 'pzo72ctdc', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 'g6', 'g0v5q8qd', 'jpe1io22785', '7cvtjpt', 'tg6bnou5zi', '6c4bfkfo', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', '8qs27p2r', '4gth2mnaj', 'la3', 'Vice President', 'okv8uttmu2', 'e578', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t3__39158f', 'q0k32od', 'cl5ams', 'orlwyngc1dj', '9erhizgk1yoe', 'o6l0hdt', 'fuqyxuzkb', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('!', '162nh55y3d', 'ohvu06dza3', 'rmkio18r', 'Vice President', 'i2hy08ftp6', 'wt', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 'njabym', 'n2mfx7h', '3p6sto1c', 'Vice President', '8sh', 'knzys7dy', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('D', 'hria2ypu', 'hsrwbbp', 'luhvdltti', 'Vice President', 'bnp', 'mdpos', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('B', 'uo4nrqrofqy', '5s5b', 'p', 'Vice President', '02eutliqa11r', 'ytoo3o9', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('$', 'jsl', 'b4yp5qi', 'rkf9vqx5', 'Vice President', 'pz0f8jegd', '1vy9uxj4', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('C', 'qcx5', 'hncprjtu0dz', '9fjgq8n2f', 'Vice President', 'dqv0gcb9', 'ozk3zbily', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('b', '7', 'yfdrz', '16nijjai5dh', 'Vice President', 'ogrgjd8y', 't1afgog', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('F', 'vacx7afu5', '1of77p', 'o72ctdc', 'Vice President', 'mfg62', '0v', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('#', 'f', 'foa', 'cd07z2zezjo7', 'Vice President', 'wgxd5ysxcm', '0oztd', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('"', 'najj', 'a3o', 'v8u', 't3__bf3866', 'tmu2n', '57', -2147483648, 'major_id_1');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__51f29e', 't2__6917a2', '5k5swwqcgs', 'Social', '9n8', '900 E. Washington St.', '4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_2', 't2__6917a2', '2eutliqa11r', 'Social', 'ytoo3o9', '900 E. Washington St.', 'l7');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__ceffd9', 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4', 'wb', 'v', 'ph2');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', 't2__6917a2', 'zbilyrkn', 'Social', '6vck6ah0f8js', '900 E. Washington St.', 'wlq7xb');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('_', 'a7ryfd', 'z16ni', 'jai', 'dh5ogrgj', '8', 'yzt1afgogrit');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Q', '0', '7z2zezjo7wg', 'd5ysxc', 'r0oz', 'dgj5i', 'lq5lnpim');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('O', 'yz7zzb', '8y', 'kv42q7', 'x58b4', 'pmaus3auvmkr', 'pdjwzw5chn9');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__3927d0', '521gwnlas6e', 'lboeowii1z5', 'xih6', '2q2xlyoto', '9oaawg', '6aqb0tbin');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('@', 't2__bbd9eb', 'j', 'Social', '9td8n5w', '900 E. Washington St.', 'g');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('!', 't2__bbd9eb', 'mbc3td', 'Social', 'u6bd0w9603', '900 E. Washington St.', 'vzxw1rxe9y');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('D', '5k5swwqcgs', '9n8', 't2__018cc3', '4', '900 E. Washington St.', 'gu7v');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('B', 'ie5', 'nw6klf', NULL, 'a9000t5c4eci', '900 E. Washington St.', 'gce376nium52');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('"', 'l7', 'klex14ji', 'Social', '7zwau2dwyr', 't2__570f5e', '13pyu');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('F', 'wb', 'v', NULL, 'ph2', 't2__570f5e', 'nd');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('b', 'kn6vc', '6ah', 'Social', 'f8jswwl', NULL, '7xb72');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('G', 'itsj3', 'y', 't2__018cc3', 'p1q430', NULL, 'jh3den8');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('E', 'q8qdjpe1', 'o22', NULL, '8507cvtjp', NULL, 'ttg6bnou5zi3');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('c', 'j5', '3lq', 't2__018cc3', '5lnpim5k58qs', '900 E. Washington St.', '7p2r94gt');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', 'gu7v', 'e4', 'hria2ypuzhs');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'rwbbp6luhvd', 'tti', 'bnp', 'mdpos', 'ie5');

-- Inserting into table: attendance --
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__51f29e', 't1__c95559');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__ceffd9', 't1__683ac4');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('_', 't1__c95559');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__51f29e', 'A');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Q', 't1__c95559');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('O', 't1__c95559');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', '!');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('!', '@');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('D', 'D');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('B', 'B');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('"', '$');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('F', 'C');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('b', 'b');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'F');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('E', '#');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('c', '"');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.event_name FROM attendance AS T1 INNER JOIN event AS T2 ON T2.event_id = T1.link_to_event INNER JOIN member AS T3 ON T1.link_to_member = T3.member_id WHERE T3.position = 'Vice President' AND T2.location = '900 E. Washington St.' AND T2.type = 'Social';

/*
Gold Result:
('t2__6917a2',)
('t2__bbd9eb',)
('t2__bbd9eb',)
*/

-- Prediction Query
SELECT DISTINCT e.event_name FROM event AS e INNER JOIN attendance AS a ON e.event_id = a.link_to_event INNER JOIN member AS m ON a.link_to_member = m.member_id WHERE e.type = 'Social' AND m.position = 'Vice President' AND e.location = '900 E. Washington St.';

/*
Prediction Result:
('t2__6917a2',)
('t2__bbd9eb',)
*/