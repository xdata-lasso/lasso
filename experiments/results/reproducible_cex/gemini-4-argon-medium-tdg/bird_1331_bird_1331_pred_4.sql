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
INSERT INTO major (major_id, major_name, department, college) VALUES ('M1', 'Computer Science', 'CS', 'Engineering');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (10001, 'Standard', 'New York', 'NY', 'New York', 'NY');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM1', 'Alice', 'Smith', 'alice@example.com', 'Vice President', 'M', '111-222-3333', 10001, 'M1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM2', 'Bob', 'Jones', 'bob@example.com', 'Vice President', 'L', '222-333-4444', 10001, 'M1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM3', 'Charlie', 'Brown', 'charlie@example.com', 'President', 'S', '333-444-5555', 10001, 'M1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM4', 'Diana', 'Prince', 'diana@example.com', 'vice president', 'M', '444-555-6666', 10001, 'M1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM5', 'Evan', 'Wright', 'evan@example.com', NULL, 'XL', '555-666-7777', 10001, 'M1');
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('INC1', '2023-01-01', 50, 'Dues', 'First payment', 'MEM1');
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('INC2', '2023-01-02', 50, 'Dues', 'Duplicate amount', 'MEM1');
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('INC3', '2023-01-03', 100, 'Fundraising', 'Different amount', 'MEM1');
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('INC4', '2023-01-04', 200, 'Donation', 'Non-VP income', 'MEM3');
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('INC5', '2023-01-05', 300, 'Dues', 'Lowercase VP', 'MEM4');
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('INC6', '2023-01-06', 400, 'Dues', 'NULL position', 'MEM5');
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('INC7', '2023-01-07', 500, 'Grant', 'Unlinked income', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.amount FROM member AS T1 INNER JOIN income AS T2 ON T1.member_id = T2.link_to_member WHERE T1.position = 'Vice President';

/*
Gold Result:
(50,)
(50,)
(100,)
*/

-- Prediction Query
SELECT SUM(income.amount) AS total_funds FROM income INNER JOIN member ON income.link_to_member = member.member_id WHERE member.position = 'Vice President';

/*
Prediction Result:
(200,)
*/