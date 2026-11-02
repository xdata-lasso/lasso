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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (2, '2020', NULL, 'Meeting', 'default2', NULL), (4, 'Meeting', 'default1', 'default1', NULL, 'default2'), (5, 'default1', '2020', 'default2', 'Meeting', NULL), (1, NULL, 'default1', '2020', 'Meeting', NULL), (3, '2020', NULL, '%Y', '2020', 'Meeting'), (0, 'default1', NULL, NULL, NULL, 'default1'), (6, 'Meeting', '2020', 'default2', '2020', 'Meeting'), (7, 'Meeting', 'default1', 'Meeting', 'default1', 'default2'), (8, 'default2', NULL, 'Meeting', '%Y', 'Meeting'), (9, 'default1', NULL, '2020', 'Meeting', 'Meeting'), (10, 'default2', 'Meeting', 'Meeting', '%Y', 'Meeting');
INSERT INTO major (major_id, major_name, department, college) VALUES ('2020', 'default1', 'Meeting', '%Y'), ('%Y', NULL, '%Y', NULL), ('default2', NULL, 'Meeting', 'Meeting'), ('Meeting', '2020', 'default2', 'default1'), ('default1', '2020', 'default1', '%Y'), ('unique_5', '2020', '2020', 'default1'), ('unique_6', '%Y', 'default1', '2020'), ('unique_7', '%Y', '2020', '2020'), ('unique_8', NULL, '2020', 'default2'), ('unique_9', '2020', NULL, '%Y'), ('unique_10', 'Meeting', 'default1', 'default2'), ('unique_11', 'default1', '%Y', '%Y'), ('unique_12', 'default1', 'Meeting', '%Y'), ('unique_13', 'default2', 'Meeting', '2020'), ('unique_14', '%Y', 'Meeting', 'default2'), ('unique_15', 'Meeting', 'default2', 'default1');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('default2', NULL, NULL, NULL, NULL, '%Y', NULL, 'default1', '%Y'), ('default1', 'unique_11', 1, 'default2', 'default1', '%Y', 'Meeting', 'default1', '%Y');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('default2', NULL, NULL, 'default2', '2020', 'default2', '2020'), ('default1', 'default2', NULL, '%Y', 'default2', 'default1', 'default2'), ('%Y', NULL, NULL, '2020', 'default1', 'default1', 'default2'), ('Meeting', 'default1', NULL, '%Y', 'Meeting', NULL, 'Meeting'), ('2020', 'default1', 'default1', 'default1', NULL, 'default1', 'default1'), ('unique_5', 'default1', NULL, '%Y', 'Meeting', '2020', '2020'), ('unique_6', 'default1', 'default1', NULL, 'Meeting', 'Meeting', '2020'), ('unique_7', 'Meeting', '2020', 'Meeting', 'default2', '2020', 'Meeting'), ('unique_8', 'Meeting', '2020', 'default1', '%Y', NULL, NULL), ('unique_9', 'default1', 'Meeting', NULL, 'default1', '%Y', NULL), ('unique_10', 'default2', 'default2', 'default2', NULL, 'Meeting', 'Meeting'), ('unique_11', '2020', '2020', NULL, 'Meeting', NULL, 'default1'), ('unique_12', 'Meeting', '2020', 'default1', 'Meeting', 'Meeting', 'default1'), ('unique_13', 'default2', 'Meeting', 'default1', 'Meeting', '%Y', 'Meeting'), ('unique_14', 'Meeting', 'Meeting', 'default2', NULL, '%Y', 'Meeting'), ('unique_15', 'default1', 'Meeting', '2020', 'default2', 'Meeting', 'default1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('unique_8', 'default2'), ('unique_7', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(T2.link_to_event) AS REAL) / COUNT(DISTINCT T2.link_to_event) FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event WHERE SUBSTRING(T1.event_date, 1, 4) = '2020' AND T1.type = 'Meeting';

/*
Gold Result:
(1.0,)
*/

-- Prediction Query
SELECT CAST(COUNT(T1.link_to_event) AS REAL) / COUNT(DISTINCT T2.event_name) FROM attendance AS T1 INNER JOIN event AS T2 ON T1.link_to_event = T2.event_id WHERE T2.type = 'Meeting' AND STRFTIME('%Y', T2.event_date) = '2020';

/*
Prediction Result:
(None,)
*/