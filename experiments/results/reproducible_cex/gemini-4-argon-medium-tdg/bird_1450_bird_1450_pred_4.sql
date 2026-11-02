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
-- Tests boundary values for income.amount (40, 41, 39, NULL), NULL foreign keys, and orphan parent records.
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (10001, 'Standard', 'New York', 'New York County', 'New York', 'NY');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (10002, 'Standard', 'Brooklyn', 'Kings County', 'New York', 'NY');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (10003, 'Standard', 'Queens', 'Queens County', 'New York', 'NY');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (10004, 'Standard', 'Bronx', 'Bronx County', 'New York', 'NY');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (10005, 'Standard', 'Staten Island', 'Richmond County', 'New York', 'NY');
INSERT INTO member (member_id, first_name, last_name, zip) VALUES ('M1', 'Alice', 'Smith', 10001);
INSERT INTO member (member_id, first_name, last_name, zip) VALUES ('M2', 'Bob', 'Jones', 10002);
INSERT INTO member (member_id, first_name, last_name, zip) VALUES ('M3', 'Charlie', 'Brown', 10003);
INSERT INTO member (member_id, first_name, last_name, zip) VALUES ('M4', 'David', 'White', 10004);
INSERT INTO member (member_id, first_name, last_name, zip) VALUES ('M5', 'Eve', 'Black', NULL);
INSERT INTO member (member_id, first_name, last_name, zip) VALUES ('M6', 'Frank', 'Green', 10005);
INSERT INTO income (income_id, amount, link_to_member) VALUES ('I1', 41, 'M1');
INSERT INTO income (income_id, amount, link_to_member) VALUES ('I2', 40, 'M2');
INSERT INTO income (income_id, amount, link_to_member) VALUES ('I3', 39, 'M3');
INSERT INTO income (income_id, amount, link_to_member) VALUES ('I4', NULL, 'M4');
INSERT INTO income (income_id, amount, link_to_member) VALUES ('I5', 100, 'M5');
INSERT INTO income (income_id, amount, link_to_member) VALUES ('I6', 100, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.city, T3.county FROM income AS T1 INNER JOIN member AS T2 ON T1.link_to_member = T2.member_id INNER JOIN zip_code AS T3 ON T3.zip_code = T2.zip WHERE T1.amount > 40;

/*
Gold Result:
('New York', 'New York County')
*/

-- Prediction Query
SELECT z.city, z.county FROM event AS e JOIN budget AS b ON e.event_id = b.link_to_event JOIN income AS i ON b.link_to_event = e.event_id JOIN member AS m ON i.link_to_member = m.member_id JOIN zip_code AS z ON m.zip = z.zip_code GROUP BY e.event_id HAVING COUNT(i.income_id) > 40;

/*
Prediction Result:
*/