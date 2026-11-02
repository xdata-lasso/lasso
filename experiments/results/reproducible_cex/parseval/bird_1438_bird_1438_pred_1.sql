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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_1', 'Katy', 'tti', 'bnp', 'mdpos', 'ie5', 'nw6klf', -2147483648, 'rec1N0upiVLy5esTO');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_2', 'Katy', 'eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr', -2147483648, 'rec1N0upiVLy5esTO');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_3', 'Katy', '3pyu78d', '9rljsl0b4', 'p5qi2rk', '9v', 'x58pz', -2147483648, 'rec1N0upiVLy5esTO');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_4', 'Katy', 'bdvlph', 'gndqwnqc', 'x5hncprjtu0', 'z', '9fjgq8n2f', -2147483648, 'rec1N0upiVLy5esTO');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_5', 'Katy', 'kn6vck6ah0f8', 'sww', 'q7x', '7', '2fxa7ryfdrz', -2147483648, 'rec1N0upiVLy5esTO');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_6', 'Katy', '6nijjai5dh', 'ogrgjd8y', 't1afgog', 'itsj3', 'y', -2147483648, 'rec1N0upiVLy5esTO');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', 'Katy', '1q43', '1jh3den', 'c68x8vacx', 'afu5w1of7', 'pzo72ctdc', -2147483648, 'rec1N0upiVLy5esTO');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 'Katy', 'mfg62g0v5q8q', 'j', 'e1io', '278507cv', 'jpttg', -2147483648, 'rec1N0upiVLy5esTO');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('G', 'Katy', '5zi36c', 'bfkfoacd', '7z2zezj', '7wgx', '5', -2147483648, 'rec1N0upiVLy5esTO');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_10', 'Katy', '5i3lq5lnpim5', '58q', 's27p2r94gth2', 'najj', 'a3o', -2147483648, 't1__100453');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_11', 't1__5d3295', '8uttmu', 'ne578lfv', 'yz7zzbe8yvk', 'v42q7sx58b4p', 'aus3', -2147483648, 'rec1N0upiVLy5esTO');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_12', 'Katy', 'a9n0jxfofws', 'do2zobb', 'q0k32od', 'cl5ams', 'orlwyngc1dj', -2147483648, 'rec1N0upiVLy5esTO');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 't1__5d3295', 'u7', 'fe4hri', 'a2ypuzhsrwbb', 'p6luhvdlttil', 'n', -2147483648, '@');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('B', NULL, '00t5c4ecigc', 'e376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', -2147483648, 'B');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('rec1N0upiVLy5esTO', '5k5swwqcgs', '9n8', 't2__d99af1');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('A', 'a9000t5c4eci', 'gce376nium52', 't2__d99af1');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_2', 'zbuo4nrqrof', 'qyp5s5bbp0', 't2__d99af1');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('O', 'f8jegd2', 'vy9uxj4', 't2__d99af1');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('_', 'dqv0gcb9', 'ozk3zbily', 't2__d99af1');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t1__100453', 'xcmr0', 'ztdg', 't2__d99af1');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t2__e97c1f', 'u', 'mkrpdj', 'wzw5chn9mo70');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('@', '5k5swwqcgs', '9n8', '4');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('B', 'rmdp', 'siie', 'unw6klfa');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, '4', 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.college FROM member AS T1 INNER JOIN major AS T2 ON T2.major_id = T1.link_to_major WHERE T1.link_to_major = 'rec1N0upiVLy5esTO' AND T1.first_name = 'Katy';

/*
Gold Result:
('t2__d99af1',)
('t2__d99af1',)
('t2__d99af1',)
('t2__d99af1',)
('t2__d99af1',)
('t2__d99af1',)
('t2__d99af1',)
('t2__d99af1',)
('t2__d99af1',)
('t2__d99af1',)
*/

-- Prediction Query
SELECT major.college FROM member INNER JOIN major ON member.link_to_major = major.major_id WHERE member.first_name = 'Katy';

/*
Prediction Result:
('t2__d99af1',)
('t2__d99af1',)
('t2__d99af1',)
('t2__d99af1',)
('t2__d99af1',)
('t2__d99af1',)
('t2__d99af1',)
('t2__d99af1',)
('t2__d99af1',)
('t2__d99af1',)
('t2__d99af1',)
*/