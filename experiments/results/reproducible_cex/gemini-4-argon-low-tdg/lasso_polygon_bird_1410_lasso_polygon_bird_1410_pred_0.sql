-- Schema DDL
CREATE TABLE event (event_id TEXT PRIMARY KEY, event_name TEXT, event_date TEXT, type TEXT, notes TEXT, location TEXT, status TEXT);

CREATE TABLE major (major_id TEXT PRIMARY KEY, major_name TEXT, department TEXT, college TEXT);

CREATE TABLE zip_code (zip_code INTEGER PRIMARY KEY, type TEXT, city TEXT, county TEXT, state TEXT, short_state TEXT);

CREATE TABLE attendance (link_to_event TEXT, link_to_member TEXT, PRIMARY KEY (link_to_event, link_to_member), FOREIGN KEY (link_to_event) REFERENCES event (event_id), FOREIGN KEY (link_to_member) REFERENCES member (member_id));

CREATE TABLE budget (budget_id TEXT PRIMARY KEY, category TEXT, spent REAL, remaining REAL, amount INTEGER, event_status TEXT, link_to_event TEXT, FOREIGN KEY (link_to_event) REFERENCES event (event_id));

CREATE TABLE expense (expense_id TEXT PRIMARY KEY, expense_description TEXT, expense_date TEXT, cost REAL, approved TEXT, link_to_member TEXT, link_to_budget TEXT, FOREIGN KEY (link_to_budget) REFERENCES budget (budget_id), FOREIGN KEY (link_to_member) REFERENCES member (member_id));

CREATE TABLE income (income_id TEXT PRIMARY KEY, date_received TEXT, amount INTEGER, source TEXT, notes TEXT, link_to_member TEXT, FOREIGN KEY (link_to_member) REFERENCES member (member_id));

CREATE TABLE member (member_id TEXT PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, position TEXT, t_shirt_size TEXT, phone TEXT, zip INTEGER, link_to_major TEXT, FOREIGN KEY (link_to_major) REFERENCES major (major_id), FOREIGN KEY (zip) REFERENCES zip_code (zip_code));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO major (major_id, major_name, department, college) VALUES ('M1', 'CS', 'Eng', 'Tech');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (10001, 'Standard', 'NYC', 'NY', 'New York', 'NY');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E1', 'Gala', '2023-01-01', 'Social', 'None', 'Hall', 'Closed');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B1', 'Food', 500.0, 500.0, 1000, 'Closed', 'E1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('rec4BLdZHS2Blfp4v', 'Charlie', 'Brown', 'charlie@example.com', 'Treasurer', 'XL', '123-456-7890', 10001, 'M1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('recOtherMember001', 'Lucy', 'VanPelt', 'lucy@example.com', 'VP', 'M', '098-765-4321', 10001, 'M1');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('EXP1', 'Catering', '2023-02-01', 75.0, 'true', 'recOtherMember001', 'B1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.first_name, T1.last_name, SUM(T2.cost) FROM member AS T1 INNER JOIN expense AS T2 ON T1.member_id = T2.link_to_member WHERE T1.member_id = 'rec4BLdZHS2Blfp4v';

/*
Gold Result:
(None, None, None)
*/

-- Prediction Query
SELECT member.first_name, member.last_name, SUM(expense.cost) AS total_cost FROM member INNER JOIN expense ON member.member_id = expense.link_to_member WHERE member.member_id = 'rec4BLdZHS2Blfp4v' GROUP BY member.first_name, member.last_name;

/*
Prediction Result:
*/