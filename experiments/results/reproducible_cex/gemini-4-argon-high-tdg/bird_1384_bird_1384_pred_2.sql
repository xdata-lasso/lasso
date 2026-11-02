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
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ1', 'Computer Science', 'CS', 'Engineering');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (10001, 'Standard', 'New York', 'New York', 'New York', 'NY');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('EV1', 'Fall Gala', '2023-10-01', 'Social', 'Annual', 'Hall A', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('EV2', 'Tech Talk', '2023-11-01', 'Academic', 'Guest speaker', 'Room 101', 'Open');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B1', 'Food', 100.0, 899.0, 999, 'Open', 'EV1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M1', 'Grant', 'Gilmour', 'grant.g@example.com', 'Member', 'L', '555-0101', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M2', 'Grant', 'Smith', 'grant.s@example.com', 'Member', 'M', '555-0102', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M3', 'David', 'Gilmour', 'david.g@example.com', 'Secretary', 'XL', '555-0103', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M4', 'Gilmour', 'Grant', 'gilmour.g@example.com', 'Treasurer', 'S', '555-0104', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M5', 'Alice', 'Brown', 'alice.b@example.com', 'President', 'M', '555-0105', 10001, 'MAJ1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('EV1', 'M1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('EV2', 'M1');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('EX1', 'Banners', '2023-10-02', 75.0, 'Yes', 'M1', 'B1');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('EX2', 'Drinks', '2023-10-03', 80.0, 'Yes', 'M1', 'B1');
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('INC1', '2023-09-01', 450, 'Dues', 'Fall dues', 'M1');
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('INC2', '2023-09-02', 111, 'Dues', 'Fall dues', 'M2');
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('INC3', '2023-09-03', 222, 'Dues', 'Fall dues', 'M3');
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('INC4', '2023-09-04', 333, 'Dues', 'Fall dues', 'M4');
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('M1', '2023-09-05', 888, 'Donation', 'ID trap', 'M5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.amount FROM member AS T1 INNER JOIN income AS T2 ON T1.member_id = T2.link_to_member WHERE T1.first_name = 'Grant' AND T1.last_name = 'Gilmour';

/*
Gold Result:
(450,)
*/

-- Prediction Query
SELECT COUNT("income"."amount") FROM "income" INNER JOIN "member" ON "income"."link_to_member" = "member"."member_id" WHERE "member"."first_name" = 'Grant' AND "member"."last_name" = 'Gilmour';

/*
Prediction Result:
(1,)
*/