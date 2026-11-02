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
INSERT INTO major (major_id, major_name, department, college) VALUES ('M1', 'Computer Science', 'CS', 'Engineering');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (10001, 'Standard', 'New York', 'New York', 'New York', 'NY');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM1', 'Alice', 'Smith', 'alice@example.com', 'President', 'M', '555-0101', 10001, 'M1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM2', 'Bob', 'Jones', 'bob@example.com', 'Treasurer', 'L', '555-0102', 10001, 'M1');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E1', 'October Meeting', '2023-10-15', 'Meeting', 'Monthly general meeting', 'Room 101', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E2', 'October Social', '2023-10-20', 'Social', 'Fall mixer', 'Student Union', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E3', 'September Meeting', '2023-09-15', 'Meeting', 'First meeting', 'Room 101', 'Open');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'MEM1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E2', 'MEM1');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B1', 'Food', 100.0, 50.0, 150, 'Closed', 'E1');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B2', 'Supplies', 40.0, 10.0, 50, 'Closed', 'E1');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B3', 'Advertising', 0.0, 25.0, 25, 'Closed', 'E1');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B4', 'Food', 80.0, 20.0, 100, 'Closed', 'E2');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B5', 'Food', 60.0, 40.0, 100, 'Open', 'E3');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('X1', 'Pizza', '2023-10-14', 20.5, 'true', 'MEM1', 'B1');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('X2', 'Drinks', '2023-10-14', 20.5, 'false', 'MEM2', 'B1');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('X3', 'Markers', '2023-10-15', 15.25, 'true', NULL, 'B2');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('X4', 'Decorations', '2023-10-19', 80.0, 'true', 'MEM1', 'B4');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('X5', 'Snacks', '2023-09-14', 60.0, 'true', 'MEM1', 'B5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.type, SUM(T3.cost) FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget WHERE T1.event_name = 'October Meeting';

/*
Gold Result:
('Meeting', 56.25)
*/

-- Prediction Query
SELECT T3.expense_description, CAST(SUM(T3.cost) AS REAL) FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget WHERE T1.event_name = 'October Meeting' AND T3.approved = 'true' GROUP BY T3.expense_description ORDER BY T3.expense_description, CAST(SUM(T3.cost) AS REAL) NULLS LAST;

/*
Prediction Result:
('Markers', 15.25)
('Pizza', 20.5)
*/