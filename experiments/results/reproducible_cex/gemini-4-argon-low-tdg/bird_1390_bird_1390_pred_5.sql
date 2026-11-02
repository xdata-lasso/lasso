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
INSERT INTO major (major_id, major_name, department, college) VALUES ('maj_1', 'Mathematics', 'Math', 'Science');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (20001, 'Standard', 'Washington', 'DC', 'DC', 'DC');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('mem_1', 'Bob', 'Jones', 'bob@example.com', 'Treasurer', 'L', '987-654-3210', 20001, 'maj_1');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('ev_1', 'Yearly Kickoff', '2023-09-01', 'Social', 'No expenses', 'Hall A', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('ev_2', 'Yearly Kickoff 2023', '2023-09-02', 'Social', 'Substring match trap', 'Hall B', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('ev_3', 'yearly kickoff', '2023-09-03', 'Social', 'Case sensitivity trap', 'Hall C', 'Closed');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('b_1', 'General', 0.0, 100.0, 100, 'Open', 'ev_1');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('b_2', 'Food', 40.0, 60.0, 100, 'Closed', 'ev_2');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('b_3', 'Drinks', 60.0, 40.0, 100, 'Closed', 'ev_3');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('ex_1', 'Snacks', '2023-09-02', 40.0, 'true', 'mem_1', 'b_2');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('ex_2', 'Soda', '2023-09-03', 60.0, 'true', 'mem_1', 'b_3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN T1.event_name = 'Yearly Kickoff' THEN T3.cost ELSE 0 END) AS REAL) * 100 / SUM(T3.cost) FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT (SELECT SUM(cost) FROM expense INNER JOIN budget ON expense.link_to_budget = budget.budget_id INNER JOIN event ON budget.link_to_event = event.event_id WHERE event.event_name = 'Yearly Kickoff') * 100.0 / (SELECT SUM(cost) FROM expense) AS yearly_kickoff_percentage;

/*
Prediction Result:
(None,)
*/