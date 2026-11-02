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
-- General comprehensive dataset:
-- Tests floating point division (3/8 = 37.5), DISTINCT vs ALL on zip codes,
-- INNER JOIN vs LEFT/RIGHT JOIN (unmatched zip_code rows and NULL member.zip),
-- and confusion between state, short_state, city, and county.
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ1', 'Computer Science', 'CS', 'Engineering');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (4001, 'Standard', 'Portland', 'Cumberland', 'Maine', 'ME');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (4002, 'Standard', 'Bangor', 'Penobscot', 'Maine', 'ME');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (5001, 'Standard', 'Burlington', 'Chittenden', 'Vermont', 'VT');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (3001, 'Standard', 'Maine', 'Vermont', 'New Hampshire', 'NH');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (2001, 'Standard', 'Boston', 'Suffolk', 'Massachusetts', 'MA');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (4999, 'Standard', 'Augusta', 'Kennebec', 'Maine', 'ME');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (5999, 'Standard', 'Montpelier', 'Washington', 'Vermont', 'VT');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M1', 'Alice', 'Smith', 'a@test.com', 'Member', 'M', '111-1111', 4001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M2', 'Bob', 'Jones', 'b@test.com', 'Member', 'L', '111-1112', 4001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M3', 'Charlie', 'Brown', 'c@test.com', 'Member', 'S', '111-1113', 4001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M4', 'David', 'Wilson', 'd@test.com', 'Member', 'XL', '111-1114', 4002, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M5', 'Eve', 'Davis', 'e@test.com', 'Member', 'M', '111-1115', 5001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M6', 'Frank', 'Miller', 'f@test.com', 'Member', 'L', '111-1116', 3001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M7', 'Grace', 'Taylor', 'g@test.com', 'Member', 'S', '111-1117', 3001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M8', 'Heidi', 'Anderson', 'h@test.com', 'Member', 'M', '111-1118', 2001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M9', 'Ivan', 'Thomas', 'i@test.com', 'Member', 'L', '111-1119', NULL, 'MAJ1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST((SUM(CASE WHEN T2.state = 'Maine' THEN 1 ELSE 0 END) - SUM(CASE WHEN T2.state = 'Vermont' THEN 1 ELSE 0 END)) AS REAL) * 100 / COUNT(T1.member_id) AS diff FROM member AS T1 INNER JOIN zip_code AS T2 ON T2.zip_code = T1.zip;

/*
Gold Result:
(37.5,)
*/

-- Prediction Query
SELECT (SUM(CASE WHEN T2.state = 'New Jersey' THEN 1 ELSE 0 END) * 1.0 / COUNT(T1.member_id)) - (SUM(CASE WHEN T2.state = 'Vermont' THEN 1 ELSE 0 END) * 1.0 / COUNT(T1.member_id)) AS percentage_difference FROM member AS T1 INNER JOIN zip_code AS T2 ON T1.zip = T2.zip_code WHERE T1.position = 'Member';

/*
Prediction Result:
(-0.125,)
*/