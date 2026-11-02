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
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('default1', '09', 'Advertisement', 'default2', 'default2', NULL, 'Advertisement'), ('September Meeting', NULL, 'default2', 'default2', '09', 'Advertisement', 'Advertisement'), ('Advertisement', '09', 'default2', '09', NULL, 'Advertisement', '09'), ('09', '09', '09', 'default1', 'September Meeting', 'default2', 'September Meeting'), ('default2', NULL, 'default1', '09', 'default1', 'default2', 'default1'), ('unique_5', NULL, 'Advertisement', '09', '09', 'default1', 'default2'), ('unique_6', '09', NULL, 'default2', NULL, '09', NULL), ('unique_7', 'September Meeting', '09', NULL, NULL, NULL, 'default1'), ('unique_8', 'September Meeting', 'September Meeting', 'September Meeting', 'September Meeting', 'default1', '09'), ('unique_9', 'default1', 'September Meeting', 'default1', 'Advertisement', NULL, '09'), ('unique_10', 'Advertisement', 'default1', 'default2', 'September Meeting', 'September Meeting', 'default2'), ('unique_11', NULL, 'default2', '09', 'Advertisement', '09', 'September Meeting');
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('09', 'unique_9', 'Advertisement', 0.0, 3.0, 6, NULL), ('default1', 'unique_7', NULL, 2.0, 6.0, 7, '09'), ('Advertisement', NULL, '09', 5.0, 5.0, 0, '09'), ('September Meeting', NULL, 'Advertisement', 5.0, NULL, 2, 'default2'), ('default2', 'unique_8', 'default1', 1.0, 6.0, NULL, 'Advertisement'), ('unique_5', 'unique_6', 'default1', 0.0, 2.0, 5, NULL), ('unique_6', '09', '09', 1.0, 7.0, NULL, 'default1'), ('unique_7', 'unique_7', 'Advertisement', 6.0, 7.0, 0, '09'), ('unique_8', 'unique_5', 'default2', 2.0, 3.0, NULL, 'default2'), ('unique_9', 'unique_10', 'default2', 0.0, 5.0, 3, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.spent FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event WHERE T1.event_name = 'September Meeting' AND T2.category = 'Advertisement' AND SUBSTRING(T1.event_date, 6, 2) = '09';

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.spent FROM budget AS T1 INNER JOIN event AS T2 ON T1.link_to_event = T2.event_id WHERE T1.category = 'Advertisement' AND T2.event_name = 'September Meeting';

/*
Prediction Result:
(6.0,)
*/