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
-- DATASET 1
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (84321, 'Standard', 'Logan', 'Cache', 'Utah', 'UT');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M1', 'Technology Systems', 'School of Applied Sciences, Technology and Education', 'College of Agriculture and Applied Sciences');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M2', 'Agricultural Education', 'School of Applied Sciences, Technology and Education', 'College of Agriculture and Applied Sciences');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M3', 'Computer Science', 'Department of Computer Science', 'College of Science');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M4', 'School of Applied Sciences, Technology and Education', 'Other Department', 'School of Applied Sciences, Technology and Education');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M5', 'Unenrolled Major', 'School of Applied Sciences, Technology and Education', 'College of Agriculture and Applied Sciences');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM1', 'Alice', 'Smith', 'alice@example.com', 'Member', 'M', '111-222-3333', 84321, 'M1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM2', 'Alice', 'Smith', 'alice2@example.com', 'President', 'L', '111-222-3334', 84321, 'M2');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM3', 'Bob', 'Jones', 'bob@example.com', 'Member', 'S', '111-222-3335', 84321, 'M3');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM4', 'Charlie', 'Brown', 'charlie@example.com', 'Member', 'XL', '111-222-3336', 84321, 'M4');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM5', 'David', 'Wilson', 'david@example.com', 'Secretary', 'M', '111-222-3337', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.first_name, T1.last_name FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id WHERE T2.department = 'School of Applied Sciences, Technology and Education';

/*
Gold Result:
('Alice', 'Smith')
('Alice', 'Smith')
*/

-- Prediction Query
SELECT DISTINCT t1.first_name, t1.last_name FROM member AS t1 INNER JOIN major AS t2 ON t1.link_to_major = t2.major_id WHERE t2.department = 'School of Applied Sciences, Technology and Education';

/*
Prediction Result:
('Alice', 'Smith')
*/