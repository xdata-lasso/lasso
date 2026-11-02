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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Game68', 'Meeting63', 'Game64', 'Meeting', 'Meeting65', 'Game66', 'Meeting67');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Meeting23', 'Game68', 'Game68', 'Game68');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Game22', 'Game68', 'Game68', 'Game68');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (25, 'Game68', 'Game68', 'Game68', 'Game68', 'Game68');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (24, 'Game68', 'Game68', 'Game68', 'Game68', 'Game68');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Game68', 'Game30');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Game68', 'Meeting31');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Game26', NULL, 'Game68', 68, 68, 68, 'Game68');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Meeting29', 'Game68', 'Meeting69', 70, 71, 72, 'Meeting73');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Game28', 'Meeting29', 'Game30', 'Game40', 'Meeting41', 396, 'Game42');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Meeting27', 'Meeting29', 'Meeting31', 'Meeting43', 'Game44', -788, 'Meeting45');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Meeting33', 'Meeting31', 'Game68', 68, 'Game68', 'Game68');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Game32', NULL, 'Game68', 68, 'Game68', 'Game68');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Game30', 'Game22', 24, 'Game68', 'Game68', 'Game68', 'Game68', 'Game68', 'Game68');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Meeting31', 'Meeting23', 24, 'Game68', 'Game68', 'Game68', 'Game68', 'Game68', 'Game68');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(CASE WHEN T1.type = 'Game' THEN T3.cost ELSE 0 END) * 100 / SUM(T3.cost) FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget;

/*
Gold Result:
(-0.0,)
*/

-- Prediction Query
SELECT (SUM(expense.cost) * 100.0) / COUNT(DISTINCT event.event_id) AS percentage FROM event INNER JOIN budget ON event.event_id = budget.link_to_event INNER JOIN expense ON budget.budget_id = expense.link_to_budget WHERE event.type = 'Meeting';

/*
Prediction Result:
(-39200.0,)
*/