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
-- Tests exact filter predicates: event_name, category, and SUBSTRING(event_date, 6, 2) = '09'.
-- Includes edge cases for date substring (09 in day/year/hour, off-by-one indices) and case/partial string matches.
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E1', 'September Meeting', '2019-09-10T12:00:00', 'Meeting', 'Valid match', 'Loc1', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E2', 'October Meeting', '2019-09-10T12:00:00', 'Meeting', 'Wrong event_name', 'Loc1', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E3', 'September Meeting Extra', '2019-09-10T12:00:00', 'Meeting', 'Prefix match event_name', 'Loc1', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E4', 'september meeting', '2019-09-10T12:00:00', 'Meeting', 'Case mismatch event_name', 'Loc1', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E5', 'September Meeting', '2019-10-09T09:00:00', 'Meeting', '09 in day and hour, not month', 'Loc1', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E6', 'September Meeting', '2009-10-15T12:00:00', 'Meeting', '09 in year, not month', 'Loc1', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E7', 'September Meeting', '201909-10T12:00:00', 'Meeting', 'Off-by-one substring index 5,2', 'Loc1', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E8', 'September Meeting', '2019--0910T12:00:00', 'Meeting', 'Off-by-one substring index 7,2', 'Loc1', 'Closed');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B1', 'Food', 12.34, 87.66, 100, 'Closed', 'E1');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B2', 'Advertisement', 23.45, 76.55, 100, 'Closed', 'E1');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B3', 'Food & Drink', 34.56, 65.44, 100, 'Closed', 'E1');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B4', 'food', 45.67, 54.33, 100, 'Closed', 'E1');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B5', 'Food', 56.78, 43.22, 100, 'Closed', 'E2');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B6', 'Food', 67.89, 32.11, 100, 'Closed', 'E3');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B7', 'Food', 78.90, 21.10, 100, 'Closed', 'E4');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B8', 'Food', 89.01, 10.99, 100, 'Closed', 'E5');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B9', 'Food', 90.12, 9.88, 100, 'Closed', 'E6');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B10', 'Food', 91.23, 8.77, 100, 'Closed', 'E7');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B11', 'Food', 92.34, 7.66, 100, 'Closed', 'E8');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.spent FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event WHERE T1.event_name = 'September Meeting' AND T2.category = 'Food' AND SUBSTRING(T1.event_date, 6, 2) = '09';

/*
Gold Result:
(12.34,)
*/

-- Prediction Query
SELECT T2.spent FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event WHERE T1.event_name = 'September Meeting' AND T2.category = 'Food';

/*
Prediction Result:
(12.34,)
(89.01,)
(90.12,)
(91.23,)
(92.34,)
*/