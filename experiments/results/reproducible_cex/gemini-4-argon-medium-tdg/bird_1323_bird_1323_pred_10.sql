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
-- Tests boundary conditions (count = 20 vs 21 vs 0) and GROUP BY event_id vs event_name (two events sharing the same name, one with 15 attendees and one with 10 attendees, totaling 25 if grouped by event_name).
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ1', 'CS', 'CS Dept', 'Engineering');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (10001, 'Standard', 'New York', 'NY', 'New York', 'NY');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M1', 'A', 'B', 'm1@test.com', 'Member', 'M', '111', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M2', 'A', 'B', 'm2@test.com', 'Member', 'M', '111', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M3', 'A', 'B', 'm3@test.com', 'Member', 'M', '111', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M4', 'A', 'B', 'm4@test.com', 'Member', 'M', '111', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M5', 'A', 'B', 'm5@test.com', 'Member', 'M', '111', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M6', 'A', 'B', 'm6@test.com', 'Member', 'M', '111', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M7', 'A', 'B', 'm7@test.com', 'Member', 'M', '111', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M8', 'A', 'B', 'm8@test.com', 'Member', 'M', '111', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M9', 'A', 'B', 'm9@test.com', 'Member', 'M', '111', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M10', 'A', 'B', 'm10@test.com', 'Member', 'M', '111', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M11', 'A', 'B', 'm11@test.com', 'Member', 'M', '111', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M12', 'A', 'B', 'm12@test.com', 'Member', 'M', '111', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M13', 'A', 'B', 'm13@test.com', 'Member', 'M', '111', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M14', 'A', 'B', 'm14@test.com', 'Member', 'M', '111', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M15', 'A', 'B', 'm15@test.com', 'Member', 'M', '111', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M16', 'A', 'B', 'm16@test.com', 'Member', 'M', '111', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M17', 'A', 'B', 'm17@test.com', 'Member', 'M', '111', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M18', 'A', 'B', 'm18@test.com', 'Member', 'M', '111', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M19', 'A', 'B', 'm19@test.com', 'Member', 'M', '111', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M20', 'A', 'B', 'm20@test.com', 'Member', 'M', '111', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M21', 'A', 'B', 'm21@test.com', 'Member', 'M', '111', 10001, 'MAJ1');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E1', 'Event TwentyOne', '2023-01-01', 'Social', 'Note', 'Loc1', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E2', 'Event Twenty', '2023-01-02', 'Social', 'Note', 'Loc1', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E3', 'Duplicate Name', '2023-01-03', 'Social', 'Note', 'Loc1', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E4', 'Duplicate Name', '2023-01-04', 'Social', 'Note', 'Loc1', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E5', 'Zero Attendance', '2023-01-05', 'Social', 'Note', 'Loc1', 'Open');
-- E1 has 21 attendees
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M2');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M3');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M4');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M5');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M6');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M7');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M8');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M9');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M10');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M11');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M12');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M13');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M14');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M15');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M16');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M17');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M18');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M19');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M20');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M21');
-- E2 has 20 attendees
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E2', 'M1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E2', 'M2');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E2', 'M3');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E2', 'M4');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E2', 'M5');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E2', 'M6');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E2', 'M7');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E2', 'M8');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E2', 'M9');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E2', 'M10');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E2', 'M11');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E2', 'M12');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E2', 'M13');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E2', 'M14');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E2', 'M15');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E2', 'M16');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E2', 'M17');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E2', 'M18');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E2', 'M19');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E2', 'M20');
-- E3 has 15 attendees
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E3', 'M1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E3', 'M2');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E3', 'M3');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E3', 'M4');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E3', 'M5');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E3', 'M6');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E3', 'M7');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E3', 'M8');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E3', 'M9');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E3', 'M10');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E3', 'M11');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E3', 'M12');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E3', 'M13');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E3', 'M14');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E3', 'M15');
-- E4 has 10 attendees
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E4', 'M1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E4', 'M2');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E4', 'M3');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E4', 'M4');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E4', 'M5');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E4', 'M6');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E4', 'M7');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E4', 'M8');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E4', 'M9');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E4', 'M10');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_name FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event GROUP BY T1.event_id HAVING COUNT(T2.link_to_event) > 20;

/*
Gold Result:
('Event TwentyOne',)
*/

-- Prediction Query
SELECT e.event_name FROM event AS e JOIN attendance AS a ON e.event_id = a.link_to_event LEFT JOIN budget AS b ON e.event_id = b.link_to_event GROUP BY e.event_id HAVING COUNT(a.link_to_member) > 20 AND (NOT b.category IN ('Food', 'Advertisement') OR b.amount <= 150);

/*
Prediction Result:
*/