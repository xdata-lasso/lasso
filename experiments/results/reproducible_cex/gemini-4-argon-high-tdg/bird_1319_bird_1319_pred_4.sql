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
INSERT INTO major (major_id, major_name, department, college) VALUES ('M1', 'Computer Science', 'CS Dept', 'Engineering');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M2', 'Finance', 'Finance Dept', 'Business');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M3', 'Fine Arts', 'Art Dept', 'Arts');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M4', 'Physics', 'Physics Dept', 'Science');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M5', 'Criminal Justice', 'Legal Studies', 'Law');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M6', 'Biology', 'Bio Dept', 'Medicine');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M7', 'Curriculum', 'Teaching Dept', 'Education');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (10001, 'Standard', 'New York', 'New York', 'New York', 'NY');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM1', 'Alice', 'Smith', 'alice@example.com', 'vice president', 'M', '111-111-1111', 10001, 'M1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM2', 'Bob', 'Jones', 'bob@example.com', 'president', 'L', '222-222-2222', 10001, 'M2');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM3', 'Carol', 'White', 'carol@example.com', 'assistant vice president', 'S', '333-333-3333', 10001, 'M3');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM4', 'David', 'Brown', 'david@example.com', 'vice president of finance', 'XL', '444-444-4444', 10001, 'M4');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM5', 'Eve', 'Davis', 'eve@example.com', 'vice chair', 'M', '555-555-5555', 10001, 'M5');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM6', 'Frank', 'Miller', 'frank@example.com', NULL, 'L', '666-666-6666', 10001, 'M6');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.college FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id WHERE T1.position LIKE 'vice president';

/*
Gold Result:
('Engineering',)
*/

-- Prediction Query
SELECT DISTINCT major.college FROM member INNER JOIN major ON member.link_to_major = major.major_id WHERE member.position = 'Vice President';

/*
Prediction Result:
*/