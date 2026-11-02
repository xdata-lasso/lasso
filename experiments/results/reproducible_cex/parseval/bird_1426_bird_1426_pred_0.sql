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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_1', 'hria2ypuzhs', 't2__cc9290', 'rwbbp6luhvd', 'Member', 'tti', 'bnp', -2147483648, 't1__a6e6c4');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('C', 'dpos', 't2__cc9290', 'ie5', 'Member', 'nw6klf', 'a9000t5c4eci', -2147483648, 't1__a6e6c4');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 'e', 't2__cc9290', '76nium52', 'Member', 'zbuo4nrqrof', 'qyp5s5bbp0', -2147483648, 't1__a6e6c4');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_4', 'lex', 't2__cc9290', '4ji7zwa', 'Member', '2dwyrq', '3pyu78d', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_5', 'jsl', 't2__cc9290', 'b4yp5qi', 'Member', 'rkf9vqx5', 'pz0f8jegd', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_6', 'vy9uxj4', 't2__cc9290', 'wb', 'Member', 'v', 'ph2', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', 'dqwn', 't2__cc9290', 'cx5hn', 'Member', 'p', 'jtu0d', -2147483648, 't2__3a20d9');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_8', 'f3dqv0gc', 't2__cc9290', '9', 't2__54efdd', 'ozk3zbily', 'kn6vc', -2147483648, 't1__a6e6c4');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_9', 'ah0f8jsww', 't2__cc9290', 'q7x', 'Member', '7', '2fxa7ryfdrz', -2147483648, 't1__a6e6c4');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_10', '6nijjai5dh', 't2__cc9290', 'ogrgjd8y', 'Member', 't1afgog', 'itsj3', -2147483648, 't1__a6e6c4');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_11', 'xp1q430', 't2__cc9290', 'jh3den8', 'Member', 'c68x8vacx7', 'f', -2147483648, 't1__a6e6c4');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_12', 'w1of77pz', NULL, '72ct', 'Member', 'c', 'mfg62', -2147483648, 't1__a6e6c4');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 'pgu7vfe4', 'hria2ypuzhs', 'rwbbp6luhvd', 'Member', 'tti', 'bnp', -2147483648, '@');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('H', 'w6kl', 'a9', '00t5c4e', 't2__8bb8e8', 'cigce376nium', '52zbuo4nrq', -2147483648, 'B');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('`', '2eutliqa11r', 'ytoo3o9', 'l7', 't2__8bb8e8', 'klex14ji', '7zwau2dwyr', -2147483648, 'C');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('D', '4', 'p5qi2rk', '9v', NULL, 'x58pz', 'f8jegd2', -2147483648, '!');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('B', 'lph2gn', 'q', 'nqcx5h', NULL, 'cprj', 'u0dz7', -2147483648, 'a');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('E', 'bilyrkn', '6vck6ah0f8js', 'wlq7xb', NULL, '72fxa7ryfd', 'z16ni', -2147483648, 'Q');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('I', '9n8c4pgu7v', 'e4', 'hria2ypuzhs', 'Member', 'rwbbp6luhvd', 'tti', -2147483648, 'D');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t1__a6e6c4', 'Environmental Engineering', 't1__958788', 't1__f75b91');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t1__e118c4', 'Environmental Engineering', 't1__958788', 't1__f75b91');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('O', 'Environmental Engineering', 't1__958788', 't1__f75b91');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('A', '2eutliqa11r', 'ytoo3o9', 'l7');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('G', 'Environmental Engineering', 't1__958788', 't1__f75b91');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t2__3a20d9', 'Environmental Engineering', 't1__958788', 't1__f75b91');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('@', NULL, '5k5swwqcgs', '9n8');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('B', 't1__4672f0', 'mdpos', 'ie5');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('C', NULL, 'rofqyp5s5b', 'p');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('!', 'Environmental Engineering', '13pyu', '8d99rljsl');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('a', 't1__4672f0', 'vy9uxj4', 'wb');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Q', NULL, 'fjgq8n2f3', 'dqv0gcb98ozk');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('D', 'Environmental Engineering', NULL, '5k5swwqcgs');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.last_name, T1.department, T1.college FROM major AS T1 INNER JOIN member AS T2 ON T1.major_id = T2.link_to_major WHERE T2.position = 'Member' AND T1.major_name = 'Environmental Engineering';

/*
Gold Result:
('t2__cc9290', 't1__958788', 't1__f75b91')
('t2__cc9290', 't1__958788', 't1__f75b91')
('t2__cc9290', 't1__958788', 't1__f75b91')
('t2__cc9290', 't1__958788', 't1__f75b91')
('t2__cc9290', 't1__958788', 't1__f75b91')
('t2__cc9290', 't1__958788', 't1__f75b91')
('t2__cc9290', 't1__958788', 't1__f75b91')
(None, 't1__958788', 't1__f75b91')
('e4', None, '5k5swwqcgs')
*/

-- Prediction Query
SELECT T1.last_name, T2.department, T2.college FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id WHERE T2.major_name = 'Environmental Engineering';

/*
Prediction Result:
('t2__cc9290', 't1__958788', 't1__f75b91')
('t2__cc9290', 't1__958788', 't1__f75b91')
('t2__cc9290', 't1__958788', 't1__f75b91')
('t2__cc9290', 't1__958788', 't1__f75b91')
('t2__cc9290', 't1__958788', 't1__f75b91')
('t2__cc9290', 't1__958788', 't1__f75b91')
('t2__cc9290', 't1__958788', 't1__f75b91')
('t2__cc9290', 't1__958788', 't1__f75b91')
(None, 't1__958788', 't1__f75b91')
('p5qi2rk', '13pyu', '8d99rljsl')
('e4', None, '5k5swwqcgs')
*/