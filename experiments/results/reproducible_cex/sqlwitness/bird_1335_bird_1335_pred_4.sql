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
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('default1', 'September Meeting', '09', 'Advertisement', 'default2', 'default1', 'September Meeting'), ('default2', 'default2', NULL, 'default1', '09', 'Advertisement', NULL), ('09', 'Advertisement', 'September Meeting', 'default1', 'default2', 'default1', 'Advertisement'), ('Advertisement', '09', 'default1', 'September Meeting', 'default2', 'default2', 'default1'), ('September Meeting', 'September Meeting', NULL, 'default2', 'Advertisement', 'default2', 'September Meeting'), ('unique_5', 'Advertisement', '09', 'default2', 'default2', 'September Meeting', 'September Meeting'), ('unique_6', 'default1', NULL, NULL, '09', 'Advertisement', 'Advertisement'), ('unique_7', 'September Meeting', NULL, NULL, 'Advertisement', '09', '09'), ('unique_8', NULL, 'Advertisement', 'September Meeting', NULL, 'Advertisement', NULL), ('unique_9', 'Advertisement', 'September Meeting', 'Advertisement', 'default1', NULL, 'Advertisement'), ('unique_10', '09', NULL, 'Advertisement', 'default2', 'September Meeting', 'Advertisement'), ('unique_11', 'default2', NULL, 'default2', 'default2', 'Advertisement', '09'), ('unique_12', 'September Meeting', 'Advertisement', NULL, 'default1', 'default1', '09'), ('unique_13', 'Advertisement', '09', 'Advertisement', 'Advertisement', 'default1', 'default2'), ('unique_14', NULL, 'default1', '09', 'default1', 'default2', 'September Meeting'), ('unique_15', 'September Meeting', 'default2', '09', 'default2', '09', 'default2');
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('09', 'default2', 'default2', 7.0, 2.0, 0, 'default2'), ('Advertisement', 'unique_8', 'September Meeting', 7.0, 7.0, 1, 'default1'), ('default1', 'September Meeting', 'default1', 7.0, NULL, 6, '09'), ('September Meeting', 'unique_12', '09', NULL, 1.0, NULL, '09'), ('default2', 'Advertisement', 'Advertisement', 0.0, 0.0, 7, NULL), ('unique_5', 'unique_11', NULL, 7.0, 6.0, 6, '09'), ('unique_6', 'default1', NULL, 7.0, 6.0, 6, 'September Meeting'), ('unique_7', 'unique_10', NULL, NULL, 1.0, 1, '09'), ('unique_8', 'unique_14', 'default1', 6.0, 2.0, 5, 'Advertisement'), ('unique_9', 'unique_9', 'Advertisement', 1.0, 6.0, 1, 'Advertisement'), ('unique_10', 'September Meeting', 'Advertisement', NULL, 6.0, 0, '09'), ('unique_11', 'unique_12', NULL, 2.0, 2.0, NULL, 'default1'), ('unique_12', 'unique_5', 'default1', 3.0, 6.0, NULL, '09'), ('unique_13', 'unique_11', 'default1', 6.0, 2.0, 5, 'default1'), ('unique_14', 'unique_10', 'default2', 1.0, 7.0, 5, 'default2'), ('unique_15', 'unique_13', NULL, 1.0, NULL, NULL, 'Advertisement');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.spent FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event WHERE T1.event_name = 'September Meeting' AND T2.category = 'Advertisement' AND SUBSTRING(T1.event_date, 6, 2) = '09';

/*
Gold Result:
*/

-- Prediction Query
SELECT spent FROM budget JOIN event ON budget.link_to_event = event.event_id WHERE category = 'Advertisement' AND event_name = 'September Meeting';

/*
Prediction Result:
(None,)
*/