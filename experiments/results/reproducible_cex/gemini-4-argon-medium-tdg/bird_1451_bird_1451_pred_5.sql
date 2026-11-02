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
-- 1. HAVING COUNT(DISTINCT T4.event_id) > 1 vs COUNT(T4.event_id) > 1 vs COUNT(DISTINCT T3.budget_id) > 1 (M1 has 2 budgets for the SAME event and highest total cost, should be excluded).
-- 2. SUM(T1.cost) vs MAX(T1.cost) vs AVG(T1.cost) vs COUNT(T1.expense_id) (M2 has highest sum, M3 has highest single cost and avg, M4 has highest count).
-- 3. ORDER BY SUM(T1.cost) DESC vs ASC (M2 vs M4).
-- 4. LIMIT 1 vs no LIMIT (M2, M3, M4 all qualify for HAVING > 1).
INSERT INTO event (event_id, event_name) VALUES ('E1', 'Event 1');
INSERT INTO event (event_id, event_name) VALUES ('E2', 'Event 2');
INSERT INTO event (event_id, event_name) VALUES ('E3', 'Event 3');
INSERT INTO member (member_id, first_name) VALUES ('M1', 'Alice');
INSERT INTO member (member_id, first_name) VALUES ('M2', 'Bob');
INSERT INTO member (member_id, first_name) VALUES ('M3', 'Charlie');
INSERT INTO member (member_id, first_name) VALUES ('M4', 'David');
INSERT INTO budget (budget_id, spent, remaining, amount, link_to_event) VALUES ('B1_1', 10.0, 10.0, 20, 'E1');
INSERT INTO budget (budget_id, spent, remaining, amount, link_to_event) VALUES ('B1_2', 10.0, 10.0, 20, 'E1');
INSERT INTO budget (budget_id, spent, remaining, amount, link_to_event) VALUES ('B2_1', 500.0, 500.0, 1000, 'E2');
INSERT INTO budget (budget_id, spent, remaining, amount, link_to_event) VALUES ('B3_1', 500.0, 500.0, 1000, 'E3');
INSERT INTO expense (expense_id, cost, approved, link_to_member, link_to_budget) VALUES ('X1', 500.0, 'true', 'M1', 'B1_1');
INSERT INTO expense (expense_id, cost, approved, link_to_member, link_to_budget) VALUES ('X2', 500.0, 'true', 'M1', 'B1_2');
INSERT INTO expense (expense_id, cost, approved, link_to_member, link_to_budget) VALUES ('X3', 60.0, 'false', 'M2', 'B1_1');
INSERT INTO expense (expense_id, cost, approved, link_to_member, link_to_budget) VALUES ('X4', 60.0, 'false', 'M2', 'B2_1');
INSERT INTO expense (expense_id, cost, approved, link_to_member, link_to_budget) VALUES ('X5', 60.0, 'false', 'M2', 'B2_1');
INSERT INTO expense (expense_id, cost, approved, link_to_member, link_to_budget) VALUES ('X6', 100.0, 'true', 'M3', 'B1_1');
INSERT INTO expense (expense_id, cost, approved, link_to_member, link_to_budget) VALUES ('X7', 50.0, 'true', 'M3', 'B2_1');
INSERT INTO expense (expense_id, cost, approved, link_to_member, link_to_budget) VALUES ('X8', 10.0, 'true', 'M4', 'B1_1');
INSERT INTO expense (expense_id, cost, approved, link_to_member, link_to_budget) VALUES ('X9', 10.0, 'true', 'M4', 'B2_1');
INSERT INTO expense (expense_id, cost, approved, link_to_member, link_to_budget) VALUES ('X10', 10.0, 'true', 'M4', 'B3_1');
INSERT INTO expense (expense_id, cost, approved, link_to_member, link_to_budget) VALUES ('X11', 10.0, 'true', 'M4', 'B3_1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.member_id FROM expense AS T1 INNER JOIN member AS T2 ON T1.link_to_member = T2.member_id INNER JOIN budget AS T3 ON T1.link_to_budget = T3.budget_id INNER JOIN event AS T4 ON T3.link_to_event = T4.event_id GROUP BY T2.member_id HAVING COUNT(DISTINCT T4.event_id) > 1 ORDER BY SUM(T1.cost) DESC, T2.member_id NULLS LAST LIMIT 1;

/*
Gold Result:
('M2',)
*/

-- Prediction Query
SELECT T1.first_name, T1.last_name FROM member AS T1 INNER JOIN expense AS T2 ON T1.member_id = T2.link_to_member GROUP BY T2.link_to_member HAVING COUNT(T2.expense_id) > 1 ORDER BY SUM(T2.cost) DESC, T1.first_name NULLS LAST, T1.last_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alice', None)
*/