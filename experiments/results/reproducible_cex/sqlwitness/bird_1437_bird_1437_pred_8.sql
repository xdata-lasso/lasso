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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (9, '2019-11-19', NULL, 'true', NULL, '2019-11-19'), (2, '2019-01-10', 'default2', 'true', '2019-11-19', NULL), (1, 'default1', 'default1', '2019-01-10', 'default1', 'default2'), (11, 'default1', 'default1', 'default2', 'default2', 'true'), (0, 'true', '2019-01-10', '2019-11-19', NULL, 'default1'), (10, '2019-11-19', 'default1', 'default2', '2019-11-19', '2019-01-10'), (3, 'default1', 'default1', 'default1', '2019-01-10', '2019-01-10');
INSERT INTO major (major_id, major_name, department, college) VALUES ('true', '2019-01-10', 'default2', 'true'), ('2019-11-19', '2019-01-10', NULL, 'default1'), ('2019-01-10', '2019-11-19', 'true', 'default2'), ('default1', 'true', 'default1', 'default1');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('2019-11-19', 'true', NULL, 'default1', '2019-11-19', 'true', 'default1', 'true', 'default2'), ('true', 'true', 2, 'true', NULL, 'default1', 'default2', '2019-11-19', 'default1'), ('default2', NULL, 9, 'default1', 'default2', 'default2', NULL, '2019-11-19', 'true'), ('2019-01-10', 'true', 11, '2019-01-10', NULL, 'true', 'default1', '2019-11-19', 'default1'), ('default1', '2019-01-10', 10, NULL, 'default1', 'default1', '2019-01-10', '2019-01-10', 'default1'), ('unique_5', 'true', 9, '2019-11-19', '2019-11-19', NULL, 'default2', 'true', NULL), ('unique_6', 'default1', 9, 'true', 'default1', '2019-11-19', 'default1', '2019-01-10', NULL), ('unique_7', '2019-11-19', 11, 'true', '2019-11-19', NULL, NULL, 'default1', 'default1'), ('unique_8', '2019-01-10', 10, 'true', '2019-01-10', NULL, 'default2', 'default2', NULL), ('unique_9', 'default1', 11, 'default2', NULL, '2019-01-10', NULL, 'true', 'default2'), ('unique_10', '2019-11-19', 2, 'default2', '2019-11-19', 'default1', 'true', 'default1', 'true'), ('unique_11', 'true', 10, '2019-01-10', 'default1', 'default1', NULL, 'default1', '2019-01-10');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('default2', '2019-11-19', 'default1', '2019-11-19', '2019-11-19', '2019-01-10', 'true'), ('default1', '2019-01-10', 'default2', 'true', '2019-11-19', '2019-01-10', 'default2'), ('2019-01-10', '2019-11-19', NULL, 'default1', '2019-01-10', 'default1', 'default1'), ('2019-11-19', 'default1', 'default1', 'true', '2019-11-19', '2019-11-19', 'default2'), ('true', 'default1', '2019-01-10', '2019-11-19', '2019-11-19', '2019-01-10', 'default2'), ('unique_5', NULL, '2019-01-10', '2019-11-19', 'default1', 'true', '2019-01-10'), ('unique_6', 'default2', 'default1', '2019-11-19', '2019-01-10', 'default1', 'true'), ('unique_7', '2019-11-19', '2019-11-19', '2019-11-19', 'true', 'default1', 'default1'), ('unique_8', 'true', 'default1', 'default2', 'default1', '2019-11-19', 'default2'), ('unique_9', 'default1', 'default1', 'true', '2019-01-10', 'true', '2019-11-19'), ('unique_10', 'default1', NULL, '2019-11-19', 'default2', '2019-11-19', 'default2'), ('unique_11', 'default1', 'default1', NULL, '2019-01-10', 'true', 'default1'), ('unique_12', '2019-11-19', '2019-01-10', 'default1', NULL, '2019-11-19', '2019-01-10');
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('2019-11-19', 'true', 'true', 0.0, NULL, 10, 'default1'), ('default1', 'true', 'default1', NULL, 1.0, 1, 'true'), ('default2', 'unique_11', 'default1', 10.0, 0.0, 9, '2019-01-10'), ('2019-01-10', 'unique_7', NULL, 0.0, 9.0, 1, '2019-11-19'), ('true', 'default2', '2019-01-10', NULL, 1.0, 2, 'default1'), ('unique_5', 'unique_7', NULL, 2.0, 1.0, NULL, 'default2');
INSERT INTO expense (expense_id, link_to_budget, link_to_member, expense_description, expense_date, cost, approved) VALUES ('default1', NULL, 'default1', 'true', 'default2', 2.0, NULL), ('true', 'true', 'unique_6', 'true', NULL, 1.0, 'default1'), ('2019-11-19', '2019-11-19', 'unique_5', 'default2', 'true', 1.0, '2019-01-10'), ('2019-01-10', 'unique_5', 'unique_10', 'default1', '2019-11-19', 0.0, 'true'), ('default2', 'true', 'true', '2019-11-19', 'default1', NULL, 'default2'), ('unique_5', 'true', '2019-01-10', '2019-11-19', 'default1', 1.0, '2019-01-10');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('unique_9', 'unique_5'), ('2019-01-10', 'default1'), ('unique_7', 'unique_9'), ('default1', 'default1'), ('unique_10', '2019-11-19'), ('unique_7', 'unique_5'), ('2019-01-10', 'unique_6'), ('2019-11-19', 'unique_7'), ('default2', '2019-01-10'), ('unique_10', 'unique_10'), ('unique_10', 'true'), ('unique_12', 'unique_5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.link_to_member, T3.link_to_event FROM expense AS T1 INNER JOIN member AS T2 ON T1.link_to_member = T2.member_id INNER JOIN attendance AS T3 ON T2.member_id = T3.link_to_member WHERE DATE(SUBSTRING(T1.expense_date, 1, 10)) BETWEEN '2019-01-10' AND '2019-11-19' AND T1.approved = 'true';

/*
Gold Result:
('unique_10', 'unique_10')
*/

-- Prediction Query
SELECT T2.first_name, T2.last_name, T3.link_to_event FROM expense AS T1 JOIN attendance AS T3 ON T1.link_to_member = T3.link_to_member JOIN member AS T2 ON T3.link_to_member = T2.member_id WHERE T1.approved = 'true' AND T1.expense_date BETWEEN '2019-01-10' AND '2019-11-19';

/*
Prediction Result:
('default2', '2019-11-19', 'unique_10')
*/