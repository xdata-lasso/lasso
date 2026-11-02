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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (1, 'default1', 'Dues', 'Dues', 'default1', 'Dues'), (0, 'default1', NULL, 'Dues', 'default1', NULL), (2, 'default2', 'Dues', 'default2', 'Dues', NULL), (3, 'default2', 'default2', NULL, NULL, 'default2'), (4, 'default1', 'Dues', 'Dues', 'default1', 'default2'), (5, NULL, 'default2', NULL, 'default1', 'default1'), (6, 'default2', NULL, NULL, NULL, 'default1'), (7, 'default2', 'Dues', NULL, NULL, NULL), (8, NULL, NULL, 'Dues', 'Dues', NULL), (9, 'Dues', 'default2', 'Dues', 'Dues', 'default2'), (10, NULL, 'default1', NULL, 'default2', 'default1'), (11, 'default1', 'Dues', NULL, 'default2', 'default2'), (12, 'default2', NULL, 'Dues', 'Dues', 'default2'), (13, 'default1', 'default2', 'default1', NULL, 'Dues'), (14, NULL, 'default2', 'default2', NULL, NULL), (15, 'default2', 'default2', NULL, NULL, NULL), (16, 'default1', 'default1', 'default2', 'default1', NULL), (17, 'default2', 'Dues', 'Dues', 'default1', NULL), (18, 'Dues', 'Dues', 'Dues', NULL, NULL), (19, 'default2', NULL, 'default2', 'default1', NULL), (20, 'Dues', 'default1', 'Dues', 'default1', 'Dues'), (21, 'default2', NULL, 'default2', 'default1', 'default1'), (22, 'Dues', 'default2', NULL, NULL, 'Dues'), (23, 'default2', 'Dues', NULL, 'default1', 'default2'), (24, 'default2', 'default2', 'default2', NULL, 'default2'), (25, 'default2', NULL, 'Dues', 'default2', 'Dues');
INSERT INTO major (major_id, major_name, department, college) VALUES ('Dues', 'default2', 'default1', 'default1'), ('default1', 'Dues', 'default2', 'default2'), ('default2', NULL, 'default2', NULL), ('unique_3', 'default2', NULL, 'Dues'), ('unique_4', 'default2', NULL, 'default2'), ('unique_5', 'default2', 'default2', 'Dues'), ('unique_6', 'default2', NULL, 'default1'), ('unique_7', NULL, 'default1', 'default1'), ('unique_8', 'default2', 'Dues', 'Dues'), ('unique_9', 'Dues', 'default1', 'default1'), ('unique_10', 'Dues', NULL, 'default2'), ('unique_11', 'Dues', NULL, 'default1'), ('unique_12', 'Dues', 'default1', 'Dues'), ('unique_13', NULL, NULL, 'default2'), ('unique_14', NULL, 'default2', 'default2'), ('unique_15', 'Dues', 'default1', 'default2'), ('unique_16', 'Dues', 'default1', 'default1');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('Dues', 'unique_11', 24, 'default2', 'default2', 'default2', 'default1', 'default1', 'default1'), ('default2', 'unique_6', 10, NULL, NULL, 'default2', 'default2', NULL, 'default1'), ('default1', NULL, 23, NULL, NULL, 'Dues', NULL, 'Dues', NULL), ('unique_3', 'unique_4', 12, 'default2', 'default2', 'default1', NULL, 'Dues', 'default1'), ('unique_4', 'default1', 16, 'default2', 'default2', NULL, 'Dues', 'default1', 'default1'), ('unique_5', 'unique_9', 11, 'default1', NULL, 'default1', 'default2', 'default1', 'Dues'), ('unique_6', 'unique_14', 23, 'default1', NULL, 'default2', 'default2', 'default2', 'Dues'), ('unique_7', 'unique_4', 20, NULL, NULL, 'default2', 'Dues', 'default2', NULL), ('unique_8', 'unique_6', 21, 'default1', 'default1', NULL, 'default1', 'Dues', 'default2'), ('unique_9', 'unique_13', 7, 'default1', NULL, 'default2', 'Dues', 'default2', 'default2'), ('unique_10', 'unique_3', 10, 'default1', 'default1', 'default1', 'Dues', 'default1', 'default1'), ('unique_11', 'unique_15', 25, 'default2', 'Dues', 'Dues', NULL, 'default2', 'Dues'), ('unique_12', 'unique_4', 14, 'default1', 'Dues', 'Dues', NULL, 'default2', 'default2'), ('unique_13', 'unique_9', 11, 'default2', NULL, 'default1', 'default1', 'default2', NULL), ('unique_14', 'unique_6', 2, 'default1', 'default1', 'default2', 'default2', 'default1', 'default2'), ('unique_15', 'unique_15', 6, 'default2', 'default1', NULL, 'default1', 'default1', 'default2'), ('unique_16', 'unique_10', 11, 'Dues', NULL, 'Dues', NULL, NULL, 'default2'), ('unique_17', 'Dues', 13, 'default1', 'Dues', 'Dues', 'default1', 'default1', 'Dues'), ('unique_18', NULL, 22, 'Dues', 'Dues', 'default2', 'Dues', NULL, 'default2'), ('unique_19', 'unique_11', 10, 'default1', NULL, NULL, 'default1', 'default2', 'Dues'), ('unique_20', 'unique_14', 10, NULL, 'default2', 'default1', NULL, 'default1', 'default1'), ('unique_21', 'unique_9', 8, 'default2', 'default2', 'default2', 'default2', 'default2', NULL), ('unique_22', 'unique_6', 21, 'Dues', 'default2', NULL, 'Dues', 'default1', 'Dues'), ('unique_23', 'unique_10', 4, 'default2', 'default2', 'default2', NULL, 'default1', 'default2');
INSERT INTO income (income_id, link_to_member, date_received, amount, source, notes) VALUES ('Dues', 'unique_6', NULL, 1, 'Dues', 'default2'), ('default1', 'unique_23', NULL, NULL, NULL, 'Dues'), ('default2', 'unique_6', 'default1', 1, NULL, 'default2'), ('unique_3', 'unique_11', 'default1', 0, 'default1', 'Dues'), ('unique_4', 'unique_6', 'default1', 0, NULL, 'Dues'), ('unique_5', 'unique_4', NULL, 0, 'Dues', 'default1'), ('unique_6', 'unique_18', 'default2', 0, 'Dues', NULL), ('unique_7', 'unique_19', 'default1', 1, 'default1', NULL), ('unique_8', 'unique_17', NULL, 0, NULL, 'Dues'), ('unique_9', NULL, 'Dues', 2, 'default1', 'Dues'), ('unique_10', 'default1', NULL, 1, 'Dues', NULL), ('unique_11', 'unique_8', 'default2', NULL, 'default2', 'Dues'), ('unique_12', 'unique_15', 'default2', NULL, NULL, 'default2'), ('unique_13', 'Dues', 'default1', 1, 'default2', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.first_name, T1.last_name FROM member AS T1 INNER JOIN income AS T2 ON T1.member_id = T2.link_to_member WHERE T2.source = 'Dues' ORDER BY T2.date_received, T1.member_id NULLS LAST, T2.income_id NULLS LAST LIMIT 1;

/*
Gold Result:
(None, None)
*/

-- Prediction Query
SELECT T2.first_name, T2.last_name FROM income AS T1 INNER JOIN member AS T2 ON T1.link_to_member = T2.member_id WHERE T1.source = 'Dues' ORDER BY T1.date_received ASC, T1.income_id NULLS LAST, T2.member_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('default1', None)
*/