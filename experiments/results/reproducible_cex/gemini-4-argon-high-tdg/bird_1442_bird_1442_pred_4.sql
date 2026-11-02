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
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E1', 'Fall Mixer', '2023-09-10', 'Social', 'Welcome event', 'Hall A', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E2', 'Tech Talk', '2023-10-15', 'Academic', 'Guest speaker', 'Room 101', 'Planning');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M1', 'Computer Science', 'CS', 'Engineering');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (10001, 'Standard', 'New York', 'New York', 'New York', 'NY');
INSERT INTO "member" (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM1', 'Alice', 'Smith', 'alice@example.com', 'Treasurer', 'M', '555-0101', 10001, 'M1');
INSERT INTO "budget" (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B1', 'Food', 125.5, -25.5, 100, 'Closed', 'E1');
INSERT INTO "budget" (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B2', 'Supplies', 200.0, 0.0, 200, 'Closed', 'E1');
INSERT INTO "budget" (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B3', 'Advertising', 150.0, 0.0, 150, 'Planning', 'E2');
INSERT INTO "budget" (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B4', 'Food', 50.0, 50.0, 100, 'Planning', 'E2');
INSERT INTO "budget" (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B5', 'Venue', 25.0, 75.0, 100, 'Planning', 'E2');
INSERT INTO "budget" (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B6', 'Prizes', 10.0, 90.0, 100, 'Closed', 'E1');
INSERT INTO "expense" (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('EXP1', 'Pizza', '2023-09-09', 75.5, 'true', 'MEM1', 'B1');
INSERT INTO "expense" (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('EXP2', 'Drinks', '2023-09-10', 50.0, 'true', 'MEM1', 'B1');
INSERT INTO "expense" (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('EXP3', 'Banners', '2023-09-05', 200.0, 'true', 'MEM1', 'B2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN remaining < 0 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(budget_id) FROM budget;

/*
Gold Result:
(16.666666666666668,)
*/

-- Prediction Query
SELECT (SUM(CASE WHEN remaining < 0 THEN 1 ELSE 0 END) * 100.0 / CAST(COUNT(DISTINCT link_to_event) AS REAL)) AS percentage_over_budget FROM budget;

/*
Prediction Result:
(50.0,)
*/