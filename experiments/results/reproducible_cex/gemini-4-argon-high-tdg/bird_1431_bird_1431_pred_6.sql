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
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ10', 'Biology', 'Bio', 'Science');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('EV1', 'Women''s Soccer', '2023-10-01', 'Sports', 'Game 1', 'North Field', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('EV2', 'Women''s Soccer', '2023-10-08', 'Sports', 'Game 2', 'South Field', 'Closed');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MB1', 'Zack', 'Smith', 'zack@example.com', 'Member', 'L', '555-0201', 20001, 'MAJ10');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MB2', 'Aaron', 'Smith', 'aaron@example.com', 'Member', 'M', '555-0202', 20001, 'MAJ10');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MB3', 'middle', 'Jones', 'jones@example.com', 'Member', 'S', '555-0203', 20001, 'MAJ10');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MB4', 'beta', 'Adams', 'adams@example.com', 'Member', 'XL', '555-0204', 20001, 'MAJ10');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('EV1', 'MB1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('EV1', 'MB2');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('EV1', 'MB3');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('EV2', 'MB3');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('EV2', 'MB4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.last_name FROM attendance AS T1 INNER JOIN event AS T2 ON T2.event_id = T1.link_to_event INNER JOIN member AS T3 ON T1.link_to_member = T3.member_id WHERE T2.event_name = 'Women''s Soccer' AND T3.position = 'Member';

/*
Gold Result:
('Smith',)
('Smith',)
('Jones',)
('Jones',)
('Adams',)
*/

-- Prediction Query
SELECT DISTINCT member.last_name FROM member INNER JOIN attendance ON member.member_id = attendance.link_to_member INNER JOIN event ON attendance.link_to_event = event.event_id WHERE member.position = 'Member' AND event.event_name = 'Women''s Soccer';

/*
Prediction Result:
('Smith',)
('Jones',)
('Adams',)
*/