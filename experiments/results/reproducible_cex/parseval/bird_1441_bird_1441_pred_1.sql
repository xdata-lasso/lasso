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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__8edc89', 'rwbbp6luhvd', 'tti', 'bnp', 'Member', 'mdpos', 'ie5', -2147483648, 't1__0b2a7e');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__38be5a', 'a11ry', 'ytoo3o9hl7', 'klex14ji', 'Member', '7zwau2dwyr', '13pyu', -2147483648, 't1__0b2a7e');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('_', '9n8c4pgu7v', 'e4', 'hria2ypuzhs', 'Member', 'rwbbp6luhvd', 'tti', -2147483648, '@');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('?', 'dpos', 'ie5', 'nw6klf', 'Member', 'a9000t5c4eci', 'gce376nium52', -2147483648, '`');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', 'p5s5bbp', '02eutliqa11r', 'ytoo3o9', 'Member', 'l7', 'klex14ji', -2147483648, 'B');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('C', '3pyu78d', '9rljsl0b4', 'p5qi2rk', 'Member', '9v', 'x58pz', -2147483648, 'D');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 'y9uxj4', 'wb', 'v', 'Member', 'ph2', 'nd', -2147483648, 'b');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 'hncprjtu0dz', '9fjgq8n2f', 'dqv0gcb9', 'Member', 'ozk3zbily', 'kn6vc', -2147483648, 'E');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('`', '8j', 'wwlq7', 'xb72fxa7ryfd', 'Member', 'z16ni', 'jai', -2147483648, 'F');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('B', 'yzt1afgog', 'itsj3', 'y', 'Member', 'p1q430', 'jh3den8', -2147483648, '"');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t1__0b2a7e', 'Education', '5k5swwqcgs', 'College of Education & Human Services');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('C', 'Education', 'nw6klf', 'College of Education & Human Services');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('A', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('G', 'Education', '5s5b', 'College of Education & Human Services');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('O', 'Education', '02eu', 'College of Education & Human Services');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t2__34ef9e', 'b4yp5qi', 'rkf9vqx5', 'pz0f8jegd');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('@', 'Education', '5k5swwqcgs', 't2__648696');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('`', 'Education', 'bnp', NULL);

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('B', NULL, 'zbuo4nrqrof', 'College of Education & Human Services');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('D', NULL, '7zwau2dwyr', 'College of Education & Human Services');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('b', NULL, 'f8jegd2', 'College of Education & Human Services');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('E', NULL, 'wnqcx', 'College of Education & Human Services');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('F', NULL, '6ah', 'College of Education & Human Services');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('"', NULL, 'dh5ogrgj', 'College of Education & Human Services');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.member_id) FROM member AS T1 INNER JOIN major AS T2 ON T2.major_id = T1.link_to_major WHERE T1.position = 'Member' AND T2.major_name LIKE '%Education%' AND T2.college = 'College of Education & Human Services';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(*) FROM member JOIN major ON member.link_to_major = major.major_id WHERE major.college = 'College of Education & Human Services';

/*
Prediction Result:
(8,)
*/