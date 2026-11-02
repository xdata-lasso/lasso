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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Electrical and Computer Engineering Department24', 'Member61', 'Member61', 'Member61', 'Member61', 'Member61', 'Member61');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Member25', 'Member61', 'Member61', 'Member61');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Member61', 'Electrical and Computer Engineering62', 'Electrical and Computer Engineering', 'Electrical and Computer Engineering Department63');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (27, 'Electrical and Computer Engineering Department39', 'Member40', 'Electrical and Computer Engineering41', 'Electrical and Computer Engineering Department42', 'Member43');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (26, 'Electrical and Computer Engineering44', 'Electrical and Computer Engineering Department45', 'Member46', 'Electrical and Computer Engineering47', 'Electrical and Computer Engineering Department48');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Electrical and Computer Engineering Department24', 'Member49');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Electrical and Computer Engineering Department24', 'Member55');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Member28', 'Electrical and Computer Engineering Department24', 'Member61', 61, 61, 61, 'Member61');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Electrical and Computer Engineering Department30', 'Member28', 'Member55', 'Member61', 'Member61', 61, 'Member61');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Electrical and Computer Engineering29', 'Member28', 'Member55', 'Member61', 'Member61', 61, 'Member61');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Electrical and Computer Engineering32', 'Member55', 'Member61', 61, 'Member61', 'Member61');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Member31', 'Member55', 'Member61', 61, 'Member61', 'Member61');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Member49', 'Member61', 26, 'Electrical and Computer Engineering50', 'Electrical and Computer Engineering Department51', 'Member52', 'Member', 'Electrical and Computer Engineering53', 'Electrical and Computer Engineering Department54');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Member55', 'Member61', 27, 'Electrical and Computer Engineering56', 'Electrical and Computer Engineering Department57', 'Member58', 'Member', 'Electrical and Computer Engineering59', 'Electrical and Computer Engineering Department60');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT city, state FROM member AS T1 INNER JOIN major AS T2 ON T2.major_id = T1.link_to_major INNER JOIN zip_code AS T3 ON T3.zip_code = T1.zip WHERE department = 'Electrical and Computer Engineering Department' AND position = 'Member';

/*
Gold Result:
*/

-- Prediction Query
SELECT T3.city, T3.state FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id INNER JOIN zip_code AS T3 ON T1.zip = T3.zip_code WHERE T2.department = 'Electrical and Computer Engineering' AND T1.position = 'Member';

/*
Prediction Result:
('Electrical and Computer Engineering Department45', 'Electrical and Computer Engineering47')
('Member40', 'Electrical and Computer Engineering Department42')
*/