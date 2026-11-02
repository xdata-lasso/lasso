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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__b996f6', 'tti', 'bnp', 'mdpos', 'ie5', 'Large', 'nw6klf', -2147483648, 't1__8e053f');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', 'jsl', 'b4yp5qi', 'rkf9vqx5', 'pz0f8jegd', 'Large', '1vy9uxj4', -2147483648, 't1__8e053f');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 'bdvlph', 'gndqwnqc', 'x5hncprjtu0', 'z', 'Large', '9fjgq8n2f', -2147483648, 't1__8e053f');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('Q', 'dqv0gcb98ozk', 'zbilyrkn', '6vck6ah0f8js', 'wlq7xb', 'Large', '72fxa7ryfd', -2147483648, 't1__8e053f');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('G', 'jja', '5dh', 'ogrgjd8y', 't1afgog', 'Large', 'itsj3', -2147483648, 't1__8e053f');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 'pgu7vfe4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 't1__261769', 'bnp', -2147483648, '@');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('_', 'w6kl', 'a9', '00t5c4e', 'cigce376nium', NULL, '52zbuo4nrq', -2147483648, 'I');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('B', '2eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', 'Large', '7zwau2dwyr', -2147483648, 'D');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('I', '4', 'p5qi2rk', '9v', 'x58pz', 't1__261769', 'f8jegd2', -2147483648, 'E');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('C', 'lph2gn', 'q', 'nqcx5h', 'cprj', NULL, 'u0dz7', -2147483648, '`');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('"', 'bilyrkn', '6vck6ah0f8js', 'wlq7xb', '72fxa7ryfd', 'Large', 'z16ni', -2147483648, 'a');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('D', 'yzt1afgog', 'itsj3', 'y', 'p1q430', 't1__261769', 'jh3den8', -2147483648, 'F');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('E', 'w1of77pz', '72ct', 'c', 'mfg62', NULL, '0v', -2147483648, '!');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t1__8e053f', 'Human Development AND Family Studies', '5k5swwqcgs', '9n8');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Q', 'Human Development AND Family Studies', 'a9000t5c4eci', 'gce376nium52');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('A', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('?', 'Human Development AND Family Studies', 'ytoo3o9hl7', 'klex14ji');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('_', 'Human Development AND Family Studies', 'au2dwyrq13', 'yu78');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t2__c580ae', 'xp1q430', 'jh3den8', 'c68x8vacx7');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('@', 'Human Development AND Family Studies', '5k5swwqcgs', '9n8');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('I', 'Human Development AND Family Studies', 'mdpos', 'ie5');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('D', 't2__fe7462', 'rofqyp5s5b', 'p');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('E', 't2__fe7462', '13pyu', '8d99rljsl');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('`', 't2__fe7462', 'vy9uxj4', 'wb');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('a', NULL, 'fjgq8n2f3', 'dqv0gcb98ozk');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('F', NULL, 'jai', 'dh5ogrgj');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('!', NULL, 'c68x8vacx7', 'f');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, '4', 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.member_id) FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id WHERE T2.major_name = 'Human Development AND Family Studies' AND T1.t_shirt_size = 'Large';

/*
Gold Result:
(5,)
*/

-- Prediction Query
SELECT COUNT(*) FROM member JOIN major ON member.link_to_major = major.major_id WHERE major.major_name = 'Business' AND member.t_shirt_size = 'Medium';

/*
Prediction Result:
(0,)
*/