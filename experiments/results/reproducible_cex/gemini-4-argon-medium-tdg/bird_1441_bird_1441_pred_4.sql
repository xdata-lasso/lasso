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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (20001, 'Standard', 'Washington', 'DC', 'District of Columbia', 'DC');
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ1', 'Special Education', 'Special Ed', 'College of Education & Human Services');
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ2', 'Mathematics', 'Math', 'College of Education & Human Services');
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ3', 'Secondary Education', 'Teaching', 'College of Arts & Sciences');
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ4', NULL, 'Unknown', 'College of Education & Human Services');
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ5', 'Early Education', 'Teaching', NULL);
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM1', 'Frank', 'Miller', 'frank@example.com', 'President', 'L', '222-333-4444', 20001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM2', 'Grace', 'Hopper', 'grace@example.com', NULL, 'S', '222-333-4445', 20001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM3', 'Hank', 'Pym', 'hank@example.com', 'Member', 'M', '222-333-4446', 20001, 'MAJ2');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM4', 'Ivy', 'League', 'ivy@example.com', 'Member', 'M', '222-333-4447', 20001, 'MAJ3');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM5', 'Jack', 'Frost', 'jack@example.com', 'Member', 'L', '222-333-4448', 20001, 'MAJ4');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM6', 'Kara', 'Zor', 'kara@example.com', 'Member', 'S', '222-333-4449', 20001, 'MAJ5');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM7', 'Liam', 'Neeson', 'liam@example.com', 'Member', 'XL', '222-333-4450', 20001, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.member_id) FROM member AS T1 INNER JOIN major AS T2 ON T2.major_id = T1.link_to_major WHERE T1.position = 'Member' AND T2.major_name LIKE '%Education%' AND T2.college = 'College of Education & Human Services';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(T1.member_id) FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id WHERE T2.major_name LIKE '%education%' AND LOWER(T2.college) = LOWER('College of Education & Human Services');

/*
Prediction Result:
(2,)
*/