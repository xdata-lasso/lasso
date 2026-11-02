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
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('woman', 'Cynthia Allen', 'company', 'policy');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('him', 'Angela Dennis', 'evidence', 'land');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('unit', 'Vanessa Patel', 'news', 'development');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('theory', 'Matthew Arroyo', 'turn', 'notice');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('family', 'Miranda Khan', 'arm', NULL);
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('community', 'Tyler Cowan', 'small', 'me');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('hundred', 'Michelle Moore', 'former', 'morning');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('able', 'Wayne Riley', 'art', 'wide');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1004, 'someone', 'Lake Larry', 'remain', 'Tennessee', 'Mississippi');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1005, 'group', 'East Jamesside', 'list', 'Florida', 'Nevada');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1006, 'tonight', 'North Susan', 'be', 'Idaho', 'California');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('left', 'Rachel', 'Hayes', 'jeffreymorgan@example.net', 'once', 'drug', '001-330-510-3105', 1004, 'woman');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('cover', 'Joshua', 'Wright', 'ramosmichelle@example.net', 'apply', 'reach', '+1-801-232-6773', 1005, 'family');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('physical', 'Carlos', 'Hensley', 'kwilson@example.org', 'particular', 'phone', '5917699854', 1006, 'family');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.college FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id GROUP BY T2.major_id ORDER BY COUNT(T2.college) DESC, T2.college NULLS LAST LIMIT 1;

/*
Gold Result:
('policy',)
*/

-- Prediction Query
SELECT T1.college FROM major AS T1 JOIN member AS T2 ON T1.major_id = T2.link_to_major GROUP BY T1.college ORDER BY COUNT(T1.major_id) DESC, T1.college NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/