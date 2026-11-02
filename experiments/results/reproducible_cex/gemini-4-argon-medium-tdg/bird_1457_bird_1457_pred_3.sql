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
-- Tests:
-- 1. Omission of INNER JOIN with budget or member in EITHER the outer query OR the subquery.
-- 2. Expenses with NULL link_to_budget or NULL link_to_member that have extreme costs skewing the average if joins are omitted or changed to LEFT JOIN.
-- 3. Unreferenced members and budgets to kill mutants using RIGHT/FULL OUTER JOINs.
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E1', 'Tech Talk', '2023-06-01', 'Academic', 'Notes', 'Room 101', 'Open');
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ1', 'Mathematics', 'Math', 'Science');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (20002, 'Standard', 'Washington', 'DC', 'District of Columbia', 'DC');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B1', 'Supplies', 50.0, 50.0, 100, 'Open', 'E1');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B2', 'Unused Budget', 0.0, 100.0, 100, 'Open', 'E1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M1', 'David', 'adams', 'david@example.com', 'Member', 'M', '444-555-6666', 20002, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M2', 'Eve', 'White', 'eve@example.com', 'Secretary', 'S', '555-666-7777', 20002, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M3', 'Frank', 'Green', 'frank@example.com', 'Member', 'XL', '666-777-8888', 20002, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M4', 'Grace', 'NoExpense', 'grace@example.com', 'Member', 'L', '777-888-9999', 20002, 'MAJ1');
-- Valid joined expenses: EX1 (10.0) and EX2 (30.0) -> Inner joined AVG = 20.0. EX2 > 20.0 (Eve qualifies).
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('EX1', 'Pens', '2023-05-01', 10.0, 'true', 'M1', 'B1');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('EX2', 'Paper', '2023-05-02', 30.0, 'true', 'M2', 'B1');
-- Expense missing budget link (cost 1000.0).
-- If outer query omits budget join, M3 is erroneously returned.
-- If subquery omits budget join, AVG becomes (10+30+1000)/3 = 346.67, causing M2 (cost 30) to be excluded!
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('EX3', 'Unbudgeted Laptop', '2023-05-03', 1000.0, 'true', 'M3', NULL);
-- Expense missing member link (cost 2000.0).
-- If subquery omits member join, AVG becomes (10+30+2000)/3 = 680.0, causing M2 (cost 30) to be excluded!
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('EX4', 'Anonymous Donation', '2023-05-04', 2000.0, 'true', NULL, 'B1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.first_name, T3.last_name, T3.phone FROM expense AS T1 INNER JOIN budget AS T2 ON T1.link_to_budget = T2.budget_id INNER JOIN member AS T3 ON T3.member_id = T1.link_to_member WHERE T1.cost > (SELECT AVG(T1.cost) FROM expense AS T1 INNER JOIN budget AS T2 ON T1.link_to_budget = T2.budget_id INNER JOIN member AS T3 ON T3.member_id = T1.link_to_member);

/*
Gold Result:
('Eve', 'White', '555-666-7777')
*/

-- Prediction Query
SELECT T1.first_name, T1.last_name, T1.phone FROM member AS T1 INNER JOIN expense AS T2 ON T1.member_id = T2.link_to_member GROUP BY T1.first_name, T1.last_name, T1.phone HAVING SUM(T2.cost) > (SELECT AVG(cost) FROM expense);

/*
Prediction Result:
('Frank', 'Green', '666-777-8888')
*/