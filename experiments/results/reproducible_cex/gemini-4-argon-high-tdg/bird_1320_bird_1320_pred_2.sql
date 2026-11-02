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
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ1', 'Computer Science', 'CS', 'Engineering');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (10001, 'Standard', 'New York', 'New York', 'New York', 'NY');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E1', 'Autumn Hackathon', '2023-10-15', 'Competition', 'Annual coding event', 'Hall A', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E2', 'Career Fair', '2023-11-01', 'Networking', 'Bring resumes', 'Gymnasium', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E3', 'Spring Mixer', '2023-04-10', 'Social', 'Refreshments provided', 'Patio', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E4', 'AI Symposium', '2023-05-20', 'Academic', 'Keynote speakers', 'Auditorium', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E5', 'Book Club', '2023-06-12', 'Social', 'Chapter 1 to 5', 'Room 101', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E6', 'Robotics Workshop', '2023-07-08', 'Workshop', 'Hands-on lab', 'Lab 3', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E7', 'Ghost Event', '2023-08-01', 'Meeting', 'No attendees', 'Room 202', 'Cancelled');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M1', 'Maya', 'Mclean', 'maya.mclean@example.com', 'President', 'M', '555-0101', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M2', 'Maya', 'Lin', 'maya.lin@example.com', 'Member', 'S', '555-0102', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M3', 'John', 'Mclean', 'john.mclean@example.com', 'Treasurer', 'L', '555-0103', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M4', 'Mclean', 'Maya', 'mclean.maya@example.com', 'Member', 'M', '555-0104', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M5', 'maya', 'mclean', 'lower.maya@example.com', 'Member', 'S', '555-0105', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M6', 'Mayan', 'McleanJr', 'mayan.jr@example.com', 'Secretary', 'XL', '555-0106', 10001, 'MAJ1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E2', 'M1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E3', 'M2');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E4', 'M3');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E5', 'M4');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E6', 'M5');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E6', 'M6');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_name FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event INNER JOIN member AS T3 ON T2.link_to_member = T3.member_id WHERE T3.first_name = 'Maya' AND T3.last_name = 'Mclean';

/*
Gold Result:
('Autumn Hackathon',)
('Career Fair',)
*/

-- Prediction Query
SELECT T3.event_name FROM member AS T1 INNER JOIN attendance AS T2 ON T1.member_id = T2.link_to_member INNER JOIN event AS T3 ON T2.link_to_event = T3.event_id INNER JOIN zip_code AS T4 ON T1.zip = T4.zip_code WHERE T1.first_name = 'Maya' AND T4.city = 'Mclean';

/*
Prediction Result:
*/