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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (1, 'default1', 'default2', 'default1', 'default1', NULL), (0, 'default1', NULL, 'default2', 'default1', 'default2'), (2, '954-555-6240', 'default2', NULL, '954-555-6240', 'default2'), (3, '954-555-6240', 'default1', 'default2', NULL, NULL), (4, 'default1', NULL, '954-555-6240', 'default1', NULL), (5, 'default1', 'default2', 'default1', 'default2', NULL), (6, '954-555-6240', NULL, 'default2', NULL, '954-555-6240'), (7, 'default1', 'default1', '954-555-6240', '954-555-6240', 'default2'), (8, 'default2', NULL, 'default2', 'default2', NULL), (9, 'default1', 'default1', 'default2', '954-555-6240', '954-555-6240'), (10, 'default2', 'default1', 'default2', 'default2', 'default2'), (11, 'default1', NULL, 'default1', 'default2', NULL), (12, '954-555-6240', '954-555-6240', '954-555-6240', 'default2', 'default1'), (13, 'default1', 'default2', '954-555-6240', '954-555-6240', 'default1'), (14, 'default2', NULL, '954-555-6240', 'default2', 'default2'), (15, '954-555-6240', 'default1', '954-555-6240', '954-555-6240', 'default2'), (16, 'default1', 'default2', NULL, NULL, '954-555-6240'), (17, 'default2', NULL, NULL, 'default2', '954-555-6240'), (18, '954-555-6240', NULL, NULL, '954-555-6240', 'default1');
INSERT INTO major (major_id, major_name, department, college) VALUES ('default2', NULL, NULL, 'default2'), ('954-555-6240', 'default1', NULL, NULL), ('default1', 'default2', 'default2', '954-555-6240'), ('unique_3', 'default1', 'default2', 'default1'), ('unique_4', '954-555-6240', '954-555-6240', '954-555-6240'), ('unique_5', '954-555-6240', NULL, 'default2'), ('unique_6', NULL, 'default2', NULL), ('unique_7', 'default1', '954-555-6240', '954-555-6240'), ('unique_8', NULL, 'default1', 'default1'), ('unique_9', 'default2', 'default2', NULL), ('unique_10', '954-555-6240', 'default1', NULL), ('unique_11', 'default2', 'default1', 'default1'), ('unique_12', 'default2', 'default1', NULL), ('unique_13', 'default2', '954-555-6240', 'default1'), ('unique_14', 'default1', NULL, 'default2'), ('unique_15', 'default1', '954-555-6240', 'default2');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('default2', 'unique_3', 2, 'default1', 'default1', NULL, NULL, 'default2', '954-555-6240'), ('954-555-6240', 'unique_14', 2, NULL, NULL, 'default1', 'default2', 'default1', '954-555-6240'), ('default1', 'unique_11', 3, 'default2', NULL, 'default1', 'default1', 'default2', NULL), ('unique_3', 'unique_5', 1, 'default2', '954-555-6240', 'default2', 'default1', 'default1', '954-555-6240'), ('unique_4', 'unique_6', 7, '954-555-6240', 'default1', 'default2', NULL, NULL, 'default1'), ('unique_5', 'unique_15', 17, NULL, NULL, '954-555-6240', 'default1', '954-555-6240', NULL), ('unique_6', 'unique_4', 11, NULL, 'default2', NULL, '954-555-6240', 'default1', 'default1');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('default1', 'default1', '954-555-6240', 'default1', '954-555-6240', NULL, '954-555-6240'), ('954-555-6240', NULL, NULL, 'default1', 'default2', 'default1', '954-555-6240'), ('default2', '954-555-6240', 'default2', '954-555-6240', 'default1', NULL, 'default2'), ('unique_3', 'default1', 'default1', '954-555-6240', NULL, 'default1', 'default2');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('954-555-6240', '954-555-6240'), ('unique_3', 'unique_3'), ('unique_3', 'unique_4'), ('954-555-6240', 'unique_3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T2.link_to_event) FROM member AS T1 INNER JOIN attendance AS T2 ON T1.member_id = T2.link_to_member WHERE T1.phone = '954-555-6240';

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT e.event_id) AS number_of_events_attended FROM member AS m JOIN attendance AS a ON m.member_id = a.link_to_member JOIN event AS e ON a.link_to_event = e.event_id WHERE m.phone = '954-555-6240';

/*
Prediction Result:
(2,)
*/