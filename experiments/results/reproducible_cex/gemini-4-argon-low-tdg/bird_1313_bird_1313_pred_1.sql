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
-- Tests:
-- 1. Multiple members in the SAME major (kills COUNT(DISTINCT major_id) or counting majors instead of members).
-- 2. Multiple majors in 'College of Engineering' (kills queries limiting to 1 major).
-- 3. A major in 'College of Engineering' with 0 members (kills RIGHT/LEFT JOINs counting majors or COUNT(*)).
-- 4. Members in other colleges or where 'College of Engineering' is placed in department/major_name (kills wrong column filters or missing WHERE clause).
-- 5. Member with NULL link_to_major (kills LEFT JOIN member ON major where COUNT(*) is used).
-- 6. Member with NULL in non-key columns like first_name, zip, etc. (kills COUNT(first_name) or INNER JOIN zip_code).
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (10001, 'STANDARD', 'New York', 'New York', 'New York', 'NY');
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ1', 'Computer Science', 'CS Dept', 'College of Engineering');
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ2', 'Electrical Engineering', 'EE Dept', 'College of Engineering');
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ3', 'Mechanical Engineering', 'ME Dept', 'College of Engineering');
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ4', 'College of Engineering', 'College of Engineering', 'College of Arts');
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ5', 'Biology', 'Bio Dept', NULL);
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM1', 'Alice', 'Smith', 'alice@example.com', 'Member', 'M', '111-222-3333', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM2', 'Alice', 'Smith', 'alice@example.com', 'Member', 'M', '111-222-3333', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'MAJ2');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM4', 'Bob', 'Jones', 'bob@example.com', 'President', 'L', '444-555-6666', 10001, 'MAJ4');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM5', 'Charlie', 'Brown', 'charlie@example.com', 'Treasurer', 'S', '777-888-9999', 10001, 'MAJ5');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM6', 'David', 'Wilson', 'david@example.com', 'Secretary', 'XL', '000-111-2222', 10001, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.member_id) FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id WHERE T2.college = 'College of Engineering';

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM member AS m INNER JOIN major AS mj ON m.link_to_major = mj.major_id WHERE mj.college = 'College of Engineering' AND m.position = 'Student';

/*
Prediction Result:
(0,)
*/