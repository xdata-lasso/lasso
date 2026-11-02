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
INSERT INTO major (major_id, major_name, department, college) VALUES ('M1', 'Computer Science', 'CS Dept', 'College of Engineering');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M2', 'Mechanical Engineering', 'ME Dept', 'College of Engineering');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M3', 'Civil Engineering', 'CE Dept', 'College of Engineering');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M4', 'College of Engineering', 'College of Engineering', 'College of Arts');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M5', 'History', 'History Dept', 'college of engineering');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M6', 'Biology', 'Bio Dept', NULL);
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (10001, 'Standard', 'New York', 'NY', 'New York', 'NY');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM1', 'Alice', 'Smith', 'alice@example.com', 'Member', 'M', '111-222-3333', 10001, 'M1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM2', 'Alice', 'Smith', 'alice2@example.com', 'Member', 'M', '111-222-3334', 10001, 'M1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM3', 'Bob', 'Jones', NULL, NULL, NULL, NULL, NULL, 'M1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM4', 'Charlie', 'Brown', 'charlie@example.com', 'President', 'L', '111-222-3335', 10001, 'M2');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM5', 'David', 'Wilson', 'david@example.com', 'Treasurer', 'S', '111-222-3336', 10001, 'M4');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM6', 'Eve', 'Davis', 'eve@example.com', 'Secretary', 'M', '111-222-3337', 10001, 'M5');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM7', 'Frank', 'Miller', 'frank@example.com', 'Member', 'XL', '111-222-3338', 10001, 'M6');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM8', 'Grace', 'Lee', 'grace@example.com', 'Member', 'S', '111-222-3339', 10001, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.member_id) FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id WHERE T2.college = 'College of Engineering';

/*
Gold Result:
(4,)
*/

-- Prediction Query
SELECT COUNT(*) FROM member AS m INNER JOIN major AS mj ON m.link_to_major = mj.major_id WHERE mj.college = 'College of Engineering' AND m.position = 'Student';

/*
Prediction Result:
(0,)
*/