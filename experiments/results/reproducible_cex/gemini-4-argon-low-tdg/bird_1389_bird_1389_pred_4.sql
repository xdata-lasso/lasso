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
-- Tests basic ordering (ASC vs DESC), LIMIT 1, and differentiates T3.cost from T2.spent, T2.remaining, and T2.amount.
-- Also tests SUM(T3.cost) vs individual T3.cost.
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E1', 'Event Alpha', '2023-01-01', 'Social', 'Note 1', 'Room A', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E2', 'Event Beta', '2023-02-01', 'Meeting', 'Note 2', 'Room B', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E3', 'Event Gamma', '2023-03-01', 'Fundraiser', 'Note 3', 'Room C', 'Open');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B1', 'Food', 500.0, 500.0, 1000, 'Open', 'E1');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B2', 'Supplies', 10.0, 90.0, 100, 'Closed', 'E2');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B3', 'Advertising', 5.0, 5.0, 10, 'Open', 'E3');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('X1', 'Pizza', '2023-01-01', 15.0, 'true', NULL, 'B1');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('X2', 'Soda', '2023-01-01', 20.0, 'false', NULL, 'B1');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('X3', 'Pens', '2023-02-01', 25.0, 'true', NULL, 'B2');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('X4', 'Flyers', '2023-03-01', 100.0, 'false', NULL, 'B3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_name FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget ORDER BY T3.cost, T1.event_id NULLS LAST, T2.budget_id NULLS LAST, T3.expense_id NULLS LAST LIMIT 1;

/*
Gold Result:
('Event Alpha',)
*/

-- Prediction Query
SELECT event_name FROM event WHERE event_id = (SELECT event_id FROM expense WHERE cost = (SELECT MIN(cost) FROM expense));

/*
Prediction Result:
('Event Alpha',)
('Event Beta',)
('Event Gamma',)
*/