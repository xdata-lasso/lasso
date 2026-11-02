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
-- DATASET 1
-- Core predicate falsification, column confusion, and substring boundary tests
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('e1', 'September Meeting', '2020-09-15', 'Meeting', 'Regular', 'Room 101', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('e2', 'October Meeting', '2020-09-15', 'September Meeting', 'September Meeting', 'September Meeting', 'September Meeting');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('e3', 'September Meeting', '2020-08-09', 'Meeting', 'Day is 09, not month', 'Room 101', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('e4', 'September Meeting', '2009-10-15', 'Meeting', 'Year ends in 09', 'Room 101', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('e5', 'September Meeting', '2020-90-90', 'Meeting', 'Off-by-one substring', 'Room 101', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('e6', 'September Meeting', '2020-09-20', 'Meeting', 'For wrong category test', 'Room 102', 'Open');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('b1', 'Advertisement', 123.45, 76.55, 200, 'Closed', 'e1');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('b2', 'Advertisement', 200.00, 50.00, 250, 'Closed', 'e2');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('b3', 'Advertisement', 300.00, 50.00, 350, 'Closed', 'e3');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('b4', 'Advertisement', 400.00, 50.00, 450, 'Closed', 'e4');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('b5', 'Advertisement', 500.00, 50.00, 550, 'Closed', 'e5');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('b6', 'Food', 600.00, 50.00, 650, 'Advertisement', 'e6');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.spent FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event WHERE T1.event_name = 'September Meeting' AND T2.category = 'Advertisement' AND SUBSTRING(T1.event_date, 6, 2) = '09';

/*
Gold Result:
(123.45,)
*/

-- Prediction Query
SELECT SUM("budget"."spent") FROM "budget" INNER JOIN "event" ON "budget"."link_to_event" = "event"."event_id" WHERE "budget"."category" = 'Advertisement' AND "event"."event_name" = 'September Meeting';

/*
Prediction Result:
(1323.45,)
*/