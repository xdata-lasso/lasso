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
INSERT INTO major (major_id, major_name, department, college) VALUES ('Katy', 'Katy', 'rec1N0upiVLy5esTO', 'default1'), ('rec1N0upiVLy5esTO', 'default1', NULL, 'rec1N0upiVLy5esTO'), ('default2', 'Katy', NULL, 'rec1N0upiVLy5esTO'), ('default1', 'default2', 'Katy', 'rec1N0upiVLy5esTO'), ('unique_4', 'default1', 'Katy', 'default2'), ('unique_5', 'Katy', 'rec1N0upiVLy5esTO', 'default2'), ('unique_6', NULL, 'Katy', 'Katy'), ('unique_7', NULL, 'Katy', 'rec1N0upiVLy5esTO'), ('unique_8', 'default2', NULL, 'default1'), ('unique_9', 'default2', 'rec1N0upiVLy5esTO', NULL), ('unique_10', NULL, NULL, 'default2');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('Katy', NULL, NULL, 'default1', 'default1', 'rec1N0upiVLy5esTO', 'default1', 'Katy', 'default2'), ('rec1N0upiVLy5esTO', NULL, NULL, 'default1', 'default2', 'default1', NULL, NULL, 'default1'), ('default1', 'unique_6', NULL, 'default1', 'Katy', 'rec1N0upiVLy5esTO', 'rec1N0upiVLy5esTO', 'default1', 'Katy'), ('default2', NULL, NULL, 'Katy', 'Katy', 'default1', 'Katy', 'default1', NULL), ('unique_4', NULL, NULL, 'rec1N0upiVLy5esTO', 'default1', 'default2', 'Katy', 'rec1N0upiVLy5esTO', NULL), ('unique_5', NULL, NULL, 'default1', 'rec1N0upiVLy5esTO', NULL, 'default1', 'Katy', 'rec1N0upiVLy5esTO'), ('unique_6', 'unique_5', NULL, NULL, 'rec1N0upiVLy5esTO', NULL, 'default1', 'rec1N0upiVLy5esTO', 'rec1N0upiVLy5esTO'), ('unique_7', 'unique_6', NULL, 'Katy', 'default1', 'default1', 'default2', 'default1', NULL), ('unique_8', 'unique_6', NULL, NULL, 'rec1N0upiVLy5esTO', 'default1', 'Katy', 'Katy', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.college FROM member AS T1 INNER JOIN major AS T2 ON T2.major_id = T1.link_to_major WHERE T1.link_to_major = 'rec1N0upiVLy5esTO' AND T1.first_name = 'Katy';

/*
Gold Result:
*/

-- Prediction Query
SELECT major.college FROM member INNER JOIN major ON member.link_to_major = major.major_id WHERE member.first_name = 'Katy';

/*
Prediction Result:
('Katy',)
*/