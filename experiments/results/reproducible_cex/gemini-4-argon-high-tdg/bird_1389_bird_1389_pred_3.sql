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
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E0', 'Ghost Event No Budget', '2023-01-01', 'Social', 'No budget linked', 'Lawn', 'Planning');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E1', 'Budget Only Event', '2023-02-01', 'Meeting', 'No expenses logged', 'Room 202', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E2', 'Valid Gala', '2023-03-01', 'Social', 'Has valid expense', 'Ballroom', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E3', 'Valid Mixer', '2023-04-01', 'Social', 'Higher expense', 'Patio', 'Open');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B1', 'General', 0.0, 0.0, 0, 'Open', 'E1');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B_ORPHAN', 'Misc', 1.0, 1.0, 2, 'Closed', NULL);
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B2', 'Catering', 50.0, 50.0, 100, 'Open', 'E2');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B3', 'Decorations', 80.0, 20.0, 100, 'Open', 'E3');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('X_ORPHAN_E', 'Unlinked receipt', '2023-01-05', 0.5, 'true', NULL, NULL);
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('X_ORPHAN_B', 'Orphan budget receipt', '2023-01-06', 1.0, 'true', NULL, 'B_ORPHAN');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('X2', 'Appetizers', '2023-02-25', 50.0, 'true', NULL, 'B2');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('X3', 'Banners', '2023-03-25', 80.0, 'true', NULL, 'B3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_name FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget ORDER BY T3.cost, T1.event_id NULLS LAST, T2.budget_id NULLS LAST, T3.expense_id NULLS LAST LIMIT 1;

/*
Gold Result:
('Valid Gala',)
*/

-- Prediction Query
SELECT event.event_name FROM expense INNER JOIN budget ON expense.link_to_budget = budget.budget_id INNER JOIN event ON budget.link_to_event = event.event_id WHERE expense.cost = (SELECT MIN(cost) FROM expense) ORDER BY expense.cost ASC, expense.expense_id NULLS LAST, budget.budget_id NULLS LAST, event.event_id NULLS LAST LIMIT 1;

/*
Prediction Result:
*/