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
-- DATASET 3
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ1', 'Physics', 'Physics', 'Science');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (30301, 'Standard', 'Atlanta', 'Fulton', 'Georgia', 'GA');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM1', 'Carol', 'White', 'carol@example.com', 'Secretary', 'S', '555-0303', 30301, 'MAJ1');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('EV1', 'Annual Symposium', '2023-03-01', 'Conference', 'N1', 'Auditorium', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('EV2', 'Spring Career Fair', '2023-04-01', 'Networking', 'N2', 'Gym', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('EV3', 'Winter Retreat', '2023-12-01', 'Social', 'N3', 'Lodge', 'Open');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('BG1', 'Parking', 30.0, 70.0, 100, 'Open', 'EV1');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('BG2', 'Parking', 100.0, 0.0, 100, 'Open', 'EV2');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('BG3', 'Parking', 70.0, 30.0, 100, 'Open', 'EV3');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('EX1', 'Morning Lot', '2023-03-01', 10.0, 'true', 'MEM1', 'BG1');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('EX2', 'Evening Lot', '2023-03-01', 20.0, 'true', 'MEM1', 'BG1');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('EX3', 'Meter Fee', '2023-04-01', 15.0, 'true', 'MEM1', 'BG2');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('EX4', 'VIP Bus Parking', '2023-04-01', 85.0, 'true', 'MEM1', 'BG2');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('EX5', 'Oversized Lot', '2023-12-01', 70.0, 'true', 'MEM1', 'BG3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_name FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget WHERE T2.category = 'Parking' AND T3.cost < (SELECT AVG(cost) FROM expense);

/*
Gold Result:
('Annual Symposium',)
('Annual Symposium',)
('Spring Career Fair',)
*/

-- Prediction Query
SELECT e.event_name FROM budget AS b INNER JOIN event AS e ON b.link_to_event = e.event_id INNER JOIN expense AS ex ON ex.link_to_budget = b.budget_id WHERE b.category = 'Parking' GROUP BY e.event_name HAVING SUM(ex.cost) / COUNT(b.budget_id) < (SELECT AVG(cost) FROM expense WHERE category = 'Parking');

/*
Prediction Result:
('Annual Symposium',)
*/