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
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ1', 'Mathematics', 'Math', 'Science');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (20001, 'Standard', 'Washington', 'DC', 'District of Columbia', 'DC');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M1', 'Alice', 'Smith', 'alice@example.com', 'Member', 'M', '222-111-1111', 20001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M2', 'Bob', 'Jones', 'bob@example.com', 'Member', 'L', '222-111-1112', 20001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M3', 'Carol', 'White', 'carol@example.com', 'Secretary', 'S', '222-111-1113', 20001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M4', 'David', 'Brown', 'david1@example.com', 'Member', 'XL', '222-111-1114', 20001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M5', 'David', 'Brown', 'david2@example.com', 'Member', 'M', '222-111-1115', 20001, 'MAJ1');
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('INC1', '2023-02-01', 50, 'Dues', 'M1 first qualifying income', 'M1');
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('INC2', '2023-02-02', 60, 'Fundraiser', 'M1 second qualifying income', 'M1');
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('INC3', '2023-02-03', 25, 'Dues', 'M2 first non-qualifying income', 'M2');
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('INC4', '2023-02-04', 30, 'Dues', 'M2 second non-qualifying income, sum > 40', 'M2');
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('INC5', '2023-02-05', 50, 'Donation', 'M3 qualifying income', 'M3');
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('INC6', '2023-02-06', 10, 'Dues', 'M3 low income making avg <= 40 and min <= 40', 'M3');
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('INC7', '2023-02-07', 45, 'Dues', 'M4 qualifying income', 'M4');
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('INC8', '2023-02-08', 55, 'Dues', 'M5 qualifying income with identical member name', 'M5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.first_name, T1.last_name FROM member AS T1 INNER JOIN income AS T2 ON T1.member_id = T2.link_to_member WHERE T2.amount > 40;

/*
Gold Result:
('Alice', 'Smith')
('Alice', 'Smith')
('Carol', 'White')
('David', 'Brown')
('David', 'Brown')
*/

-- Prediction Query
SELECT DISTINCT member.first_name, member.last_name FROM member INNER JOIN income ON member.member_id = income.link_to_member WHERE income.amount > 40;

/*
Prediction Result:
('Alice', 'Smith')
('Carol', 'White')
('David', 'Brown')
*/