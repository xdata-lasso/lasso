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
-- Tests non-exact integer division truncation (5 / 2 = 2 vs 2.5 in float division),
-- case sensitivity, substring/LIKE mutations ('Financial', 'Corporate Finance', 'Biophysics'),
-- and NULL handling in major_name.
INSERT INTO major (major_id, major_name, department, college) VALUES ('M1', 'Finance', 'Business', 'College of Business');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M2', 'Finance', 'Business', 'College of Business');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M3', 'Finance', 'Business', 'College of Business');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M4', 'Finance', 'Business', 'College of Business');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M5', 'Finance', 'Business', 'College of Business');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M6', 'Physics', 'Science', 'College of Science');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M7', 'Physics', 'Science', 'College of Science');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M8', 'finance', 'Business', 'College of Business');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M9', 'Corporate Finance', 'Business', 'College of Business');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M10', 'PHYSICS', 'Science', 'College of Science');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M11', 'Astrophysics', 'Science', 'College of Science');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M12', NULL, 'Undecided', 'General');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(CASE WHEN major_name = 'Finance' THEN 1 ELSE 0 END) / SUM(CASE WHEN major_name = 'Physics' THEN 1 ELSE 0 END) AS ratio FROM major;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN major_name = 'Finance' THEN 1 ELSE 0 END) AS REAL) * 1.0 / SUM(CASE WHEN major_name = 'Physics' THEN 1 ELSE 0 END) AS ratio FROM major;

/*
Prediction Result:
(2.5,)
*/