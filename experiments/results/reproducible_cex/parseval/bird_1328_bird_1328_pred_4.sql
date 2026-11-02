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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_1', 'tti', 't1__2b386a', 'bnp', 'mdpos', 'ie5', 'nw6klf', -2147483648, 't1__2bf985');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 'u', 't1__2b386a', '4nrq', 'rofqyp5s5b', 'p', '02eutliqa11r', -2147483648, 't1__2bf985');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('C', 'au2dwy', 't1__2b386a', 'q13py', '78d99r', 'jsl', 'b4yp5qi', -2147483648, 't1__42bdae');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_4', 'h2gn', 't1__2b386a', 'q', 'nqcx5h', 'cprj', 'u0dz7', -2147483648, 'G');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_5', 'gq8', 't1__2b386a', 'n2f3dqv0gcb9', 'ozk3zbily', 'kn6vc', '6ah', -2147483648, 'G');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_6', 'fdrz16n', 't1__2b386a', 'jja', '5dh', 'ogrgjd8y', 't1afgog', -2147483648, 'O');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', 'tsj', 't1__2b386a', 'ayxp1q43', '1jh3den', 'c68x8vacx', 'afu5w1of7', -2147483648, 't1__2bf985');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('_', '72ct', 't1__2b386a', 'c', 'mfg62', '0v', 'q8qdjpe1', -2147483648, 't1__2bf985');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('Q', '278507cv', 't1__2b386a', 'jpttg', 'bnou5zi36', '4', 'f', -2147483648, 't1__2bf985');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_10', 'oacd07z2zez', 't1__2b386a', 'o7w', 'xd', 'ysxcmr0o', 'ztdgj5i3lq5l', -2147483648, 't1__2bf985');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_11', 'ajjl', NULL, '3', 'okv8uttmu2', 'e578', 'fvy', -2147483648, 't1__2bf985');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('''', 'pgu7vfe4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'bnp', 'mdpos', -2147483648, '@');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t1__2bf985', 'Law and Constitutional Studies', '5k5swwqcgs', '9n8');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_2', 'Law and Constitutional Studies', 'a9000t5c4eci', 'gce376nium52');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t1__42bdae', 'ytoo3o9', 'l7', 'klex14ji');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('A', 'Law and Constitutional Studies', 'rkf9vqx5', 'pz0f8jegd');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('G', '1vy9uxj4', 'wb', 'v');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('O', 'f8jswwl', '7xb72', 'xa');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t2__f12439', 'pim5', '58q', 's27p2r94gth2');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('@', NULL, '5k5swwqcgs', '9n8');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, '4', 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.last_name FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id WHERE T2.major_name = 'Law and Constitutional Studies';

/*
Gold Result:
('t1__2b386a',)
('t1__2b386a',)
('t1__2b386a',)
('t1__2b386a',)
('t1__2b386a',)
('t1__2b386a',)
(None,)
*/

-- Prediction Query
SELECT DISTINCT member.last_name FROM member INNER JOIN major ON member.link_to_major = major.major_id WHERE major.major_name = 'Law and Constitutional Studies';

/*
Prediction Result:
('t1__2b386a',)
(None,)
*/