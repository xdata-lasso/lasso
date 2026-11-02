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
INSERT INTO major (major_id, major_name, department, college) VALUES ('M1', 'Agricultural Systems Technology', 'School of Applied Sciences, Technology AND Education', 'College of Agriculture AND Applied Sciences');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M2', 'Technology Systems', 'School of Applied Sciences, Technology AND Education', 'College of Agriculture AND Applied Sciences');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M3', 'Agricultural Systems Technology', 'School of Applied Sciences, Technology AND Education', 'College of Agriculture AND Applied Sciences');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M4', NULL, 'School of Applied Sciences, Technology AND Education', 'College of Agriculture AND Applied Sciences');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M5', 'Aviation Technology', 'School of Applied Sciences, Technology AND Education', 'College of Engineering');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M6', 'Animal Science', 'Department of Animal, Dairy and Veterinary Sciences', 'College of Agriculture AND Applied Sciences');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M7', 'Computer Science', 'Department of Computer Science', 'College of Science');
INSERT INTO major (major_id, major_name, department, college) VALUES (NULL, 'Outdoor Product Design', 'School of Applied Sciences, Technology AND Education', 'College of Agriculture AND Applied Sciences');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (84321, 'Standard', 'Logan', 'Cache', 'Utah', 'UT');
INSERT INTO "member" (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM1', 'John', 'Doe', 'john.doe@example.com', 'Member', 'L', '555-0101', 84321, 'M1');
INSERT INTO "member" (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM2', 'Jane', 'Smith', 'jane.smith@example.com', 'President', 'M', '555-0102', 84321, 'M1');
INSERT INTO "member" (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM3', 'Bob', 'Brown', 'bob.brown@example.com', 'Treasurer', 'XL', '555-0103', 84321, 'M2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(major_id) FROM major WHERE department = 'School of Applied Sciences, Technology AND Education' AND college = 'College of Agriculture AND Applied Sciences';

/*
Gold Result:
(4,)
*/

-- Prediction Query
SELECT COUNT(*) AS major_count FROM major WHERE department = 'School of Applied Sciences, Technology and Education' AND college = 'College of Agriculture and Applied Sciences';

/*
Prediction Result:
(0,)
*/