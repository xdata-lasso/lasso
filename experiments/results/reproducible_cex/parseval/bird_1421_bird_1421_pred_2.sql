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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__4a5380', 'bnp', 'mdpos', 'ie5', 'Member', 'nw6klf', 'a9000t5c4eci', -2147483648, 't1__2e0fc1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', 'jsl', 'b4yp5qi', 'rkf9vqx5', 'Member', 'pz0f8jegd', '1vy9uxj4', -2147483648, 't1__2e0fc1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 'bdvlph', 'gndqwnqc', 'x5hncprjtu0', 'Member', 'z', '9fjgq8n2f', -2147483648, 't1__2e0fc1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('I', '0gcb98', 'zk3z', 'i', 'Member', 'yrk', 'n6vck6ah0f', -2147483648, 't1__2e0fc1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('Q', 'wlq7xb', '72fxa7ryfd', 'z16ni', 'Member', 'jai', 'dh5ogrgj', -2147483648, 't1__2e0fc1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('P', 'pgu7vfe4', 'hria2ypuzhs', 'rwbbp6luhvd', 'Member', 'tti', 'bnp', -2147483648, 'G');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('C', 'u7', 'fe4hri', 'a2ypuzhsrwbb', 't1__1f0619', 'p6luhvdlttil', 'n', -2147483648, '_');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', '00t5c4ecigc', 'e376nium52', 'zbuo4nrqrof', NULL, 'qyp5s5bbp0', '2eutliqa11r', -2147483648, '@');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('B', 'pgu7vfe4', 'hria2ypuzhs', 'rwbbp6luhvd', 'Member', 'tti', 'bnp', -2147483648, '`');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('D', 'w6kl', 'a9', '00t5c4e', 'Member', 'cigce376nium', '52zbuo4nrq', -2147483648, 'B');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('$', '2eutliqa11r', 'ytoo3o9', 'l7', 'Member', 'klex14ji', '7zwau2dwyr', -2147483648, 'H');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t1__2e0fc1', '5k5swwqcgs', '9n8', '4');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('A', 'e', '76nium52', 'zbuo4nrqrof');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('C', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('O', '72klex14ji7z', 'au2dwy', 'q13py');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t2__bd6828', 'yzt1afgog', 'itsj3', 'y');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('G', 'Mathematics', '5k5swwqcgs', '9n8');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('_', '5k5swwqcgs', '9n8', '4');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('@', 'rmdp', 'siie', 'unw6klfa');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('`', 'Mathematics', '5k5swwqcgs', '9n8');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('B', 'Mathematics', 'mdpos', 'ie5');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('H', 'Mathematics', 'rofqyp5s5b', 'p');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN T2.major_name = 'Mathematics' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.member_id) FROM member AS T1 INNER JOIN major AS T2 ON T2.major_id = T1.link_to_major WHERE T1.position = 'Member';

/*
Gold Result:
(44.44444444444444,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T1.major_name = 'Mathematics' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T2.member_id) FROM major AS T1 INNER JOIN member AS T2 ON T1.major_id = T2.link_to_major;

/*
Prediction Result:
(36.36363636363637,)
*/