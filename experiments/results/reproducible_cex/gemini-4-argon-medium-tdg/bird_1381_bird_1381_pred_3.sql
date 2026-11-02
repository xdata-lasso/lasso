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
-- Tests GROUP BY column mistakes (e.g., grouping by first_name, last_name, major, zip, or event instead of member_id)
-- Also tests DISTINCT mutations in SELECT (two distinct qualifying members with identical names).
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ1', 'Math', 'Sci', 'ArtSci');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (20001, 'Standard', 'DC', 'DC', 'Washington', 'DC');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E1', 'E1', '2023-02-01', 'Meeting', '', 'Room 1', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E2', 'E2', '2023-02-02', 'Meeting', '', 'Room 1', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E3', 'E3', '2023-02-03', 'Meeting', '', 'Room 1', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E4', 'E4', '2023-02-04', 'Meeting', '', 'Room 1', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E5', 'E5', '2023-02-05', 'Meeting', '', 'Room 1', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E6', 'E6', '2023-02-06', 'Meeting', '', 'Room 1', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E7', 'E7', '2023-02-07', 'Meeting', '', 'Room 1', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E8', 'E8', '2023-02-08', 'Meeting', '', 'Room 1', 'Closed');
-- Two members named 'John Smith' who each only have 4 events (if grouped by name, sum is 8 > 7, which is wrong)
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M_JS1', 'John', 'Smith', 'js1@test.com', 'Member', 'M', '222-0001', 20001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M_JS2', 'John', 'Smith', 'js2@test.com', 'Member', 'L', '222-0002', 20001, 'MAJ1');
-- Two members named 'Alice Brown' who EACH have 8 events (both should be output; catches SELECT DISTINCT mutants)
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M_AB1', 'Alice', 'Brown', 'ab1@test.com', 'Member', 'S', '222-0003', 20001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M_AB2', 'Alice', 'Brown', 'ab2@test.com', 'Member', 'S', '222-0004', 20001, 'MAJ1');
-- Attendance for M_JS1 (4 events)
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M_JS1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E2', 'M_JS1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E3', 'M_JS1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E4', 'M_JS1');
-- Attendance for M_JS2 (4 events)
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E5', 'M_JS2');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E6', 'M_JS2');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E7', 'M_JS2');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E8', 'M_JS2');
-- Attendance for M_AB1 (8 events)
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M_AB1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E2', 'M_AB1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E3', 'M_AB1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E4', 'M_AB1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E5', 'M_AB1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E6', 'M_AB1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E7', 'M_AB1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E8', 'M_AB1');
-- Attendance for M_AB2 (8 events)
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M_AB2');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E2', 'M_AB2');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E3', 'M_AB2');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E4', 'M_AB2');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E5', 'M_AB2');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E6', 'M_AB2');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E7', 'M_AB2');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E8', 'M_AB2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.first_name, T1.last_name FROM member AS T1 INNER JOIN attendance AS T2 ON T1.member_id = T2.link_to_member GROUP BY T2.link_to_member HAVING COUNT(T2.link_to_event) > 7;

/*
Gold Result:
('Alice', 'Brown')
('Alice', 'Brown')
*/

-- Prediction Query
SELECT member.first_name, member.last_name FROM member INNER JOIN attendance ON member.member_id = attendance.link_to_member GROUP BY member.first_name, member.last_name HAVING COUNT(attendance.link_to_event) > 7;

/*
Prediction Result:
('Alice', 'Brown')
('John', 'Smith')
*/