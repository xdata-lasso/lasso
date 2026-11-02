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
-- Tests DISTINCT behavior:
-- 1. A single event having multiple budgets with remaining > 0.
-- 2. Two different events having the exact same event_name and location, both with remaining > 0.
-- 3. Two different events having the same event_name but different locations (tests GROUP BY event_name alone).
-- 4. Two different events having different event_names but the same location (tests GROUP BY location alone).
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E1', 'Tech Talk', '2023-02-01', 'Talk', 'N1', 'Auditorium', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E2', 'Tech Talk', '2023-03-01', 'Talk', 'N2', 'Auditorium', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E3', 'Tech Talk', '2023-04-01', 'Talk', 'N3', 'Library', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E4', 'Career Fair', '2023-05-01', 'Fair', 'N4', 'Auditorium', 'Open');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B1', 'Catering', 100.0, 50.0, 150, 'Open', 'E1');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B2', 'Flyers', 20.0, 30.0, 50, 'Open', 'E1');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B3', 'Catering', 100.0, 10.0, 110, 'Closed', 'E2');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B4', 'Drinks', 10.0, 15.0, 25, 'Open', 'E3');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B5', 'Booths', 200.0, 80.0, 280, 'Open', 'E4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.event_name, T1.location FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event WHERE T2.remaining > 0;

/*
Gold Result:
('Tech Talk', 'Auditorium')
('Tech Talk', 'Library')
('Career Fair', 'Auditorium')
*/

-- Prediction Query
SELECT e.event_name, e.location FROM event AS e JOIN budget AS b ON e.event_id = b.link_to_event WHERE b.remaining > 0;

/*
Prediction Result:
('Tech Talk', 'Auditorium')
('Tech Talk', 'Auditorium')
('Tech Talk', 'Auditorium')
('Tech Talk', 'Library')
('Career Fair', 'Auditorium')
*/