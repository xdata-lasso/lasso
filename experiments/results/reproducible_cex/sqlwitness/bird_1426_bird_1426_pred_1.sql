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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (1, NULL, 'default2', 'Member', 'default1', NULL), (0, NULL, 'default1', 'Member', 'default1', NULL);
INSERT INTO major (major_id, major_name, department, college) VALUES ('default1', NULL, 'default2', 'default1'), ('default2', 'default2', 'default1', NULL), ('Member', 'default2', 'default2', 'default1'), ('Environmental Engineering', 'default1', 'default2', 'default2'), ('unique_4', 'Environmental Engineering', 'Environmental Engineering', 'Environmental Engineering'), ('unique_5', 'Member', 'Member', 'Member'), ('unique_6', 'default2', 'Member', 'default1'), ('unique_7', 'Member', 'default1', 'Member');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('default2', 'default1', 0, NULL, 'Environmental Engineering', 'default1', 'Environmental Engineering', 'default2', NULL), ('Environmental Engineering', 'Member', 1, NULL, 'default2', 'Member', 'default2', NULL, NULL), ('Member', 'unique_4', NULL, 'Environmental Engineering', 'default2', 'Member', 'default2', NULL, 'Environmental Engineering'), ('default1', 'unique_5', 1, 'default1', 'Member', NULL, NULL, 'default2', 'default1'), ('unique_4', 'unique_7', 1, 'default2', 'default1', 'default1', 'Member', 'Member', 'default1'), ('unique_5', 'unique_5', 1, 'default2', 'Member', 'default2', NULL, NULL, NULL), ('unique_6', 'unique_6', 1, 'default1', 'default2', 'Environmental Engineering', NULL, 'default2', 'default2'), ('unique_7', 'Environmental Engineering', 0, 'default1', 'default1', 'default1', 'Environmental Engineering', NULL, NULL), ('unique_8', 'unique_6', NULL, 'default2', NULL, 'Environmental Engineering', 'default1', 'Environmental Engineering', 'Member'), ('unique_9', 'default2', 1, 'default2', NULL, NULL, NULL, NULL, 'default1'), ('unique_10', 'unique_6', NULL, 'Environmental Engineering', 'default1', 'default2', 'default2', NULL, NULL), ('unique_11', 'default2', 0, 'Environmental Engineering', 'default2', 'default2', NULL, 'default2', 'Member');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.last_name, T1.department, T1.college FROM major AS T1 INNER JOIN member AS T2 ON T1.major_id = T2.link_to_major WHERE T2.position = 'Member' AND T1.major_name = 'Environmental Engineering';

/*
Gold Result:
*/

-- Prediction Query
SELECT member.last_name, major.department, major.college FROM member INNER JOIN major ON member.link_to_major = major.major_id WHERE major.major_name = 'Environmental Engineering';

/*
Prediction Result:
('default2', 'Environmental Engineering', 'Environmental Engineering')
*/