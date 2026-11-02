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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (84321, 'Standard', 'Logan', 'Cache', 'Utah', 'UT');
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ_1', 'Agricultural Systems Technology', 'School of Applied Sciences, Technology AND Education', 'College of Agriculture AND Applied Sciences');
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ_2', 'Agricultural Systems Technology', 'School of Applied Sciences, Technology AND Education', 'College of Agriculture AND Applied Sciences');
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ_3', NULL, 'School of Applied Sciences, Technology AND Education', 'College of Agriculture AND Applied Sciences');
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ_4', 'Technology Systems', 'School of Applied Sciences, Technology AND Education', 'College of Engineering');
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ_5', 'Animal Science', 'Department of Animal, Dairy AND Veterinary Sciences', 'College of Agriculture AND Applied Sciences');
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ_6', 'Family and Consumer Sciences', 'School of Applied Sciences, Technology and Education', 'College of Agriculture and Applied Sciences');
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ_7', 'Swapped Major', 'College of Agriculture AND Applied Sciences', 'School of Applied Sciences, Technology AND Education');
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ_8', 'School of Applied Sciences, Technology AND Education', 'Other Department', 'College of Agriculture AND Applied Sciences');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM_1', 'Alice', 'Smith', 'alice@example.com', 'Member', 'M', '555-0101', 84321, 'MAJ_1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM_2', 'Bob', 'Jones', 'bob@example.com', 'Member', 'L', '555-0102', 84321, 'MAJ_1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM_3', 'Charlie', 'Brown', 'charlie@example.com', 'President', 'S', '555-0103', 84321, 'MAJ_2');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM_4', 'Dana', 'White', 'dana@example.com', 'Secretary', 'M', '555-0104', 84321, 'MAJ_2');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM_5', 'Evan', 'Green', 'evan@example.com', 'Member', 'XL', '555-0105', 84321, 'MAJ_4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(major_id) FROM major WHERE department = 'School of Applied Sciences, Technology AND Education' AND college = 'College of Agriculture AND Applied Sciences';

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(*) AS major_count FROM major WHERE department = 'School of Applied Sciences, Technology and Education' AND college = 'College of Agriculture and Applied Sciences';

/*
Prediction Result:
(1,)
*/