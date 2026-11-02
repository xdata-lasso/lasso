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
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E1', 'Closed_Overbudget_Small', '2023-01-01', 'Workshop', 'Notes 1', 'Room 101', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E2', 'Closed_Overbudget_Large', '2023-01-02', 'Seminar', 'Notes 2', 'Room 102', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E3', 'Open_Severe_Overbudget', '2023-01-03', 'Meeting', 'Notes 3', 'Room 103', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E4', 'Closed_Zero_Remaining', '2023-01-04', 'Party', 'Notes 4', 'Room 104', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E5', 'Closed_Positive_Remaining', '2023-01-05', 'Fundraiser', 'Notes 5', 'Room 105', 'Closed');
INSERT INTO "budget" (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B1', 'Food', 120.0, -20.0, 100, 'Closed', 'E1');
INSERT INTO "budget" (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B2', 'Food', 150.0, -50.0, 100, 'Closed', 'E2');
INSERT INTO "budget" (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B3', 'Equipment', 600.0, -500.0, 100, 'Open', 'E3');
INSERT INTO "budget" (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B4', 'Advertisement', 100.0, 0.0, 100, 'Closed', 'E4');
INSERT INTO "budget" (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B5', 'Venue', 50.0, 50.0, 100, 'Closed', 'E5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.event_name FROM budget AS T1 INNER JOIN event AS T2 ON T2.event_id = T1.link_to_event WHERE T1.event_status = 'Closed' AND T1.remaining < 0 ORDER BY T1.remaining, T1.budget_id NULLS LAST, T2.event_id NULLS LAST LIMIT 1;

/*
Gold Result:
('Closed_Overbudget_Large',)
*/

-- Prediction Query
SELECT T2.event_name FROM budget AS T1 INNER JOIN event AS T2 ON T1.link_to_event = T2.event_id WHERE T2.status = 'Closed' AND T1.remaining < 0 ORDER BY T1.remaining ASC, T1.budget_id NULLS LAST, T2.event_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Open_Severe_Overbudget',)
*/