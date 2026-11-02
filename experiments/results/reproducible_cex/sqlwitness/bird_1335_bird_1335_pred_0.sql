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
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('09', '09', 'Advertisement', 'default2', 'default2', NULL, NULL), ('default1', 'September Meeting', 'September Meeting', 'default1', NULL, 'default1', 'September Meeting'), ('September Meeting', NULL, 'Advertisement', 'September Meeting', 'Advertisement', NULL, '09'), ('Advertisement', 'September Meeting', 'September Meeting', 'September Meeting', NULL, 'default1', NULL), ('default2', 'default1', NULL, 'September Meeting', 'default2', 'Advertisement', '09');
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('09', '09', '09', 0.0, 6.0, NULL, 'September Meeting'), ('default2', 'Advertisement', 'default1', 3.0, 7.0, 2, 'September Meeting'), ('default1', 'September Meeting', 'default1', NULL, 0.0, 3, 'Advertisement'), ('September Meeting', 'September Meeting', 'September Meeting', 0.0, 5.0, 1, 'default1'), ('Advertisement', 'default2', NULL, NULL, 2.0, 1, NULL), ('unique_5', 'default1', 'default2', NULL, 5.0, 0, 'Advertisement'), ('unique_6', 'default2', 'default2', 1.0, 1.0, 0, 'Advertisement'), ('unique_7', 'default1', 'Advertisement', 6.0, 1.0, 7, 'Advertisement'), ('unique_8', 'default2', 'September Meeting', 1.0, 0.0, 6, 'September Meeting'), ('unique_9', NULL, 'Advertisement', 5.0, 7.0, 7, 'default1'), ('unique_10', NULL, 'default1', NULL, 0.0, 0, NULL), ('unique_11', '09', 'Advertisement', 1.0, 7.0, 0, 'Advertisement'), ('unique_12', 'default1', NULL, 2.0, 3.0, 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.spent FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event WHERE T1.event_name = 'September Meeting' AND T2.category = 'Advertisement' AND SUBSTRING(T1.event_date, 6, 2) = '09';

/*
Gold Result:
*/

-- Prediction Query
SELECT T2.spent FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event WHERE T1.event_name = 'September Meeting' AND T2.category = 'Advertisement';

/*
Prediction Result:
(6.0,)
*/