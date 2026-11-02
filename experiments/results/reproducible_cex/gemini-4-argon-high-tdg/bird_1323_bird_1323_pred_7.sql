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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (10001, 'Standard', 'New York', 'New York', 'New York', 'NY');
INSERT INTO major (major_id, major_name, department, college) VALUES ('CS', 'Computer Science', 'CS Dept', 'Engineering');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E1', 'Event Twenty', '2023-01-01', 'Social', 'Note 1', 'Room A', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E2', 'Event Twenty-One', NULL, NULL, NULL, NULL, NULL);
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E3', 'Event Zero', '2023-01-03', 'Meeting', 'Note 3', 'Room C', 'Closed');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M01', 'F1', 'L1', 'm01@test.com', 'Member', 'M', '111-0001', 10001, 'CS');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M02', 'F2', 'L2', 'm02@test.com', 'Member', 'M', '111-0002', 10001, 'CS');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M03', 'F3', 'L3', 'm03@test.com', 'Member', 'M', '111-0003', 10001, 'CS');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M04', 'F4', 'L4', 'm04@test.com', 'Member', 'M', '111-0004', 10001, 'CS');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M05', 'F5', 'L5', 'm05@test.com', 'Member', 'M', '111-0005', 10001, 'CS');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M06', 'F6', 'L6', 'm06@test.com', 'Member', 'M', '111-0006', 10001, 'CS');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M07', 'F7', 'L7', 'm07@test.com', 'Member', 'M', '111-0007', 10001, 'CS');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M08', 'F8', 'L8', 'm08@test.com', 'Member', 'M', '111-0008', 10001, 'CS');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M09', 'F9', 'L9', 'm09@test.com', 'Member', 'M', '111-0009', 10001, 'CS');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M10', 'F10', 'L10', 'm10@test.com', 'Member', 'M', '111-0010', 10001, 'CS');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M11', 'F11', 'L11', 'm11@test.com', 'Member', 'M', '111-0011', 10001, 'CS');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M12', 'F12', 'L12', 'm12@test.com', 'Member', 'M', '111-0012', 10001, 'CS');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M13', 'F13', 'L13', 'm13@test.com', 'Member', 'M', '111-0013', 10001, 'CS');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M14', 'F14', 'L14', 'm14@test.com', 'Member', 'M', '111-0014', 10001, 'CS');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M15', 'F15', 'L15', 'm15@test.com', 'Member', 'M', '111-0015', 10001, 'CS');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M16', 'F16', 'L16', 'm16@test.com', 'Member', 'M', '111-0016', 10001, 'CS');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M17', 'F17', 'L17', 'm17@test.com', 'Member', 'M', '111-0017', 10001, 'CS');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M18', 'F18', 'L18', 'm18@test.com', 'Member', 'M', '111-0018', 10001, 'CS');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M19', 'F19', 'L19', 'm19@test.com', 'Member', 'M', '111-0019', 10001, 'CS');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M20', 'F20', 'L20', 'm20@test.com', 'Member', 'M', '111-0020', 10001, 'CS');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M21', 'F21', 'L21', 'm21@test.com', 'Member', 'M', '111-0021', 10001, 'CS');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M01');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M02');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M03');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M04');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M05');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M06');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M07');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M08');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M09');
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
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E2', 'M01');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E2', 'M02');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E2', 'M03');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E2', 'M04');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E2', 'M05');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E2', 'M06');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E2', 'M07');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E2', 'M08');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E2', 'M09');
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
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E2', 'M21');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_name FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event GROUP BY T1.event_id HAVING COUNT(T2.link_to_event) > 20;

/*
Gold Result:
('Event Twenty-One',)
*/

-- Prediction Query
SELECT DISTINCT event.event_name FROM event INNER JOIN attendance ON event.event_id = attendance.link_to_event WHERE event.type <> 'fundraiser' GROUP BY event.event_id HAVING COUNT(attendance.link_to_member) > 20;

/*
Prediction Result:
*/