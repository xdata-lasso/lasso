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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (1, 'default2', 'default2', 'Member', 'Member', 'default1'), (0, 'Art and Design Department', NULL, NULL, 'default2', 'default1'), (2, 'Member', NULL, 'Member', 'Art and Design Department', NULL), (3, 'Art and Design Department', 'Member', NULL, 'Member', 'Member'), (4, 'Art and Design Department', 'Member', 'default1', 'Member', 'default2'), (5, 'Art and Design Department', 'default2', 'default1', NULL, 'default2'), (6, 'Member', NULL, 'Member', 'Art and Design Department', 'Member'), (7, 'Art and Design Department', 'Member', NULL, NULL, 'default1');
INSERT INTO major (major_id, major_name, department, college) VALUES ('Art and Design Department', 'default1', 'Art and Design Department', 'Art and Design Department'), ('default2', NULL, 'Art and Design Department', 'Member'), ('Member', 'Member', 'default1', 'default2');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('Member', 'default2', NULL, 'Art and Design Department', 'Member', 'default2', 'default2', 'default2', 'default1'), ('default2', 'Member', 1, NULL, 'Member', NULL, NULL, 'default1', 'Member'), ('Art and Design Department', 'Member', 1, 'Art and Design Department', 'default2', NULL, 'Member', 'default2', NULL), ('default1', 'default2', 4, NULL, 'Member', 'default2', 'Member', 'Art and Design Department', NULL), ('unique_4', 'Art and Design Department', NULL, 'default2', NULL, 'Art and Design Department', 'default1', 'Member', 'Art and Design Department'), ('unique_5', NULL, NULL, 'Art and Design Department', 'default2', 'Art and Design Department', 'default2', 'default1', 'Art and Design Department'), ('unique_6', NULL, 4, 'Member', 'Member', 'Art and Design Department', 'Art and Design Department', 'default2', 'Member'), ('unique_7', NULL, 6, NULL, 'Member', 'default1', 'default1', NULL, NULL), ('unique_8', 'Member', 7, 'Member', NULL, 'default1', NULL, 'default1', NULL), ('unique_9', 'Member', 6, 'default1', 'default2', 'Art and Design Department', 'Member', 'default2', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.first_name, T1.last_name FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id WHERE T2.department = 'Art and Design Department';

/*
Gold Result:
('Art and Design Department', 'Member')
(None, 'Member')
('default2', None)
*/

-- Prediction Query
SELECT T1.first_name, T1.last_name FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id WHERE T2.department = 'Art and Design Department' AND T1.position = 'Member';

/*
Prediction Result:
(None, 'Member')
*/