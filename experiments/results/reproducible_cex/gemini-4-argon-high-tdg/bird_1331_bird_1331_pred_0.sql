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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (10001, 'Standard', 'New York', 'New York', 'New York', 'NY');
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ1', 'Computer Science', 'CS', 'Engineering');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M1', 'Alice', 'Smith', 'alice@example.com', 'Vice President', 'M', '555-0101', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M2', 'Bob', 'Jones', 'bob@example.com', 'Vice President', 'L', '555-0102', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M3', 'Carol', 'White', 'carol@example.com', 'Vice President', 'S', '555-0103', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M4', 'Dave', 'Black', 'dave@example.com', 'President', 'XL', '555-0104', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M5', 'Eve', 'Green', 'eve@example.com', 'Assistant Vice President', 'M', '555-0105', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M6', 'Frank', 'Hall', 'frank@example.com', NULL, 'L', '555-0106', 10001, 'MAJ1');
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('INC1', '2023-01-10', 150, 'Dues', 'Spring dues', 'M2');
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('INC2', '2023-02-15', 250, 'Fundraising', 'Bake sale', 'M2');
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('INC3', '2023-03-01', 150, 'Dues', 'Spring dues', 'M3');
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('INC4', '2023-03-10', 500, 'Donation', 'Alumni gift', 'M4');
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('INC5', '2023-03-20', 600, 'Dues', 'Late dues', 'M5');
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('INC6', '2023-04-01', 700, 'Grant', 'Club grant', 'M6');
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('INC7', '2023-04-05', 999, 'Anonymous', 'Unlinked income', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.amount FROM member AS T1 INNER JOIN income AS T2 ON T1.member_id = T2.link_to_member WHERE T1.position = 'Vice President';

/*
Gold Result:
(150,)
(250,)
(150,)
*/

-- Prediction Query
SELECT SUM(T1.amount) FROM income AS T1 INNER JOIN member AS T2 ON T1.link_to_member = T2.member_id WHERE T2.position = 'Vice President';

/*
Prediction Result:
(550,)
*/