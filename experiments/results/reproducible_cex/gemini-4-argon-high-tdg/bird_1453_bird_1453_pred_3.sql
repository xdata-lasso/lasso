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
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ1', 'Computer Science', 'CS', 'Engineering');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (10001, 'Standard', 'New York', 'New York', 'New York', 'NY');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM1', 'Alice', 'Smith', 'alice@example.com', 'President', 'M', '555-0101', 10001, 'MAJ1');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('EV1', 'Alpha Gala', '2023-01-10', 'Social', 'Note 1', 'Hall A', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('EV2', 'Beta Workshop', '2023-02-15', 'Academic', 'Note 2', 'Hall B', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('EV3', 'Gamma Mixer', '2023-03-20', 'Social', 'Note 3', 'Hall C', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('EV4', 'Delta Concert', '2023-04-25', 'Music', 'Note 4', 'Hall D', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('EV5', 'Epsilon Tech', '2023-05-30', 'Academic', 'Note 5', 'Hall E', 'Open');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('BG1', 'Parking', 500.0, 500.0, 1000, 'Open', 'EV1');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('BG2', 'Parking', 600.0, 400.0, 1000, 'Open', 'EV2');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('BG3', 'Parking', 5.0, 5.0, 10, 'Open', 'EV3');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('BG4', 'Food', 15.0, 85.0, 100, 'Open', 'EV4');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('BG5', 'Food', 95.0, 5.0, 100, 'Open', 'EV5');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('EX1', 'Lot A', '2023-01-11', 10.0, 'true', 'MEM1', 'BG1');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('EX2', 'Lot B', '2023-02-16', 35.0, 'true', 'MEM1', 'BG2');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('EX3', 'Lot C', '2023-03-21', 45.0, 'true', 'MEM1', 'BG3');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('EX4', 'Snacks', '2023-04-26', 15.0, 'true', 'MEM1', 'BG4');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('EX5', 'Dinner', '2023-05-31', 95.0, 'true', 'MEM1', 'BG5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_name FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget WHERE T2.category = 'Parking' AND T3.cost < (SELECT AVG(cost) FROM expense);

/*
Gold Result:
('Alpha Gala',)
('Beta Workshop',)
*/

-- Prediction Query
SELECT e.event_name FROM event AS e JOIN budget AS b ON e.event_id = b.link_to_event JOIN expense AS ex ON b.budget_id = ex.link_to_budget WHERE b.category = 'Parking' AND ex.cost < (SELECT CAST(SUM(ex2.cost) AS REAL) / COUNT(ex2.expense_id) FROM expense AS ex2 JOIN budget AS b2 ON ex2.link_to_budget = b2.budget_id WHERE b2.category = 'Parking');

/*
Prediction Result:
('Alpha Gala',)
*/