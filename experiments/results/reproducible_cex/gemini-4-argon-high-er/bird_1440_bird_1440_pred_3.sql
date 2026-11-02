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
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('e1', 'Event 1', '2019-10-01', 'Social', 'None', 'Room 1', 'Closed');
INSERT INTO major (major_id, major_name, department, college) VALUES ('m1', 'CS', 'CS Dept', 'Engineering');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (12345, 'Standard', 'City', 'County', 'State', 'ST');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('b1', 'Food', 50.0, 50.0, 100, 'Closed', 'e1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('mem1', 'John', 'Doe', 'john@example.com', 'Member', 'M', '123-456-7890', 12345, 'm1');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('exp1', 'Dinner', '2019-11-19 12:00:00', 25.0, 'true', 'mem1', 'b1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.email FROM member AS T1 INNER JOIN expense AS T2 ON T1.member_id = T2.link_to_member WHERE DATE(SUBSTRING(T2.expense_date, 1, 10)) BETWEEN '2019-09-10' AND '2019-11-19' AND T2.cost > 20;

/*
Gold Result:
('john@example.com',)
*/

-- Prediction Query
SELECT m.email FROM expense AS e JOIN member AS m ON e.link_to_member = m.member_id WHERE e.expense_date BETWEEN '2019-09-10' AND '2019-11-19' AND e.cost > 20;

/*
Prediction Result:
*/