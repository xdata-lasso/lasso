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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (20001, 'Standard', 'Washington', 'DC', 'District of Columbia', 'DC');
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ1', 'Mathematics', 'Math', 'Sciences');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('EV1', 'Symposium', '2023-03-15', 'Academic', 'Spring talk', 'Room 101', 'Open');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B1', 'Travel', 120.0, 80.0, 200, 'Open', 'EV1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M1', 'Dana', 'White', 'dana@example.com', 'Secretary', 'X-Large', '222-333-4444', 20001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M2', 'Evan', 'Green', 'evan@example.com', 'Member', 'X-Large', '222-333-5555', 20001, 'MAJ1');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('E1', 'Parking Pass', '2023-03-14', 15.0, 'true', 'M1', 'B1');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('E2', 'Parking Pass', '2023-03-15', 15.0, 'true', 'M1', 'B1');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('E3', 'Fuel Reimbursement', '2023-03-15', 45.0, 'true', 'M1', 'B1');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('E4', 'Parking Pass', '2023-03-15', 15.0, 'true', 'M2', 'B1');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('E5', 'Highway Tolls', '2023-03-15', 30.0, 'true', 'M2', 'B1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.expense_description FROM member AS T1 INNER JOIN expense AS T2 ON T1.member_id = T2.link_to_member WHERE T1.t_shirt_size = 'X-Large';

/*
Gold Result:
('Parking Pass',)
('Parking Pass',)
('Fuel Reimbursement',)
('Parking Pass',)
('Highway Tolls',)
*/

-- Prediction Query
SELECT DISTINCT T2.expense_description FROM member AS T1 INNER JOIN expense AS T2 ON T1.member_id = T2.link_to_member WHERE T1.t_shirt_size = 'X-Large';

/*
Prediction Result:
('Parking Pass',)
('Fuel Reimbursement',)
('Highway Tolls',)
*/