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
-- Tests duplicate rows (SELECT vs SELECT DISTINCT), inner join vs left join (dangling references/NULLs), and column confusion (budget.spent vs expense.cost, budget.category vs expense.expense_description, event.event_date vs expense.expense_date).
INSERT INTO major (major_id, major_name, department, college) VALUES ('M1', 'CS', 'Eng', 'Tech');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (10001, 'Standard', 'NY', 'NY', 'New York', 'NY');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM1', 'Jane', 'Doe', 'jane@d.com', 'President', 'M', '456', 10001, 'M1');
-- E1 has two valid expenses across two budgets (tests DISTINCT vs ALL and date confusion)
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E1', 'Duplicate Test Event', '2023-05-01', 'Meeting', 'Notes', 'Room 1', 'Closed');
-- E2 has budget.category='Pizza' and budget.spent=75, but expense is 'Soda' and cost=20 (tests column confusion)
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E2', 'Column Trap Event', '2023-06-01', 'Pizza', 'Pizza', 'Room 2', 'Open');
-- E3 has no budget (tests LEFT JOIN mutants)
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E3', 'No Budget Event', '2023-07-01', 'Social', 'Notes', 'Room 3', 'Open');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B1', 'General', 200.0, 10.0, 210, 'Closed', 'E1');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B2', 'Food', 10.0, 90.0, 100, 'Closed', 'E1');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B3', 'Pizza', 75.0, 75.0, 75, 'Open', 'E2');
-- B4 has NULL link_to_event (tests join condition)
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B4', 'Food', 75.0, 25.0, 100, 'Open', NULL);
-- Two valid expenses for E1
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('X1', 'Pizza', '2023-05-02', 60.0, 'No', 'MEM1', 'B1');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('X2', 'Pizza', '2023-05-03', 99.99, 'Yes', 'MEM1', 'B2');
-- Invalid expense for E2 (traps queries checking budget columns instead of expense columns)
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('X3', 'Drinks', '2023-06-01', 20.0, 'Yes', 'MEM1', 'B3');
-- Valid expense linked to B4 which has no event
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('X4', 'Pizza', '2023-08-01', 75.0, 'Yes', 'MEM1', 'B4');
-- Valid expense with NULL link_to_budget
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('X5', 'Pizza', '2023-08-02', 75.0, 'Yes', 'MEM1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_name, T1.event_date FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget WHERE T3.expense_description = 'Pizza' AND T3.cost > 50 AND T3.cost < 100;

/*
Gold Result:
('Duplicate Test Event', '2023-05-01')
('Duplicate Test Event', '2023-05-01')
*/

-- Prediction Query
SELECT DISTINCT e.event_name, e.event_date FROM event AS e INNER JOIN budget AS b ON e.event_id = b.link_to_event INNER JOIN expense AS ex ON b.budget_id = ex.link_to_budget WHERE ex.expense_description = 'Pizza' AND ex.cost > 50 AND ex.cost < 100;

/*
Prediction Result:
('Duplicate Test Event', '2023-05-01')
*/