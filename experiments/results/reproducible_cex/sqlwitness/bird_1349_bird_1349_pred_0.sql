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
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('September Speaker', 'default2', 'default2', 'default2', 'default1', 'default1', 'September Speaker'), ('default1', NULL, 'default2', 'default1', 'default1', NULL, 'September Speaker'), ('default2', 'default1', 'default1', NULL, 'default1', 'default1', 'September Speaker'), ('unique_3', NULL, 'September Speaker', NULL, 'default2', NULL, NULL), ('unique_4', 'September Speaker', 'September Speaker', NULL, 'default1', 'default2', 'September Speaker'), ('unique_5', 'default1', NULL, NULL, 'default1', 'default1', NULL), ('unique_6', 'September Speaker', 'September Speaker', 'default1', 'default2', 'default2', 'default1'), ('unique_7', 'default2', NULL, 'September Speaker', 'September Speaker', 'default2', NULL), ('unique_8', NULL, 'September Speaker', 'default1', NULL, NULL, NULL), ('unique_9', 'September Speaker', 'default1', 'default1', 'default2', 'default1', 'September Speaker'), ('unique_10', 'September Speaker', 'default1', 'default2', 'default2', NULL, NULL), ('unique_11', 'September Speaker', 'default2', 'September Speaker', 'default2', 'default2', 'September Speaker');
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('default1', 'default2', NULL, 0.0, 1.0, 1, 'September Speaker'), ('default2', 'unique_4', NULL, NULL, 0.0, 0, NULL), ('September Speaker', 'default1', 'default2', 0.0, 1.0, 0, 'default2'), ('unique_3', 'unique_3', NULL, 1.0, NULL, 0, 'default2'), ('unique_4', 'unique_10', 'September Speaker', NULL, 1.0, 1, 'September Speaker'), ('unique_5', 'unique_3', 'default2', 0.0, 0.0, 0, 'default1'), ('unique_6', 'unique_8', 'default2', 0.0, 1.0, 1, 'September Speaker'), ('unique_7', 'unique_8', 'default2', 1.0, 0.0, NULL, 'September Speaker'), ('unique_8', 'default1', 'default2', 0.0, 0.0, NULL, 'default2'), ('unique_9', 'unique_6', 'default2', NULL, 1.0, NULL, 'September Speaker'), ('unique_10', 'default2', 'default1', 1.0, 0.0, NULL, 'September Speaker'), ('unique_11', NULL, 'September Speaker', NULL, 0.0, NULL, 'default1'), ('unique_12', 'unique_6', 'default2', 1.0, 0.0, NULL, 'default1'), ('unique_13', 'September Speaker', 'default2', 0.0, 1.0, 1, 'September Speaker'), ('unique_14', 'unique_9', NULL, NULL, NULL, NULL, NULL), ('unique_15', NULL, 'default2', 0.0, 0.0, 0, NULL), ('unique_16', 'unique_10', NULL, NULL, 1.0, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(T1.amount) FROM budget AS T1 INNER JOIN event AS T2 ON T1.link_to_event = T2.event_id WHERE T2.event_name = 'September Speaker';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT SUM(amount) FROM budget WHERE link_to_event = (SELECT event_id FROM event WHERE event_name = 'September Speaker');

/*
Prediction Result:
(0,)
*/