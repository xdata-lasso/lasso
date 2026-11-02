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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (2, 'default1', 'Dues', NULL, 'default2', 'default2'), (0, 'default1', 'default2', NULL, 'default2', 'Dues'), (1, 'Dues', 'default2', 'default2', 'default1', 'default1'), (3, NULL, 'Dues', 'default1', 'Dues', NULL), (4, 'Dues', 'default1', 'default1', NULL, 'Dues'), (5, 'Dues', 'Dues', 'Dues', NULL, 'Dues'), (6, 'Dues', NULL, 'default1', 'Dues', 'default1');
INSERT INTO major (major_id, major_name, department, college) VALUES ('default2', 'default1', 'default2', 'default1'), ('Dues', 'default2', 'Dues', NULL), ('default1', 'default2', 'default2', 'default2'), ('unique_3', NULL, NULL, NULL), ('unique_4', 'Dues', NULL, 'Dues'), ('unique_5', 'Dues', NULL, 'default2'), ('unique_6', NULL, 'default1', 'Dues'), ('unique_7', 'default2', 'default1', 'default1');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('default2', 'Dues', 3, NULL, 'Dues', 'Dues', 'default1', 'default1', 'Dues'), ('Dues', 'unique_5', 0, 'default2', 'default2', NULL, 'default2', 'Dues', 'default1'), ('default1', 'unique_6', 3, NULL, 'default2', NULL, 'default1', NULL, 'default2'), ('unique_3', 'unique_3', 2, NULL, 'default1', 'Dues', NULL, 'default1', 'default2');
INSERT INTO income (income_id, link_to_member, date_received, amount, source, notes) VALUES ('default1', 'unique_3', 'default1', 2, NULL, 'default1'), ('Dues', 'Dues', NULL, 1, 'Dues', 'default2'), ('default2', NULL, 'default2', 2, 'default2', 'default2'), ('unique_3', NULL, NULL, NULL, 'default1', NULL), ('unique_4', NULL, 'Dues', 1, 'default2', 'default2'), ('unique_5', 'unique_3', 'default2', 1, 'default2', 'default1'), ('unique_6', 'default1', 'default2', NULL, 'default2', 'default2'), ('unique_7', NULL, 'default1', NULL, 'Dues', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.first_name, T1.last_name FROM member AS T1 INNER JOIN income AS T2 ON T1.member_id = T2.link_to_member WHERE T2.source = 'Dues' ORDER BY T2.date_received, T1.member_id NULLS LAST, T2.income_id NULLS LAST LIMIT 1;

/*
Gold Result:
('default2', 'default2')
*/

-- Prediction Query
SELECT m.first_name, m.last_name FROM income AS i INNER JOIN member AS m ON i.link_to_member = m.member_id WHERE i.source = 'Dues' AND i.date_received = (SELECT MIN(date_received) FROM income WHERE source = 'Dues') LIMIT 1;

/*
Prediction Result:
*/