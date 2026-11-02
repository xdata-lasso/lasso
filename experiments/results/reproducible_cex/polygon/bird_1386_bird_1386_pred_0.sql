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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Yearly Kickoff52', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Yearly Kickoff24', NULL, 'Yearly Kickoff52', 'Yearly Kickoff52', 'Yearly Kickoff52', 'Yearly Kickoff52', 'Yearly Kickoff52');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Yearly Kickoff25', 'Yearly Kickoff52', 'Yearly Kickoff52', 'Yearly Kickoff52');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (27, 'Yearly Kickoff52', 'Yearly Kickoff52', 'Yearly Kickoff52', 'Yearly Kickoff52', 'Yearly Kickoff52');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Yearly Kickoff30', 'Yearly Kickoff52', NULL, NULL, 43, 44, NULL);
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Yearly Kickoff67', 'Yearly Kickoff52', 'Yearly Kickoff53', 54, 55, 56, 'Yearly Kickoff57');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Yearly Kickoff32', NULL, 'Yearly Kickoff29', 'Yearly Kickoff52', 'Yearly Kickoff52', 52, 'Yearly Kickoff52');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Yearly Kickoff31', 'Yearly Kickoff67', 'Yearly Kickoff34', 'Yearly Kickoff60', NULL, 0, 'Yearly Kickoff62');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Yearly Kickoff29', NULL, 27, 'Yearly Kickoff52', 'Yearly Kickoff52', 'Yearly Kickoff52', 'Yearly Kickoff52', 'Yearly Kickoff52', 'Yearly Kickoff52');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Yearly Kickoff34', 'Yearly Kickoff25', NULL, 'Yearly Kickoff52', 'Yearly Kickoff52', 'Yearly Kickoff52', 'Yearly Kickoff52', 'Yearly Kickoff52', 'Yearly Kickoff52');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(T3.cost) FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget WHERE T1.event_name = 'Yearly Kickoff';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT SUM(cost) FROM expense WHERE link_to_budget IN (SELECT budget_id FROM budget WHERE link_to_event = (SELECT event_id FROM event WHERE event_name = 'Yearly Kickoff'));

/*
Prediction Result:
(None,)
*/