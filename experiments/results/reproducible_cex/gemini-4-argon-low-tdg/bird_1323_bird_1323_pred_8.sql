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
-- Tests exact boundary conditions (> 20 vs >= 20 vs > 21) and grouping by event_id vs event_name (events sharing the same name with counts 10 and 12).
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (10001, 'Standard', 'New York', 'New York', 'New York', 'NY');
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ1', 'Computer Science', 'CS', 'Engineering');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M1', 'F1', 'L1', 'm1@test.com', 'Member', 'M', '111-1111', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M2', 'F2', 'L2', 'm2@test.com', 'Member', 'M', '111-1112', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M3', 'F3', 'L3', 'm3@test.com', 'Member', 'M', '111-1113', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M4', 'F4', 'L4', 'm4@test.com', 'Member', 'M', '111-1114', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M5', 'F5', 'L5', 'm5@test.com', 'Member', 'M', '111-1115', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M6', 'F6', 'L6', 'm6@test.com', 'Member', 'M', '111-1116', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M7', 'F7', 'L7', 'm7@test.com', 'Member', 'M', '111-1117', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M8', 'F8', 'L8', 'm8@test.com', 'Member', 'M', '111-1118', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M9', 'F9', 'L9', 'm9@test.com', 'Member', 'M', '111-1119', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M10', 'F10', 'L10', 'm10@test.com', 'Member', 'M', '111-1120', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M11', 'F11', 'L11', 'm11@test.com', 'Member', 'M', '111-1121', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M12', 'F12', 'L12', 'm12@test.com', 'Member', 'M', '111-1122', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M13', 'F13', 'L13', 'm13@test.com', 'Member', 'M', '111-1123', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M14', 'F14', 'L14', 'm14@test.com', 'Member', 'M', '111-1124', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M15', 'F15', 'L15', 'm15@test.com', 'Member', 'M', '111-1125', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M16', 'F16', 'L16', 'm16@test.com', 'Member', 'M', '111-1126', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M17', 'F17', 'L17', 'm17@test.com', 'Member', 'M', '111-1127', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M18', 'F18', 'L18', 'm18@test.com', 'Member', 'M', '111-1128', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M19', 'F19', 'L19', 'm19@test.com', 'Member', 'M', '111-1129', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M20', 'F20', 'L20', 'm20@test.com', 'Member', 'M', '111-1130', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M21', 'F21', 'L21', 'm21@test.com', 'Member', 'M', '111-1131', 10001, 'MAJ1');
-- E1: 21 attendances (Should be returned)
-- E2: 20 attendances (Boundary check: Should NOT be returned)
-- E3 & E4: Share same event_name 'Duplicate Name', 10 and 12 attendances respectively (Sum=22 > 20, but individually <= 20. Tests GROUP BY event_id vs GROUP BY event_name)
-- E5: 0 attendances (Tests INNER JOIN vs LEFT JOIN / NOT IN)
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E1', 'Event TwentyOne', '2023-01-01', 'Social', 'N1', 'Loc1', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E2', 'Event Twenty', '2023-01-02', 'Social', 'N2', 'Loc2', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E3', 'Duplicate Name', '2023-01-03', 'Meeting', 'N3', 'Loc3', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E4', 'Duplicate Name', '2023-01-04', 'Meeting', 'N4', 'Loc4', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E5', 'Event Zero', '2023-01-05', 'Fundraiser', 'N5', 'Loc5', 'Planned');
-- 21 attendances for E1
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
-- 20 attendances for E2
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
-- 10 attendances for E3
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
-- 12 attendances for E4
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E4', 'M10');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E4', 'M11');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E4', 'M12');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E4', 'M13');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E4', 'M14');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E4', 'M15');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E4', 'M16');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E4', 'M17');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E4', 'M18');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E4', 'M19');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E4', 'M20');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E4', 'M21');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_name FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event GROUP BY T1.event_id HAVING COUNT(T2.link_to_event) > 20;

/*
Gold Result:
('Event TwentyOne',)
*/

-- Prediction Query
SELECT T1.event_name FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event INNER JOIN budget AS T3 ON T1.event_id = T3.link_to_event WHERE T3.category <> 'Fundraising' GROUP BY T1.event_id HAVING COUNT(T2.link_to_member) > 20;

/*
Prediction Result:
*/