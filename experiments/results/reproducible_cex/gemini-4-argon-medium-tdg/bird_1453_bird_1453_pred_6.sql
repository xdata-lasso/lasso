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
-- DATASET 4
-- Tests floating-point precision in AVG(cost) vs integer division, and case-sensitivity / substring matching on 'Parking'.
-- Global AVG(cost) = (10 + 10 + 11) / 3 = 10.3333... (Integer division would yield 10).
-- X1 has cost 10.2, which is < 10.3333... but > 10.
INSERT INTO event (event_id, event_name, type) VALUES ('E1', 'Precision_Event', 'Parking');
INSERT INTO event (event_id, event_name, type) VALUES ('E2', 'Case_Mismatch_Event', 'Parking');
INSERT INTO event (event_id, event_name, type) VALUES ('E3', 'Substring_Mismatch_Event', 'Parking');
INSERT INTO budget (budget_id, category, link_to_event) VALUES ('B1', 'Parking', 'E1');
INSERT INTO budget (budget_id, category, link_to_event) VALUES ('B2', 'parking', 'E2');
INSERT INTO budget (budget_id, category, link_to_event) VALUES ('B3', 'Parking Lot', 'E3');
INSERT INTO expense (expense_id, expense_description, cost, link_to_budget) VALUES ('X1', 'Float Test', 10.2, 'B1');
INSERT INTO expense (expense_id, expense_description, cost, link_to_budget) VALUES ('X2', 'Case Test', 9.9, 'B2');
INSERT INTO expense (expense_id, expense_description, cost, link_to_budget) VALUES ('X3', 'Substring Test', 10.9, 'B3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_name FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget WHERE T2.category = 'Parking' AND T3.cost < (SELECT AVG(cost) FROM expense);

/*
Gold Result:
('Precision_Event',)
*/

-- Prediction Query
SELECT event.event_name FROM expense INNER JOIN budget ON expense.link_to_budget = budget.budget_id INNER JOIN event ON budget.link_to_event = event.event_id WHERE expense.cost < (SELECT AVG(cost) FROM expense);

/*
Prediction Result:
('Precision_Event',)
('Case_Mismatch_Event',)
*/