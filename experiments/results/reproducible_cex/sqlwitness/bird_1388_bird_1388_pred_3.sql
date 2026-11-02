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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (2, NULL, 'default2', 'default2', 'default1', 'default1'), (0, 'default1', 'default2', 'default1', 'default1', 'default1'), (1, 'default2', 'default1', 'default1', 'default2', 'default2'), (3, 'default2', 'default1', NULL, 'default1', 'default2'), (4, 'default1', NULL, 'default2', NULL, 'default2'), (5, 'default1', NULL, NULL, 'default2', 'default2'), (6, 'default2', 'default1', 'default1', 'default2', NULL), (7, 'default1', NULL, 'default1', 'default1', 'default1'), (8, NULL, 'default1', 'default2', 'default2', 'default2'), (9, NULL, NULL, NULL, NULL, NULL), (10, 'default1', 'default1', 'default2', NULL, 'default2'), (11, 'default2', NULL, NULL, 'default2', 'default1');
INSERT INTO major (major_id, major_name, department, college) VALUES ('default1', NULL, 'default2', NULL), ('default2', NULL, 'default2', NULL), ('unique_2', 'default2', NULL, 'default2'), ('unique_3', 'default2', 'default2', 'default1'), ('unique_4', 'default1', 'default2', NULL), ('unique_5', 'default2', 'default2', 'default2'), ('unique_6', 'default1', NULL, 'default1'), ('unique_7', NULL, 'default1', NULL), ('unique_8', 'default1', 'default1', 'default1'), ('unique_9', 'default1', 'default1', 'default2'), ('unique_10', 'default1', 'default1', 'default2'), ('unique_11', 'default2', 'default1', 'default2'), ('unique_12', 'default1', NULL, 'default2');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('default2', 'unique_6', 7, 'default2', 'default1', 'default2', 'default2', 'default2', 'default2'), ('default1', 'unique_2', 5, NULL, 'default1', NULL, 'default1', NULL, 'default2'), ('unique_2', 'unique_6', NULL, 'default2', 'default2', 'default1', 'default2', 'default2', 'default1'), ('unique_3', 'unique_5', 9, 'default2', 'default2', 'default1', NULL, NULL, 'default2'), ('unique_4', 'default2', 9, 'default1', 'default2', NULL, 'default1', NULL, 'default2'), ('unique_5', 'unique_4', 11, NULL, NULL, 'default2', 'default2', NULL, NULL), ('unique_6', NULL, 11, 'default2', NULL, 'default2', 'default2', NULL, 'default1'), ('unique_7', 'unique_2', 0, 'default2', 'default2', 'default2', NULL, 'default1', 'default2'), ('unique_8', 'unique_2', 10, 'default1', 'default2', 'default1', NULL, NULL, 'default2'), ('unique_9', 'unique_9', 6, NULL, NULL, 'default1', NULL, 'default1', 'default2'), ('unique_10', 'unique_11', 1, NULL, 'default1', NULL, NULL, NULL, 'default2'), ('unique_11', 'unique_10', 0, NULL, 'default2', 'default2', 'default1', 'default2', 'default1'), ('unique_12', 'default1', 8, NULL, 'default1', 'default2', 'default2', 'default2', 'default1');
INSERT INTO income (income_id, link_to_member, date_received, amount, source, notes) VALUES ('default2', 'unique_10', 'default2', 2, 'default2', 'default1'), ('default1', 'unique_9', NULL, NULL, 'default2', 'default1'), ('unique_2', 'unique_6', 'default2', 2, 'default2', 'default2'), ('unique_3', 'unique_8', 'default1', 0, NULL, 'default1'), ('unique_4', NULL, NULL, 1, 'default1', 'default2'), ('unique_5', 'unique_3', 'default1', 2, NULL, NULL), ('unique_6', 'unique_2', 'default2', 0, 'default2', 'default1'), ('unique_7', 'unique_6', 'default2', NULL, 'default1', 'default2'), ('unique_8', 'unique_12', 'default1', 0, 'default2', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.first_name, T1.last_name, T2.source FROM member AS T1 INNER JOIN income AS T2 ON T1.member_id = T2.link_to_member GROUP BY T1.first_name, T1.last_name, T2.source ORDER BY SUM(T2.amount) DESC, T1.first_name NULLS LAST, T1.last_name NULLS LAST, T2.source NULLS LAST LIMIT 1;

/*
Gold Result:
('default2', 'default2', None)
*/

-- Prediction Query
SELECT T2.first_name, T2.last_name, T1.source FROM income AS T1 INNER JOIN member AS T2 ON T1.link_to_member = T2.member_id ORDER BY T1.amount DESC, T1.income_id NULLS LAST, T2.member_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(None, 'default1', 'default2')
*/