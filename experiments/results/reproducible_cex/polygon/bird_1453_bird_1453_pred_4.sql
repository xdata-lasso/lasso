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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Parking51', 'Parking62', NULL, 'Parking64', 'Parking65', 'Parking66', NULL);
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Parking78', 'Parking72', 'Parking73', 'Parking74', 'Parking75', 'Parking76', 'Parking77');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Parking45', 'Parking54', 'Parking54', 'Parking54');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Parking44', 'Parking54', 'Parking54', 'Parking54');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (47, 'Parking54', 'Parking54', 'Parking54', 'Parking54', 'Parking54');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (46, 'Parking54', 'Parking54', 'Parking54', 'Parking54', 'Parking54');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Parking78', 'Parking55');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Parking50', 'Parking51', 'Parking', 68, 69, 70, 'Parking71');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Parking54', 'Parking78', 'Parking', 79, 80, 81, 'Parking82');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Parking53', 'Parking54', 'Parking55', 'Parking85', 'Parking86', -1166, 'Parking87');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Parking52', NULL, NULL, 'Parking54', 'Parking54', 335, 'Parking54');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Parking57', 'Parking55', 'Parking54', 54, 'Parking54', 'Parking54');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Parking56', 'Parking55', 'Parking54', 54, 'Parking54', 'Parking54');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Parking49', 'Parking44', 47, 'Parking54', 'Parking54', 'Parking54', 'Parking54', 'Parking54', 'Parking54');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Parking55', 'Parking44', 47, 'Parking54', 'Parking54', 'Parking54', 'Parking54', 'Parking54', 'Parking54');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_name FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget WHERE T2.category = 'Parking' AND T3.cost < (SELECT AVG(cost) FROM expense);

/*
Gold Result:
('Parking72',)
*/

-- Prediction Query
SELECT T1.event_name FROM event AS T1 JOIN budget AS T2 ON T1.event_id = T2.link_to_event JOIN expense AS T3 ON T3.link_to_budget = T2.budget_id WHERE T2.category = 'Parking' AND T3.cost < (SELECT AVG(cost) FROM expense WHERE link_to_budget IN (SELECT budget_id FROM budget WHERE category = 'Parking'));

/*
Prediction Result:
*/