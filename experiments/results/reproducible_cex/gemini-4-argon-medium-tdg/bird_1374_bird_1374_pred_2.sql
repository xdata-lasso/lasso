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
-- Tests basic counting, multiple members sharing the target phone number,
-- overlapping event attendance (tests COUNT vs COUNT(DISTINCT)),
-- non-matching phone numbers, and target member with no attendance (tests INNER vs LEFT JOIN + COUNT(*)).
INSERT INTO event (event_id, event_name) VALUES ('E1', 'Orientation');
INSERT INTO event (event_id, event_name) VALUES ('E2', 'Workshop');
INSERT INTO event (event_id, event_name) VALUES ('E3', 'Seminar');
INSERT INTO major (major_id, major_name) VALUES ('MAJ1', 'Computer Science');
INSERT INTO zip_code (zip_code, city, state) VALUES (10001, 'New York', 'NY');
INSERT INTO member (member_id, first_name, last_name, phone, zip, link_to_major) VALUES ('M1', 'Alice', 'Smith', '954-555-6240', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, phone, zip, link_to_major) VALUES ('M2', 'Bob', 'Smith', '954-555-6240', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, phone, zip, link_to_major) VALUES ('M3', 'Charlie', 'Brown', '954-555-0000', 10001, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, phone, zip, link_to_major) VALUES ('M4', 'Diana', 'Prince', '954-555-6240', 10001, 'MAJ1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E2', 'M1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E1', 'M2');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E3', 'M3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T2.link_to_event) FROM member AS T1 INNER JOIN attendance AS T2 ON T1.member_id = T2.link_to_member WHERE T1.phone = '954-555-6240';

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM attendance WHERE link_to_member = (SELECT member_id FROM member WHERE phone = '954-555-6240');

/*
Prediction Result:
(2,)
*/