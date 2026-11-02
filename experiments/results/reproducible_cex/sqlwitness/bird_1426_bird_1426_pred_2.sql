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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (1, NULL, 'Member', 'default1', 'Environmental Engineering', 'Member'), (0, 'Member', 'Environmental Engineering', 'Member', NULL, NULL), (2, 'Environmental Engineering', 'default1', 'Member', 'default1', NULL), (3, 'Environmental Engineering', 'default2', 'default1', NULL, 'default1'), (4, 'default2', 'Environmental Engineering', 'Member', 'default2', 'Member'), (5, 'default1', 'default2', NULL, 'default1', 'Environmental Engineering'), (6, NULL, 'default2', 'default2', 'Environmental Engineering', 'default2'), (7, 'default2', 'default1', 'Member', 'Environmental Engineering', 'default2'), (8, 'Member', 'Environmental Engineering', 'default1', 'Environmental Engineering', NULL), (9, 'Environmental Engineering', 'Member', 'Environmental Engineering', 'default2', 'default1'), (10, 'default2', 'default2', 'default2', 'default1', 'Environmental Engineering'), (11, 'Environmental Engineering', 'Member', 'default1', 'default1', 'Environmental Engineering'), (12, 'Member', 'Environmental Engineering', 'default2', 'Member', NULL), (13, 'Environmental Engineering', 'default2', 'default2', NULL, NULL), (14, 'default2', 'default1', 'default1', 'Member', NULL), (15, 'default2', 'default2', 'default2', NULL, 'default1');
INSERT INTO major (major_id, major_name, department, college) VALUES ('Environmental Engineering', 'Environmental Engineering', NULL, 'Environmental Engineering'), ('Member', 'default1', NULL, 'Member'), ('default2', 'Member', 'Member', NULL), ('default1', 'default1', 'Member', NULL), ('unique_4', NULL, NULL, 'Member'), ('unique_5', 'default2', 'Environmental Engineering', 'Environmental Engineering'), ('unique_6', 'Member', 'default2', 'Member'), ('unique_7', NULL, 'default1', 'Environmental Engineering'), ('unique_8', 'Environmental Engineering', NULL, 'Member'), ('unique_9', NULL, 'default2', NULL), ('unique_10', 'Environmental Engineering', 'default1', 'Member'), ('unique_11', NULL, 'default1', NULL), ('unique_12', NULL, 'Member', 'default1'), ('unique_13', 'Environmental Engineering', 'Environmental Engineering', 'Environmental Engineering');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('Environmental Engineering', 'unique_13', 10, NULL, 'Member', 'Member', 'Environmental Engineering', 'default1', 'Environmental Engineering'), ('Member', 'unique_6', 5, 'Environmental Engineering', 'Member', 'default1', 'Environmental Engineering', NULL, 'Environmental Engineering'), ('default1', 'default1', 14, 'default2', 'default1', 'Environmental Engineering', 'Member', 'Environmental Engineering', 'default2'), ('default2', 'unique_12', 5, 'Environmental Engineering', 'Environmental Engineering', 'default2', 'Member', 'default1', 'default1'), ('unique_4', 'unique_6', NULL, 'Environmental Engineering', 'Member', 'Member', 'default2', 'default1', 'Member'), ('unique_5', NULL, 0, 'Environmental Engineering', 'default2', NULL, 'Environmental Engineering', 'default1', 'default1'), ('unique_6', 'unique_12', 0, 'Environmental Engineering', 'Environmental Engineering', 'Environmental Engineering', 'Member', 'Environmental Engineering', 'Member'), ('unique_7', 'unique_9', 10, 'Member', NULL, NULL, 'Member', 'default1', 'default2'), ('unique_8', 'Member', 15, 'Environmental Engineering', 'Environmental Engineering', 'Member', 'default1', 'Environmental Engineering', 'Member'), ('unique_9', 'unique_8', NULL, NULL, 'default1', NULL, 'default2', NULL, 'Member'), ('unique_10', 'unique_13', 4, 'Environmental Engineering', 'Environmental Engineering', NULL, 'Environmental Engineering', 'default2', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.last_name, T1.department, T1.college FROM major AS T1 INNER JOIN member AS T2 ON T1.major_id = T2.link_to_major WHERE T2.position = 'Member' AND T1.major_name = 'Environmental Engineering';

/*
Gold Result:
*/

-- Prediction Query
SELECT m.last_name, maj.department, maj.college FROM member AS m JOIN major AS maj ON m.link_to_major = maj.major_id WHERE maj.major_name = 'Environmental Engineering';

/*
Prediction Result:
('Member', 'Environmental Engineering', 'Environmental Engineering')
('default1', None, 'Member')
('Environmental Engineering', 'Environmental Engineering', 'Environmental Engineering')
*/