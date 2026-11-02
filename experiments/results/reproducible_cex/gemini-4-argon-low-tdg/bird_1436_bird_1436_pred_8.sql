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
-- Tests:
-- 1. Boundary conditions on expense.cost: = 50, < 50, > 50, and NULL.
-- 2. Wrong join path: expense -> budget -> event vs expense -> member -> attendance -> event.
-- 3. Wrong column projection: projecting event.event_name vs event_id.
-- 4. Outer join mutations: members with expenses but no attendance, and members with attendance but no expenses.
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (10001, 'Standard', 'New York', 'New York', 'New York', 'NY');
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ1', 'Computer Science', 'CS', 'Engineering');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E_ATTENDED_51', 'Gala', '2023-01-01', 'Social', 'Note1', 'Hall A', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E_BUDGET_51', 'Meeting', '2023-01-02', 'Business', 'Note2', 'Room 1', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E_ATTENDED_50', 'Workshop', '2023-01-03', 'Academic', 'Note3', 'Lab 1', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E_ATTENDED_49', 'Seminar', '2023-01-04', 'Academic', 'Note4', 'Hall B', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E_ATTENDED_NULL_COST', 'Retreat', '2023-01-05', 'Social', 'Note5', 'Camp', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E_NO_EXPENSE', 'Picnic', '2023-01-06', 'Social', 'Note6', 'Park', 'Open');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B1', 'Food', 10.0, 100.0, 20, 'Open', 'E_BUDGET_51');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B2', 'Supplies', 60.0, 60.0, 60, 'Open', 'E_ATTENDED_50');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M_51', 'Alice', 'Smith', 'a@test.com', 'Member', 'M', '111-1111', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M_50', 'Bob', 'Jones', 'b@test.com', 'President', 'L', '222-2222', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M_49', 'Charlie', 'Brown', 'c@test.com', 'Treasurer', 'S', '333-3333', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M_NULL_COST', 'David', 'Wilson', 'd@test.com', 'Secretary', 'XL', '444-4444', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M_NO_ATTEND', 'Eve', 'Davis', 'e@test.com', 'Member', 'M', '555-5555', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M_NO_EXP', 'Frank', 'Miller', 'f@test.com', 'Member', 'L', '666-6666', 10001, 'MAJ1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E_ATTENDED_51', 'M_51');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E_ATTENDED_50', 'M_50');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E_ATTENDED_49', 'M_49');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E_ATTENDED_NULL_COST', 'M_NULL_COST');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E_NO_EXPENSE', 'M_NO_EXP');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('EXP_51', 'Catering', '2023-01-01', 50.01, 'false', 'M_51', 'B1');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('EXP_50', 'Handouts', '2023-01-02', 50.00, 'true', 'M_50', 'B2');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('EXP_49', 'Pens', '2023-01-03', 49.99, 'true', 'M_49', 'B2');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('EXP_NULL', 'Misc', '2023-01-04', NULL, 'true', 'M_NULL_COST', 'B2');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('EXP_NO_ATT', 'Travel', '2023-01-05', 100.00, 'true', 'M_NO_ATTEND', 'B2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.link_to_event FROM expense AS T1 INNER JOIN member AS T2 ON T1.link_to_member = T2.member_id INNER JOIN attendance AS T3 ON T2.member_id = T3.link_to_member WHERE T1.cost > 50;

/*
Gold Result:
('E_ATTENDED_51',)
*/

-- Prediction Query
SELECT T1.link_to_event FROM budget AS T1 INNER JOIN expense AS T2 ON T1.budget_id = T2.link_to_budget WHERE T2.cost > 50;

/*
Prediction Result:
('E_BUDGET_51',)
('E_ATTENDED_50',)
*/