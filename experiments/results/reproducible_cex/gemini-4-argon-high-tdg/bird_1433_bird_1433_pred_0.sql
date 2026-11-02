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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (10001, 'PO Box', 'Alpha', 'Adams', 'New York', 'NY');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (10002, 'PO Box', 'Beta', 'Adams', 'New York', 'NY');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (10003, 'PO Box', 'Gamma', 'Baker', 'New York', 'NY');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (10004, 'PO Box', 'Delta', NULL, 'New York', 'NY');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (10005, 'Standard', 'Epsilon', 'Clark', 'New York', 'NY');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (10006, 'Unique', 'Zeta', 'Davis', 'New York', 'NY');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (10007, NULL, 'Eta', 'Evans', 'New York', 'NY');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M1', 'Computer Science', 'CS', 'Engineering');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM1', 'Alice', 'Smith', 'alice@example.com', 'Member', 'M', '555-0101', 10001, 'M1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM2', 'Bob', 'Jones', 'bob@example.com', 'Member', 'L', '555-0102', 10005, 'M1');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E1', 'Meetup', '2023-01-01', 'PO Box', 'Note', 'Room 1', 'Open');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT county FROM zip_code WHERE type = 'PO Box' AND NOT county IS NULL;

/*
Gold Result:
('Adams',)
('Baker',)
*/

-- Prediction Query
SELECT DISTINCT county FROM zip_code WHERE type = 'PO Box';

/*
Prediction Result:
('Adams',)
('Baker',)
(None,)
*/