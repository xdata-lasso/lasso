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
-- Tests exact lower and upper date boundaries (with timestamps requiring SUBSTRING), and DISTINCT keyword on duplicate valid expenses.
INSERT INTO major (major_id, major_name, department, college) VALUES ('maj1', 'CS', 'Eng', 'Tech');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (10001, 'Standard', 'NYC', 'NY', 'New York', 'NY');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('ev1', 'Fall Fest', '2019-10-01', 'Social', 'None', 'Hall A', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('ev2', 'Spring Gala', '2019-04-01', 'Social', 'None', 'Hall B', 'Closed');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('m1', 'Alice', 'Smith', 'a@b.c', 'Member', 'M', '111-2222', 10001, 'maj1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('m2', 'Bob', 'Jones', 'b@b.c', 'Admin', 'L', '111-3333', 10001, 'maj1');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('b1', 'Food', 100.0, 50.0, 150, 'Open', 'ev1');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('b2', 'Drinks', 50.0, 50.0, 100, 'Closed', 'ev2');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('ev1', 'm1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('ev2', 'm2');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('ex1', 'Pizza', '2019-01-10 14:30:00', 50.0, 'true', 'm1', 'b1');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('ex2', 'Soda', '2019-06-15 09:00:00', 25.0, 'true', 'm1', 'b1');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('ex3', 'Napkins', '2019-11-19 23:59:59', 15.0, 'true', 'm2', 'b2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.link_to_member, T3.link_to_event FROM expense AS T1 INNER JOIN member AS T2 ON T1.link_to_member = T2.member_id INNER JOIN attendance AS T3 ON T2.member_id = T3.link_to_member WHERE DATE(SUBSTRING(T1.expense_date, 1, 10)) BETWEEN '2019-01-10' AND '2019-11-19' AND T1.approved = 'true';

/*
Gold Result:
('m1', 'ev1')
('m2', 'ev2')
*/

-- Prediction Query
SELECT member.member_id, attendance.link_to_event FROM member INNER JOIN expense ON member.member_id = expense.link_to_member INNER JOIN attendance ON member.member_id = attendance.link_to_member WHERE expense.approved = 'true' AND expense.expense_date BETWEEN '2019-01-10' AND '2019-11-19';

/*
Prediction Result:
('m1', 'ev1')
('m1', 'ev1')
*/