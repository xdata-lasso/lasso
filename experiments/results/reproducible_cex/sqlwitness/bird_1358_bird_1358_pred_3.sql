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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (1, 'default1', 'default2', 'default1', 'default2', 'Dues'), (2, NULL, 'Dues', 'default1', 'Dues', 'default1'), (0, NULL, 'default1', 'Dues', NULL, 'default1'), (3, NULL, 'Dues', 'Dues', NULL, 'Dues'), (4, 'Dues', 'Dues', NULL, NULL, 'Dues'), (5, 'default1', NULL, 'default1', 'Dues', 'default1'), (6, 'default1', NULL, 'Dues', NULL, 'default1'), (7, 'default1', 'default2', 'default1', 'default2', 'default2'), (8, 'default2', NULL, 'default1', 'default1', 'default1'), (9, 'Dues', 'Dues', 'default1', 'default2', 'default1'), (10, NULL, 'Dues', 'default1', NULL, 'Dues'), (11, 'default2', 'default2', 'default2', 'Dues', 'default2'), (12, NULL, 'default1', NULL, 'Dues', 'Dues'), (13, 'default2', 'default2', 'default2', 'Dues', NULL), (14, NULL, 'default1', NULL, 'default2', NULL), (15, 'Dues', 'Dues', NULL, 'default1', 'default2');
INSERT INTO major (major_id, major_name, department, college) VALUES ('default1', 'default1', 'default1', 'default1'), ('Dues', NULL, 'default2', 'Dues'), ('default2', 'Dues', 'default1', NULL), ('unique_3', 'default2', 'Dues', 'default1'), ('unique_4', 'Dues', NULL, NULL), ('unique_5', 'Dues', NULL, 'default2'), ('unique_6', 'Dues', 'default2', NULL), ('unique_7', 'Dues', NULL, 'Dues'), ('unique_8', 'default2', 'default1', 'default1'), ('unique_9', 'default2', NULL, 'default2'), ('unique_10', 'Dues', 'Dues', 'default2'), ('unique_11', 'Dues', 'Dues', 'Dues'), ('unique_12', 'Dues', NULL, NULL), ('unique_13', 'default2', 'default1', 'default2'), ('unique_14', 'default1', 'default1', 'Dues'), ('unique_15', 'default1', 'Dues', 'Dues');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('default2', 'unique_10', 10, 'default2', 'Dues', 'default2', 'Dues', 'default1', 'Dues'), ('Dues', 'unique_6', 9, NULL, 'default2', 'default1', 'default2', NULL, 'Dues'), ('default1', 'unique_14', 2, 'default1', 'default1', 'Dues', 'default2', NULL, 'default2'), ('unique_3', 'unique_10', 14, 'Dues', 'default2', 'default1', 'default2', 'Dues', 'default2'), ('unique_4', 'unique_9', 11, 'Dues', 'default1', NULL, 'default2', NULL, 'default1'), ('unique_5', 'unique_3', 8, 'Dues', NULL, 'default2', 'Dues', 'default2', NULL), ('unique_6', 'unique_5', 13, 'default1', 'default1', 'default2', 'default1', 'default2', 'Dues'), ('unique_7', 'unique_5', 2, 'Dues', 'default1', NULL, 'Dues', NULL, 'default1'), ('unique_8', 'unique_10', 14, NULL, 'default2', 'default1', 'default2', 'Dues', 'Dues'), ('unique_9', 'unique_15', 7, NULL, NULL, NULL, 'Dues', NULL, 'Dues'), ('unique_10', 'unique_13', 5, 'default1', 'default2', 'Dues', 'default1', 'default2', 'default1'), ('unique_11', 'unique_11', 11, 'default1', NULL, 'default2', 'default2', NULL, 'Dues'), ('unique_12', 'unique_7', 10, 'default1', 'default2', 'Dues', 'Dues', 'default2', NULL), ('unique_13', 'default2', 15, 'default1', 'default2', 'default2', 'default2', 'default2', 'default2');
INSERT INTO income (income_id, link_to_member, date_received, amount, source, notes) VALUES ('default1', 'unique_8', 'Dues', NULL, NULL, NULL), ('default2', 'unique_11', 'Dues', 1, 'Dues', 'Dues'), ('Dues', 'unique_12', 'Dues', 0, 'Dues', 'Dues'), ('unique_3', 'unique_5', NULL, NULL, NULL, NULL), ('unique_4', 'unique_4', 'Dues', 1, NULL, 'Dues'), ('unique_5', 'Dues', 'Dues', NULL, 'default1', 'default1'), ('unique_6', NULL, 'default1', NULL, 'default2', 'default2'), ('unique_7', NULL, 'default2', 0, 'Dues', 'default2'), ('unique_8', 'unique_8', 'default1', 0, NULL, 'Dues'), ('unique_9', 'default2', NULL, 2, NULL, 'Dues'), ('unique_10', 'Dues', 'default2', 2, 'default1', 'default1'), ('unique_11', 'Dues', 'default2', 1, 'default2', 'default2'), ('unique_12', 'unique_7', 'default1', 1, 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.first_name, T1.last_name FROM member AS T1 INNER JOIN income AS T2 ON T1.member_id = T2.link_to_member WHERE T2.source = 'Dues' ORDER BY T2.date_received, T1.member_id NULLS LAST, T2.income_id NULLS LAST LIMIT 1;

/*
Gold Result:
('default1', None)
*/

-- Prediction Query
SELECT m.first_name, m.last_name FROM income AS i JOIN member AS m ON i.link_to_member = m.member_id WHERE i.source = 'Dues' ORDER BY i.date_received, i.income_id NULLS LAST, m.member_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('default1', 'default2')
*/