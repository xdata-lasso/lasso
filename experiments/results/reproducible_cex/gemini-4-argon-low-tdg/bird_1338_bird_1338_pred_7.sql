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
INSERT INTO major (major_id, major_name, department, college) VALUES ('maj_1', 'History', 'Humanities', 'Arts');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (20001, 'Standard', 'Washington', 'DC', 'DC', 'DC');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('mem_1', 'Bob', 'Jones', 'bob@example.com', 'Treasurer', 'L', '555-0202', 20001, 'maj_1');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('ev_1', 'October Meeting', '2019-10-09T10:00:00', 'Meeting', 'Wrong date', 'Room 1', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('ev_2', 'November Meeting', '2019-10-08T10:00:00', 'Meeting', 'Wrong name', 'Room 2', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('ev_3', 'October Meeting Extra', '2019-10-08T12:00:00', 'Meeting', 'Superstring name', 'Room 3', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('ev_4', 'October Meeting', '2018-10-08 2019-10-08', 'Meeting', 'Prefix mismatch date', 'Room 4', 'Closed');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('bg_1', 'Food', 10.0, 90.0, 100, 'Closed', 'ev_1');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('bg_2', 'Food', 10.0, 90.0, 100, 'Closed', 'ev_2');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('bg_3', 'Food', 10.0, 90.0, 100, 'Closed', 'ev_3');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('bg_4', 'Food', 10.0, 90.0, 100, 'Closed', 'ev_4');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('ex_1', 'Item 1', '2019-10-08', 10.0, 'true', 'mem_1', 'bg_1');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('ex_2', 'Item 2', '2019-10-08', 10.0, 'false', 'mem_1', 'bg_2');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('ex_3', 'Item 3', '2019-10-08', 10.0, 'true', 'mem_1', 'bg_3');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('ex_4', 'Item 4', '2019-10-08', 10.0, 'false', 'mem_1', 'bg_4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.approved FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget WHERE T1.event_name = 'October Meeting' AND T1.event_date LIKE '2019-10-08%';

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.expense_id, T1.expense_description, T1.approved FROM expense AS T1 INNER JOIN budget AS T2 ON T1.link_to_budget = T2.budget_id INNER JOIN event AS T3 ON T2.link_to_event = T3.event_id WHERE T3.event_name LIKE '%October Meeting%' AND T3.event_date LIKE '%2019-10-08%';

/*
Prediction Result:
('ex_3', 'Item 3', 'true')
('ex_4', 'Item 4', 'false')
*/