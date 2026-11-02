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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Yearly Kickoff60', 'Yearly Kickoff', 'Yearly Kickoff55', 'Yearly Kickoff56', 'Yearly Kickoff57', 'Yearly Kickoff58', 'Yearly Kickoff59');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Yearly Kickoff71', 'Yearly Kickoff', 'Yearly Kickoff66', 'Yearly Kickoff67', 'Yearly Kickoff68', 'Yearly Kickoff69', 'Yearly Kickoff70');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Yearly Kickoff31', 'Yearly Kickoff34', 'Yearly Kickoff34', 'Yearly Kickoff34');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Yearly Kickoff39', 'Yearly Kickoff34', 'Yearly Kickoff34', 'Yearly Kickoff34');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (32, 'Yearly Kickoff34', 'Yearly Kickoff34', 'Yearly Kickoff34', 'Yearly Kickoff34', 'Yearly Kickoff34');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (40, 'Yearly Kickoff34', 'Yearly Kickoff34', 'Yearly Kickoff34', 'Yearly Kickoff34', 'Yearly Kickoff34');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Yearly Kickoff71', 'Yearly Kickoff33');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Yearly Kickoff71', 'Yearly Kickoff34');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Yearly Kickoff35', 'Yearly Kickoff71', 'Yearly Kickoff72', 73, 74, 75, 'Yearly Kickoff76');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Yearly Kickoff36', 'Yearly Kickoff60', 'Yearly Kickoff61', 62, 63, 64, 'Yearly Kickoff65');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Yearly Kickoff82', 'Yearly Kickoff35', 'Yearly Kickoff34', 'Yearly Kickoff83', 'Yearly Kickoff84', 85, 'Yearly Kickoff86');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Yearly Kickoff77', 'Yearly Kickoff36', 'Yearly Kickoff34', 'Yearly Kickoff78', 'Yearly Kickoff79', 80, 'Yearly Kickoff81');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Yearly Kickoff38', 'Yearly Kickoff34', 'Yearly Kickoff34', 34, 'Yearly Kickoff34', 'Yearly Kickoff34');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Yearly Kickoff37', 'Yearly Kickoff34', 'Yearly Kickoff34', 34, 'Yearly Kickoff34', 'Yearly Kickoff34');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Yearly Kickoff33', 'Yearly Kickoff31', 32, 'Yearly Kickoff34', 'Yearly Kickoff34', 'Yearly Kickoff34', 'Yearly Kickoff34', 'Yearly Kickoff34', 'Yearly Kickoff34');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Yearly Kickoff34', 'Yearly Kickoff39', 40, NULL, 'Yearly Kickoff50', 'Yearly Kickoff51', 'Yearly Kickoff52', 'Yearly Kickoff53', 'Yearly Kickoff54');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T4.first_name, T4.last_name FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget INNER JOIN member AS T4 ON T3.link_to_member = T4.member_id WHERE T1.event_name = 'Yearly Kickoff';

/*
Gold Result:
(None, 'Yearly Kickoff50')
(None, 'Yearly Kickoff50')
*/

-- Prediction Query
SELECT DISTINCT T4.first_name, T4.last_name FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget INNER JOIN member AS T4 ON T3.link_to_member = T4.member_id WHERE T1.event_name = 'Yearly Kickoff';

/*
Prediction Result:
(None, 'Yearly Kickoff50')
*/