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
-- Tests basic integer division where Finance > Physics and ratio has a remainder (5 / 2 = 2 in integer division vs 2.5 in float).
-- Also includes rows in `member` to kill mutants that incorrectly JOIN `major` with `member`.
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (10001, 'Standard', 'New York', 'New York', 'New York', 'NY');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M1', 'Finance', 'Business', 'College of Business');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M2', 'Finance', 'Economics', 'College of Business');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M3', 'Finance', 'Finance Dept', 'College of Business');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M4', 'Finance', 'Accounting', 'College of Business');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M5', 'Finance', 'Investments', 'College of Business');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M6', 'Physics', 'Sciences', 'College of Science');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M7', 'Physics', 'Astrophysics', 'College of Science');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M8', 'History', 'Humanities', 'College of Arts');
INSERT INTO "member" (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM1', 'Alice', 'Smith', 'alice@example.com', 'Member', 'M', '111-222-3333', 10001, 'M6');
INSERT INTO "member" (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM2', 'Bob', 'Jones', 'bob@example.com', 'Member', 'L', '111-222-3334', 10001, 'M6');
INSERT INTO "member" (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM3', 'Charlie', 'Brown', 'charlie@example.com', 'Member', 'S', '111-222-3335', 10001, 'M1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(CASE WHEN major_name = 'Finance' THEN 1 ELSE 0 END) / SUM(CASE WHEN major_name = 'Physics' THEN 1 ELSE 0 END) AS ratio FROM major;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T1.major_name = 'Finance' THEN 1 ELSE 0 END) AS REAL) / CASE WHEN SUM(CASE WHEN T1.major_name = 'Physics' THEN 1 ELSE 0 END) = 0 THEN 1 ELSE SUM(CASE WHEN T1.major_name = 'Physics' THEN 1 ELSE 0 END) END FROM major AS T1;

/*
Prediction Result:
(2.5,)
*/