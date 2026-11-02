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
-- Tests duplicate retention (SELECT vs SELECT DISTINCT) and multiple qualifying expenses for the same event/budget.
-- Also tests column confusion (T3.cost vs T2.spent, T2.remaining, T2.amount).
-- Global AVG(cost) = (10 + 15 + 65) / 3 = 30.0.
INSERT INTO event (event_id, event_name) VALUES ('E1', 'Duplicate_Event');
INSERT INTO event (event_id, event_name) VALUES ('E2', 'Anchor_Event');
INSERT INTO budget (budget_id, category, spent, remaining, amount, link_to_event) VALUES ('B1', 'Parking', 500.0, 500.0, 500, 'E1');
INSERT INTO budget (budget_id, category, spent, remaining, amount, link_to_event) VALUES ('B2', 'Food', 5.0, 5.0, 5, 'E2');
INSERT INTO expense (expense_id, expense_description, cost, link_to_budget) VALUES ('X1', 'Low 1', 10.0, 'B1');
INSERT INTO expense (expense_id, expense_description, cost, link_to_budget) VALUES ('X2', 'Low 2', 15.0, 'B1');
INSERT INTO expense (expense_id, expense_description, cost, link_to_budget) VALUES ('X3', 'High Anchor', 65.0, 'B2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_name FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget WHERE T2.category = 'Parking' AND T3.cost < (SELECT AVG(cost) FROM expense);

/*
Gold Result:
('Duplicate_Event',)
('Duplicate_Event',)
*/

-- Prediction Query
SELECT e.event_name FROM budget AS b INNER JOIN event AS e ON b.link_to_event = e.event_id INNER JOIN expense AS ex ON ex.link_to_budget = b.budget_id WHERE b.category = 'Parking' GROUP BY e.event_name HAVING SUM(ex.cost) / COUNT(b.budget_id) < (SELECT AVG(cost) FROM expense WHERE category = 'Parking');

/*
Prediction Result:
('Duplicate_Event',)
*/