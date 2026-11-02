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
-- DATASET 2
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ1', 'Biology', 'Bio Dept', 'Science');
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ2', 'Chemistry', 'Chem Dept', 'Science');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (20001, 'Standard', 'Washington', 'DC', 'District of Columbia', 'DC');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('EVT1', 'Symposium', '2023-02-01', 'Conference', 'Annual', 'Hall A', 'Open');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('BDG1', 'Supplies', 800.0, 200.0, 1000, 'Open', 'EVT1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM1', 'John', 'Doe', 'john1@example.com', 'Member', 'M', '101-0001', 20001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM2', 'Jane', 'Roe', 'jane1@example.com', 'Member', 'S', '101-0002', 20001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM3', 'Jane', 'Roe', 'jane2@example.com', 'Officer', 'L', '101-0003', 20001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM4', 'John', 'Doe', 'john2@example.com', 'Member', 'L', '101-0004', 20001, 'MAJ2');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM5', 'John', 'Adams', 'john3@example.com', 'Member', 'M', '101-0005', 20001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM6', 'Mary', 'Doe', 'mary1@example.com', 'Member', 'S', '101-0006', 20001, 'MAJ1');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('EXP1', 'Lab Gear 1', '2023-02-02', 120.0, 'true', 'MEM1', 'BDG1');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('EXP2', 'Lab Gear 2', '2023-02-03', 180.0, 'true', 'MEM1', 'BDG1');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('EXP3', 'Poster', '2023-02-04', 150.0, 'true', 'MEM2', 'BDG1');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('EXP4', 'Banner', '2023-02-05', 160.0, 'true', 'MEM3', 'BDG1');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('EXP5', 'Beakers', '2023-02-06', 140.0, 'true', 'MEM4', 'BDG1');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('EXP6', 'Slides', '2023-02-07', 130.0, 'true', 'MEM5', 'BDG1');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('EXP7', 'Gloves', '2023-02-08', 170.0, 'true', 'MEM6', 'BDG1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.first_name, T1.last_name, T2.major_name FROM member AS T1 INNER JOIN major AS T2 ON T2.major_id = T1.link_to_major INNER JOIN expense AS T3 ON T1.member_id = T3.link_to_member WHERE T3.cost > 100;

/*
Gold Result:
('John', 'Doe', 'Biology')
('Jane', 'Roe', 'Biology')
('John', 'Doe', 'Chemistry')
('John', 'Adams', 'Biology')
('Mary', 'Doe', 'Biology')
*/

-- Prediction Query
SELECT m.first_name, m.last_name, maj.major_name FROM member AS m JOIN expense AS e ON m.member_id = e.link_to_member JOIN major AS maj ON m.link_to_major = maj.major_id WHERE e.cost > 100;

/*
Prediction Result:
('John', 'Doe', 'Biology')
('John', 'Doe', 'Biology')
('Jane', 'Roe', 'Biology')
('Jane', 'Roe', 'Biology')
('John', 'Doe', 'Chemistry')
('John', 'Adams', 'Biology')
('Mary', 'Doe', 'Biology')
*/