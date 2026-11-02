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
INSERT INTO major (major_id, major_name, department, college) VALUES ('maj_1', 'Computer Science', 'CS', 'Engineering');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (10001, 'Standard', 'New York', 'New York', 'New York', 'NY');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('ev_1', 'October Meeting', '2023-10-01', 'Meeting', 'October Meeting', 'Room 101', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('ev_2', 'October Meeting', '2023-10-15', 'Meeting', 'Follow up', 'Room 102', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('ev_3', 'November Meeting', '2023-11-01', 'October Meeting', 'October Meeting', 'October Meeting', 'October Meeting');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('ev_4', 'october meeting', '2023-10-20', 'Meeting', 'Case test', 'Room 103', 'Closed');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('mem_1', 'Alice', 'Smith', 'alice@example.com', 'Member', 'M', '111-222-3333', 10001, 'maj_1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('mem_2', 'Bob', 'Jones', 'bob@example.com', 'President', 'L', '222-333-4444', 10001, 'maj_1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('mem_3', 'Charlie', 'Brown', 'charlie@example.com', 'Secretary', 'S', '333-444-5555', 10001, 'maj_1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('mem_4', 'October Meeting', 'October Meeting', 'oct@example.com', 'October Meeting', 'XL', '444-555-6666', 10001, 'maj_1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('ev_1', 'mem_1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('ev_2', 'mem_1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('ev_2', 'mem_2');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('ev_3', 'mem_2');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('ev_3', 'mem_3');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('ev_4', 'mem_3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.member_id FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event INNER JOIN member AS T3 ON T2.link_to_member = T3.member_id WHERE T1.event_name = 'October Meeting';

/*
Gold Result:
('mem_1',)
('mem_2',)
*/

-- Prediction Query
SELECT DISTINCT member.first_name, member.last_name FROM member INNER JOIN attendance ON member.member_id = attendance.link_to_member INNER JOIN event ON attendance.link_to_event = event.event_id WHERE event.event_name = 'October Meeting';

/*
Prediction Result:
('Alice', 'Smith')
('Bob', 'Jones')
*/