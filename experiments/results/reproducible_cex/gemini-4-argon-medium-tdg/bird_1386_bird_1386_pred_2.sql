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
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E1', 'Yearly Kickoff', '2022-09-01', 'Meeting', '2022 Kickoff', 'Room 1', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E2', 'Yearly Kickoff', '2023-09-01', 'Meeting', '2023 Kickoff', 'Room 2', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E3', 'Yearly Kickoff ', '2023-09-02', 'Meeting', 'Typo', 'Room 3', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E4', 'yearly kickoff', '2023-09-03', 'Meeting', 'Lower', 'Room 4', 'Open');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B1', 'Decor', 999.0, 1.0, 1000, 'Closed', 'E1');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B2', 'Music', 888.0, 12.0, 900, 'Open', 'E2');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B3', 'Other', 777.0, 23.0, 800, 'Open', 'E3');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B4', 'Other', 666.0, 34.0, 700, 'Open', 'E4');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('EX1', 'Balloons', '2022-09-01', 10.25, 'true', NULL, 'B1');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('EX2', 'DJ', '2023-09-01', 40.75, 'true', NULL, 'B2');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('EX3', 'Misc1', '2023-09-02', 100.0, 'true', NULL, 'B3');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('EX4', 'Misc2', '2023-09-03', 200.0, 'true', NULL, 'B4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(T3.cost) FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget WHERE T1.event_name = 'Yearly Kickoff';

/*
Gold Result:
(51.0,)
*/

-- Prediction Query
SELECT SUM(cost) FROM expense WHERE link_to_budget IN (SELECT budget_id FROM budget WHERE link_to_event = (SELECT event_id FROM event WHERE event_name = 'Yearly Kickoff'));

/*
Prediction Result:
(10.25,)
*/