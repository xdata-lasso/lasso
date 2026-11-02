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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (0, 'default1', NULL, NULL, NULL, 'Member'), (1, 'default1', 'Member', 'Women''s Soccer', 'default1', 'default1'), (2, NULL, NULL, 'Women''s Soccer', 'Member', 'default2'), (3, 'Member', 'Women''s Soccer', NULL, 'default2', 'Member'), (4, NULL, 'default1', 'Women''s Soccer', 'default2', 'default2'), (5, 'Women''s Soccer', NULL, NULL, 'Member', 'Women''s Soccer'), (6, 'default2', 'Women''s Soccer', NULL, 'default1', NULL), (7, 'default2', 'Member', 'Women''s Soccer', 'default1', 'Member'), (8, 'default2', 'default2', 'Women''s Soccer', 'Women''s Soccer', 'Women''s Soccer');
INSERT INTO major (major_id, major_name, department, college) VALUES ('Women''s Soccer', NULL, 'Women''s Soccer', NULL);
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('Women''s Soccer', 'Women''s Soccer', 2, 'Women''s Soccer', NULL, 'default1', 'Women''s Soccer', 'default2', 'Member'), ('default2', NULL, 4, 'default1', 'default2', NULL, 'default2', 'default1', 'Women''s Soccer'), ('Member', 'Women''s Soccer', NULL, 'Member', NULL, 'default1', 'default2', NULL, 'default2'), ('default1', NULL, 1, 'default1', 'default1', 'default2', NULL, 'Member', 'Women''s Soccer'), ('unique_4', NULL, 8, 'Member', 'default1', 'Women''s Soccer', 'Women''s Soccer', 'Women''s Soccer', 'default1'), ('unique_5', 'Women''s Soccer', NULL, 'Women''s Soccer', 'Member', 'Women''s Soccer', NULL, 'default1', NULL), ('unique_6', 'Women''s Soccer', 2, 'default1', 'default1', NULL, 'Member', 'Women''s Soccer', 'default2'), ('unique_7', 'Women''s Soccer', 3, NULL, 'Women''s Soccer', 'default1', 'Member', NULL, 'default1'), ('unique_8', 'Women''s Soccer', 3, 'Member', 'default2', 'default1', 'default2', NULL, NULL), ('unique_9', NULL, 7, NULL, NULL, NULL, 'Member', 'default2', NULL), ('unique_10', NULL, NULL, 'Member', 'Member', 'Women''s Soccer', 'Member', 'Women''s Soccer', NULL), ('unique_11', 'Women''s Soccer', 7, 'default1', 'default2', 'Member', 'Member', 'Women''s Soccer', 'Women''s Soccer');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('Member', 'Women''s Soccer', 'default1', 'default2', 'default2', 'default2', 'Member'), ('default1', 'default2', 'Member', 'Women''s Soccer', 'Member', 'Member', 'Member'), ('Women''s Soccer', NULL, 'default1', 'Women''s Soccer', 'Member', 'Women''s Soccer', NULL), ('default2', 'Women''s Soccer', NULL, 'Member', NULL, 'Women''s Soccer', NULL), ('unique_4', 'default1', 'Member', NULL, 'default1', 'Women''s Soccer', 'Women''s Soccer'), ('unique_5', 'Women''s Soccer', 'default1', 'default2', NULL, NULL, 'default2'), ('unique_6', 'Member', 'default1', 'default1', NULL, NULL, 'Member'), ('unique_7', 'Women''s Soccer', 'Member', 'default2', 'Women''s Soccer', NULL, 'Member'), ('unique_8', 'Member', 'default1', 'default1', NULL, 'Women''s Soccer', NULL), ('unique_9', 'Women''s Soccer', 'Member', 'default2', 'default1', 'default2', 'default2'), ('unique_10', NULL, 'Member', 'Women''s Soccer', 'Member', 'default2', 'Member'), ('unique_11', 'Member', 'default2', 'default1', 'Women''s Soccer', 'default1', 'Women''s Soccer'), ('unique_12', NULL, 'Women''s Soccer', 'Member', 'default2', 'default2', NULL), ('unique_13', 'default1', 'default1', 'default2', 'default1', 'default2', NULL), ('unique_14', 'default1', 'Member', 'default2', 'default1', 'default2', 'default2'), ('unique_15', 'default1', 'default2', 'default1', 'Member', NULL, 'Member'), ('unique_16', NULL, 'default1', NULL, 'Member', 'Women''s Soccer', 'default1'), ('unique_17', 'Member', 'Member', 'Member', 'default1', 'default1', NULL), ('unique_18', 'Member', 'Women''s Soccer', 'Women''s Soccer', 'default1', 'Women''s Soccer', 'Member'), ('unique_19', NULL, 'default2', 'default1', 'Women''s Soccer', 'default1', 'Women''s Soccer'), ('unique_20', 'default1', 'Member', 'default1', 'Women''s Soccer', 'Women''s Soccer', 'Member'), ('unique_21', 'default2', NULL, NULL, 'default1', 'Women''s Soccer', NULL), ('unique_22', 'Women''s Soccer', 'Women''s Soccer', 'default1', 'Women''s Soccer', NULL, 'Member'), ('unique_23', 'Member', NULL, NULL, 'Women''s Soccer', 'default2', 'default2'), ('unique_24', 'Women''s Soccer', 'default2', 'Member', 'Member', NULL, NULL), ('unique_25', 'Women''s Soccer', 'Women''s Soccer', 'Women''s Soccer', NULL, 'default2', 'default1'), ('unique_26', 'default1', 'default2', NULL, 'default1', 'default1', 'default1'), ('unique_27', NULL, 'default1', 'Member', 'default1', 'default1', 'default1'), ('unique_28', NULL, NULL, 'default2', 'Women''s Soccer', NULL, NULL), ('unique_29', 'default1', NULL, 'default1', 'Women''s Soccer', 'Women''s Soccer', 'default2'), ('unique_30', 'Member', 'Women''s Soccer', 'Member', 'default1', 'Member', 'Member'), ('unique_31', 'Women''s Soccer', 'Women''s Soccer', 'default2', NULL, 'Women''s Soccer', NULL), ('unique_32', 'default2', 'default1', 'Member', NULL, 'default2', 'Member');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('unique_16', 'default2'), ('unique_12', 'unique_5'), ('unique_31', 'Women''s Soccer'), ('Women''s Soccer', 'unique_6'), ('default2', 'unique_9'), ('unique_30', 'unique_10'), ('unique_9', 'default2'), ('unique_11', 'unique_5'), ('unique_5', 'unique_9'), ('unique_25', 'default2'), ('unique_5', 'unique_11');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.last_name FROM attendance AS T1 INNER JOIN event AS T2 ON T2.event_id = T1.link_to_event INNER JOIN member AS T3 ON T1.link_to_member = T3.member_id WHERE T2.event_name = 'Women''s Soccer' AND T3.position = 'Member';

/*
Gold Result:
(None,)
(None,)
('default2',)
*/

-- Prediction Query
SELECT DISTINCT member.last_name FROM member INNER JOIN attendance ON member.member_id = attendance.link_to_member INNER JOIN event ON attendance.link_to_event = event.event_id WHERE member.position = 'Member' AND event.event_name = 'Women''s Soccer';

/*
Prediction Result:
(None,)
('default2',)
*/