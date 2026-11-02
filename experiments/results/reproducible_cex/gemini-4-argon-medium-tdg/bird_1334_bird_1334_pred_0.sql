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
-- Tests basic join, WHERE clause filtering, column confusion (state vs short_state vs city), and duplicate name retention (SELECT vs SELECT DISTINCT)
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ1', 'Computer Science', 'Engineering', 'Engineering');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (60601, 'Standard', 'Chicago', 'Cook', 'Illinois', 'IL');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (60602, 'Standard', 'Chicago', 'Cook', 'IL', 'Illinois');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (90210, 'Standard', 'Illinois', 'Los Angeles', 'California', 'CA');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (10001, 'Standard', 'New York', 'Illinois', 'New York', 'NY');
INSERT INTO "member" (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M1', 'John', 'Doe', 'jdoe1@test.com', 'Member', 'L', '111-1111', 60601, 'MAJ1');
INSERT INTO "member" (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M2', 'John', 'Doe', 'jdoe2@test.com', 'Secretary', 'M', '222-2222', 60601, 'MAJ1');
INSERT INTO "member" (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M3', 'Jane', 'Smith', 'jsmith@test.com', 'President', 'S', '333-3333', 60602, 'MAJ1');
INSERT INTO "member" (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M4', 'Alice', 'Johnson', 'ajohnson@test.com', 'Treasurer', 'M', '444-4444', 90210, 'MAJ1');
INSERT INTO "member" (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M5', 'Bob', 'Brown', 'bbrown@test.com', 'Member', 'XL', '555-5555', 10001, 'MAJ1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.first_name, T1.last_name FROM member AS T1 INNER JOIN zip_code AS T2 ON T1.zip = T2.zip_code WHERE T2.state = 'Illinois';

/*
Gold Result:
('John', 'Doe')
('John', 'Doe')
*/

-- Prediction Query
SELECT member.first_name, member.last_name FROM member INNER JOIN zip_code ON member.zip = zip_code.zip_code WHERE zip_code.state = 'Illinois' AND member.position = 'Student_Club';

/*
Prediction Result:
*/