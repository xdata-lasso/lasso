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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t2__6dd6b1', 't2__d766dd', 't2__7f0b6c', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', -2147483648, 't1__2d6e8a');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t2__01fbf9', 't2__d766dd', 't2__7f0b6c', 'yp5qi2rk', '9v', 'x58pz', 'f8jegd2', -2147483648, 't1__2d6e8a');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 't2__d766dd', 't2__7f0b6c', 'h0f8jswwlq', 'xb72fxa7r', 'fdrz16n', 'jja', -2147483648, 't1__2d6e8a');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('G', 'h', 'ogrgjd8y', 't1afgog', 'itsj3', 'y', 'p1q430', -2147483648, 't1__593b68');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('I', 'foa', 'cd07z2zezjo7', 'wgxd5ysxcm', '0oztd', 'j5', '3lq', -2147483648, 't1__2d6e8a');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', 'vy', '7zzbe8y', 'kv42q7', 'x58b4', 'pmaus3auvmkr', 'pdjwzw5chn9', -2147483648, '_');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_7', 't2__13e550', 't2__268096', '2zob', '0', '0k32o', 'w', -2147483648, 't2__4541cb');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t3__6bd633', 't2__d766dd', 't2__7f0b6c', '5am', 'sorlwyngc1', 'j', '9erhizgk1yoe', -2147483648, 't1__2d6e8a');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_9', 't2__13e550', 't2__268096', 'hdt6fuq', 'xuzkb52', 'gwnlas6', 'elboeowii1', -2147483648, 't2__4541cb');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_10', 't2__13e550', 't2__268096', 'h66', 'q2xlyoto', '9oaawg', '6aqb0tbin', -2147483648, 't2__4541cb');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 'tilbn', 'rmdp', 'siie', 'unw6klfa', '9000t5c4ec', 'gce', -2147483648, '@');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('B', 'au2dwy', 'q13py', '78d99r', 'jsl', 'b4yp5qi', 'rkf9vqx5', -2147483648, 'B');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('`', 'hncprjtu0dz', '9fjgq8n2f', 'dqv0gcb9', 'ozk3zbily', 'kn6vc', '6ah', -2147483648, '?');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('a', '1afgo', 'ri', 'tsj3ayxp1q4', '01jh3den', 'c68x8vacx', 'afu5w1of7', -2147483648, 'D');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('C', 'bfkfoacd', '7z2zezj', '7wgx', '5', 'sxcmr0o', 'ztdgj5i3lq5l', -2147483648, 'C');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('F', '78lfvyz7', 'zzbe8yvkv4', 'q7sx58b4', 'pmaus3auvmkr', 'pdjwzw5chn9', 'o705', -2147483648, 'H');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('"', 'qyxuzk', '5', '1gwnlas6', 'elboeowii1', '5nxih66', 'q2xlyoto', -2147483648, 'F');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t3__07e904', 'Community Theater', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_2', 'Community Theater', '2eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t3__8ec6de', 'vy9uxj4', 'wb', 'v', 'ph2', 'nd', 'wnqcx');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('O', 'Community Theater', 'jh3den8', 'c68x8vacx7', 'f', '5w1of7', 'pzo72ctdc');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', 'mfg62g0v5q8q', 'j', 'e1io', '278507cv', 'jpttg', 'bnou5zi36');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('I', 'Community Theater', '5lnpim5k58qs', '7p2r94gt', '2m', 'ajjl', '3');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t4__74f2da', '9td8n5w', 'g', 'mbc3td', 'u6bd0w9603', 'vzxw1rxe9y', 'k7');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('@', 'Community Theater', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('B', 'Community Theater', '76nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('D', 't4__238003', 'pz0f8jegd', '1vy9uxj4', 'wb', 'v', 'ph2');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('E', 't4__238003', 'f8jswwl', '7xb72', 'xa', '7ryfdrz16n', 'jja');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('C', NULL, 'pzo72ctdc', 'mfg62', '0v', 'q8qdjpe1', 'o22');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('F', NULL, 'pim5', '58q', 's27p2r94gth2', 'najj', 'a3o');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('G', NULL, 'a9n0jxfofws', 'do2zobb', 'q0k32od', 'cl5ams', 'orlwyngc1dj');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t1__2d6e8a', 'Interior Design', 'hria2ypuzhs', 'rwbbp6luhvd');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t1__593b68', 'Interior Design', '13pyu', '8d99rljsl');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('O', 'Interior Design', '5hncprjtu0d', '79fjgq8');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('A', 'n2f3dqv0gcb9', 'ozk3zbily', 'kn6vc');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('_', 'Interior Design', 'v8u', 'tmu2n');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t2__4541cb', 'Interior Design', 'o705a9n0jxfo', 'ws');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('@', 't1__10e606', 'hria2ypuzhs', 'rwbbp6luhvd');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('B', NULL, 'l7', 'klex14ji');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('?', 't1__10e606', 'nd', 'wnqcx');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('D', NULL, '5dh', 'ogrgjd8y');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('C', 'Interior Design', '8507cvtjp', 'ttg6bnou5zi3');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('H', 't1__10e606', 'v8u', 'tmu2n');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('F', NULL, '9erhizgk1yoe', 'o6l0hdt');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'tti', 'bnp', 'mdpos', 'ie5', 'nw6klf');

-- Inserting into table: attendance --
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t3__07e904', 't2__6dd6b1');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t3__8ec6de', 't2__6dd6b1');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t3__07e904', 'G');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 't2__6dd6b1');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t3__07e904', 'I');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t3__07e904', 'O');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t3__07e904', 't3__6bd633');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', '@');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('B', 'B');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('D', '`');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('E', 'a');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('C', 'C');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('F', 'F');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', '"');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.first_name, T2.last_name FROM major AS T1 INNER JOIN member AS T2 ON T1.major_id = T2.link_to_major INNER JOIN attendance AS T3 ON T2.member_id = T3.link_to_member INNER JOIN event AS T4 ON T3.link_to_event = T4.event_id WHERE T4.event_name = 'Community Theater' AND T1.major_name = 'Interior Design';

/*
Gold Result:
('t2__d766dd', 't2__7f0b6c')
('h', 'ogrgjd8y')
('foa', 'cd07z2zezjo7')
('vy', '7zzbe8y')
('t2__d766dd', 't2__7f0b6c')
*/

-- Prediction Query
SELECT DISTINCT member.first_name, member.last_name FROM member INNER JOIN major ON member.link_to_major = major.major_id INNER JOIN attendance ON member.member_id = attendance.link_to_member INNER JOIN event ON attendance.link_to_event = event.event_id WHERE major.major_name = 'Interior Design' AND event.event_name = 'Community Theater';

/*
Prediction Result:
('t2__d766dd', 't2__7f0b6c')
('h', 'ogrgjd8y')
('foa', 'cd07z2zezjo7')
('vy', '7zzbe8y')
*/