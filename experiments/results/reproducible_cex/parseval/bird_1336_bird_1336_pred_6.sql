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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_1', 'tti', 'Guidi', 'bnp', 'mdpos', 'ie5', 'nw6klf', -2147483648, 't1__932cb4');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_2', 'eutliqa11r', 'Guidi', 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr', -2147483648, 'O');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_3', 'kf9vq', 'Guidi', 'x58pz0f8je', 'd2', 'vy9uxj4', 'wb', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_4', 'lph2gn', 'Guidi', 'q', 'nqcx5h', 'cprj', 'u0dz7', -2147483648, 'O');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_5', 'k', 'Guidi', 'ah0f8jsww', 'q7x', '7', '2fxa7ryfdrz', -2147483648, 'G');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_6', '6nijjai5dh', 'Guidi', 'ogrgjd8y', 't1afgog', 'itsj3', 'y', -2147483648, 'O');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('Q', '1q43', 'Guidi', '1jh3den', 'c68x8vacx', 'afu5w1of7', 'pzo72ctdc', -2147483648, 't1__932cb4');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 'mfg62g0v5q8q', 'Guidi', 'j', 'e1io', '278507cv', 'jpttg', -2147483648, 't1__932cb4');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', 'ou5z', 'Guidi', '36c', 'bfkfoacd', '7z2zezj', '7wgx', -2147483648, 't1__932cb4');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_10', 'cmr0oz', 't1__b5e2ef', 'dgj5i', 'lq5lnpim', 'k58qs27p', 'r94gth2m', -2147483648, 't1__932cb4');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_11', '57', 'Guidi', 'lfvyz7zzb', '8y', 'kv42q7', 'x58b4', -2147483648, 't1__932cb4');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', '9n0jxfofwsz', 'Pierce', 'o', '2zobb0q0k32o', 'w', 'l', -2147483648, '@');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('H', 'u7', NULL, 'fe4hri', 'a2ypuzhsrwbb', 'p6luhvdlttil', 'n', -2147483648, 'H');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('B', '00t5c4ecigc', NULL, 'e376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', -2147483648, 'B');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('C', 'au2dwy', NULL, 'q13py', '78d99r', 'jsl', 'b4yp5qi', -2147483648, 'C');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('I', 'bdvlph', NULL, 'gndqwnqc', 'x5hncprjtu0', 'z', '9fjgq8n2f', -2147483648, 'D');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('L', 'ah0f8jsww', NULL, 'q7x', '7', '2fxa7ryfdrz', '16nijjai5dh', -2147483648, 'J');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('b', 'xp1q430', NULL, 'jh3den8', 'c68x8vacx7', 'f', '5w1of7', -2147483648, 'F');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t1__932cb4', '5k5swwqcgs', 't2__af26de', '9n8');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('O', 'a9000t5c4eci', 't2__af26de', 'gce376nium52');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_2', 'zbuo4nrqrof', 't2__af26de', 'qyp5s5bbp0');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('A', '13pyu', '8d99rljsl', 'b4yp5qi');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('G', 'fjgq8n2f3', 'dqv0gcb98ozk', 'zbilyrkn');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t2__bb7e96', 'ajjl', '3', 'okv8uttmu2');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('@', 'pmaus3auvmkr', 'pdjwzw5chn9', 'o705');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('H', '5k5swwqcgs', '9n8', '4');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('B', 'rmdp', 'siie', 'unw6klfa');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('C', 'ytoo3o9', 'l7', 'klex14ji');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('D', 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('J', 'dqv0gcb9', 'ozk3zbily', 'kn6vc');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('F', 'ogrgjd8y', 't1afgog', 'itsj3');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, '4', 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.department FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id WHERE T1.last_name = 'Pierce' OR T1.last_name = 'Guidi';

/*
Gold Result:
('t2__af26de',)
('t2__af26de',)
('8d99rljsl',)
('t2__af26de',)
('dqv0gcb98ozk',)
('t2__af26de',)
('t2__af26de',)
('t2__af26de',)
('t2__af26de',)
('t2__af26de',)
('pdjwzw5chn9',)
*/

-- Prediction Query
SELECT M.department FROM member AS Mem INNER JOIN major AS M ON Mem.link_to_major = M.major_id WHERE Mem.first_name = 'Pierce' INTERSECT SELECT M.department FROM member AS Mem INNER JOIN major AS M ON Mem.link_to_major = M.major_id WHERE Mem.first_name = 'Guidi';

/*
Prediction Result:
*/