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
-- Tests basic ordering by T2.spent DESC, LIMIT 5 (with 6 rows), and ensures T2.spent is not confused with T2.amount, T2.remaining, or T1.cost.
-- Also tests DISTINCT / GROUP BY mutations by having duplicate member names with different expenses, and LEFT JOIN mutations via unreferenced rows.
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('e1', 'Gala', '2023-01-01', 'Social', 'None', 'Hall', 'Closed');
INSERT INTO major (major_id, major_name, department, college) VALUES ('m1', 'CS', 'Eng', 'Tech');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (10001, 'Standard', 'NYC', 'NY', 'New York', 'NY');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('mem1', 'Alice', 'Smith', 'a@a.com', 'Member', 'M', '111', 10001, 'm1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('mem2', 'Bob', 'Jones', 'b@a.com', 'President', 'L', '222', 10001, 'm1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('mem3', 'Charlie', 'Brown', 'c@a.com', 'Treasurer', 'S', '333', 10001, 'm1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('mem4', 'Diana', 'Prince', 'd@a.com', 'Secretary', 'M', '444', 10001, 'm1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('mem5', 'Evan', 'Wright', 'e@a.com', 'Admin', 'XL', '555', 10001, 'm1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('mem_unused', 'Unreferenced', 'Member', 'u@a.com', 'Member', 'S', '000', 10001, 'm1');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('b1', 'Food', 500.0, 100.0, 600, 'Closed', 'e1');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('b2', 'Drinks', 400.0, 200.0, 800, 'Open', 'e1');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('b3', 'Decor', 300.0, 300.0, 900, 'Planning', 'e1');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('b4', 'Music', 200.0, 400.0, 1000, 'Closed', 'e1');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('b5', 'Venue', 100.0, 500.0, 1100, 'Open', 'e1');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('b6', 'Misc', 50.0, 600.0, 1200, 'Closed', 'e1');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('b_unused', 'Unused', 9999.0, 0.0, 9999, 'Closed', 'e1');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('exp1', 'Catering', '2023-01-02', 10.0, 'true', 'mem1', 'b1');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('exp2', 'Soda', '2023-01-03', 20.0, 'false', 'mem1', 'b2');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('exp3', 'Balloons', '2023-01-04', 300.0, 'true', 'mem2', 'b3');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('exp4', 'DJ', '2023-01-05', 400.0, 'false', 'mem3', 'b4');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('exp5', 'Hall Rental', '2023-01-06', 500.0, 'true', 'mem4', 'b5');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('exp6', 'Napkins', '2023-01-07', 600.0, 'true', 'mem5', 'b6');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.first_name, T3.last_name FROM expense AS T1 INNER JOIN budget AS T2 ON T1.link_to_budget = T2.budget_id INNER JOIN member AS T3 ON T1.link_to_member = T3.member_id ORDER BY T2.spent DESC, T1.expense_id NULLS LAST, T2.budget_id NULLS LAST, T3.member_id NULLS LAST LIMIT 5;

/*
Gold Result:
('Alice', 'Smith')
('Alice', 'Smith')
('Bob', 'Jones')
('Charlie', 'Brown')
('Diana', 'Prince')
*/

-- Prediction Query
SELECT m.first_name, m.last_name FROM member AS m JOIN expense AS e ON m.member_id = e.link_to_member GROUP BY m.member_id ORDER BY SUM(e.cost) DESC, m.first_name NULLS LAST, m.last_name NULLS LAST LIMIT 5;

/*
Prediction Result:
('Evan', 'Wright')
('Diana', 'Prince')
('Charlie', 'Brown')
('Bob', 'Jones')
('Alice', 'Smith')
*/