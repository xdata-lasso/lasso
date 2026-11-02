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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (10001, 'Standard', 'New York', 'New York', 'New York', 'NY');
INSERT INTO major (major_id, major_name, department, college) VALUES ('maj1', 'Computer Science', 'CS', 'Engineering');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('mem1', 'Alice', 'Smith', 'alice@example.com', 'President', 'M', '555-0101', 10001, 'maj1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('mem2', 'Bob', 'Jones', 'bob@example.com', 'Treasurer', 'L', '555-0102', 10001, 'maj1');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('ev1', 'November Speaker', '2023-11-15', 'Speaker', 'Fall keynote', 'Room 101', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('ev2', 'October Speaker', '2023-10-15', 'Speaker', 'Oct keynote', 'Room 102', 'Closed');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('ev1', 'mem1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('ev1', 'mem2');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('b1', 'Parking', 8.5, 1.5, 10, 'Closed', 'ev1');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('b2', 'Food', 5.0, 15.0, 20, 'Closed', 'ev1');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('b3', 'Parking', 50.0, 50.0, 100, 'Closed', 'ev2');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('b4', 'Venue', 100.0, 100.0, 200, 'Closed', 'ev2');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('exp1', 'Garage pass A', '2023-11-15', 4.0, 'true', 'mem1', 'b1');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('exp2', 'Garage pass B', '2023-11-15', 4.5, 'true', 'mem2', 'b1');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('exp3', 'Snacks', '2023-11-15', 5.0, 'true', 'mem1', 'b2');
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('inc1', '2023-11-01', 500, 'Dues', 'Fall dues', 'mem1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN T1.category = 'Parking' THEN T1.amount ELSE 0 END) AS REAL) * 100 / SUM(T1.amount) FROM budget AS T1 INNER JOIN event AS T2 ON T1.link_to_event = T2.event_id WHERE T2.event_name = 'November Speaker';

/*
Gold Result:
(33.333333333333336,)
*/

-- Prediction Query
SELECT (CAST(SUM(CASE WHEN category = 'Parking' THEN amount ELSE 0 END) AS REAL) / CAST(SUM(amount) AS REAL)) * 100 AS percentage FROM budget JOIN event ON budget.link_to_event = event.event_id WHERE event_name = 'November Speaker';

/*
Prediction Result:
(33.33333333333333,)
*/