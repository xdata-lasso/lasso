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
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('EV1', 'Fall Mixer', '2023-09-10', 'Social', 'Annual mixer', 'Hall A', 'Open');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M1', 'Computer Science', 'CS', 'Engineering');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (10001, 'Standard', 'New York', 'New York', 'New York', 'NY');
INSERT INTO "member" (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM1', 'Alice', 'Smith', 'alice@example.com', 'Treasurer', 'M', '555-0101', 10001, 'M1');
INSERT INTO "budget" (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B1', 'Advertisement', 50.0, 50.0, 100, 'Open', 'EV1');
INSERT INTO "budget" (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B2', 'Advertisement', 25.0, 75.0, 100, 'Open', 'EV1');
INSERT INTO "budget" (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B3', 'Food', 80.0, 20.0, 100, 'Open', 'EV1');
INSERT INTO "budget" (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B4', 'Equipment', 0.0, 200.0, 200, 'Open', 'EV1');
INSERT INTO "expense" (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('E1', 'Posters', '2023-09-01', 20.0, 'true', 'MEM1', 'B1');
INSERT INTO "expense" (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('E2', 'Posters', '2023-09-02', 30.0, 'true', 'MEM1', 'B1');
INSERT INTO "expense" (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('E3', 'Posters', '2023-09-03', 25.0, 'true', 'MEM1', 'B2');
INSERT INTO "expense" (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('E4', 'Pizza', '2023-09-04', 80.0, 'true', 'MEM1', 'B3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.category FROM expense AS T1 INNER JOIN budget AS T2 ON T1.link_to_budget = T2.budget_id WHERE T1.expense_description = 'Posters';

/*
Gold Result:
('Advertisement',)
*/

-- Prediction Query
SELECT budget.category FROM expense INNER JOIN budget ON expense.link_to_budget = budget.budget_id WHERE expense.expense_description = 'Posters';

/*
Prediction Result:
('Advertisement',)
('Advertisement',)
('Advertisement',)
*/