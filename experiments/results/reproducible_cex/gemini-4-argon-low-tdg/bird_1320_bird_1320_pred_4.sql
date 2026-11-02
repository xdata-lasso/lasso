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
-- Tests DISTINCT vs ALL (bag semantics), multiple events per member, and multiple 'Maya Mclean' members attending the same event.
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (20001, 'Standard', 'Washington', 'District of Columbia', 'District of Columbia', 'DC');
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ2', 'Mathematics', 'Math', 'Science');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E10', 'Coding Bootcamp', '2023-11-01', 'Workshop', 'Bring laptop', 'Room 101', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E20', 'Coding Bootcamp', '2023-11-05', 'Workshop', 'Repeat session', 'Room 102', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E30', 'Hackathon', '2023-11-10', 'Competition', '24 hours', 'Main Gym', 'Open');
INSERT INTO "member" (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M10', 'Maya', 'Mclean', 'maya1@example.com', 'Member', 'M', '555-0201', 20001, 'MAJ2');
INSERT INTO "member" (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M20', 'Maya', 'Mclean', 'maya2@example.com', 'Officer', 'L', '555-0202', 20001, 'MAJ2');
INSERT INTO "member" (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M30', 'Alice', 'Wonder', 'alice@example.com', 'Member', 'S', '555-0203', 20001, 'MAJ2');
INSERT INTO "attendance" (link_to_event, link_to_member) VALUES ('E10', 'M10');
INSERT INTO "attendance" (link_to_event, link_to_member) VALUES ('E10', 'M20');
INSERT INTO "attendance" (link_to_event, link_to_member) VALUES ('E20', 'M10');
INSERT INTO "attendance" (link_to_event, link_to_member) VALUES ('E30', 'M10');
INSERT INTO "attendance" (link_to_event, link_to_member) VALUES ('E30', 'M30');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_name FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event INNER JOIN member AS T3 ON T2.link_to_member = T3.member_id WHERE T3.first_name = 'Maya' AND T3.last_name = 'Mclean';

/*
Gold Result:
('Coding Bootcamp',)
('Coding Bootcamp',)
('Coding Bootcamp',)
('Hackathon',)
*/

-- Prediction Query
SELECT DISTINCT e.event_name FROM member AS m INNER JOIN attendance AS a ON m.member_id = a.link_to_member INNER JOIN event AS e ON a.link_to_event = e.event_id WHERE m.first_name = 'Maya' AND m.last_name = 'Mclean';

/*
Prediction Result:
('Coding Bootcamp',)
('Hackathon',)
*/