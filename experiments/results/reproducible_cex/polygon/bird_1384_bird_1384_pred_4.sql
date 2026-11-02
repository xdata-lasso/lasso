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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Gilmour19', 'Gilmour39', 'Gilmour39', 'Gilmour39', 'Gilmour39', 'Gilmour39', 'Gilmour39');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Grant18', 'Gilmour39', 'Gilmour39', 'Gilmour39', 'Gilmour39', 'Gilmour39', 'Gilmour39');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Grant40', 'Gilmour39', 'Gilmour39', 'Gilmour39');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Grant20', 'Gilmour39', 'Gilmour39', 'Gilmour39');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (41, 'Gilmour39', 'Gilmour39', 'Gilmour39', 'Gilmour39', 'Gilmour39');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Gilmour19', 'Gilmour21');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Grant18', 'Gilmour21');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Grant22', 'Grant18', 'Gilmour39', 39, 39, 39, 'Gilmour39');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Grant24', 'Grant22', 'Gilmour21', 'Gilmour39', 'Gilmour39', 39, 'Gilmour39');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Gilmour23', 'Grant22', 'Gilmour21', 'Gilmour39', 'Gilmour39', 39, 'Gilmour39');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Gilmour29', 'Gilmour39', 'Grant30', NULL, 'Grant32', 'Gilmour33');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Grant34', 'Gilmour39', 'Gilmour35', NULL, 'Gilmour37', 'Grant38');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Gilmour39', 'Grant40', 41, 'Grant', 'Gilmour', 'Grant42', 'Gilmour43', 'Grant44', 'Gilmour45');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Gilmour21', 'Grant40', 41, 'Gilmour39', 'Gilmour39', 'Gilmour39', 'Gilmour39', 'Gilmour39', 'Gilmour39');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.amount FROM member AS T1 INNER JOIN income AS T2 ON T1.member_id = T2.link_to_member WHERE T1.first_name = 'Grant' AND T1.last_name = 'Gilmour';

/*
Gold Result:
(None,)
(None,)
*/

-- Prediction Query
SELECT SUM(i.amount) AS total_income FROM income AS i JOIN member AS m ON i.link_to_member = m.member_id WHERE m.first_name = 'Grant' AND m.last_name = 'Gilmour';

/*
Prediction Result:
(None,)
*/