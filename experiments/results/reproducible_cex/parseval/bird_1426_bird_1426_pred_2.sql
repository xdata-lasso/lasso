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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_1', 'hria2ypuzhs', 't2__8a1462', 'rwbbp6luhvd', 'Member', 'tti', 'bnp', -2147483648, 't1__9e8685');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('C', 'dpos', 't2__8a1462', 'ie5', 'Member', 'nw6klf', 'a9000t5c4eci', -2147483648, 't1__9e8685');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 'e', 't2__8a1462', '76nium52', 'Member', 'zbuo4nrqrof', 'qyp5s5bbp0', -2147483648, 't1__9e8685');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_4', 'lex', 't2__8a1462', '4ji7zwa', 'Member', '2dwyrq', '3pyu78d', -2147483648, '_');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_5', 'x58pz0f8je', 't2__8a1462', 'd2', 'Member', 'vy9uxj4', 'wb', -2147483648, 'O');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_6', 'lph2gn', 't2__8a1462', 'q', 'Member', 'nqcx5h', 'cprj', -2147483648, 'O');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('G', '0dz79f', 't2__8a1462', 'gq8', 'Member', 'n2f3dqv0gcb9', 'ozk3zbily', -2147483648, 't2__c56acf');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', 'n6vck6ah0f', 't2__8a1462', 'jswwlq7xb', 'Member', '72fxa7ryfd', 'z16ni', -2147483648, 't2__c56acf');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_9', 'dh5ogrgj', 't2__8a1462', '8', 't2__a8c750', 'yzt1afgogrit', 'sj3ayxp1q430', -2147483648, 't1__9e8685');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_10', 'jh3den8c68', 't2__8a1462', '8vacx7', 'Member', 'f', '5w1of7', -2147483648, 't1__9e8685');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_11', 'o72ctdc', NULL, 'mfg62', 'Member', '0v', 'q8qdjpe1', -2147483648, 't1__9e8685');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_12', '2278', 't2__8a1462', '07cvtjpt', 'Member', 'tg6bnou5zi', '6c4bfkfo', -2147483648, 't1__9e8685');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_13', 'cd07z2zezjo7', 't2__8a1462', 'wgxd5ysxcm', 'Member', '0oztd', 'j5', -2147483648, 't1__9e8685');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 'pgu7vfe4', 'hria2ypuzhs', 'rwbbp6luhvd', 'Member', 'tti', 'bnp', -2147483648, '@');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('B', 'w6kl', 'a9', '00t5c4e', 't2__43ee57', 'cigce376nium', '52zbuo4nrq', -2147483648, 'H');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('I', '2eutliqa11r', 'ytoo3o9', 'l7', 't2__43ee57', 'klex14ji', '7zwau2dwyr', -2147483648, 'D');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('`', '4', 'p5qi2rk', '9v', NULL, 'x58pz', 'f8jegd2', -2147483648, 'F');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('D', 'lph2gn', 'q', 'nqcx5h', NULL, 'cprj', 'u0dz7', -2147483648, 'L');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('F', 'bilyrkn', '6vck6ah0f8js', 'wlq7xb', NULL, '72fxa7ryfd', 'z16ni', -2147483648, 'E');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('a', '9n8c4pgu7v', 'e4', 'hria2ypuzhs', 'Member', 'rwbbp6luhvd', 'tti', -2147483648, 'B');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t1__9e8685', 'Environmental Engineering', 't1__a05e6b', 't1__f867ff');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('C', 'Environmental Engineering', 't1__a05e6b', 't1__f867ff');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('A', 'Environmental Engineering', 't1__a05e6b', 't1__f867ff');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('_', '2eutliqa11r', 'ytoo3o9', 'l7');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('O', '9rljsl0b4', 'p5qi2rk', '9v');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t2__c56acf', 'Environmental Engineering', 't1__a05e6b', 't1__f867ff');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('@', NULL, '5k5swwqcgs', '9n8');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('H', 't1__f1dcc4', 'mdpos', 'ie5');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('D', NULL, 'rofqyp5s5b', 'p');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('F', 'Environmental Engineering', '13pyu', '8d99rljsl');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('L', 't1__f1dcc4', 'vy9uxj4', 'wb');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('E', NULL, 'fjgq8n2f3', 'dqv0gcb98ozk');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('B', 'Environmental Engineering', NULL, '5k5swwqcgs');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.last_name, T1.department, T1.college FROM major AS T1 INNER JOIN member AS T2 ON T1.major_id = T2.link_to_major WHERE T2.position = 'Member' AND T1.major_name = 'Environmental Engineering';

/*
Gold Result:
('t2__8a1462', 't1__a05e6b', 't1__f867ff')
('t2__8a1462', 't1__a05e6b', 't1__f867ff')
('t2__8a1462', 't1__a05e6b', 't1__f867ff')
('t2__8a1462', 't1__a05e6b', 't1__f867ff')
('t2__8a1462', 't1__a05e6b', 't1__f867ff')
('t2__8a1462', 't1__a05e6b', 't1__f867ff')
(None, 't1__a05e6b', 't1__f867ff')
('t2__8a1462', 't1__a05e6b', 't1__f867ff')
('t2__8a1462', 't1__a05e6b', 't1__f867ff')
('e4', None, '5k5swwqcgs')
*/

-- Prediction Query
SELECT member.last_name, major.department, major.college FROM member INNER JOIN major ON member.link_to_major = major.major_id WHERE major.major_name = 'Environmental Engineering';

/*
Prediction Result:
('t2__8a1462', 't1__a05e6b', 't1__f867ff')
('t2__8a1462', 't1__a05e6b', 't1__f867ff')
('t2__8a1462', 't1__a05e6b', 't1__f867ff')
('t2__8a1462', 't1__a05e6b', 't1__f867ff')
('t2__8a1462', 't1__a05e6b', 't1__f867ff')
('t2__8a1462', 't1__a05e6b', 't1__f867ff')
('t2__8a1462', 't1__a05e6b', 't1__f867ff')
(None, 't1__a05e6b', 't1__f867ff')
('t2__8a1462', 't1__a05e6b', 't1__f867ff')
('t2__8a1462', 't1__a05e6b', 't1__f867ff')
('p5qi2rk', '13pyu', '8d99rljsl')
('e4', None, '5k5swwqcgs')
*/