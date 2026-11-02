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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Water, chips, cookies33', 'Water, chips, cookies23', 'Water, chips, cookies23', 'Water, chips, cookies23', 'Water, chips, cookies23', 'Water, chips, cookies23', 'Water, chips, cookies23');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Water, chips, cookies16', 'Water, chips, cookies23', 'Water, chips, cookies23', 'Water, chips, cookies23', 'Water, chips, cookies23', 'Water, chips, cookies23', 'Water, chips, cookies23');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Water, chips, cookies18', 'Water, chips, cookies23', 'Water, chips, cookies23', 'Water, chips, cookies23');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Water, chips, cookies17', 'Water, chips, cookies23', 'Water, chips, cookies23', 'Water, chips, cookies23');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (19, 'Water, chips, cookies23', 'Water, chips, cookies23', 'Water, chips, cookies23', 'Water, chips, cookies23', 'Water, chips, cookies23');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Water, chips, cookies16', 'Water, chips, cookies23');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Water, chips, cookies42', 'Water, chips, cookies33', 'Water, chips, cookies34', 35, NULL, 37, 'Water, chips, cookies38');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Water, chips, cookies22', 'Water, chips, cookies42', 'Water, chips, cookies23', 'Water, chips, cookies', 'Water, chips, cookies30', 31, 'Water, chips, cookies32');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Water, chips, cookies21', NULL, 'Water, chips, cookies23', 'Water, chips, cookies', 'Water, chips, cookies39', 40, 'Water, chips, cookies41');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Water, chips, cookies25', 'Water, chips, cookies23', 'Water, chips, cookies23', 23, 'Water, chips, cookies23', 'Water, chips, cookies23');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Water, chips, cookies24', 'Water, chips, cookies23', 'Water, chips, cookies23', 23, 'Water, chips, cookies23', 'Water, chips, cookies23');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Water, chips, cookies23', 'Water, chips, cookies18', 19, 'Water, chips, cookies23', 'Water, chips, cookies23', 'Water, chips, cookies23', 'Water, chips, cookies23', 'Water, chips, cookies23', 'Water, chips, cookies23');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.budget_id FROM expense AS T1 INNER JOIN budget AS T2 ON T1.link_to_budget = T2.budget_id WHERE T1.expense_description = 'Water, chips, cookies' ORDER BY T1.cost DESC, T1.expense_id NULLS LAST, T2.budget_id NULLS LAST LIMIT 1;

/*
Gold Result:
('Water, chips, cookies42',)
*/

-- Prediction Query
SELECT T1.link_to_budget FROM expense AS T1 WHERE T1.expense_description = 'Water, chips, cookies' ORDER BY T1.cost DESC, T1.expense_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/