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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Yearly Kickoff32', 'Yearly Kickoff', NULL, NULL, 'Yearly Kickoff70', 'Yearly Kickoff71', 'Yearly Kickoff72');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Yearly Kickoff33', 'Yearly Kickoff', 'Yearly Kickoff79', 'Yearly Kickoff80', 'Yearly Kickoff81', 'Yearly Kickoff82', 'Yearly Kickoff83');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Yearly Kickoff41', 'Yearly Kickoff32', 'Yearly Kickoff32', 'Yearly Kickoff32');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Yearly Kickoff30', 'Yearly Kickoff32', 'Yearly Kickoff32', 'Yearly Kickoff32');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (43, 'Yearly Kickoff32', 'Yearly Kickoff32', 'Yearly Kickoff32', 'Yearly Kickoff32', 'Yearly Kickoff32');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (31, 'Yearly Kickoff32', 'Yearly Kickoff32', 'Yearly Kickoff32', 'Yearly Kickoff32', 'Yearly Kickoff32');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Yearly Kickoff33', 'Yearly Kickoff35');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Yearly Kickoff32', 'Yearly Kickoff34');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Yearly Kickoff84', 'Yearly Kickoff33', 'Yearly Kickoff85', NULL, 87, 88, 'Yearly Kickoff89');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Yearly Kickoff73', 'Yearly Kickoff32', 'Yearly Kickoff74', 75, 76, 77, 'Yearly Kickoff78');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Yearly Kickoff37', 'Yearly Kickoff84', 'Yearly Kickoff35', 'Yearly Kickoff50', 'Yearly Kickoff51', NULL, 'Yearly Kickoff53');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Yearly Kickoff36', 'Yearly Kickoff73', 'Yearly Kickoff35', 'Yearly Kickoff54', 'Yearly Kickoff55', NULL, 'Yearly Kickoff57');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Yearly Kickoff39', 'Yearly Kickoff35', 'Yearly Kickoff32', 32, 'Yearly Kickoff32', 'Yearly Kickoff32');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Yearly Kickoff38', 'Yearly Kickoff35', 'Yearly Kickoff32', 32, 'Yearly Kickoff32', 'Yearly Kickoff32');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Yearly Kickoff34', NULL, NULL, NULL, NULL, 'Yearly Kickoff60', 'Yearly Kickoff61', 'Yearly Kickoff62', 'Yearly Kickoff63');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Yearly Kickoff35', 'Yearly Kickoff41', 43, NULL, 'Yearly Kickoff95', 'Yearly Kickoff64', 'Yearly Kickoff65', 'Yearly Kickoff66', 'Yearly Kickoff67');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T4.first_name, T4.last_name FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget INNER JOIN member AS T4 ON T3.link_to_member = T4.member_id WHERE T1.event_name = 'Yearly Kickoff';

/*
Gold Result:
(None, 'Yearly Kickoff95')
(None, 'Yearly Kickoff95')
*/

-- Prediction Query
SELECT m.first_name, m.last_name FROM event AS e INNER JOIN budget AS b ON e.event_id = b.link_to_event INNER JOIN attendance AS a ON b.link_to_event = a.link_to_event INNER JOIN member AS m ON a.link_to_member = m.member_id WHERE e.event_name = 'Yearly Kickoff';

/*
Prediction Result:
(None, 'Yearly Kickoff95')
(None, None)
*/