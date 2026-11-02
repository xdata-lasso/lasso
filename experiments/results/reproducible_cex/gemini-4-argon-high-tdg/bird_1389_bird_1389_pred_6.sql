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
-- DATASET 3
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E1', 'Zebra Conference', '2023-06-01', 'Conference', 'First by ID', 'Hall Z', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E2', 'Alpha Conference', '2023-06-02', 'Conference', 'First by Name', 'Hall A', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E3', 'Middle Conference', '2023-06-03', 'Conference', 'Higher cost', 'Hall M', 'Open');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B9', 'Printing', 15.0, 85.0, 100, 'Open', 'E1');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B1', 'Printing', 15.0, 85.0, 100, 'Open', 'E2');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B5', 'Printing', 40.0, 60.0, 100, 'Open', 'E3');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('X9', 'Flyers E1', '2023-05-20', 15.0, 'true', NULL, 'B9');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('X1', 'Flyers E2', '2023-05-20', 15.0, 'true', NULL, 'B1');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('X5', 'Posters E3', '2023-05-21', 40.0, 'true', NULL, 'B5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_name FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget ORDER BY T3.cost, T1.event_id NULLS LAST, T2.budget_id NULLS LAST, T3.expense_id NULLS LAST LIMIT 1;

/*
Gold Result:
('Zebra Conference',)
*/

-- Prediction Query
SELECT e.event_name FROM event AS e JOIN budget AS b ON e.event_id = b.link_to_event JOIN expense AS ex ON b.budget_id = ex.link_to_budget GROUP BY e.event_name ORDER BY MIN(ex.cost) ASC, e.event_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alpha Conference',)
*/