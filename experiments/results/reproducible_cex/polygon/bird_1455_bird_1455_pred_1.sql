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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Water, chips, cookies15', 'Water, chips, cookies21', 'Water, chips, cookies21', 'Water, chips, cookies21', 'Water, chips, cookies21', 'Water, chips, cookies21', 'Water, chips, cookies21');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Water, chips, cookies31', 'Water, chips, cookies21', 'Water, chips, cookies21', 'Water, chips, cookies21', 'Water, chips, cookies21', 'Water, chips, cookies21', 'Water, chips, cookies21');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Water, chips, cookies16', 'Water, chips, cookies21', 'Water, chips, cookies21', 'Water, chips, cookies21');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (17, 'Water, chips, cookies21', 'Water, chips, cookies21', 'Water, chips, cookies21', 'Water, chips, cookies21', 'Water, chips, cookies21');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Water, chips, cookies31', 'Water, chips, cookies21');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Water, chips, cookies15', 'Water, chips, cookies21');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Water, chips, cookies40', 'Water, chips, cookies31', 'Water, chips, cookies32', 33, 34, 35, 'Water, chips, cookies36');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Water, chips, cookies18', NULL, 'Water, chips, cookies21', 21, 21, 21, 'Water, chips, cookies21');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Water, chips, cookies20', 'Water, chips, cookies40', 'Water, chips, cookies21', 'Water, chips, cookies', 'Water, chips, cookies28', 29, 'Water, chips, cookies30');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Water, chips, cookies19', NULL, 'Water, chips, cookies21', 'Water, chips, cookies', 'Water, chips, cookies37', 38, 'Water, chips, cookies39');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Water, chips, cookies23', 'Water, chips, cookies21', 'Water, chips, cookies21', 21, 'Water, chips, cookies21', 'Water, chips, cookies21');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Water, chips, cookies22', 'Water, chips, cookies21', 'Water, chips, cookies21', 21, 'Water, chips, cookies21', 'Water, chips, cookies21');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Water, chips, cookies21', 'Water, chips, cookies16', 17, 'Water, chips, cookies21', 'Water, chips, cookies21', 'Water, chips, cookies21', 'Water, chips, cookies21', 'Water, chips, cookies21', 'Water, chips, cookies21');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.budget_id FROM expense AS T1 INNER JOIN budget AS T2 ON T1.link_to_budget = T2.budget_id WHERE T1.expense_description = 'Water, chips, cookies' ORDER BY T1.cost DESC, T1.expense_id NULLS LAST, T2.budget_id NULLS LAST LIMIT 1;

/*
Gold Result:
('Water, chips, cookies40',)
*/

-- Prediction Query
SELECT link_to_budget FROM expense WHERE expense_description = 'Water, chips, cookies' ORDER BY cost DESC, expense.expense_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/