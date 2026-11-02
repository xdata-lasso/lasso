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
-- DATASET 6
-- Tests NULL handling in aggregation and multiple 'Elijah Allen' members (kills GROUP BY member_id mutants and manual SUM/COUNT(*) mutants).
INSERT INTO member (member_id, first_name, last_name) VALUES ('M1', 'Elijah', 'Allen');
INSERT INTO member (member_id, first_name, last_name) VALUES ('M2', 'Elijah', 'Allen');
INSERT INTO expense (expense_id, expense_date, cost, link_to_member) VALUES ('E1', '2023-09-05', 15.0, 'M1');
INSERT INTO expense (expense_id, expense_date, cost, link_to_member) VALUES ('E2', '2023-09-06', NULL, 'M1');
INSERT INTO expense (expense_id, expense_date, cost, link_to_member) VALUES ('E3', '2023-10-12', 45.0, 'M2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T2.cost) FROM member AS T1 INNER JOIN expense AS T2 ON T1.member_id = T2.link_to_member WHERE T1.last_name = 'Allen' AND T1.first_name = 'Elijah' AND (SUBSTRING(T2.expense_date, 6, 2) = '09' OR SUBSTRING(T2.expense_date, 6, 2) = '10');

/*
Gold Result:
(30.0,)
*/

-- Prediction Query
SELECT AVG(cost) FROM expense WHERE link_to_member = (SELECT member_id FROM member WHERE first_name = 'Elijah' AND last_name = 'Allen') AND (STRFTIME('%m', expense_date) = '09' OR STRFTIME('%m', expense_date) = '10');

/*
Prediction Result:
(15.0,)
*/