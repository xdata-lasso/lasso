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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__82bded', 'tti', 'bnp', 'mdpos', 'ie5', 'nw6klf', 'a9000t5c4eci', -2147483648, 't1__c0416a');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__4a59a6', 'p5qi2rk', '9v', 'x58pz', 'f8jegd2', 'vy9uxj4', 'wb', -2147483648, 't1__c0416a');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('_', 'pgu7vfe4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'bnp', 'mdpos', -2147483648, '@');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', '9000t5c4ec', 'gce', '76nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', -2147483648, '!');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('C', 'pgu7vfe4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'bnp', 'mdpos', -2147483648, '_');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', '9000t5c4ec', 'gce', '76nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', -2147483648, '"');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 'lex', '4ji7zwa', '2dwyrq', '3pyu78d', '9rljsl0b4', 'p5qi2rk', -2147483648, 'D');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('`', 'f8jegd21vy9u', 'j4hwbd', 'lph2gn', 'q', 'nqcx5h', 'cprj', -2147483648, '`');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t1__c0416a', '5k5swwqcgs', '9n8', 'College of Engineering');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('C', 'gce376nium52', 'zbuo4nrqrof', 'College of Engineering');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('A', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('O', '72klex14ji7z', 'au2dwy', 'College of Engineering');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('G', '13pyu', '8d99rljsl', 'College of Engineering');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t2__525e51', 'nd', 'wnqcx', '5hncprjtu0d');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('@', '5k5swwqcgs', '9n8', 't2__241123');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('!', 'ie5', 'nw6klf', NULL);

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('_', '5k5swwqcgs', '9n8', 'College of Engineering');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('"', 'ie5', 'nw6klf', 'College of Engineering');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('D', 'ytoo3o9', 'l7', 'College of Engineering');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('`', '9v', 'x58pz', 'College of Engineering');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, '4', 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.member_id) FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id WHERE T2.college = 'College of Engineering';

/*
Gold Result:
(6,)
*/

-- Prediction Query
SELECT COUNT(*) FROM member AS m INNER JOIN major AS mj ON m.link_to_major = mj.major_id WHERE mj.college = 'College of Engineering' AND m.position = 'Student';

/*
Prediction Result:
(0,)
*/