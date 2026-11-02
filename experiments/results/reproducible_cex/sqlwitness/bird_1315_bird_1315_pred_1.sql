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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (0, 'Women''s Soccer', NULL, 'default2', NULL, NULL), (1, 'default1', 'default1', 'Women''s Soccer', 'Women''s Soccer', 'default2'), (2, 'Student Club', 'Student Club', 'Women''s Soccer', NULL, 'Student Club'), (3, 'Student Club', NULL, 'default2', 'Student Club', 'Women''s Soccer'), (4, 'Women''s Soccer', 'default1', 'Women''s Soccer', 'Student Club', 'default2'), (5, 'default2', 'default1', 'default1', 'Student Club', NULL), (6, NULL, 'default2', 'Women''s Soccer', 'Student Club', NULL), (7, 'Student Club', 'Student Club', NULL, 'Student Club', 'default2'), (8, 'default2', 'default1', 'Student Club', 'default1', 'default1'), (9, 'default1', 'Women''s Soccer', 'default2', NULL, NULL), (10, 'default2', 'Women''s Soccer', NULL, 'default1', NULL);
INSERT INTO major (major_id, major_name, department, college) VALUES ('Women''s Soccer', 'Student Club', NULL, 'default2'), ('default2', 'Student Club', NULL, NULL), ('default1', 'default1', NULL, NULL), ('Student Club', 'Student Club', NULL, 'default2'), ('unique_4', NULL, 'default2', 'default2'), ('unique_5', 'Student Club', 'Student Club', 'default1'), ('unique_6', 'Women''s Soccer', 'default1', NULL), ('unique_7', 'Women''s Soccer', NULL, 'Student Club'), ('unique_8', 'Student Club', 'default1', 'default1'), ('unique_9', NULL, 'default1', 'Women''s Soccer'), ('unique_10', 'default1', 'Student Club', NULL);
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('default2', 'default2', 1, 'Student Club', 'Women''s Soccer', NULL, 'Women''s Soccer', 'Student Club', NULL), ('Student Club', 'default2', 2, NULL, NULL, 'default1', 'default1', NULL, 'default2');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('Women''s Soccer', 'default1', 'default2', NULL, NULL, 'default2', 'Student Club'), ('Student Club', 'default1', 'Women''s Soccer', 'Women''s Soccer', 'default2', 'default1', NULL), ('default1', 'Women''s Soccer', 'Student Club', NULL, NULL, 'default2', 'default1'), ('default2', 'default1', NULL, 'default2', 'Student Club', 'default2', 'Student Club'), ('unique_4', 'default2', NULL, 'Women''s Soccer', 'default1', 'default2', NULL);
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('default1', 'default2'), ('default2', 'Student Club');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.event_id) FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event WHERE T1.event_name = 'Women''s Soccer';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT m.member_id) AS student_count FROM event AS e INNER JOIN attendance AS a ON e.event_id = a.link_to_event INNER JOIN member AS m ON a.link_to_member = m.member_id WHERE e.event_name = 'Women''s Soccer' AND m.position = 'Student Club';

/*
Prediction Result:
(0,)
*/