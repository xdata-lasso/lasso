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
-- DATASET 3
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ1', 'History', 'Hist', 'Arts');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (30001, 'Standard', 'Atlanta', 'Fulton', 'Georgia', 'GA');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E1', 'women''s soccer', '2023-11-01', 'Sports', NULL, 'Field', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E2', 'Women''s Soccer Championship', '2023-11-02', 'Sports', NULL, 'Field', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E3', 'Women''s Soccer', '2023-11-03', 'Sports', NULL, 'Field', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E4', NULL, '2023-11-04', 'Sports', NULL, 'Field', 'Open');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M1', 'Hank', 'Wilson', 'hank@example.com', 'member', 'XL', '333-444-5555', 30001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M2', 'Ivy', 'Moore', 'ivy@example.com', 'Board Member', 'S', '333-444-5556', 30001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M3', 'Jack', 'Taylor', 'jack@example.com', NULL, 'M', '333-444-5557', 30001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M4', 'Kara', 'Anderson', 'kara@example.com', 'Member', 'L', '333-444-5558', 30001, 'MAJ1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M4');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E2', 'M4');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E3', 'M1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E3', 'M2');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E3', 'M3');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E4', 'M4');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E3', 'M4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.last_name FROM attendance AS T1 INNER JOIN event AS T2 ON T2.event_id = T1.link_to_event INNER JOIN member AS T3 ON T1.link_to_member = T3.member_id WHERE T2.event_name = 'Women''s Soccer' AND T3.position = 'Member';

/*
Gold Result:
('Anderson',)
*/

-- Prediction Query
SELECT T3.last_name FROM attendance AS T1 INNER JOIN event AS T2 ON T1.link_to_event = T2.event_id INNER JOIN member AS T3 ON T1.link_to_member = T3.member_id WHERE T2.event_name LIKE 'Women%' AND T3.position = 'Member';

/*
Prediction Result:
('Anderson',)
('Anderson',)
('Anderson',)
*/