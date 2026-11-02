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
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ1', 'Mathematics', 'Math', 'Science');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E1', 'E1', '2023-02-01', 'Social', 'N1', 'Loc1', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E2', 'E2', '2023-02-02', 'Social', 'N2', 'Loc2', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E3', 'E3', '2023-02-03', 'Social', 'N3', 'Loc3', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E4', 'E4', '2023-02-04', 'Social', 'N4', 'Loc4', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E5', 'E5', '2023-02-05', 'Social', 'N5', 'Loc5', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E6', 'E6', '2023-02-06', 'Social', 'N6', 'Loc6', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E7', 'E7', '2023-02-07', 'Social', 'N7', 'Loc7', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E8', 'E8', '2023-02-08', 'Social', 'N8', 'Loc8', 'Open');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M1', 'John', 'Smith', 'john1@test.com', 'Member', 'M', '222-0001', 20001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M2', 'John', 'Smith', 'john2@test.com', 'Member', 'L', '222-0002', 20001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M3', 'Alice', 'Jones', 'alice1@test.com', 'Member', 'S', '222-0003', 20001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M4', 'Alice', 'Jones', 'alice2@test.com', 'Member', 'M', '222-0004', 20001, 'MAJ1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E2', 'M1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E3', 'M1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E4', 'M1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E5', 'M2');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E6', 'M2');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E7', 'M2');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E8', 'M2');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M3');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E2', 'M3');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E3', 'M3');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E4', 'M3');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E5', 'M3');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E6', 'M3');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E7', 'M3');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E8', 'M3');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M4');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E2', 'M4');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E3', 'M4');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E4', 'M4');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E5', 'M4');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E6', 'M4');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E7', 'M4');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E8', 'M4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.first_name, T1.last_name FROM member AS T1 INNER JOIN attendance AS T2 ON T1.member_id = T2.link_to_member GROUP BY T2.link_to_member HAVING COUNT(T2.link_to_event) > 7;

/*
Gold Result:
('Alice', 'Jones')
('Alice', 'Jones')
*/

-- Prediction Query
SELECT member.first_name, member.last_name FROM member INNER JOIN attendance ON member.member_id = attendance.link_to_member GROUP BY member.first_name, member.last_name HAVING COUNT(attendance.link_to_event) > 7;

/*
Prediction Result:
('Alice', 'Jones')
('John', 'Smith')
*/