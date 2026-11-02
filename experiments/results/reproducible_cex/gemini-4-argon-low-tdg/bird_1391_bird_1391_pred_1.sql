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
-- Tests exact integer division (6 / 2 = 3), duplicate major_names (catches DISTINCT mutations),
-- confused column mutations (Department/College containing 'Physics' or 'Finance'),
-- and inner/natural join mutations (Finance rows have no matching members, Physics rows have multiple members).
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (10001, 'Standard', 'New York', 'New York', 'New York', 'NY');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M1', 'Finance', 'Physics', 'Physics');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M2', 'Finance', 'Business', 'Business');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M3', 'Finance', 'Business', 'Business');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M4', 'Finance', 'Business', 'Business');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M5', 'Finance', 'Business', 'Business');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M6', 'Finance', 'Business', 'Business');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M7', 'Physics', 'Finance', 'Finance');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M8', 'Physics', 'Science', 'Science');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M9', 'History', 'Humanities', 'Arts');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM1', 'Alice', 'Smith', 'alice@example.com', 'Member', 'M', '123-456-7890', 10001, 'M7');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM2', 'Bob', 'Jones', 'bob@example.com', 'Member', 'L', '123-456-7891', 10001, 'M7');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM3', 'Charlie', 'Brown', 'charlie@example.com', 'Member', 'S', '123-456-7892', 10001, 'M8');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(CASE WHEN major_name = 'Finance' THEN 1 ELSE 0 END) / SUM(CASE WHEN major_name = 'Physics' THEN 1 ELSE 0 END) AS ratio FROM major;

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T2.major_name = 'Finance' THEN 1 ELSE 0 END) AS REAL) / SUM(CASE WHEN T2.major_name = 'Physics' THEN 1 ELSE 0 END) AS finance_to_physics_ratio FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id;

/*
Prediction Result:
(0.0,)
*/