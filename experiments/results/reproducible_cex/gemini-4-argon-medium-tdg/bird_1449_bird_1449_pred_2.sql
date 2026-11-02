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
-- Tests: DISTINCT keyword (member with multiple qualifying expenses), cost boundary (100, 100.01, 50, NULL), and column projection distinctions (major_name vs department/college).
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ1', 'Computer Science', 'CS Dept', 'Engineering');
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ2', 'Mathematics', 'Math Dept', 'Science');
INSERT INTO member (member_id, first_name, last_name, link_to_major) VALUES ('MEM1', 'Alice', 'Smith', 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, link_to_major) VALUES ('MEM2', 'Bob', 'Jones', 'MAJ2');
INSERT INTO member (member_id, first_name, last_name, link_to_major) VALUES ('MEM3', 'Charlie', 'Brown', 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, link_to_major) VALUES ('MEM4', 'Diana', 'Prince', 'MAJ2');
INSERT INTO expense (expense_id, expense_description, cost, approved, link_to_member) VALUES ('EXP1', 'Server', 150.0, 'true', 'MEM1');
INSERT INTO expense (expense_id, expense_description, cost, approved, link_to_member) VALUES ('EXP2', 'Monitor', 200.0, 'false', 'MEM1');
INSERT INTO expense (expense_id, expense_description, cost, approved, link_to_member) VALUES ('EXP3', 'Books', 100.0, 'true', 'MEM2');
INSERT INTO expense (expense_id, expense_description, cost, approved, link_to_member) VALUES ('EXP4', 'Pizza', 50.0, 'true', 'MEM3');
INSERT INTO expense (expense_id, expense_description, cost, approved, link_to_member) VALUES ('EXP5', 'Venue', NULL, 'true', 'MEM3');
INSERT INTO expense (expense_id, expense_description, cost, approved, link_to_member) VALUES ('EXP6', 'Catering', 100.01, 'false', 'MEM4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.first_name, T1.last_name, T2.major_name FROM member AS T1 INNER JOIN major AS T2 ON T2.major_id = T1.link_to_major INNER JOIN expense AS T3 ON T1.member_id = T3.link_to_member WHERE T3.cost > 100;

/*
Gold Result:
('Alice', 'Smith', 'Computer Science')
('Diana', 'Prince', 'Mathematics')
*/

-- Prediction Query
SELECT T1.first_name, T1.last_name, T3.major_name FROM member AS T1 INNER JOIN expense AS T2 ON T1.member_id = T2.link_to_member INNER JOIN major AS T3 ON T1.link_to_major = T3.major_id WHERE T2.cost > 100;

/*
Prediction Result:
('Alice', 'Smith', 'Computer Science')
('Alice', 'Smith', 'Computer Science')
('Diana', 'Prince', 'Mathematics')
*/