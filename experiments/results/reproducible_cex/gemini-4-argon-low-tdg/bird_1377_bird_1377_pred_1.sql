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
-- Tests basic counting of multiple 'President' rows, filtering out other positions, NULL positions, and case/substring variations (e.g., 'president', 'Vice President').
-- Also tests mutants that incorrectly join with major, zip_code, attendance, income, or expense (via missing FKs or 1-to-many fan-out).
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ1', 'Computer Science', 'CS', 'Engineering');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (10001, 'Standard', 'New York', 'New York', 'New York', 'NY');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E1', 'Annual Gala', '2023-01-01', 'Social', 'None', 'Hall A', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E2', 'Tech Talk', '2023-02-01', 'Academic', 'None', 'Room 101', 'Open');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B1', 'Food', 50.0, 50.0, 100, 'Closed', 'E1');
-- M1: Exact match 'President', has valid foreign keys and multiple child records in attendance/income/expense (tests join fan-out)
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M1', 'Alice', 'Smith', 'alice@example.com', 'President', 'M', '555-0001', 10001, 'MAJ1');
-- M2: Exact match 'President', but NULL foreign keys and NULL other attributes (tests INNER JOIN mutants and COUNT(other_column) mutants)
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M2', NULL, NULL, NULL, 'President', NULL, NULL, NULL, NULL);
-- M3: Substring match 'Vice President' (tests LIKE '%President%' mutants)
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M3', 'Charlie', 'Brown', 'charlie@example.com', 'Vice President', 'L', '555-0003', 10001, 'MAJ1');
-- M4: Case variation 'president' (tests case-insensitive mutants)
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M4', 'David', 'Jones', 'david@example.com', 'president', 'S', '555-0004', 10001, 'MAJ1');
-- M5: Different position 'Member' (tests missing WHERE clause or != mutants)
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M5', 'Eve', 'Adams', 'eve@example.com', 'Member', 'XL', '555-0005', 10001, 'MAJ1');
-- M6: NULL position (tests IS NULL / IS NOT NULL handling)
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M6', 'Frank', 'Wright', 'frank@example.com', NULL, 'M', '555-0006', 10001, 'MAJ1');
-- M7: 'President' in wrong column (last_name) (tests wrong column in WHERE predicate)
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M7', 'Grace', 'President', 'grace@example.com', 'Secretary', 'S', '555-0007', 10001, 'MAJ1');
-- Child table records for M1 to cause row multiplication if unnecessary joins are performed
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E2', 'M1');
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('I1', '2023-01-05', 20, 'Dues', 'None', 'M1');
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('I2', '2023-01-06', 30, 'Donation', 'None', 'M1');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('EX1', 'Pizza', '2023-01-01', 25.0, 'true', 'M1', 'B1');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('EX2', 'Drinks', '2023-01-01', 25.0, 'true', 'M1', 'B1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(member_id) FROM member WHERE position = 'President';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(*) FROM member WHERE LOWER(position) = 'president';

/*
Prediction Result:
(3,)
*/