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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (1001, 'Standard', 'Portland', 'Cumberland', 'Maine', 'ME');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (1002, 'Standard', 'Bangor', 'Penobscot', 'Maine', 'ME');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (2001, 'Standard', 'Burlington', 'Chittenden', 'Vermont', 'VT');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (2002, 'Standard', 'Montpelier', 'Washington', 'Vermont', 'VT');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (3001, 'Standard', 'Concord', 'Merrimack', 'New Hampshire', 'NH');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (3002, 'Standard', 'Boston', 'Suffolk', 'Massachusetts', 'MA');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M1', 'Alice', 'Smith', 'alice@example.com', 'Member', 'M', '555-0101', 1001, NULL);
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M2', 'Bob', 'Jones', 'bob@example.com', 'Member', 'L', '555-0102', 1001, NULL);
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M3', 'Charlie', 'Brown', 'charlie@example.com', 'Member', 'S', '555-0103', 1001, NULL);
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M4', 'Diana', 'Prince', 'diana@example.com', 'President', 'M', '555-0104', 2001, NULL);
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M5', 'Evan', 'Wright', 'evan@example.com', 'Treasurer', 'XL', '555-0105', 3001, NULL);
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M6', 'Fiona', 'Gallagher', 'fiona@example.com', 'Secretary', 'S', '555-0106', 3001, NULL);
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M7', 'George', 'Clark', 'george@example.com', 'Member', 'L', '555-0107', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST((SUM(CASE WHEN T2.state = 'Maine' THEN 1 ELSE 0 END) - SUM(CASE WHEN T2.state = 'Vermont' THEN 1 ELSE 0 END)) AS REAL) * 100 / COUNT(T1.member_id) AS diff FROM member AS T1 INNER JOIN zip_code AS T2 ON T2.zip_code = T1.zip;

/*
Gold Result:
(33.333333333333336,)
*/

-- Prediction Query
SELECT (SUM(CASE WHEN z.state = 'New Jersey' THEN 1 ELSE 0 END) * 1.0 / COUNT(m.member_id)) - (SUM(CASE WHEN z.state = 'Vermont' THEN 1 ELSE 0 END) * 1.0 / COUNT(m.member_id)) AS percentage_difference FROM member AS m JOIN zip_code AS z ON m.zip = z.zip_code WHERE m.position = 'Member';

/*
Prediction Result:
(0.0,)
*/