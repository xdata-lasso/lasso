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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_1', 'tti', 'bnp', 'mdpos', 'vice president', 'ie5', 'nw6klf', -2147483648, 't1__1f3540');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_2', 'u', '4nrq', 'rofqyp5s5b', 'vice president', 'p', '02eutliqa11r', -2147483648, 't1__1f3540');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_3', 'au2dwy', 'q13py', '78d99r', 'vice president', 'jsl', 'b4yp5qi', -2147483648, 'C');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_4', 'h2gn', 'q', 'nqcx5h', 'vice president', 'cprj', 'u0dz7', -2147483648, '_');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_5', 'k', 'ah0f8jsww', 'q7x', 'vice president', '7', '2fxa7ryfdrz', -2147483648, 'G');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_6', 'tsj', 'ayxp1q43', '1jh3den', 'vice president', 'c68x8vacx', 'afu5w1of7', -2147483648, 'I');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('?', 'o72ctdc', 'mfg62', '0v', 'vice president', 'q8qdjpe1', 'o22', -2147483648, 't1__1f3540');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', '7cvtjpt', 'tg6bnou5zi', '6c4bfkfo', 'vice president', 'c', '0', -2147483648, 't1__1f3540');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', 'zezjo7wg', 'd5ysxc', 'r0oz', 'vice president', 'dgj5i', 'lq5lnpim', -2147483648, 't1__1f3540');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_10', 's27p2r94gth2', 'najj', 'a3o', NULL, 'v8u', 'tmu2n', -2147483648, 't1__1f3540');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_11', 'v42', '7sx58', 'b4pmaus3auv', 'vice president', 'krpd', 'wzw', -2147483648, 't1__1f3540');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 'u7', 'fe4hri', 'a2ypuzhsrwbb', NULL, 'p6luhvdlttil', 'n', -2147483648, '@');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('B', '00t5c4ecigc', 'e376nium52', 'zbuo4nrqrof', NULL, 'qyp5s5bbp0', '2eutliqa11r', -2147483648, 'B');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('C', 'au2dwy', 'q13py', '78d99r', NULL, 'jsl', 'b4yp5qi', -2147483648, '"');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('D', 'bdvlph', 'gndqwnqc', 'x5hncprjtu0', NULL, 'z', '9fjgq8n2f', -2147483648, '`');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('J', 'ah0f8jsww', 'q7x', '7', NULL, '2fxa7ryfdrz', '16nijjai5dh', -2147483648, 'D');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('K', 'xp1q430', 'jh3den8', 'c68x8vacx7', NULL, 'f', '5w1of7', -2147483648, 'F');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('`', 'q8qdjpe1io22', '8507cvtjp', 'ttg6bnou5zi3', NULL, 'c4bfkfoac', '0', -2147483648, '#');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('a', 'g', '5i3', 'q5l', NULL, 'pim5', '58q', -2147483648, '''');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('!', '8uttmu', 'ne578lfv', 'yz7zzbe8yvk', NULL, 'v42q7sx58b4p', 'aus3', -2147483648, '&');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t1__1f3540', '5k5swwqcgs', '9n8', 't2__8561a9');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_2', 'a9000t5c4eci', 'gce376nium52', 't2__8561a9');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('C', 'ytoo3o9', 'l7', 'klex14ji');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('A', 'rkf9vqx5', 'pz0f8jegd', 't2__8561a9');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('_', '1vy9uxj4', 'wb', 'v');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('G', 'fjgq8n2f3', 'dqv0gcb98ozk', 'zbilyrkn');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('I', '16nijjai5dh', 'ogrgjd8y', 't1afgog');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t2__38e1d1', '57', 'lfvyz7zzb', '8y');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('@', '5k5swwqcgs', '9n8', '4');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('B', 'rmdp', 'siie', 'unw6klfa');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('"', 'ytoo3o9', 'l7', 'klex14ji');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('`', 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('D', 'dqv0gcb9', 'ozk3zbily', 'kn6vc');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('F', 'ogrgjd8y', 't1afgog', 'itsj3');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('#', 'pzo72ctdc', 'mfg62', '0v');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('''', '7z2zezjo7wg', 'd5ysxc', 'r0oz');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('&', 's27p2r94gth2', 'najj', 'a3o');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, '4', 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.college FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id WHERE T1.position LIKE 'vice president';

/*
Gold Result:
('t2__8561a9',)
('t2__8561a9',)
('klex14ji',)
('v',)
('zbilyrkn',)
('t1afgog',)
('t2__8561a9',)
('t2__8561a9',)
('t2__8561a9',)
('t2__8561a9',)
*/

-- Prediction Query
SELECT T2.college FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id WHERE T1.position = 'Vice President';

/*
Prediction Result:
*/