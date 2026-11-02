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
INSERT INTO major (major_id, major_name, department, college) VALUES ('M1', 'CS', 'Eng', 'CoE');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (10001, 'Standard', 'NYC', 'NY', 'New York', 'NY');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E1', 'Meet', '2023-09-01', 'Social', 'N', 'Room 1', 'Closed');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B1', 'Food', 100.0, 50.0, 150, 'Closed', 'E1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM1', 'Elijah', 'Allen', 'ea@test.com', 'Member', 'L', '111-1111', 10001, 'M1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM2', 'Elijah', 'Smith', 'es@test.com', 'Member', 'M', '222-2222', 10001, 'M1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM3', 'John', 'Allen', 'ja@test.com', 'Member', 'S', '333-3333', 10001, 'M1');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('EXP1', 'Valid Sept 1', '2023-09-15', 10.0, 'true', 'MEM1', 'B1');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('EXP2', 'Valid Sept 2 (Dup Cost)', '2023-09-20', 10.0, 'true', 'MEM1', 'B1');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('EXP3', 'Valid Oct', '2023-10-05', 25.0, 'false', 'MEM1', 'B1');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('EXP4', 'Invalid Aug', '2023-08-15', 1000.0, 'true', 'MEM1', 'B1');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('EXP5', 'Invalid Nov', '2023-11-15', 2000.0, 'true', 'MEM1', 'B1');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('EXP6', 'Wrong Last Name', '2023-09-15', 5000.0, 'true', 'MEM2', 'B1');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('EXP7', 'Wrong First Name', '2023-10-15', 8000.0, 'true', 'MEM3', 'B1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T2.cost) FROM member AS T1 INNER JOIN expense AS T2 ON T1.member_id = T2.link_to_member WHERE T1.last_name = 'Allen' AND T1.first_name = 'Elijah' AND (SUBSTRING(T2.expense_date, 6, 2) = '09' OR SUBSTRING(T2.expense_date, 6, 2) = '10');

/*
Gold Result:
(15.0,)
*/

-- Prediction Query
SELECT AVG(expense.cost) AS average_cost FROM expense INNER JOIN member ON expense.link_to_member = member.member_id WHERE member.first_name = 'Elijah' AND member.last_name = 'Allen' AND CAST(SUBSTRING(expense.expense_date, 5, 2) AS INTEGER) IN (9, 10);

/*
Prediction Result:
(None,)
*/