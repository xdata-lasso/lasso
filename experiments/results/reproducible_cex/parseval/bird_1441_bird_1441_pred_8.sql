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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__baa27c', 'rwbbp6luhvd', 'tti', 'bnp', 'mdpos', 'ie5', 'nw6klf', -2147483648, 't1__4236aa');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', '78d99r', 'jsl', 'b4yp5qi', 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4', -2147483648, 't1__4236aa');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', '9n8c4pgu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'bnp', -2147483648, 'H');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('B', 'e5u', 'w6kl', 'a9', '00t5c4e', 'cigce376nium', '52zbuo4nrq', -2147483648, 'C');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('H', '02eu', 'liqa1', 'ryytoo3', '9hl7', 'klex14ji', '7zwau2dwyr', -2147483648, '@');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('I', '9rljsl0b4', 'p5qi2rk', '9v', 'x58pz', 'f8jegd2', 'vy9uxj4', -2147483648, 'B');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('G', 'lph2gn', 'q', 'nqcx5h', 'cprj', 'u0dz7', 'fjgq8n2f3', -2147483648, 'D');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('C', 'bilyrkn', '6vck6ah0f8js', 'wlq7xb', '72fxa7ryfd', 'z16ni', 'jai', -2147483648, '$');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('D', 'yzt1afgog', 'itsj3', 'y', 'p1q430', 'jh3den8', 'c68x8vacx7', -2147483648, 'F');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('F', 'w1of77pz', '72ct', 'c', 'mfg62', '0v', 'q8qdjpe1', -2147483648, '&');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t1__4236aa', 'education', '5k5swwqcgs', 'College of Education & Human Services');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('A', 'education', 'a9000t5c4eci', 'College of Education & Human Services');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('G', 'gce376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('_', 'eutliqa11r', 'ytoo3o9', 'l7');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('O', 'lex', '4ji7zwa', '2dwyrq');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t2__2d60a2', 'h2gn', 'q', 'nqcx5h');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('H', 'education', '5k5swwqcgs', 't2__c2f6e7');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('C', 'education', 'mdpos', NULL);

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('@', NULL, 'rofqyp5s5b', 'College of Education & Human Services');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('B', NULL, '13pyu', 'College of Education & Human Services');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('D', NULL, 'wb', 'College of Education & Human Services');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('$', NULL, 'dqv0gcb98ozk', 'College of Education & Human Services');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('F', NULL, 'dh5ogrgj', 'College of Education & Human Services');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('&', NULL, 'f', 'College of Education & Human Services');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.member_id) FROM member AS T1 INNER JOIN major AS T2 ON T2.major_id = T1.link_to_major WHERE T1.position = 'Member' AND T2.major_name LIKE '%Education%' AND T2.college = 'College of Education & Human Services';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(T1.member_id) FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id WHERE T2.major_name LIKE '%education%' AND LOWER(T2.college) = LOWER('College of Education & Human Services');

/*
Prediction Result:
(2,)
*/