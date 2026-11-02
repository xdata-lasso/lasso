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
-- Tests SELECT vs SELECT DISTINCT when two distinct events both exceed 20 attendances and share the exact same event_name.
-- Also tests COUNT(T2.link_to_event) vs COUNT(DISTINCT T2.link_to_event) and vs COUNT(T1.notes) when notes is NULL.
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (20001, 'Standard', 'Washington', 'DC', 'District of Columbia', 'DC');
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ2', 'Mathematics', 'Math', 'Science');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M1', 'A', 'B', '1@a.com', 'P', 'S', '1', 20001, 'MAJ2');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M2', 'A', 'B', '2@a.com', 'P', 'S', '2', 20001, 'MAJ2');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M3', 'A', 'B', '3@a.com', 'P', 'S', '3', 20001, 'MAJ2');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M4', 'A', 'B', '4@a.com', 'P', 'S', '4', 20001, 'MAJ2');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M5', 'A', 'B', '5@a.com', 'P', 'S', '5', 20001, 'MAJ2');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M6', 'A', 'B', '6@a.com', 'P', 'S', '6', 20001, 'MAJ2');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M7', 'A', 'B', '7@a.com', 'P', 'S', '7', 20001, 'MAJ2');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M8', 'A', 'B', '8@a.com', 'P', 'S', '8', 20001, 'MAJ2');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M9', 'A', 'B', '9@a.com', 'P', 'S', '9', 20001, 'MAJ2');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M10', 'A', 'B', '10@a.com', 'P', 'S', '10', 20001, 'MAJ2');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M11', 'A', 'B', '11@a.com', 'P', 'S', '11', 20001, 'MAJ2');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M12', 'A', 'B', '12@a.com', 'P', 'S', '12', 20001, 'MAJ2');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M13', 'A', 'B', '13@a.com', 'P', 'S', '13', 20001, 'MAJ2');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M14', 'A', 'B', '14@a.com', 'P', 'S', '14', 20001, 'MAJ2');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M15', 'A', 'B', '15@a.com', 'P', 'S', '15', 20001, 'MAJ2');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M16', 'A', 'B', '16@a.com', 'P', 'S', '16', 20001, 'MAJ2');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M17', 'A', 'B', '17@a.com', 'P', 'S', '17', 20001, 'MAJ2');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M18', 'A', 'B', '18@a.com', 'P', 'S', '18', 20001, 'MAJ2');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M19', 'A', 'B', '19@a.com', 'P', 'S', '19', 20001, 'MAJ2');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M20', 'A', 'B', '20@a.com', 'P', 'S', '20', 20001, 'MAJ2');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M21', 'A', 'B', '21@a.com', 'P', 'S', '21', 20001, 'MAJ2');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M22', 'A', 'B', '22@a.com', 'P', 'S', '22', 20001, 'MAJ2');
-- EV_A and EV_B have the same event_name 'Annual Gala', and NULL in other columns to kill mutants counting nullable event columns
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('EV_A', 'Annual Gala', NULL, NULL, NULL, NULL, NULL);
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('EV_B', 'Annual Gala', '2023-05-01', 'Social', 'Notes', 'Hall', 'Open');
-- 21 attendances for EV_A
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('EV_A', 'M1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('EV_A', 'M2');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('EV_A', 'M3');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('EV_A', 'M4');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('EV_A', 'M5');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('EV_A', 'M6');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('EV_A', 'M7');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('EV_A', 'M8');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('EV_A', 'M9');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('EV_A', 'M10');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('EV_A', 'M11');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('EV_A', 'M12');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('EV_A', 'M13');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('EV_A', 'M14');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('EV_A', 'M15');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('EV_A', 'M16');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('EV_A', 'M17');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('EV_A', 'M18');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('EV_A', 'M19');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('EV_A', 'M20');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('EV_A', 'M21');
-- 22 attendances for EV_B
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('EV_B', 'M1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('EV_B', 'M2');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('EV_B', 'M3');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('EV_B', 'M4');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('EV_B', 'M5');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('EV_B', 'M6');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('EV_B', 'M7');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('EV_B', 'M8');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('EV_B', 'M9');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('EV_B', 'M10');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('EV_B', 'M11');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('EV_B', 'M12');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('EV_B', 'M13');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('EV_B', 'M14');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('EV_B', 'M15');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('EV_B', 'M16');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('EV_B', 'M17');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('EV_B', 'M18');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('EV_B', 'M19');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('EV_B', 'M20');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('EV_B', 'M21');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('EV_B', 'M22');
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
SELECT T1.event_name FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event WHERE T1.type <> 'fundraiser' GROUP BY T1.event_id HAVING COUNT(T2.link_to_event) > 20;

/*
Prediction Result:
('Annual Gala',)
*/