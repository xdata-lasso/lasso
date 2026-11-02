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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (1, 'Mclean', 'Maya', NULL, NULL, 'Maya'), (0, NULL, 'Women''s Soccer', NULL, 'default1', 'YES'), (2, 'Women''s Soccer', 'YES', NULL, 'YES', 'default1'), (3, 'YES', 'Mclean', 'YES', 'Maya', NULL), (4, 'Mclean', 'Mclean', 'default2', 'Maya', 'Maya'), (5, 'default1', NULL, 'Women''s Soccer', 'Women''s Soccer', 'Women''s Soccer'), (6, 'Maya', 'YES', NULL, NULL, 'default2'), (7, 'Mclean', 'default1', 'YES', 'Mclean', 'Maya'), (8, 'Women''s Soccer', 'default2', 'default2', 'Women''s Soccer', 'Women''s Soccer'), (9, 'Mclean', 'Mclean', 'YES', 'Mclean', 'default2'), (10, 'Maya', 'Women''s Soccer', 'default2', 'YES', 'Mclean'), (11, 'default1', 'Maya', 'Women''s Soccer', NULL, 'default2'), (12, 'YES', 'default1', 'Women''s Soccer', 'Maya', 'Mclean'), (13, 'default1', 'default2', 'Mclean', 'Women''s Soccer', 'YES'), (14, NULL, NULL, 'default1', 'Mclean', 'Women''s Soccer'), (15, 'Maya', 'YES', 'default2', 'Maya', 'Women''s Soccer'), (16, 'default2', NULL, 'default2', 'Mclean', 'Women''s Soccer'), (17, 'YES', 'Mclean', NULL, 'default1', 'YES'), (18, 'Maya', NULL, 'default2', 'default2', 'Mclean'), (19, 'Maya', 'YES', 'Women''s Soccer', 'Women''s Soccer', 'YES'), (20, 'YES', NULL, 'Mclean', NULL, 'Mclean'), (21, 'Mclean', 'YES', 'default1', 'Maya', 'Maya'), (22, 'Women''s Soccer', 'YES', 'Maya', 'default2', 'Maya');
INSERT INTO major (major_id, major_name, department, college) VALUES ('default2', 'Women''s Soccer', 'default2', NULL), ('default1', 'Maya', 'Maya', 'Mclean'), ('Mclean', 'Mclean', 'YES', 'Maya'), ('Maya', NULL, 'default2', NULL), ('YES', NULL, 'Mclean', NULL), ('Women''s Soccer', 'YES', 'YES', 'Mclean'), ('unique_6', 'default1', 'Mclean', 'Mclean'), ('unique_7', 'Mclean', 'YES', 'Maya'), ('unique_8', 'default1', 'Women''s Soccer', 'Women''s Soccer'), ('unique_9', NULL, 'YES', 'Mclean'), ('unique_10', 'Women''s Soccer', 'Maya', 'default1'), ('unique_11', 'YES', 'Women''s Soccer', 'default2'), ('unique_12', 'default2', 'default2', 'Maya'), ('unique_13', 'YES', 'YES', 'Maya'), ('unique_14', 'Women''s Soccer', 'Maya', 'YES');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('Maya', 'unique_13', 14, 'Maya', 'Mclean', 'default2', 'Women''s Soccer', 'Maya', 'default1'), ('default2', 'unique_14', 21, 'Women''s Soccer', 'YES', 'YES', 'Mclean', 'YES', 'Women''s Soccer'), ('default1', 'Maya', 6, 'Mclean', 'Women''s Soccer', 'default1', NULL, 'default1', 'YES'), ('Women''s Soccer', 'unique_11', 19, 'Women''s Soccer', 'YES', 'Mclean', NULL, 'Women''s Soccer', 'Mclean'), ('YES', 'YES', 15, NULL, 'Women''s Soccer', 'default1', 'default1', 'Mclean', 'default2'), ('Mclean', 'unique_8', 7, 'Maya', 'Maya', 'default2', 'Maya', 'default1', 'Maya'), ('unique_6', 'unique_9', 19, 'default2', NULL, 'default1', 'YES', 'default1', 'default2'), ('unique_7', 'default2', NULL, 'Maya', 'default1', 'default2', 'default2', 'default2', 'YES'), ('unique_8', 'default1', 4, 'Mclean', NULL, NULL, NULL, NULL, 'Women''s Soccer'), ('unique_9', 'unique_12', 17, 'Women''s Soccer', 'Women''s Soccer', 'Maya', 'default1', 'default1', 'Mclean'), ('unique_10', 'default2', 15, 'default2', 'YES', 'Mclean', 'Maya', NULL, 'default2'), ('unique_11', 'Maya', 2, 'YES', 'default2', 'YES', 'default1', 'Women''s Soccer', 'default2'), ('unique_12', 'unique_6', 22, 'YES', 'default2', NULL, 'default2', NULL, 'Maya'), ('unique_13', 'default1', 6, 'YES', NULL, 'default2', 'default2', 'default2', 'Maya');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('YES', 'Maya', 'Women''s Soccer', 'default1', 'Mclean', 'default1', 'Women''s Soccer'), ('default1', 'YES', 'Women''s Soccer', 'YES', 'default2', 'YES', 'default1'), ('default2', 'default1', 'Women''s Soccer', 'Maya', 'default1', 'Maya', 'Mclean'), ('Women''s Soccer', 'default2', 'YES', 'Maya', 'Mclean', NULL, 'Maya'), ('Mclean', 'Maya', 'default1', 'Maya', 'Mclean', 'Women''s Soccer', 'YES'), ('Maya', 'YES', 'Mclean', 'Maya', 'YES', 'Women''s Soccer', 'default2'), ('unique_6', 'YES', 'default2', 'default1', 'default2', 'Women''s Soccer', NULL), ('unique_7', 'Maya', NULL, 'Maya', 'Mclean', NULL, 'default2'), ('unique_8', NULL, 'Mclean', 'Maya', 'YES', 'Mclean', 'default2'), ('unique_9', 'Women''s Soccer', 'default2', NULL, 'YES', 'Mclean', NULL), ('unique_10', 'default1', 'default1', 'YES', 'Women''s Soccer', 'Women''s Soccer', NULL), ('unique_11', 'Mclean', 'Maya', NULL, 'Maya', 'YES', NULL), ('unique_12', 'default1', 'Women''s Soccer', 'Women''s Soccer', 'Mclean', 'Mclean', 'Mclean');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('Maya', 'default2'), ('Mclean', 'unique_11'), ('Maya', 'Women''s Soccer'), ('Maya', 'Mclean'), ('unique_7', 'unique_11'), ('unique_11', 'unique_13'), ('default2', 'unique_12'), ('unique_8', 'unique_10'), ('unique_10', 'Maya'), ('YES', 'Mclean');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CASE WHEN T3.event_name = 'Women''s Soccer' THEN 'YES' END AS result FROM member AS T1 INNER JOIN attendance AS T2 ON T1.member_id = T2.link_to_member INNER JOIN event AS T3 ON T2.link_to_event = T3.event_id WHERE T1.first_name = 'Maya' AND T1.last_name = 'Mclean';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT member.first_name, member.last_name FROM member INNER JOIN attendance ON member.member_id = attendance.link_to_member INNER JOIN event ON attendance.link_to_event = event.event_id WHERE member.first_name = 'Maya' AND member.last_name = 'Mclean' AND event.event_name = 'Women''s Soccer';

/*
Prediction Result:
*/