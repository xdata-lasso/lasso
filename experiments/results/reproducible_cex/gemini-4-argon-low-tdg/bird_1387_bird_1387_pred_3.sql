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
INSERT INTO major (major_id, major_name, department, college) VALUES ('maj1', 'Computer Science', 'CS', 'Engineering');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (10001, 'Standard', 'New York', 'NY', 'New York', 'NY');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('e1', 'Yearly Kickoff', '2023-09-01', 'Meeting', 'Main kickoff', 'Room 101', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('e2', 'Monthly Social', '2023-10-01', 'Social', 'Pizza party', 'Lounge', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('e3', 'Yearly Kickoff Party', '2023-09-02', 'Social', 'Afterparty', 'Club', 'Planning');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('m1', 'Alice', 'Smith', 'alice@example.com', 'President', 'M', '555-0101', 10001, 'maj1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('m2', 'Bob', 'Jones', 'bob@example.com', 'Treasurer', 'L', '555-0102', 10001, 'maj1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('m3', 'Charlie', 'Brown', 'charlie@example.com', 'Member', 'S', '555-0103', 10001, 'maj1');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('b1', 'Food', 50.0, 50.0, 100, 'Closed', 'e1');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('b2', 'Drinks', 20.0, 30.0, 50, 'Open', 'e2');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('b3', 'Music', 100.0, 0.0, 100, 'Planning', 'e3');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('x1', 'Bagels', '2023-09-01', 50.0, 'false', 'm1', 'b1');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('x2', 'Soda', '2023-10-01', 20.0, 'true', 'm2', 'b2');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('x3', 'DJ', '2023-09-02', 100.0, 'true', 'm3', 'b3');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e1', 'm2');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e2', 'm1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T4.first_name, T4.last_name FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget INNER JOIN member AS T4 ON T3.link_to_member = T4.member_id WHERE T1.event_name = 'Yearly Kickoff';

/*
Gold Result:
('Alice', 'Smith')
*/

-- Prediction Query
SELECT m.first_name, m.last_name FROM event AS e INNER JOIN budget AS b ON e.event_id = b.link_to_event INNER JOIN attendance AS a ON b.link_to_event = a.link_to_event INNER JOIN member AS m ON a.link_to_member = m.member_id WHERE e.event_name = 'Yearly Kickoff';

/*
Prediction Result:
('Bob', 'Jones')
*/