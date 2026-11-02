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
-- DATASET 4
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ1', 'Physics', 'Science', 'Science');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (73301, 'Standard', 'Austin', 'Travis', 'Texas', 'TX');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M1', 'Sacha', 'Harrison', 'sacha@example.com', 'Member', 'M', '555-0401', 73301, 'MAJ1');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E1', 'ISO Date Event', '2019-02-14', 'Social', 'Standard ISO', 'Room 1', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E2', 'US Date Event', '02/14/2019', 'Social', 'Year at end', 'Room 2', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E3', 'Compact Date Event', '20190214', 'Social', 'No hyphens', 'Room 3', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E4', 'Year Only Event', '2019', 'Social', 'Exact year string', 'Room 4', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E5', 'Shifted Date Event', ' 2019-05-01', 'Social', 'Leading space', 'Room 5', 'Closed');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E2', 'M1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E3', 'M1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E4', 'M1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E5', 'M1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.event_id) FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event INNER JOIN member AS T3 ON T2.link_to_member = T3.member_id WHERE T3.first_name = 'Sacha' AND T3.last_name = 'Harrison' AND SUBSTRING(T1.event_date, 1, 4) = '2019';

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM member AS m JOIN attendance AS a ON m.member_id = a.link_to_member JOIN event AS e ON a.link_to_event = e.event_id WHERE m.first_name = 'Sacha' AND m.last_name = 'Harrison' AND STRFTIME('%Y', e.event_date) = '2019';

/*
Prediction Result:
(1,)
*/