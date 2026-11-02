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
-- Tests COUNT(DISTINCT event_id) > 1 vs COUNT(event_id) > 1 or COUNT(budget_id) > 1, and SUM(cost) vs MAX/AVG(cost) or budget.spent
INSERT INTO event (event_id, event_name) VALUES ('E1', 'Event 1');
INSERT INTO event (event_id, event_name) VALUES ('E2', 'Event 2');
INSERT INTO event (event_id, event_name) VALUES ('E3', 'Event 3');
INSERT INTO member (member_id, first_name) VALUES ('M1', 'Alice');
INSERT INTO member (member_id, first_name) VALUES ('M2', 'Bob');
INSERT INTO member (member_id, first_name) VALUES ('M3', 'Charlie');
INSERT INTO budget (budget_id, spent, amount, link_to_event) VALUES ('B1', 10.0, 50, 'E1');
INSERT INTO budget (budget_id, spent, amount, link_to_event) VALUES ('B2', 10.0, 50, 'E1');
INSERT INTO budget (budget_id, spent, amount, link_to_event) VALUES ('B3', 500.0, 1000, 'E2');
INSERT INTO budget (budget_id, spent, amount, link_to_event) VALUES ('B4', 500.0, 1000, 'E3');
-- M1: 2 expenses, 2 budgets, but ONLY 1 distinct event (E1). Highest total cost (1000). Should be filtered out by HAVING.
INSERT INTO expense (expense_id, cost, link_to_member, link_to_budget) VALUES ('EX1', 500.0, 'M1', 'B1');
INSERT INTO expense (expense_id, cost, link_to_member, link_to_budget) VALUES ('EX2', 500.0, 'M1', 'B2');
-- M2: 3 expenses across 2 distinct events (E1, E2). Total cost = 350. Max cost = 150, Avg = 116.67. (Winner for SUM)
INSERT INTO expense (expense_id, cost, link_to_member, link_to_budget) VALUES ('EX3', 100.0, 'M2', 'B1');
INSERT INTO expense (expense_id, cost, link_to_member, link_to_budget) VALUES ('EX4', 100.0, 'M2', 'B1');
INSERT INTO expense (expense_id, cost, link_to_member, link_to_budget) VALUES ('EX5', 150.0, 'M2', 'B3');
-- M3: 2 expenses across 2 distinct events (E2, E3). Total cost = 300. Max cost = 250, Avg = 150. (Loser for SUM, Winner for MAX/AVG/budget.spent)
INSERT INTO expense (expense_id, cost, link_to_member, link_to_budget) VALUES ('EX6', 250.0, 'M3', 'B3');
INSERT INTO expense (expense_id, cost, link_to_member, link_to_budget) VALUES ('EX7', 50.0, 'M3', 'B4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.member_id FROM expense AS T1 INNER JOIN member AS T2 ON T1.link_to_member = T2.member_id INNER JOIN budget AS T3 ON T1.link_to_budget = T3.budget_id INNER JOIN event AS T4 ON T3.link_to_event = T4.event_id GROUP BY T2.member_id HAVING COUNT(DISTINCT T4.event_id) > 1 ORDER BY SUM(T1.cost) DESC, T2.member_id NULLS LAST LIMIT 1;

/*
Gold Result:
('M2',)
*/

-- Prediction Query
SELECT m.first_name, m.last_name, SUM(CAST(e.cost AS REAL)) AS total_cost FROM member AS m JOIN expense AS e ON m.member_id = e.link_to_member GROUP BY m.member_id HAVING COUNT(DISTINCT e.link_to_budget) > 1 ORDER BY total_cost DESC, m.first_name NULLS LAST, m.last_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alice', None, 1000.0)
*/