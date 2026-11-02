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
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ1', 'Computer Science', 'CS', 'Engineering');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M1', 'Alice', 'Smith', 'a1@test.com', 'Member', 'M', '111-1111', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M2', 'Bob', 'Smith', 'a2@test.com', 'Member', 'M', '111-1112', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M3', 'Charlie', 'Smith', 'a3@test.com', 'Member', 'M', '111-1113', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M4', 'David', 'Smith', 'a4@test.com', 'Member', 'M', '111-1114', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M5', 'Eve', 'Smith', 'a5@test.com', 'Member', 'M', '111-1115', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M6', 'Frank', 'Smith', 'a6@test.com', 'Member', 'M', '111-1116', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M7', 'Grace', 'Smith', 'a7@test.com', 'Member', 'M', '111-1117', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M8', 'Heidi', 'Smith', 'a8@test.com', 'Member', 'M', '111-1118', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M9', 'Ivan', 'Smith', 'a9@test.com', 'Member', 'M', '111-1119', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M10', 'Judy', 'Smith', 'a10@test.com', 'Member', 'M', '111-1120', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M11', 'Karl', 'Smith', 'a11@test.com', 'Member', 'M', '111-1121', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M12', 'Leo', 'Smith', 'a12@test.com', 'Member', 'M', '111-1122', 10001, 'MAJ1');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E1', 'Board Sync', '2023-01-01', 'Meeting', 'N1', 'Room A', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E2', 'Team Sync', '2023-01-02', 'Meeting', 'N2', 'Room B', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E3', 'Unattended Sync', '2023-01-03', 'Meeting', 'N3', 'Room C', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E4', 'Meeting', '2023-01-04', 'Social', 'N4', 'Hall', 'Meeting');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M2');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M3');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M4');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M5');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M6');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E2', 'M1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E2', 'M2');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E2', 'M3');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E2', 'M4');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E2', 'M5');
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
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E4', 'M11');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E4', 'M12');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.event_id) FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event WHERE T1.type = 'Meeting' GROUP BY T1.type HAVING COUNT(T2.link_to_event) > 10;

/*
Gold Result:
(11,)
*/

-- Prediction Query
SELECT COUNT(T1.type) FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event WHERE T1.type = 'Meeting' GROUP BY T2.link_to_event HAVING COUNT(T2.link_to_event) > 10;

/*
Prediction Result:
*/