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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (1, 'default1', '%Y', 'Meeting', NULL, 'Meeting'), (5, '2020', '2020', 'Meeting', 'default2', '2020'), (0, 'default1', 'Meeting', 'Meeting', 'default1', 'default2'), (2, '%Y', 'Meeting', '2020', 'Meeting', '2020'), (4, 'default2', '%Y', 'default1', NULL, 'default1'), (3, '2020', '%Y', NULL, NULL, 'default1'), (6, '%Y', '%Y', '%Y', 'Meeting', 'default1'), (7, NULL, '2020', 'default2', '2020', 'Meeting'), (8, '2020', '2020', 'default2', NULL, 'default1'), (9, 'default1', 'default2', '%Y', NULL, '%Y'), (10, 'Meeting', NULL, '2020', '2020', 'Meeting'), (11, '2020', '2020', 'Meeting', '2020', 'default1'), (12, 'Meeting', '2020', 'default1', '2020', NULL), (13, '%Y', NULL, '2020', 'default1', 'default2'), (14, NULL, 'default2', 'Meeting', NULL, NULL), (15, 'default1', '2020', '%Y', '%Y', 'Meeting'), (16, '2020', 'Meeting', 'default1', NULL, 'default1'), (17, 'default1', '%Y', 'default2', '2020', 'default1'), (18, 'default2', 'default1', 'default1', NULL, '%Y'), (19, 'default2', '2020', 'default1', '2020', 'default1'), (20, '2020', NULL, '%Y', NULL, 'default2'), (21, NULL, '%Y', 'default2', '%Y', NULL), (22, '2020', 'default2', '2020', 'default1', NULL);
INSERT INTO major (major_id, major_name, department, college) VALUES ('default1', 'default1', NULL, '%Y'), ('2020', 'default2', 'default1', 'default1'), ('Meeting', 'default2', 'default1', '%Y'), ('%Y', NULL, NULL, 'default2');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('%Y', '%Y', 7, 'Meeting', '%Y', '2020', 'Meeting', NULL, NULL), ('default1', '2020', 14, '%Y', '2020', NULL, '%Y', '2020', '2020'), ('Meeting', 'default1', NULL, '2020', 'Meeting', 'Meeting', '%Y', 'default1', '%Y'), ('2020', '2020', 4, '%Y', '2020', 'default1', '2020', '2020', 'default2'), ('default2', 'default1', 9, '2020', 'default2', '%Y', '2020', '%Y', '2020'), ('unique_5', '%Y', 15, NULL, '2020', '2020', 'default1', 'default1', 'default1'), ('unique_6', '2020', 4, 'default2', 'default2', 'default2', 'default2', '%Y', '2020'), ('unique_7', 'Meeting', 0, '%Y', 'default1', 'default2', 'Meeting', 'default2', 'Meeting'), ('unique_8', 'default1', 15, '%Y', '2020', '2020', '2020', NULL, 'Meeting'), ('unique_9', '2020', 9, '2020', '2020', '%Y', '%Y', 'default1', '%Y'), ('unique_10', NULL, 21, NULL, '%Y', 'default2', NULL, 'Meeting', 'default1'), ('unique_11', 'default1', 20, NULL, '2020', 'Meeting', 'Meeting', 'default2', 'default2'), ('unique_12', 'Meeting', 22, '%Y', '%Y', 'default1', '%Y', 'default1', 'default2'), ('unique_13', 'Meeting', 4, 'Meeting', NULL, 'default2', '2020', 'Meeting', 'default2'), ('unique_14', 'default1', NULL, NULL, '%Y', NULL, '2020', 'default1', '2020'), ('unique_15', 'default1', 11, '%Y', '2020', 'Meeting', '%Y', '%Y', NULL), ('unique_16', 'Meeting', 18, 'Meeting', 'Meeting', NULL, '%Y', '2020', NULL), ('unique_17', NULL, 15, 'Meeting', NULL, '2020', '%Y', NULL, 'Meeting'), ('unique_18', NULL, 9, 'Meeting', '%Y', 'default2', '2020', 'Meeting', '%Y'), ('unique_19', NULL, 11, NULL, '2020', 'default1', 'Meeting', '%Y', NULL), ('unique_20', 'default1', 20, NULL, 'default2', '%Y', '2020', '%Y', '2020');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('%Y', NULL, '%Y', 'default2', 'Meeting', 'default1', 'default1'), ('Meeting', 'default2', '2020', 'Meeting', '2020', NULL, 'default2');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('Meeting', '2020'), ('Meeting', 'unique_13');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(T2.link_to_event) AS REAL) / COUNT(DISTINCT T2.link_to_event) FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event WHERE SUBSTRING(T1.event_date, 1, 4) = '2020' AND T1.type = 'Meeting';

/*
Gold Result:
(2.0,)
*/

-- Prediction Query
SELECT CAST(COUNT(a.link_to_member) AS REAL) / COUNT(DISTINCT e.event_name) AS average_attendance FROM event AS e INNER JOIN attendance AS a ON e.event_id = a.link_to_event WHERE e.type = 'Meeting' AND STRFTIME('%Y', e.event_date) = '2020';

/*
Prediction Result:
(None,)
*/