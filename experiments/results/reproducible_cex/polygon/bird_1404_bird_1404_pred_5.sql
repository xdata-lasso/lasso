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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('true25', 'October Meeting', 'true35', 'October Meeting36', 'true37', 'October Meeting38', 'true39');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('October Meeting24', 'October Meeting', 'October Meeting40', NULL, 'October Meeting42', 'true43', 'October Meeting44');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('true27', 'true25', 'true25', 'true25');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('October Meeting26', 'true25', 'true25', 'true25');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (28, 'true25', 'true25', 'true25', 'true25', 'true25');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('true25', 'October Meeting52');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('October Meeting24', 'October Meeting62');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('true55', 'true25', 'October Meeting56', 57, 58, 59, 'October Meeting60');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('October Meeting66', 'October Meeting24', 'true67', 68, 69, 70, 'true71');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('true51', 'true55', 'October Meeting52', 'true53', 'October Meeting54', 0, 'true');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('true61', 'October Meeting66', 'October Meeting62', 'true63', 'October Meeting64', NULL, 'true');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('October Meeting30', 'October Meeting62', 'true25', 25, 'true25', 'true25');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('true29', 'October Meeting62', 'true25', 25, 'true25', 'true25');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('October Meeting52', 'true27', 28, 'true25', 'true25', 'true25', 'true25', 'true25', 'true25');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('October Meeting62', 'true27', 28, 'true25', 'true25', 'true25', 'true25', 'true25', 'true25');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.type, SUM(T3.cost) FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget WHERE T1.event_name = 'October Meeting';

/*
Gold Result:
('October Meeting36', 0.0)
*/

-- Prediction Query
SELECT T1.expense_description, SUM(T1.cost) FROM expense AS T1 INNER JOIN budget AS T2 ON T1.link_to_budget = T2.budget_id INNER JOIN event AS T3 ON T2.link_to_event = T3.event_id WHERE T3.event_name = 'October Meeting' AND T1.approved = 'true' GROUP BY T1.expense_description;

/*
Prediction Result:
('true53', 0.0)
('true63', None)
*/