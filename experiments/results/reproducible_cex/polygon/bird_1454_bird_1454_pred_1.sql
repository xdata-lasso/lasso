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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Game23', 'Game69', 'Game69', 'Game69', 'Game69', 'Game69', 'Game69');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Game69', 'Game64', 'Game65', 'Game', 'Game66', 'Game67', 'Game68');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Game25', 'Game69', 'Game69', 'Game69');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Game24', 'Game69', 'Game69', 'Game69');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (27, 'Game69', 'Game69', 'Game69', 'Game69', 'Game69');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (26, 'Game69', 'Game69', 'Game69', 'Game69', 'Game69');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Game69', 'Game33');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Game32', 'Game69', 'Game70', 71, 72, 73, 'Game74');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Game31', 'Game69', 'Game75', 76, 77, 78, 'Game79');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Game30', 'Game31', 'Game33', 'Game43', 'Game44', 1, 'Game45');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Game29', 'Game32', 'Game34', 'Game46', 'Game47', 2, 'Game48');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Game36', 'Game33', 'Game69', 69, 'Game69', 'Game69');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Game35', 'Game34', 'Game69', 69, 'Game69', 'Game69');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Game33', 'Game24', 26, 'Game69', 'Game69', 'Game69', 'Game69', 'Game69', 'Game69');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Game34', 'Game25', 26, 'Game69', 'Game69', 'Game69', 'Game69', 'Game69', 'Game69');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(CASE WHEN T1.type = 'Game' THEN T3.cost ELSE 0 END) * 100 / SUM(T3.cost) FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget;

/*
Gold Result:
(100.0,)
*/

-- Prediction Query
SELECT CAST(SUM(T3.cost) AS REAL) * 100 / COUNT(T1.event_id) AS percentage_cost FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget WHERE T1.type = 'Game' AND NOT T3.cost IS NULL;

/*
Prediction Result:
(150.0,)
*/