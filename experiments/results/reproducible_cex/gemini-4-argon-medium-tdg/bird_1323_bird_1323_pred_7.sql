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
-- Tests SELECT DISTINCT vs SELECT, and GROUP BY event_id vs event_name when TWO different events WITH THE SAME NAME both exceed 20 attendees (Gold query returns two rows with the same name). Also tests confusion with budget.amount > 20.
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
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M22', 'A', 'B', 'm22@test.com', 'Member', 'M', '111', 10001, 'MAJ1');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E10', 'Annual Gala', '2023-05-01', 'Meeting', 'N1', 'Hall A', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E20', 'Annual Gala', '2024-05-01', 'Meeting', 'N2', 'Hall B', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E30', 'Rich Event Low Attendance', '2024-06-01', 'Social', 'N3', 'Hall C', 'Open');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B1', 'Food', 10.0, 5.0, 15, 'Closed', 'E10');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B2', 'Venue', 50.0, 50.0, 100, 'Open', 'E30');
-- E10 has 21 attendees
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E10', 'M1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E10', 'M2');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E10', 'M3');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E10', 'M4');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E10', 'M5');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E10', 'M6');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E10', 'M7');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E10', 'M8');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E10', 'M9');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E10', 'M10');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E10', 'M11');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E10', 'M12');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E10', 'M13');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E10', 'M14');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E10', 'M15');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E10', 'M16');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E10', 'M17');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E10', 'M18');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E10', 'M19');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E10', 'M20');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E10', 'M21');
-- E20 has 22 attendees
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E20', 'M1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E20', 'M2');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E20', 'M3');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E20', 'M4');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E20', 'M5');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E20', 'M6');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E20', 'M7');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E20', 'M8');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E20', 'M9');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E20', 'M10');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E20', 'M11');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E20', 'M12');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E20', 'M13');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E20', 'M14');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E20', 'M15');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E20', 'M16');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E20', 'M17');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E20', 'M18');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E20', 'M19');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E20', 'M20');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E20', 'M21');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E20', 'M22');
-- E30 has 1 attendee
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E30', 'M1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_name FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event GROUP BY T1.event_id HAVING COUNT(T2.link_to_event) > 20;

/*
Gold Result:
('Annual Gala',)
('Annual Gala',)
*/

-- Prediction Query
SELECT DISTINCT event.event_name FROM event INNER JOIN attendance ON event.event_id = attendance.link_to_event WHERE event.type <> 'fundraiser' GROUP BY event.event_id HAVING COUNT(attendance.link_to_member) > 20;

/*
Prediction Result:
('Annual Gala',)
*/