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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (0, 'Student_Club', 'default1', 'Medium', 'default1', 'default2'), (1, NULL, 'default2', 'Women''s Soccer', NULL, 'Women''s Soccer'), (2, 'default2', 'Medium', 'Medium', NULL, NULL), (3, NULL, 'Student_Club', 'Women''s Soccer', 'default1', NULL);
INSERT INTO major (major_id, major_name, department, college) VALUES ('Student_Club', 'default1', NULL, NULL), ('Medium', NULL, 'default2', 'default1'), ('default1', 'default2', 'Women''s Soccer', 'Medium'), ('Women''s Soccer', 'Women''s Soccer', 'Women''s Soccer', 'Medium'), ('default2', 'Medium', 'Women''s Soccer', 'Medium'), ('unique_5', 'Student_Club', 'default2', NULL), ('unique_6', NULL, 'Medium', NULL);
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('Women''s Soccer', 'Women''s Soccer', 2, NULL, 'Women''s Soccer', NULL, 'default2', 'Medium', 'Student_Club'), ('default1', 'Medium', 2, 'Medium', 'Medium', 'Student_Club', 'Women''s Soccer', 'Medium', NULL), ('default2', 'unique_6', 2, 'Medium', 'default1', NULL, 'default1', NULL, 'Student_Club'), ('Student_Club', NULL, 1, 'default2', 'Student_Club', 'Medium', 'Medium', 'Student_Club', 'Student_Club'), ('Medium', NULL, 1, 'Women''s Soccer', 'Medium', NULL, NULL, 'Women''s Soccer', 'default1'), ('unique_5', 'default1', 1, 'default1', 'Women''s Soccer', 'default1', NULL, 'Student_Club', 'Medium'), ('unique_6', 'default1', NULL, 'Student_Club', 'Medium', 'default2', 'default2', 'default1', 'Women''s Soccer'), ('unique_7', 'unique_5', 1, 'default2', 'Student_Club', 'Student_Club', 'Medium', 'Women''s Soccer', 'Women''s Soccer'), ('unique_8', 'unique_6', 3, 'Medium', 'default2', 'Student_Club', 'Medium', 'Medium', 'Women''s Soccer'), ('unique_9', 'default1', NULL, 'default2', 'Women''s Soccer', 'Women''s Soccer', 'Medium', 'default2', 'default2'), ('unique_10', 'unique_6', 3, 'Medium', 'default2', 'Medium', 'Student_Club', 'Medium', 'default2'), ('unique_11', 'unique_6', 3, 'Medium', 'default1', 'Women''s Soccer', 'default1', NULL, 'Student_Club'), ('unique_12', 'unique_5', 0, 'Medium', 'default1', 'Student_Club', 'Student_Club', NULL, 'default2');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('default2', 'Medium', NULL, NULL, 'Student_Club', NULL, 'default2'), ('Medium', 'Women''s Soccer', NULL, NULL, 'default1', 'default1', 'default2'), ('Women''s Soccer', NULL, 'default2', 'Student_Club', 'Medium', 'Student_Club', 'default2'), ('Student_Club', 'Medium', 'Medium', 'default2', 'Women''s Soccer', 'default1', 'Medium'), ('default1', 'Women''s Soccer', 'Student_Club', 'Women''s Soccer', NULL, 'Student_Club', NULL);
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('default1', 'unique_8'), ('Women''s Soccer', 'Student_Club'), ('default1', 'unique_10'), ('default2', 'default1'), ('default2', 'Women''s Soccer');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.event_id) FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event INNER JOIN member AS T3 ON T2.link_to_member = T3.member_id WHERE T1.event_name = 'Women''s Soccer' AND T3.t_shirt_size = 'Medium';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(*) FROM event AS e INNER JOIN attendance AS a ON e.event_id = a.link_to_event INNER JOIN member AS m ON a.link_to_member = m.member_id WHERE e.event_name = 'Women''s Soccer' AND m.position = 'Student_Club' AND m.t_shirt_size = 'Medium';

/*
Prediction Result:
(1,)
*/