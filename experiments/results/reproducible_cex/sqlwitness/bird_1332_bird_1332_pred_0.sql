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
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('09', 'September Meeting', 'default2', 'Food', '09', 'Food', 'September Meeting'), ('default2', 'default1', NULL, '09', 'Food', '09', 'September Meeting'), ('Food', 'default1', '09', 'default2', 'September Meeting', NULL, '09'), ('September Meeting', NULL, '09', '09', 'default1', 'September Meeting', 'default2'), ('default1', '09', NULL, 'default2', 'September Meeting', 'default2', 'September Meeting');
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('09', 'September Meeting', '09', 7.0, 7.0, NULL, 'default2'), ('default2', 'default2', 'default1', 6.0, 3.0, 7, '09'), ('default1', '09', NULL, 3.0, 6.0, 1, 'default1'), ('Food', NULL, 'Food', NULL, NULL, NULL, 'default1'), ('September Meeting', 'September Meeting', '09', 3.0, 3.0, 6, 'September Meeting'), ('unique_5', 'default2', 'Food', 1.0, 6.0, 0, 'Food'), ('unique_6', 'September Meeting', 'Food', NULL, 3.0, 7, '09'), ('unique_7', '09', 'Food', 5.0, 0.0, 7, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.spent FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event WHERE T1.event_name = 'September Meeting' AND T2.category = 'Food' AND SUBSTRING(T1.event_date, 6, 2) = '09';

/*
Gold Result:
*/

-- Prediction Query
SELECT T2.spent FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event WHERE T1.event_name = 'September Meeting' AND T2.category = 'Food';

/*
Prediction Result:
(5.0,)
*/