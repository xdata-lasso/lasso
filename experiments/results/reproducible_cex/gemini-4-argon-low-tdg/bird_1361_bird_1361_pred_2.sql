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
-- Tests NULL foreign keys (link_to_member, link_to_budget), unapproved expenses, and NULL cost handling (kills unnecessary INNER JOINs to member/budget/event and extra predicates on 'approved').
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('e1', 'Social', '2023-10-01', 'Social', 'None', 'Hall', 'Open');
INSERT INTO major (major_id, major_name, department, college) VALUES ('maj1', 'History', 'Humanities', 'Arts');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (20001, 'Standard', 'Washington', 'DC', 'DC', 'DC');
INSERT INTO "member" (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('m1', 'Bob', 'Jones', 'bob@example.com', 'Treasurer', 'L', '555-0202', 20001, 'maj1');
INSERT INTO "budget" (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('b1', 'Refreshments', 20.0, 80.0, 100, 'Open', 'e1');
INSERT INTO "expense" (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('x1', 'Pizza', '2023-10-01', 12.75, 'false', NULL, NULL);
INSERT INTO "expense" (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('x2', 'Pizza', '2023-10-02', 8.25, 'true', 'm1', NULL);
INSERT INTO "expense" (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('x3', 'Pizza', '2023-10-03', NULL, 'true', NULL, 'b1');
INSERT INTO "expense" (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('x4', 'Water', '2023-10-03', 50.0, 'true', 'm1', 'b1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(cost) FROM expense WHERE expense_description = 'Pizza';

/*
Gold Result:
(21.0,)
*/

-- Prediction Query
SELECT SUM(T1.cost) FROM expense AS T1 INNER JOIN budget AS T2 ON T1.link_to_budget = T2.budget_id WHERE T1.expense_description = 'Pizza';

/*
Prediction Result:
(None,)
*/