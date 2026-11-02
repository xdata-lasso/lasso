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
-- Tests cost boundary conditions (> 100 vs >= 100 vs < 100), DISTINCT vs non-DISTINCT (multiple qualifying expenses for one member), and SUM(cost) > 100 vs individual cost > 100.
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ1', 'Computer Science', 'CS Dept', 'Engineering');
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ2', 'Mathematics', 'Math Dept', 'Science');
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ3', 'History', 'Hist Dept', 'Arts');
INSERT INTO member (member_id, first_name, last_name, link_to_major) VALUES ('MEM1', 'Alice', 'Smith', 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, link_to_major) VALUES ('MEM2', 'Bob', 'Jones', 'MAJ2');
INSERT INTO member (member_id, first_name, last_name, link_to_major) VALUES ('MEM3', 'Charlie', 'Brown', 'MAJ3');
INSERT INTO expense (expense_id, expense_description, cost, link_to_member) VALUES ('EXP1', 'Server', 100.01, 'MEM1');
INSERT INTO expense (expense_id, expense_description, cost, link_to_member) VALUES ('EXP2', 'Monitor', 150.00, 'MEM1');
INSERT INTO expense (expense_id, expense_description, cost, link_to_member) VALUES ('EXP3', 'Books', 100.00, 'MEM2');
INSERT INTO expense (expense_id, expense_description, cost, link_to_member) VALUES ('EXP4', 'Food 1', 60.00, 'MEM3');
INSERT INTO expense (expense_id, expense_description, cost, link_to_member) VALUES ('EXP5', 'Food 2', 60.00, 'MEM3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.first_name, T1.last_name, T2.major_name FROM member AS T1 INNER JOIN major AS T2 ON T2.major_id = T1.link_to_major INNER JOIN expense AS T3 ON T1.member_id = T3.link_to_member WHERE T3.cost > 100;

/*
Gold Result:
('Alice', 'Smith', 'Computer Science')
*/

-- Prediction Query
SELECT m.first_name, m.last_name, maj.major_name FROM member AS m JOIN expense AS e ON m.member_id = e.link_to_member JOIN major AS maj ON m.link_to_major = maj.major_id WHERE e.cost > 100;

/*
Prediction Result:
('Alice', 'Smith', 'Computer Science')
('Alice', 'Smith', 'Computer Science')
*/