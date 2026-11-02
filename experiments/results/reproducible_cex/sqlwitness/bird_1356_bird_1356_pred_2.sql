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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (0, 'President', 'President', NULL, 'default2', 'default2'), (1, 'default2', 'default1', 'President', NULL, 'default2'), (2, NULL, 'default2', 'President', NULL, 'President'), (3, NULL, 'default1', 'default1', 'default2', 'President'), (4, 'President', 'President', NULL, 'default2', 'President'), (5, 'default1', 'default1', NULL, 'President', 'President'), (6, 'default1', 'default1', NULL, NULL, 'default2'), (7, NULL, NULL, 'default1', 'default1', 'President'), (8, NULL, 'default2', NULL, 'President', 'President');
INSERT INTO major (major_id, major_name, department, college) VALUES ('President', 'default2', 'default1', 'default2'), ('default1', 'default1', 'default1', 'President'), ('default2', 'default2', 'President', NULL), ('unique_3', 'President', 'default1', 'default1'), ('unique_4', 'default2', NULL, 'default2'), ('unique_5', NULL, 'default1', 'President');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('President', 'President', 1, 'default2', NULL, 'President', 'President', NULL, 'President'), ('default1', NULL, 7, 'default2', 'default2', 'default2', 'default2', NULL, 'default2'), ('default2', 'unique_4', 4, 'default2', 'President', NULL, 'default1', NULL, NULL), ('unique_3', 'unique_3', 8, 'President', 'default1', 'President', NULL, 'default2', NULL), ('unique_4', 'default1', 3, 'President', 'default1', 'President', NULL, 'default2', 'default1'), ('unique_5', 'default2', 1, 'default2', 'President', 'President', 'default2', 'default1', NULL), ('unique_6', 'unique_4', 7, 'default2', 'default1', NULL, NULL, 'President', 'default1'), ('unique_7', 'default2', NULL, 'President', 'default1', 'default2', NULL, 'default2', 'default1'), ('unique_8', 'unique_3', 3, 'default1', 'default2', 'default2', 'default2', 'default1', 'default2'), ('unique_9', 'unique_5', 3, NULL, 'President', NULL, 'default1', 'default1', 'default2'), ('unique_10', 'unique_4', NULL, 'default2', 'default2', NULL, 'default2', 'President', 'default1'), ('unique_11', NULL, 5, 'default1', 'default2', NULL, 'default1', 'default2', 'default2'), ('unique_12', 'unique_5', NULL, 'default1', 'default2', NULL, 'President', 'default1', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.department FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id WHERE T1.position = 'President';

/*
Gold Result:
('default1',)
('default1',)
*/

-- Prediction Query
SELECT DISTINCT major.department FROM member INNER JOIN major ON member.link_to_major = major.major_id WHERE member.position = 'President';

/*
Prediction Result:
('default1',)
*/