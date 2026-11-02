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
-- Tests basic ordering by T1.remaining ASC, ensuring T1.remaining is chosen over T1.spent, T1.amount, and T2.cost, and that INNER JOIN filters out budgets with no expenses.
INSERT INTO "budget" (budget_id, category, spent, remaining, amount) VALUES ('B_NO_EXP', 'Food', 0.0, 1.0, 100);
INSERT INTO "budget" (budget_id, category, spent, remaining, amount) VALUES ('B1', 'Travel', 500.0, 10.0, 1000);
INSERT INTO "budget" (budget_id, category, spent, remaining, amount) VALUES ('B2', 'Supplies', 5.0, 20.0, 50);
INSERT INTO "expense" (expense_id, expense_description, cost, approved, link_to_budget) VALUES ('E_ORPHAN', 'Orphan Expense', 1.0, 'true', NULL);
INSERT INTO "expense" (expense_id, expense_description, cost, approved, link_to_budget) VALUES ('E1', 'Target Min Remaining', 500.0, 'false', 'B1');
INSERT INTO "expense" (expense_id, expense_description, cost, approved, link_to_budget) VALUES ('E2', 'Min Cost And Spent', 5.0, 'true', 'B2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.expense_description FROM budget AS T1 INNER JOIN expense AS T2 ON T1.budget_id = T2.link_to_budget ORDER BY T1.remaining, T1.budget_id NULLS LAST, T2.expense_id NULLS LAST LIMIT 1;

/*
Gold Result:
('Target Min Remaining',)
*/

-- Prediction Query
SELECT e.expense_description FROM expense AS e INNER JOIN budget AS b ON e.link_to_budget = b.budget_id WHERE b.budget_id = (SELECT budget_id FROM budget ORDER BY remaining ASC, budget.budget_id NULLS LAST LIMIT 1);

/*
Prediction Result:
*/