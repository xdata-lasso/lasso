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
-- Tests duplicate outputs vs DISTINCT:
-- 1) One member with multiple qualifying incomes (> 40).
-- 2) Two distinct members with the exact same first_name and last_name, both having qualifying incomes.
-- 3) One member whose individual incomes are <= 40 (e.g., 25 + 25 = 50), killing mutants that erroneously GROUP BY member and use HAVING SUM(amount) > 40.
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ1', 'Mathematics', 'Math', 'Science');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (20001, 'Standard', 'Washington', 'DC', 'District of Columbia', 'DC');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M1', 'John', 'Doe', 'john1@example.com', 'Member', 'M', '222-333-4444', 20001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M2', 'John', 'Doe', 'john2@example.com', 'Member', 'L', '222-333-4445', 20001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M3', 'Jane', 'Roe', 'jane@example.com', 'Member', 'S', '222-333-4446', 20001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M4', 'Sam', 'Split', 'sam@example.com', 'Member', 'M', '222-333-4447', 20001, 'MAJ1');
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('I1', '2023-02-01', 50, 'Fundraiser', 'First qualifying for M3', 'M3');
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('I2', '2023-02-02', 60, 'Fundraiser', 'Second qualifying for M3', 'M3');
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('I3', '2023-02-03', 45, 'Dues', 'Qualifying for M1', 'M1');
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('I4', '2023-02-04', 75, 'Dues', 'Qualifying for M2', 'M2');
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('I5', '2023-02-05', 25, 'Part 1', 'Sub-threshold 1', 'M4');
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('I6', '2023-02-06', 25, 'Part 2', 'Sub-threshold 2', 'M4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.first_name, T1.last_name FROM member AS T1 INNER JOIN income AS T2 ON T1.member_id = T2.link_to_member WHERE T2.amount > 40;

/*
Gold Result:
('Jane', 'Roe')
('Jane', 'Roe')
('John', 'Doe')
('John', 'Doe')
*/

-- Prediction Query
SELECT DISTINCT member.first_name, member.last_name FROM member INNER JOIN income ON member.member_id = income.link_to_member WHERE income.amount > 40;

/*
Prediction Result:
('Jane', 'Roe')
('John', 'Doe')
*/