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
-- Tests DISTINCT vs ALL, multiple incomes for the same target member, and multiple members with the same name.
-- Also includes decoy data in budget and expense tables to catch wrong table joins.
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('ev1', 'Party', '2023-05-01', 'Social', 'Fun', 'Hall', 'Open');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('b1', 'Food', 10.0, 90.0, 999, 'Open', 'ev1');
INSERT INTO major (major_id, major_name, department, college) VALUES ('maj1', 'CS', 'Eng', 'Tech');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (10001, 'Standard', 'NYC', 'NY', 'New York', 'NY');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('m1', 'Grant', 'Gilmour', 'gg1@test.com', 'Member', 'L', '111-1111', 10001, 'maj1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('m2', 'Grant', 'Gilmour', 'gg2@test.com', 'President', 'M', '222-2222', 10001, 'maj1');
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('inc1', '2023-01-01', 50, 'Dues', 'First', 'm1');
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('inc2', '2023-01-02', 50, 'Fundraiser', 'Duplicate Amount', 'm1');
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('inc3', '2023-01-03', 75, 'Donation', 'Second Member', 'm2');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('exp1', 'Pizza', '2023-01-05', 888.0, 'Yes', 'm1', 'b1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.amount FROM member AS T1 INNER JOIN income AS T2 ON T1.member_id = T2.link_to_member WHERE T1.first_name = 'Grant' AND T1.last_name = 'Gilmour';

/*
Gold Result:
(50,)
(50,)
(75,)
*/

-- Prediction Query
SELECT SUM(T2.amount) FROM member AS T1 INNER JOIN income AS T2 ON T1.member_id = T2.link_to_member WHERE T1.first_name = 'Grant' AND T1.last_name = 'Gilmour';

/*
Prediction Result:
(175,)
*/