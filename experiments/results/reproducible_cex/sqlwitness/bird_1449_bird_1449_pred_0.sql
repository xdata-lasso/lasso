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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (99, 'default1', NULL, NULL, NULL, 'default2'), (101, 'default1', 'default2', NULL, 'default1', 'default1'), (1, 'default2', 'default2', 'default1', 'default2', 'default2'), (0, NULL, 'default1', NULL, 'default2', 'default2'), (100, NULL, 'default2', NULL, 'default2', 'default1'), (2, NULL, NULL, 'default2', 'default2', NULL), (3, 'default2', 'default1', 'default1', NULL, 'default2'), (4, 'default1', NULL, NULL, 'default2', NULL), (5, 'default1', NULL, 'default1', 'default1', NULL), (6, 'default1', 'default2', NULL, NULL, NULL);
INSERT INTO major (major_id, major_name, department, college) VALUES ('default1', 'default2', NULL, 'default2'), ('default2', 'default1', 'default1', 'default2'), ('unique_2', NULL, 'default1', NULL), ('unique_3', 'default2', 'default1', 'default2'), ('unique_4', NULL, 'default2', 'default2'), ('unique_5', 'default2', NULL, 'default2'), ('unique_6', 'default2', NULL, 'default2'), ('unique_7', 'default1', 'default2', 'default1'), ('unique_8', 'default1', 'default2', NULL), ('unique_9', 'default2', NULL, NULL), ('unique_10', 'default2', 'default2', 'default2'), ('unique_11', 'default2', 'default2', NULL), ('unique_12', NULL, NULL, 'default2');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('default1', 'unique_8', 100, 'default2', NULL, 'default2', 'default1', 'default1', 'default2'), ('default2', 'unique_10', 5, NULL, 'default1', 'default2', 'default2', 'default2', 'default2');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('default1', NULL, 'default2', NULL, NULL, 'default1', NULL), ('default2', 'default1', NULL, NULL, 'default2', 'default1', 'default2'), ('unique_2', 'default2', NULL, 'default2', 'default2', 'default1', 'default1'), ('unique_3', 'default1', 'default2', NULL, 'default1', NULL, 'default2');
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('default2', 'default1', NULL, NULL, 99.0, 0, 'default1'), ('default1', 'default2', 'default1', 101.0, NULL, 0, 'default2');
INSERT INTO expense (expense_id, link_to_budget, link_to_member, expense_description, expense_date, cost, approved) VALUES ('default2', NULL, 'default2', 'default2', NULL, 99.0, 'default2'), ('default1', 'default1', 'default2', NULL, 'default1', 101.0, NULL), ('unique_2', 'default2', 'default1', 'default1', 'default1', 101.0, 'default1'), ('unique_3', NULL, 'default2', 'default1', NULL, 101.0, NULL), ('unique_4', 'default1', 'default2', 'default2', 'default2', 99.0, 'default1'), ('unique_5', NULL, 'default1', 'default2', 'default1', 1.0, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.first_name, T1.last_name, T2.major_name FROM member AS T1 INNER JOIN major AS T2 ON T2.major_id = T1.link_to_major INNER JOIN expense AS T3 ON T1.member_id = T3.link_to_member WHERE T3.cost > 100;

/*
Gold Result:
(None, 'default1', 'default2')
('default2', None, 'default1')
*/

-- Prediction Query
SELECT T2.first_name, T2.last_name, T4.major_name FROM expense AS T1 INNER JOIN member AS T2 ON T1.link_to_member = T2.member_id INNER JOIN major AS T4 ON T2.link_to_major = T4.major_id WHERE T1.cost > 100;

/*
Prediction Result:
(None, 'default1', 'default2')
('default2', None, 'default1')
(None, 'default1', 'default2')
*/