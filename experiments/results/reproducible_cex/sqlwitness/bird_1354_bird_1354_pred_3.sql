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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (1, 'Vice President', 'Vice President', 'Vice President', 'Vice President', NULL), (0, 'default1', 'default1', NULL, 'Vice President', NULL), (2, 'default1', 'default2', 'default2', 'default1', 'default1'), (3, NULL, 'Vice President', 'default1', 'default2', NULL), (4, 'default1', 'default2', 'default2', NULL, 'Vice President'), (5, 'default1', 'default2', 'default2', NULL, NULL), (6, 'default1', 'default2', 'Vice President', 'default2', 'default2'), (7, 'default2', 'default1', 'default2', NULL, 'Vice President');
INSERT INTO major (major_id, major_name, department, college) VALUES ('default1', 'default1', 'default1', 'default2'), ('default2', NULL, NULL, NULL), ('Vice President', NULL, 'default2', 'Vice President'), ('unique_3', 'default1', 'default2', 'default1'), ('unique_4', 'default1', 'default2', 'default2'), ('unique_5', 'default1', NULL, 'default1'), ('unique_6', 'Vice President', 'default2', 'Vice President'), ('unique_7', 'Vice President', 'default2', 'default1'), ('unique_8', 'Vice President', 'Vice President', 'Vice President');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('default2', 'unique_4', NULL, 'Vice President', 'default2', NULL, 'default1', 'default2', 'default1'), ('Vice President', 'unique_3', 7, 'default2', 'default1', 'default1', 'default2', 'Vice President', 'default1'), ('default1', 'unique_7', 1, 'default2', NULL, 'default1', 'Vice President', 'default1', 'Vice President'), ('unique_3', 'unique_3', 6, 'default2', 'default1', 'default2', 'default1', 'default1', 'default2'), ('unique_4', 'unique_6', 5, 'default1', 'Vice President', 'default1', NULL, 'Vice President', 'Vice President'), ('unique_5', NULL, 5, 'default1', 'Vice President', NULL, 'Vice President', NULL, 'Vice President'), ('unique_6', 'default2', 5, 'Vice President', 'default2', 'default2', 'default2', 'default2', NULL), ('unique_7', 'unique_5', 1, 'default2', 'default2', 'default2', 'Vice President', NULL, 'default1'), ('unique_8', 'default2', 0, 'default2', 'default1', NULL, 'default2', 'default1', 'Vice President'), ('unique_9', 'unique_3', 5, NULL, NULL, 'default1', 'Vice President', 'default2', NULL), ('unique_10', 'unique_8', 6, NULL, 'default1', 'default2', 'default1', 'Vice President', 'Vice President'), ('unique_11', 'unique_6', 6, 'default1', 'Vice President', 'Vice President', 'default1', 'default1', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.major_name FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id WHERE T1.position = 'Vice President';

/*
Gold Result:
('Vice President',)
('default1',)
('default1',)
*/

-- Prediction Query
SELECT DISTINCT major.major_name FROM major INNER JOIN member ON major.major_id = member.link_to_major WHERE member.position = 'Vice President';

/*
Prediction Result:
('Vice President',)
('default1',)
*/