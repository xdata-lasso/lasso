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
-- Tests basic inner joins, category equality ('Parking' vs others), strict inequality (< vs <=) against AVG(cost), and global AVG(cost) vs category-restricted AVG(cost).
-- Global AVG(cost) = (10 + 20 + 30) / 3 = 20.0.
INSERT INTO event (event_id, event_name) VALUES ('E1', 'Event_Match');
INSERT INTO event (event_id, event_name) VALUES ('E2', 'Event_At_Boundary');
INSERT INTO event (event_id, event_name) VALUES ('E3', 'Event_Wrong_Category');
INSERT INTO budget (budget_id, category, spent, remaining, amount, link_to_event) VALUES ('B1', 'Parking', 100.0, 100.0, 100, 'E1');
INSERT INTO budget (budget_id, category, spent, remaining, amount, link_to_event) VALUES ('B2', 'Parking', 100.0, 100.0, 100, 'E2');
INSERT INTO budget (budget_id, category, spent, remaining, amount, link_to_event) VALUES ('B3', 'Food', 100.0, 100.0, 100, 'E3');
INSERT INTO expense (expense_id, expense_description, cost, link_to_budget) VALUES ('X1', 'Valid Expense', 10.0, 'B1');
INSERT INTO expense (expense_id, expense_description, cost, link_to_budget) VALUES ('X2', 'Boundary Expense', 20.0, 'B2');
INSERT INTO expense (expense_id, expense_description, cost, link_to_budget) VALUES ('X3', 'High Non-Parking Expense', 30.0, 'B3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_name FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget WHERE T2.category = 'Parking' AND T3.cost < (SELECT AVG(cost) FROM expense);

/*
Gold Result:
('Event_Match',)
*/

-- Prediction Query
SELECT T1.event_name FROM event AS T1 JOIN budget AS T2 ON T1.event_id = T2.link_to_event WHERE T2.category = 'Parking' AND T2.spent < (SELECT AVG(spent) FROM budget WHERE category = 'Parking');

/*
Prediction Result:
*/