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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (0, 'default2', NULL, 'default1', NULL, 'default2'), (1, 'President', 'President', 'default1', 'default1', NULL);
INSERT INTO major (major_id, major_name, department, college) VALUES ('default1', 'President', NULL, NULL), ('default2', 'default2', NULL, 'President'), ('President', 'President', 'default2', NULL), ('unique_3', 'default2', 'default1', 'President'), ('unique_4', 'President', 'default1', 'President'), ('unique_5', 'default1', 'President', 'default1'), ('unique_6', 'default2', NULL, 'default1'), ('unique_7', 'President', 'default2', 'default2'), ('unique_8', 'President', 'default2', 'President'), ('unique_9', NULL, NULL, 'President'), ('unique_10', NULL, 'default1', NULL), ('unique_11', 'default1', NULL, 'default2'), ('unique_12', NULL, 'default2', 'default2');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('default2', 'unique_11', 0, 'President', NULL, 'default2', 'President', 'default2', NULL), ('default1', 'unique_4', NULL, 'President', 'default2', NULL, NULL, 'default1', 'President'), ('President', 'unique_6', NULL, 'President', 'President', 'default1', 'default1', NULL, 'default2'), ('unique_3', 'unique_12', 1, 'default2', NULL, 'President', 'default2', 'default1', NULL), ('unique_4', 'unique_8', 0, 'default2', 'default1', 'President', 'President', NULL, 'default2'), ('unique_5', 'unique_11', 0, NULL, 'President', NULL, 'default2', NULL, 'President'), ('unique_6', NULL, 0, 'default2', NULL, 'default2', 'default1', 'default2', 'default1'), ('unique_7', 'unique_4', 0, 'default2', 'default2', 'default2', 'default1', 'default2', 'President'), ('unique_8', 'default2', 1, NULL, NULL, 'default2', 'default2', 'default1', 'President'), ('unique_9', NULL, NULL, 'default1', 'default1', 'President', 'default1', 'President', 'default1'), ('unique_10', 'unique_12', 1, 'default1', NULL, 'President', 'President', 'default2', NULL), ('unique_11', 'unique_9', NULL, NULL, 'President', 'President', 'President', NULL, 'default2'), ('unique_12', 'unique_6', 1, 'President', 'default1', 'President', 'default1', 'default1', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.department FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id WHERE T1.position = 'President';

/*
Gold Result:
(None,)
('default2',)
('default2',)
(None,)
*/

-- Prediction Query
SELECT DISTINCT T2.department FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id WHERE T1.position = 'President';

/*
Prediction Result:
(None,)
('default2',)
*/