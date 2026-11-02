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
-- Tests boundary conditions for T1.amount (> 40, = 40, < 40, NULL)
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (10001, 'Standard', 'City_Over40', 'County_Over40', 'New York', 'NY');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (10002, 'Standard', 'City_Exact40', 'County_Exact40', 'New York', 'NY');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (10003, 'Standard', 'City_Under40', 'County_Under40', 'New York', 'NY');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (10004, 'Standard', 'City_Null', 'County_Null', 'New York', 'NY');
INSERT INTO member (member_id, first_name, last_name, zip) VALUES ('M1', 'John', 'Doe', 10001);
INSERT INTO member (member_id, first_name, last_name, zip) VALUES ('M2', 'Jane', 'Smith', 10002);
INSERT INTO member (member_id, first_name, last_name, zip) VALUES ('M3', 'Bob', 'Brown', 10003);
INSERT INTO member (member_id, first_name, last_name, zip) VALUES ('M4', 'Alice', 'White', 10004);
INSERT INTO income (income_id, amount, link_to_member) VALUES ('I1', 41, 'M1');
INSERT INTO income (income_id, amount, link_to_member) VALUES ('I2', 40, 'M2');
INSERT INTO income (income_id, amount, link_to_member) VALUES ('I3', 39, 'M3');
INSERT INTO income (income_id, amount, link_to_member) VALUES ('I4', NULL, 'M4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.city, T3.county FROM income AS T1 INNER JOIN member AS T2 ON T1.link_to_member = T2.member_id INNER JOIN zip_code AS T3 ON T3.zip_code = T2.zip WHERE T1.amount > 40;

/*
Gold Result:
('City_Over40', 'County_Over40')
*/

-- Prediction Query
SELECT T1.location, T5.city, T5.county FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event INNER JOIN income AS T3 ON T3.link_to_member = T2.link_to_member INNER JOIN zip_code AS T5 ON T1.location = T5.zip_code GROUP BY T1.location, T5.city, T5.county HAVING COUNT(T3.income_id) > 40;

/*
Prediction Result:
*/