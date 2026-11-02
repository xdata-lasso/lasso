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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (5, '2020', '2020', 'default1', '2020', NULL), (0, 'Meeting', 'Meeting', 'default1', 'default2', NULL), (2, 'default2', 'default1', NULL, '2020', NULL), (1, 'default1', 'default1', NULL, '2020', '%Y'), (3, '2020', '2020', '%Y', 'default2', 'default2'), (4, '%Y', '2020', '%Y', 'Meeting', '2020'), (6, '2020', 'default2', '2020', '%Y', '2020'), (7, 'default1', 'default2', 'default1', '%Y', 'default2'), (8, NULL, NULL, 'Meeting', NULL, 'Meeting'), (9, NULL, 'default1', NULL, 'default2', 'Meeting'), (10, 'default1', '2020', NULL, NULL, 'default1'), (11, 'default1', NULL, 'default1', 'default1', NULL), (12, 'default2', 'default2', '%Y', '2020', '%Y'), (13, 'default2', 'Meeting', NULL, '%Y', 'default1'), (14, 'default2', NULL, 'default1', 'default2', 'default1');
INSERT INTO major (major_id, major_name, department, college) VALUES ('Meeting', 'default1', 'Meeting', '2020'), ('%Y', 'Meeting', '%Y', NULL);
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('%Y', '%Y', 8, 'default1', 'default2', 'Meeting', '2020', 'Meeting', '2020'), ('Meeting', 'Meeting', 1, NULL, 'Meeting', 'default2', NULL, '2020', '2020'), ('default1', '%Y', 14, 'default1', NULL, 'default2', 'default1', '%Y', 'Meeting'), ('2020', 'Meeting', 6, 'default2', 'default2', 'default1', '2020', 'default2', 'default1'), ('default2', '%Y', 5, NULL, 'default2', 'Meeting', NULL, '2020', 'Meeting'), ('unique_5', '%Y', 12, '2020', '%Y', '%Y', 'Meeting', 'default1', 'Meeting'), ('unique_6', 'Meeting', 10, NULL, '%Y', '2020', '%Y', 'default1', NULL), ('unique_7', '%Y', 11, '2020', 'Meeting', 'Meeting', 'default2', 'default1', 'default2'), ('unique_8', NULL, 14, '%Y', 'default2', 'default2', '2020', 'default1', '%Y'), ('unique_9', NULL, 1, 'default1', 'default2', 'default1', 'Meeting', 'default2', 'default1'), ('unique_10', NULL, 0, '%Y', NULL, '%Y', '%Y', '2020', 'default2');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('Meeting', 'default2', '2020', 'default1', 'default2', 'default2', NULL), ('2020', 'Meeting', 'Meeting', '2020', 'default2', 'default2', '2020'), ('default2', '%Y', NULL, 'default2', 'default1', '%Y', '%Y'), ('default1', 'Meeting', NULL, '2020', '2020', 'default2', 'default1'), ('%Y', '2020', '2020', 'Meeting', 'Meeting', '2020', 'Meeting'), ('unique_5', NULL, 'default1', '%Y', 'default2', 'default2', NULL), ('unique_6', '2020', 'default2', 'Meeting', 'Meeting', '2020', 'default2');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('default2', '2020'), ('unique_6', 'unique_10'), ('default2', 'unique_8'), ('%Y', 'unique_6'), ('Meeting', 'unique_7'), ('%Y', 'unique_8'), ('unique_6', 'unique_5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(T2.link_to_event) AS REAL) / COUNT(DISTINCT T2.link_to_event) FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event WHERE SUBSTRING(T1.event_date, 1, 4) = '2020' AND T1.type = 'Meeting';

/*
Gold Result:
(2.0,)
*/

-- Prediction Query
SELECT CAST(COUNT(event_id) AS REAL) / COUNT(DISTINCT event_name) AS average_attendance FROM event INNER JOIN attendance ON event.event_id = attendance.link_to_event WHERE event.type = 'Meeting' AND STRFTIME('%Y', event.event_date) = '2020';

/*
Prediction Result:
(None,)
*/