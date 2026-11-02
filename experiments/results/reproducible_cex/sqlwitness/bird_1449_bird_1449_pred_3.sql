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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (100, NULL, 'default1', NULL, 'default2', 'default2'), (0, 'default1', 'default2', 'default1', 'default2', 'default1'), (1, 'default1', NULL, 'default1', 'default1', 'default1'), (101, 'default2', 'default1', 'default1', 'default1', 'default2'), (99, 'default1', NULL, 'default2', NULL, 'default2'), (2, 'default2', 'default2', 'default1', 'default1', 'default2'), (3, 'default2', 'default2', 'default2', 'default1', 'default1'), (4, 'default2', 'default1', 'default1', 'default2', NULL), (5, 'default2', 'default2', NULL, 'default2', 'default2'), (6, 'default1', NULL, NULL, 'default1', NULL), (7, 'default1', 'default2', 'default2', NULL, NULL);
INSERT INTO major (major_id, major_name, department, college) VALUES ('default1', NULL, 'default2', NULL), ('default2', NULL, NULL, NULL), ('unique_2', 'default2', 'default1', 'default2'), ('unique_3', 'default2', 'default1', NULL), ('unique_4', NULL, 'default1', 'default2'), ('unique_5', 'default1', NULL, NULL), ('unique_6', 'default2', 'default1', 'default2'), ('unique_7', NULL, 'default1', NULL);
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('default2', 'unique_4', 100, 'default2', NULL, NULL, NULL, NULL, NULL), ('default1', 'unique_6', NULL, NULL, 'default1', NULL, 'default1', NULL, NULL), ('unique_2', 'unique_5', 0, 'default2', NULL, 'default2', 'default1', NULL, 'default1'), ('unique_3', 'default1', 2, 'default1', 'default1', 'default2', NULL, 'default2', 'default2'), ('unique_4', 'unique_4', 6, 'default2', 'default1', 'default1', 'default1', 'default2', 'default2'), ('unique_5', 'unique_2', 99, 'default1', 'default1', 'default2', 'default1', 'default2', NULL), ('unique_6', 'default2', NULL, 'default1', 'default1', NULL, NULL, NULL, NULL), ('unique_7', 'unique_3', NULL, NULL, 'default2', NULL, NULL, 'default1', NULL), ('unique_8', 'unique_6', 2, 'default2', 'default2', 'default1', NULL, 'default1', 'default1'), ('unique_9', 'default2', 4, NULL, 'default1', 'default2', NULL, 'default1', NULL), ('unique_10', 'unique_5', 99, NULL, 'default1', 'default2', 'default1', 'default2', 'default1');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('default1', 'default2', 'default1', 'default2', NULL, NULL, 'default2'), ('default2', NULL, 'default2', NULL, NULL, 'default2', 'default2'), ('unique_2', NULL, 'default1', NULL, 'default2', 'default2', 'default1');
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('default1', NULL, NULL, 99.0, 1.0, NULL, 'default1'), ('default2', NULL, NULL, 0.0, 0.0, 101, 'default2'), ('unique_2', 'unique_2', 'default1', NULL, 1.0, NULL, 'default1'), ('unique_3', 'unique_2', 'default2', NULL, 0.0, 101, 'default1'), ('unique_4', 'default1', NULL, 99.0, 99.0, 101, 'default2'), ('unique_5', 'default1', 'default2', 99.0, 101.0, 100, 'default1'), ('unique_6', 'default2', 'default1', NULL, NULL, 100, NULL), ('unique_7', 'default2', 'default2', 101.0, NULL, 101, 'default2'), ('unique_8', NULL, 'default2', NULL, 1.0, 101, NULL);
INSERT INTO expense (expense_id, link_to_budget, link_to_member, expense_description, expense_date, cost, approved) VALUES ('default2', 'default1', 'unique_3', NULL, 'default2', 101.0, NULL), ('default1', 'unique_6', 'unique_10', 'default2', NULL, 1.0, 'default1'), ('unique_2', 'unique_7', 'unique_6', 'default2', NULL, 0.0, 'default2'), ('unique_3', 'unique_2', 'unique_3', 'default2', NULL, 101.0, 'default1'), ('unique_4', 'default2', 'default1', 'default2', 'default1', 101.0, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.first_name, T1.last_name, T2.major_name FROM member AS T1 INNER JOIN major AS T2 ON T2.major_id = T1.link_to_major INNER JOIN expense AS T3 ON T1.member_id = T3.link_to_member WHERE T3.cost > 100;

/*
Gold Result:
('default1', 'default1', None)
(None, 'default1', 'default2')
*/

-- Prediction Query
SELECT m.first_name, m.last_name, maj.major_name FROM member AS m JOIN expense AS e ON m.member_id = e.link_to_member JOIN major AS maj ON m.link_to_major = maj.major_id WHERE e.cost > 100;

/*
Prediction Result:
('default1', 'default1', None)
('default1', 'default1', None)
(None, 'default1', 'default2')
*/