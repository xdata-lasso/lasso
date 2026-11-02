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
-- 1. LIMIT 5 boundary (7 matching rows)
-- 2. ORDER BY T2.spent DESC vs ASC, and T2.spent vs T1.cost, T2.remaining, T2.amount
-- 3. Duplicate member output (SELECT vs SELECT DISTINCT)
-- 4. Unmatched parent rows in member and budget (INNER JOIN vs LEFT/RIGHT JOIN)
-- 5. Expense rows with NULL foreign keys (INNER JOIN filtering)
-- 6. Alternative join path traps (member -> attendance -> event -> budget)
INSERT INTO event (event_id, event_name) VALUES ('E1', 'Gala');
INSERT INTO event (event_id, event_name) VALUES ('E2', 'Workshop');
INSERT INTO member (member_id, first_name, last_name) VALUES ('M1', 'Alice', 'Smith');
INSERT INTO member (member_id, first_name, last_name) VALUES ('M2', 'Bob', 'Jones');
INSERT INTO member (member_id, first_name, last_name) VALUES ('M3', 'Charlie', 'Brown');
INSERT INTO member (member_id, first_name, last_name) VALUES ('M4', 'Diana', 'Prince');
INSERT INTO member (member_id, first_name, last_name) VALUES ('M5', 'Evan', 'Wright');
INSERT INTO member (member_id, first_name, last_name) VALUES ('M6', 'Fiona', 'Gallagher');
INSERT INTO member (member_id, first_name, last_name) VALUES ('M_UNMATCHED', 'Ghost', 'Member');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M6');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E2', 'M1');
INSERT INTO income (income_id, amount, link_to_member) VALUES ('I1', 9999, 'M6');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B1', 'Food', 500.50, 10.0, 510, 'Closed', 'E1');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B2', 'Tech', 400.00, 200.0, 600, 'Open', 'E2');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B3', 'Decor', 300.25, 300.0, 600, 'Planning', 'E1');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B4', 'Venue', 200.00, 800.0, 1000, 'Approved', 'E2');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B5', 'Misc', 100.00, 900.0, 1000, 'Closed', 'E1');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B_UNMATCHED', 'Extra', 9999.99, 0.0, 10000, 'Open', 'E1');
INSERT INTO expense (expense_id, expense_description, cost, approved, link_to_member, link_to_budget) VALUES ('X1', 'Catering', 50.0, 'true', 'M1', 'B1');
INSERT INTO expense (expense_id, expense_description, cost, approved, link_to_member, link_to_budget) VALUES ('X2', 'Drinks', 60.0, 'false', 'M1', 'B1');
INSERT INTO expense (expense_id, expense_description, cost, approved, link_to_member, link_to_budget) VALUES ('X3', 'Projector', 800.0, 'true', 'M2', 'B2');
INSERT INTO expense (expense_id, expense_description, cost, approved, link_to_member, link_to_budget) VALUES ('X4', 'Balloons', 150.0, 'true', 'M3', 'B3');
INSERT INTO expense (expense_id, expense_description, cost, approved, link_to_member, link_to_budget) VALUES ('X5', 'Deposit', 900.0, 'false', 'M4', 'B4');
INSERT INTO expense (expense_id, expense_description, cost, approved, link_to_member, link_to_budget) VALUES ('X6', 'Tape', 1000.0, 'true', 'M5', 'B5');
INSERT INTO expense (expense_id, expense_description, cost, approved, link_to_member, link_to_budget) VALUES ('X7', 'Pens', 1200.0, 'true', 'M6', 'B5');
INSERT INTO expense (expense_id, expense_description, cost, approved, link_to_member, link_to_budget) VALUES ('X_NULL_B', 'Orphan Budget', 5000.0, 'true', 'M6', NULL);
INSERT INTO expense (expense_id, expense_description, cost, approved, link_to_member, link_to_budget) VALUES ('X_NULL_M', 'Orphan Member', 5000.0, 'true', NULL, 'B1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.first_name, T3.last_name FROM expense AS T1 INNER JOIN budget AS T2 ON T1.link_to_budget = T2.budget_id INNER JOIN member AS T3 ON T1.link_to_member = T3.member_id ORDER BY T2.spent DESC, T1.expense_id NULLS LAST, T2.budget_id NULLS LAST, T3.member_id NULLS LAST LIMIT 5;

/*
Gold Result:
('Alice', 'Smith')
('Alice', 'Smith')
('Bob', 'Jones')
('Charlie', 'Brown')
('Diana', 'Prince')
*/

-- Prediction Query
SELECT T1.first_name, T1.last_name FROM member AS T1 INNER JOIN expense AS T2 ON T1.member_id = T2.link_to_member ORDER BY T2.cost DESC, T1.member_id NULLS LAST, T2.expense_id NULLS LAST LIMIT 5;

/*
Prediction Result:
('Fiona', 'Gallagher')
('Fiona', 'Gallagher')
('Evan', 'Wright')
('Diana', 'Prince')
('Bob', 'Jones')
*/