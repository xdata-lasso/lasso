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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__1cf27f', 'bnp', 'mdpos', 'ie5', 'Member', 'Medium', 'nw6klf', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 'nrqrofqy', '5s5b', 'p', 'Member', 'Medium', '02eutliqa11r', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('C', 'oo3o9', 'l7', 'klex14ji', '7zwau2dwyr', '13pyu', '8d99rljsl', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('E', 'i2rkf', 'vqx58pz0f', '8jegd21vy9ux', 'j4hwbdvlph', 'gndqwnqc', 'x5hncprjtu0', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', 'q8', 'n2f3dqv0gcb9', 'ozk3zbily', 'kn6vc', '6ah', 'f8jswwl', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t2__731d15', '7', '2fxa7ryfdrz', '16nijjai5dh', 'Member', 'Medium', 'ogrgjd8y', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 'swwqcgsk', '9n8c4pgu7v', 'e4', 'Member', 'Medium', 'hria2ypuzhs', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('D', 'swwqcgsk', '9n8c4pgu7v', 'e4', 'Member', 't1__0a6aef', 'hria2ypuzhs', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('`', '5u', 'w6kl', 'a9', 'Member', NULL, '00t5c4e', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('B', '02eutliqa11r', 'ytoo3o9', 'l7', 't1__464676', 'Medium', 'klex14ji', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('F', 'yp5qi2rk', '9v', 'x58pz', 't1__464676', 't1__0a6aef', 'f8jegd2', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('G', 'nqcx5h', 'cprj', 'u0dz7', 't1__464676', NULL, 'fjgq8n2f3', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('#', 'k', 'ah0f8jsww', 'q7x', NULL, 'Medium', '7', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('K', 'rg', 'd8y', 't1afgog', NULL, 't1__0a6aef', 'itsj3', -2147483648, 'major_id_1');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', '5k5swwqcgs', '9n8', '4');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti');

-- Inserting into table: income --
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('t2__37ef4f', 'a9000t5c4eci', 1149850321, 'e', '76nium52', 't1__1cf27f');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('A', 't1afgog', -946046410, 'tsj3ayxp1q4', '01jh3den', 't2__731d15');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('@', 'rwbbp6luhvd', 50, 'tti', 'bnp', '@');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('H', 'rwbbp6luhvd', -1377057208, 'ilbnp', 'mdpos', 'D');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('B', 'cigce376nium', 283598170, 'zbuo4nrq', 'rofqyp5s5b', '`');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('?', '7zwau2dwyr', -1021749117, '3pyu78d99r', 'jsl', 'B');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('O', 'vy9uxj4', -1612443122, 'd', 'lph2gn', 'F');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('C', 'dqv0gcb98ozk', -155284187, 'i', 'yrk', 'G');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('"', '2fxa7ryfdrz', 61479715, 'jja', '5dh', '#');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('D', 'y', -598313376, 'q4301jh', 'den8c68x', 'K');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN T2.amount = 50 THEN 1.0 ELSE 0 END) AS REAL) * 100 / COUNT(T2.income_id) FROM member AS T1 INNER JOIN income AS T2 ON T1.member_id = T2.link_to_member WHERE T1.position = 'Member' AND T1.t_shirt_size = 'Medium';

/*
Gold Result:
(33.333333333333336,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN income.amount = 50 THEN 1 ELSE 0 END) AS REAL) * 100.0 / COUNT(*) AS percentage FROM member INNER JOIN income ON member.member_id = income.link_to_member WHERE member.t_shirt_size = 'Medium';

/*
Prediction Result:
(20.0,)
*/