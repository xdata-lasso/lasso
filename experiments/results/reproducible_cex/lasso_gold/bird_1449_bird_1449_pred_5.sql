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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('we', 'Eric Ortiz', 'interesting', 'same', 'Never court professor here security.', '8044 Russell Prairie Suite 777
New Thomas, MH 96964', 'condition');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('reason', 'Jose Schultz', 'government', 'better');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('https://griffin.info/', 'Jose Schultz', 'government', 'better');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1026, 'tell', 'Lake Lance', 'sure', 'Illinois', 'Georgia');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('ago', 'any', 1027.5, 1028.5, 1029, 'election', 'we');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('may', 'Cheryl', 'Mack', 'operry@example.net', 'day', 'serious', '001-967-263-2016x328', 1026, 'reason');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('free', 'Cheryl', 'Mack', 'operry@example.net', 'day', 'serious', '001-967-263-2016x328', 1026, 'https://griffin.info/');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('onto', 'True building card let most.', 'operation', 101.0, 'physical', 'may', 'ago');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('event', 'True building card let most.', 'operation', 102.0, 'physical', 'free', 'ago');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.first_name, T1.last_name, T2.major_name FROM member AS T1 INNER JOIN major AS T2 ON T2.major_id = T1.link_to_major INNER JOIN expense AS T3 ON T1.member_id = T3.link_to_member WHERE T3.cost > 100;

/*
Gold Result:
('Cheryl', 'Mack', 'Jose Schultz')
*/

-- Prediction Query
SELECT T1.first_name, T1.last_name, T2.major_name FROM member AS T1 JOIN expense AS T3 ON T1.member_id = T3.link_to_member JOIN major AS T2 ON T1.link_to_major = T2.major_id WHERE T3.cost > 100;

/*
Prediction Result:
('Cheryl', 'Mack', 'Jose Schultz')
('Cheryl', 'Mack', 'Jose Schultz')
*/