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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (0, 'default2', 'Game', 'Game', 'Meeting', 'Meeting'), (100, 'default2', NULL, 'Game', NULL, 'default1'), (-1, NULL, 'Game', 'default1', 'Game', 'default2'), (101, 'Meeting', 'default1', 'default1', 'Game', 'Meeting'), (1, 'default1', NULL, 'default2', 'default2', NULL), (99, 'Game', 'Game', 'Meeting', 'Meeting', NULL), (2, NULL, 'default1', 'Meeting', 'default1', NULL), (3, 'default1', 'default1', 'Game', 'Game', 'Game'), (4, 'Game', 'default2', 'Game', 'default1', 'Game'), (5, 'default1', NULL, 'default2', 'Meeting', 'Meeting'), (6, 'Meeting', 'Game', NULL, NULL, 'Game');
INSERT INTO major (major_id, major_name, department, college) VALUES ('default1', 'default2', 'Game', 'default2'), ('Meeting', 'default2', 'default2', 'Meeting'), ('Game', NULL, 'default2', 'default1'), ('default2', 'default1', NULL, NULL), ('unique_4', 'default2', 'Meeting', 'default2');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('default2', 'Meeting', 2, 'default2', 'Meeting', 'Game', 'Meeting', 'Meeting', 'Game'), ('default1', 'unique_4', 6, NULL, 'Game', 'default2', 'default1', 'default2', 'default2'), ('Game', 'Meeting', 2, 'Meeting', 'default2', 'Meeting', 'default2', 'default2', 'Meeting'), ('Meeting', 'default2', 99, 'default1', 'default2', 'default2', NULL, 'default2', 'default2'), ('unique_4', 'default2', 1, NULL, 'Meeting', 'Game', 'Game', 'Game', 'default1'), ('unique_5', 'Game', 6, NULL, 'Meeting', 'Meeting', 'default2', 'default2', 'default2');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('Meeting', NULL, 'Meeting', 'Game', NULL, 'Meeting', 'default1'), ('default1', NULL, 'default2', 'Game', NULL, 'Game', 'Meeting'), ('default2', NULL, 'default1', 'default2', NULL, NULL, 'default2'), ('Game', 'default1', 'Game', NULL, 'default2', 'default2', NULL), ('unique_4', 'Meeting', NULL, 'Game', 'default2', 'default2', 'Game'), ('unique_5', NULL, 'default2', 'Meeting', 'default1', 'Meeting', 'default2'), ('unique_6', 'default2', 'Meeting', 'Meeting', NULL, 'Game', 'default2');
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('default1', 'unique_4', NULL, -1.0, 0.0, 99, 'default2'), ('default2', NULL, 'Meeting', 101.0, 0.0, 1, 'Meeting'), ('Meeting', 'unique_5', NULL, 0.0, NULL, 0, NULL), ('Game', 'Meeting', 'Game', -1.0, 100.0, 99, NULL), ('unique_4', 'default2', 'default1', 99.0, -1.0, NULL, 'Game'), ('unique_5', 'default1', NULL, 99.0, 101.0, 101, 'Meeting'), ('unique_6', 'unique_6', 'Meeting', NULL, 99.0, NULL, 'Game'), ('unique_7', 'Meeting', NULL, 1.0, 0.0, NULL, 'Game'), ('unique_8', 'unique_6', NULL, 99.0, 100.0, 99, NULL);
INSERT INTO expense (expense_id, link_to_budget, link_to_member, expense_description, expense_date, cost, approved) VALUES ('Game', 'unique_7', 'Meeting', 'Meeting', NULL, 101.0, 'Game'), ('Meeting', 'unique_7', 'default2', 'default2', 'Meeting', 100.0, 'Game'), ('default2', NULL, NULL, 'Game', NULL, 99.0, 'Game'), ('default1', 'unique_6', 'Meeting', 'default1', NULL, NULL, NULL), ('unique_4', 'default2', 'Game', NULL, 'Game', 99.0, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(CASE WHEN T1.type = 'Game' THEN T3.cost ELSE 0 END) * 100 / SUM(T3.cost) FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget;

/*
Gold Result:
(100.0,)
*/

-- Prediction Query
SELECT CAST(SUM("expense"."cost") AS REAL) * 100 / COUNT("event"."event_id") FROM "expense" INNER JOIN "budget" ON "expense"."link_to_budget" = "budget"."budget_id" INNER JOIN "event" ON "budget"."link_to_event" = "event"."event_id" WHERE "event"."type" = 'Meeting';

/*
Prediction Result:
(None,)
*/