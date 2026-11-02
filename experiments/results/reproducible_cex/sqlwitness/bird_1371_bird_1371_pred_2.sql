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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (0, 'default2', 'default2', 'Women''s Soccer', 'default2', 'Women''s Soccer'), (1, NULL, NULL, 'default1', 'default1', NULL), (2, 'Women''s Soccer', 'Women''s Soccer', 'Women''s Soccer', 'default2', 'default1'), (3, 'default1', 'default1', 'default2', NULL, 'Women''s Soccer'), (4, 'Women''s Soccer', NULL, 'default2', 'Women''s Soccer', NULL), (5, 'Women''s Soccer', NULL, 'default2', 'default1', 'default2'), (6, NULL, 'default1', NULL, 'Women''s Soccer', 'Women''s Soccer'), (7, NULL, 'default2', 'Women''s Soccer', 'default2', 'default2'), (8, 'default2', 'default1', 'Women''s Soccer', 'default1', 'Women''s Soccer');
INSERT INTO major (major_id, major_name, department, college) VALUES ('default2', 'default1', 'default1', 'default2'), ('default1', 'default2', 'default2', 'default1'), ('Women''s Soccer', 'default1', 'default2', 'default1'), ('unique_3', NULL, 'default2', 'default2'), ('unique_4', 'Women''s Soccer', 'default2', 'default1'), ('unique_5', 'default1', 'Women''s Soccer', 'default2'), ('unique_6', NULL, 'Women''s Soccer', 'Women''s Soccer'), ('unique_7', 'default1', NULL, 'default2'), ('unique_8', NULL, 'default2', NULL);
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('default1', 'unique_4', 8, 'default1', NULL, 'default1', 'Women''s Soccer', 'default2', 'Women''s Soccer'), ('default2', 'Women''s Soccer', 6, 'default1', 'default1', NULL, NULL, NULL, 'default2'), ('Women''s Soccer', 'unique_6', 4, 'default1', NULL, NULL, 'Women''s Soccer', 'default1', 'default2');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('default2', 'Women''s Soccer', 'default2', 'default1', NULL, NULL, 'Women''s Soccer'), ('default1', 'default1', 'default1', 'Women''s Soccer', 'Women''s Soccer', NULL, NULL), ('Women''s Soccer', 'default2', 'default1', 'Women''s Soccer', 'default1', 'default1', 'Women''s Soccer'), ('unique_3', 'Women''s Soccer', 'default2', 'default1', 'default2', NULL, 'default1'), ('unique_4', 'default1', NULL, 'Women''s Soccer', 'default2', NULL, 'default2'), ('unique_5', 'Women''s Soccer', 'Women''s Soccer', 'Women''s Soccer', NULL, NULL, 'default1'), ('unique_6', 'Women''s Soccer', 'Women''s Soccer', NULL, NULL, 'default2', 'default2'), ('unique_7', 'default2', 'default2', 'default2', 'default1', 'default1', 'Women''s Soccer');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('unique_5', 'Women''s Soccer'), ('unique_4', 'default1'), ('unique_6', 'Women''s Soccer');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T2.link_to_member) FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event WHERE T1.event_name = 'Women''s Soccer';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT attendance.link_to_member) FROM attendance JOIN event ON attendance.link_to_event = event.event_id WHERE event.event_name = 'Women''s Soccer';

/*
Prediction Result:
(1,)
*/