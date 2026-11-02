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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Yearly Kickoff31', 'Yearly Kickoff', 'Yearly Kickoff44', 'Yearly Kickoff45', 'Yearly Kickoff46', 'Yearly Kickoff47', 'Yearly Kickoff48');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Yearly Kickoff37', NULL, 'Yearly Kickoff55', 'Yearly Kickoff56', 'Yearly Kickoff57', 'Yearly Kickoff58', 'Yearly Kickoff59');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Yearly Kickoff32', 'Yearly Kickoff70', 'Yearly Kickoff70', 'Yearly Kickoff70');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Yearly Kickoff64', 'Yearly Kickoff70', 'Yearly Kickoff70', 'Yearly Kickoff70');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (33, 'Yearly Kickoff70', 'Yearly Kickoff70', 'Yearly Kickoff70', 'Yearly Kickoff70', 'Yearly Kickoff70');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (65, 'Yearly Kickoff70', 'Yearly Kickoff70', 'Yearly Kickoff70', 'Yearly Kickoff70', 'Yearly Kickoff70');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Yearly Kickoff31', 'Yearly Kickoff70');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Yearly Kickoff37', 'Yearly Kickoff34');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Yearly Kickoff36', 'Yearly Kickoff37', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Yearly Kickoff35', 'Yearly Kickoff31', 'Yearly Kickoff76', 77, 78, 79, 'Yearly Kickoff80');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Yearly Kickoff71', 'Yearly Kickoff35', 'Yearly Kickoff70', 'Yearly Kickoff72', NULL, 74, 'Yearly Kickoff75');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Yearly Kickoff81', 'Yearly Kickoff35', 'Yearly Kickoff70', 'Yearly Kickoff82', 'Yearly Kickoff83', 84, 'Yearly Kickoff85');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Yearly Kickoff39', 'Yearly Kickoff70', 'Yearly Kickoff70', 70, 'Yearly Kickoff70', 'Yearly Kickoff70');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Yearly Kickoff38', 'Yearly Kickoff70', 'Yearly Kickoff70', 70, 'Yearly Kickoff70', 'Yearly Kickoff70');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Yearly Kickoff70', 'Yearly Kickoff64', 65, NULL, NULL, 'Yearly Kickoff66', 'Yearly Kickoff67', 'Yearly Kickoff68', 'Yearly Kickoff69');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Yearly Kickoff34', 'Yearly Kickoff32', 33, 'Yearly Kickoff70', 'Yearly Kickoff70', 'Yearly Kickoff70', 'Yearly Kickoff70', 'Yearly Kickoff70', 'Yearly Kickoff70');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T4.first_name, T4.last_name FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget INNER JOIN member AS T4 ON T3.link_to_member = T4.member_id WHERE T1.event_name = 'Yearly Kickoff';

/*
Gold Result:
(None, None)
(None, None)
*/

-- Prediction Query
SELECT DISTINCT m.first_name, m.last_name FROM member AS m INNER JOIN expense AS e ON m.member_id = e.link_to_member INNER JOIN budget AS b ON e.link_to_budget = b.budget_id INNER JOIN event AS ev ON b.link_to_event = ev.event_id WHERE ev.event_name = 'Yearly Kickoff';

/*
Prediction Result:
(None, None)
*/