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
-- Tests GROUP BY column mistakes (grouping by first_name, last_name, or both instead of member_id) and SELECT DISTINCT mutations.
-- M1 and M2 share both first_name and last_name, with 4 events each (sum = 8 > 7, but individually <= 7).
-- M3 and M4 share both first_name and last_name, with 8 events each (both qualify, should return 2 identical rows, testing DISTINCT).
-- M5 and M6 share only first_name, with 5 events each (sum = 10 > 7).
-- M7 and M8 share only last_name, with 5 events each (sum = 10 > 7).
INSERT INTO major (major_id, major_name, department, college) VALUES ('maj1', 'Math', 'Math', 'Science');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (20001, 'Standard', 'Washington', 'DC', 'DC', 'DC');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('e1', 'E1', '2023-01-01', 'Meeting', '', 'Loc1', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('e2', 'E2', '2023-01-02', 'Meeting', '', 'Loc1', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('e3', 'E3', '2023-01-03', 'Meeting', '', 'Loc1', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('e4', 'E4', '2023-01-04', 'Meeting', '', 'Loc1', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('e5', 'E5', '2023-01-05', 'Meeting', '', 'Loc1', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('e6', 'E6', '2023-01-06', 'Meeting', '', 'Loc1', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('e7', 'E7', '2023-01-07', 'Meeting', '', 'Loc1', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('e8', 'E8', '2023-01-08', 'Meeting', '', 'Loc1', 'Open');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('m1', 'John', 'Smith', 'js1@test.com', 'Member', 'L', '222-0001', 20001, 'maj1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('m2', 'John', 'Smith', 'js2@test.com', 'Member', 'L', '222-0002', 20001, 'maj1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('m3', 'Jane', 'Doe', 'jd1@test.com', 'Member', 'S', '222-0003', 20001, 'maj1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('m4', 'Jane', 'Doe', 'jd2@test.com', 'Member', 'S', '222-0004', 20001, 'maj1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('m5', 'Alice', 'Wonder', 'aw@test.com', 'Member', 'M', '222-0005', 20001, 'maj1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('m6', 'Alice', 'Walker', 'awk@test.com', 'Member', 'M', '222-0006', 20001, 'maj1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('m7', 'Bob', 'Brown', 'bb1@test.com', 'Member', 'XL', '222-0007', 20001, 'maj1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('m8', 'Charlie', 'Brown', 'cb@test.com', 'Member', 'XL', '222-0008', 20001, 'maj1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e1', 'm1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e2', 'm1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e3', 'm1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e4', 'm1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e5', 'm2');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e6', 'm2');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e7', 'm2');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e8', 'm2');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e1', 'm3');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e2', 'm3');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e3', 'm3');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e4', 'm3');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e5', 'm3');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e6', 'm3');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e7', 'm3');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e8', 'm3');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e1', 'm4');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e2', 'm4');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e3', 'm4');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e4', 'm4');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e5', 'm4');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e6', 'm4');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e7', 'm4');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e8', 'm4');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e1', 'm5');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e2', 'm5');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e3', 'm5');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e4', 'm5');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e5', 'm5');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e1', 'm6');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e2', 'm6');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e3', 'm6');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e4', 'm6');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e5', 'm6');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e1', 'm7');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e2', 'm7');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e3', 'm7');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e4', 'm7');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e5', 'm7');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e1', 'm8');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e2', 'm8');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e3', 'm8');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e4', 'm8');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('e5', 'm8');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.first_name, T1.last_name FROM member AS T1 INNER JOIN attendance AS T2 ON T1.member_id = T2.link_to_member GROUP BY T2.link_to_member HAVING COUNT(T2.link_to_event) > 7;

/*
Gold Result:
('Jane', 'Doe')
('Jane', 'Doe')
*/

-- Prediction Query
SELECT member.first_name, member.last_name FROM member INNER JOIN attendance ON member.member_id = attendance.link_to_member GROUP BY member.first_name, member.last_name HAVING COUNT(attendance.link_to_event) > 7;

/*
Prediction Result:
('Jane', 'Doe')
('John', 'Smith')
*/