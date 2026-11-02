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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (1, 'Women%', 'default1', 'Women''s Soccer', 'Member', 'default1'), (0, 'default1', NULL, 'Women%', NULL, NULL), (2, 'default1', 'default2', 'default2', 'default1', 'default1');
INSERT INTO major (major_id, major_name, department, college) VALUES ('Member', 'default1', 'Member', NULL), ('default2', 'Member', 'Women''s Soccer', 'Member'), ('default1', 'Women''s Soccer', 'Women%', NULL), ('Women''s Soccer', 'Women%', 'default2', 'Member'), ('Women%', 'default2', 'Member', 'Women''s Soccer'), ('unique_5', NULL, 'Women''s Soccer', NULL), ('unique_6', 'default2', 'Women''s Soccer', 'default2'), ('unique_7', 'Member', NULL, 'default2'), ('unique_8', 'Women''s Soccer', 'Women%', 'Member'), ('unique_9', NULL, 'default1', 'default1');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('default2', 'Member', 0, 'default2', NULL, 'Member', 'default1', 'Women''s Soccer', 'default1'), ('Member', NULL, 2, 'Women''s Soccer', 'default2', 'default1', 'Women%', 'Women%', 'Women''s Soccer'), ('Women%', NULL, 2, 'default1', 'Women%', 'Women''s Soccer', NULL, 'Women%', 'Women%'), ('default1', 'unique_7', 2, 'default2', 'Women%', 'default2', 'Member', NULL, 'Women%'), ('Women''s Soccer', 'unique_9', 1, 'default1', 'Women''s Soccer', 'default2', 'default2', 'Women%', 'default1'), ('unique_5', 'unique_8', 0, 'Women''s Soccer', 'Member', 'Member', 'Member', 'Member', 'default1'), ('unique_6', 'unique_7', 2, 'Women''s Soccer', 'Member', 'Women''s Soccer', 'default1', 'Women''s Soccer', 'default2'), ('unique_7', 'unique_6', 1, 'Women''s Soccer', 'Women%', 'default1', 'Women%', 'Women%', 'Women''s Soccer'), ('unique_8', 'Member', 2, 'Women''s Soccer', 'Member', 'default1', 'Women%', 'Member', 'Member'), ('unique_9', 'default1', NULL, 'Member', 'Member', 'default2', 'Women''s Soccer', 'Member', 'Women''s Soccer'), ('unique_10', 'Women%', 2, 'default1', 'default1', NULL, 'Member', NULL, 'default1'), ('unique_11', 'Women''s Soccer', 2, NULL, 'default1', 'Women''s Soccer', 'default1', 'default2', 'default2'), ('unique_12', 'default1', 0, NULL, 'default1', 'Women''s Soccer', 'default2', 'Women%', 'Member'), ('unique_13', 'Women%', 0, 'default1', NULL, 'Member', 'Women''s Soccer', 'default1', 'default2');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('default2', NULL, 'Women%', 'Member', 'Women''s Soccer', NULL, NULL), ('Women%', 'Women''s Soccer', 'Women''s Soccer', 'Women%', 'Member', 'Member', 'Women%'), ('default1', 'Women''s Soccer', 'Women%', NULL, 'Women%', 'Women''s Soccer', 'Women%'), ('Member', 'default1', NULL, NULL, 'Women%', 'Women%', 'Member'), ('Women''s Soccer', 'Women%', 'Women%', 'Women%', 'default2', 'default2', 'default2'), ('unique_5', 'Women''s Soccer', 'Women%', NULL, 'Member', 'default1', 'Women%'), ('unique_6', 'default2', NULL, 'default1', 'default2', 'default1', NULL), ('unique_7', 'default2', 'Women%', 'Women''s Soccer', 'Member', 'Women%', 'Women%'), ('unique_8', 'Women%', 'Women%', 'default2', 'Women%', 'Women''s Soccer', 'Member'), ('unique_9', 'Women%', 'default2', 'Women%', 'Member', 'Member', 'Women''s Soccer'), ('unique_10', 'Women%', 'Women''s Soccer', 'Member', 'Member', NULL, 'default1'), ('unique_11', 'Women''s Soccer', 'Women%', NULL, 'default1', 'default2', 'Member'), ('unique_12', NULL, 'Member', 'default2', 'Women''s Soccer', 'Women''s Soccer', 'default1'), ('unique_13', 'Women%', 'Member', 'Women''s Soccer', 'Women''s Soccer', 'default2', 'Women''s Soccer'), ('unique_14', 'Women%', 'Member', NULL, 'Member', 'Women%', 'Member');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('Women''s Soccer', 'default1'), ('unique_5', 'unique_12'), ('unique_11', 'unique_12'), ('default2', 'unique_5'), ('unique_10', 'default2'), ('unique_11', 'unique_5'), ('Women%', 'Women''s Soccer'), ('unique_13', 'Member'), ('unique_12', 'unique_12'), ('unique_6', 'Women''s Soccer'), ('default1', 'Member'), ('default1', 'unique_13'), ('unique_5', 'Women%');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.last_name FROM attendance AS T1 INNER JOIN event AS T2 ON T2.event_id = T1.link_to_event INNER JOIN member AS T3 ON T1.link_to_member = T3.member_id WHERE T2.event_name = 'Women''s Soccer' AND T3.position = 'Member';

/*
Gold Result:
('Member',)
*/

-- Prediction Query
SELECT T3.last_name FROM attendance AS T1 INNER JOIN event AS T2 ON T1.link_to_event = T2.event_id INNER JOIN member AS T3 ON T1.link_to_member = T3.member_id WHERE T2.event_name LIKE 'Women%' AND T3.position = 'Member';

/*
Prediction Result:
('Women%',)
('Member',)
*/