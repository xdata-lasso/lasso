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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (1, '2020', 'default1', '%Y', 'default2', 'default1'), (5, 'Meeting', 'Meeting', '2020', NULL, 'default2'), (4, '2020', '%Y', 'default1', 'default1', 'Meeting'), (0, 'default1', '%Y', '%Y', '2020', NULL), (2, 'default2', 'default2', 'Meeting', 'Meeting', 'default1'), (3, '%Y', 'default1', 'default2', 'Meeting', '2020'), (6, 'Meeting', 'default1', '2020', '%Y', 'default1'), (7, '%Y', '2020', '2020', 'Meeting', NULL), (8, 'default1', '2020', 'default2', 'Meeting', 'default2'), (9, '2020', '2020', 'default1', 'default2', '2020'), (10, '%Y', NULL, '2020', 'Meeting', NULL), (11, 'default1', 'Meeting', 'default1', '2020', 'default2'), (12, '2020', 'default2', 'default2', NULL, 'Meeting'), (13, 'Meeting', 'default2', '%Y', 'default1', '2020'), (14, 'Meeting', 'Meeting', '2020', '%Y', 'default2'), (15, '2020', '2020', '%Y', 'default1', '%Y'), (16, '2020', '2020', 'default2', '2020', NULL), (17, 'default2', 'default2', 'default2', 'default1', '2020'), (18, 'default1', 'Meeting', 'default1', '2020', NULL), (19, 'default1', 'Meeting', NULL, '2020', '2020'), (20, 'default2', 'default1', 'Meeting', 'default2', '2020'), (21, NULL, '2020', NULL, '%Y', '2020'), (22, 'default1', '2020', '%Y', '%Y', '%Y'), (23, NULL, 'default2', 'default2', '2020', 'default1'), (24, 'default2', NULL, 'default1', '2020', 'default1');
INSERT INTO major (major_id, major_name, department, college) VALUES ('%Y', 'Meeting', NULL, 'default1'), ('Meeting', '2020', '%Y', 'Meeting'), ('2020', '2020', 'default1', 'default2'), ('default2', NULL, 'Meeting', 'default2'), ('default1', 'Meeting', 'default1', 'Meeting'), ('unique_5', 'Meeting', NULL, '2020'), ('unique_6', 'default2', NULL, 'default2'), ('unique_7', 'default2', 'default1', NULL), ('unique_8', 'default1', NULL, '2020'), ('unique_9', 'default1', '2020', NULL), ('unique_10', 'default2', 'default1', 'default1'), ('unique_11', 'default1', '2020', 'Meeting'), ('unique_12', 'default1', '%Y', '2020'), ('unique_13', 'default2', 'Meeting', '2020'), ('unique_14', '%Y', '%Y', '%Y'), ('unique_15', 'default1', '2020', 'default1'), ('unique_16', 'default1', NULL, 'default1'), ('unique_17', 'default2', 'default1', '2020'), ('unique_18', 'Meeting', 'default2', 'default2'), ('unique_19', NULL, '2020', '2020'), ('unique_20', 'default1', 'default2', 'default2'), ('unique_21', 'Meeting', 'Meeting', '%Y'), ('unique_22', '2020', 'default2', '2020'), ('unique_23', '%Y', NULL, 'default2');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('%Y', 'unique_16', 4, 'default1', 'Meeting', 'default1', 'default1', 'default2', 'default2'), ('default2', 'unique_7', 9, 'default2', 'default1', '2020', '2020', NULL, 'Meeting'), ('2020', 'unique_13', 12, 'default2', 'default1', '2020', '%Y', 'Meeting', 'Meeting'), ('default1', 'unique_21', 20, NULL, '%Y', 'default2', NULL, '%Y', '2020'), ('Meeting', 'unique_17', 4, 'Meeting', 'default1', 'default2', NULL, 'default1', '%Y'), ('unique_5', '2020', 1, 'default2', NULL, 'Meeting', NULL, 'default1', 'Meeting'), ('unique_6', 'default2', 22, 'Meeting', 'default2', 'default2', '%Y', '2020', 'Meeting'), ('unique_7', NULL, 23, NULL, '2020', NULL, NULL, '2020', NULL), ('unique_8', 'unique_23', 13, 'default1', NULL, 'default2', 'Meeting', 'default2', 'default1'), ('unique_9', 'unique_8', 8, 'default2', '2020', '%Y', 'Meeting', '2020', '%Y'), ('unique_10', NULL, 16, 'default1', NULL, 'default2', '2020', NULL, 'default2'), ('unique_11', 'unique_11', 5, NULL, 'Meeting', '2020', NULL, 'Meeting', 'default2'), ('unique_12', NULL, 10, '%Y', 'Meeting', 'Meeting', '%Y', 'Meeting', 'default1'), ('unique_13', 'unique_15', 10, '2020', 'default1', 'default1', 'default1', 'Meeting', 'Meeting'), ('unique_14', 'unique_14', 19, '%Y', 'default1', 'default2', '2020', '%Y', '%Y'), ('unique_15', 'unique_18', 22, '2020', '%Y', NULL, NULL, '2020', 'default2'), ('unique_16', 'unique_5', 2, '2020', '%Y', 'Meeting', '2020', 'default2', 'Meeting'), ('unique_17', 'unique_21', 20, NULL, 'default2', 'Meeting', '%Y', '2020', '%Y'), ('unique_18', 'unique_8', 5, 'Meeting', NULL, '2020', 'default1', 'default2', 'Meeting'), ('unique_19', 'unique_9', 19, 'default1', 'Meeting', NULL, NULL, 'Meeting', '%Y'), ('unique_20', 'unique_22', 17, NULL, 'default1', 'default1', '2020', 'default1', NULL), ('unique_21', '2020', 0, '%Y', '2020', NULL, NULL, '%Y', '2020'), ('unique_22', 'unique_13', 6, 'default1', 'default1', 'default2', NULL, '2020', NULL), ('unique_23', 'unique_8', 17, 'Meeting', '2020', NULL, 'Meeting', NULL, 'default2'), ('unique_24', 'default1', 4, 'Meeting', 'Meeting', 'default2', '%Y', 'Meeting', '%Y'), ('unique_25', 'unique_6', 0, 'default1', 'default2', 'Meeting', NULL, '2020', 'default2');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('%Y', 'Meeting', '2020', 'Meeting', '2020', NULL, 'Meeting'), ('default1', 'default2', NULL, '2020', 'Meeting', 'default1', 'default2'), ('default2', '%Y', NULL, NULL, '%Y', '2020', '2020'), ('2020', 'default2', 'default2', 'Meeting', 'default2', 'Meeting', 'default1'), ('Meeting', 'Meeting', NULL, '2020', 'Meeting', '2020', 'default1'), ('unique_5', 'default2', 'Meeting', '2020', '2020', 'Meeting', 'default1'), ('unique_6', 'default2', '%Y', 'default2', '2020', NULL, '2020'), ('unique_7', 'default2', NULL, 'default2', 'default2', 'default1', 'default2');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('Meeting', 'default1'), ('2020', 'unique_11'), ('Meeting', 'unique_8'), ('2020', 'unique_24'), ('%Y', 'unique_17'), ('unique_6', 'unique_13'), ('Meeting', 'unique_19'), ('default1', 'unique_19');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(T2.link_to_event) AS REAL) / COUNT(DISTINCT T2.link_to_event) FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event WHERE SUBSTRING(T1.event_date, 1, 4) = '2020' AND T1.type = 'Meeting';

/*
Gold Result:
(1.0,)
*/

-- Prediction Query
SELECT AVG(CAST(attendance_count AS REAL)) FROM (SELECT COUNT(a.link_to_member) AS attendance_count FROM event AS e JOIN attendance AS a ON e.event_id = a.link_to_event WHERE e.type = 'Meeting' AND STRFTIME('%Y', e.event_date) = '2020' GROUP BY e.event_name);

/*
Prediction Result:
(None,)
*/