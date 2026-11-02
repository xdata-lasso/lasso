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
-- Tests exact boundary dates, off-by-one dates, and timestamps with time components (testing SUBSTRING(event_date, 1, 10) vs raw string comparison or missing DATE/SUBSTRING)
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('e1', 'Halloween Party', '2019-10-31T23:59:59', 'Social', 'Before start boundary', 'Hall A', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('e2', 'Nov Kickoff', '2019-11-01', 'Meeting', 'Exact start boundary without time', 'Room 101', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('e3', 'Nov Morning', '2019-11-01T08:30:00', 'Workshop', 'Exact start boundary with time', 'Room 102', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('e4', 'New Year Bash', '2020-01-15T12:00:00', 'Social', 'Middle of range', 'Main Quad', 'Planning');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('e5', 'March Finale', '2020-03-31', 'Meeting', 'Exact end boundary without time', 'Room 201', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('e6', 'March Late Night', '2020-03-31T23:59:59', 'Social', 'Exact end boundary with time (tests string <= 2020-03-31)', 'Room 202', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('e7', 'April Fools', '2020-04-01T00:00:00', 'Social', 'After end boundary', 'Hall B', 'Open');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT event_id, location, status FROM event WHERE DATE(SUBSTRING(event_date, 1, 10)) BETWEEN '2019-11-01' AND '2020-03-31';

/*
Gold Result:
('e2', 'Room 101', 'Open')
('e3', 'Room 102', 'Closed')
('e4', 'Main Quad', 'Planning')
('e5', 'Room 201', 'Open')
('e6', 'Room 202', 'Closed')
*/

-- Prediction Query
SELECT event_id, location, status FROM event WHERE event_date BETWEEN '2019-11-01' AND '2020-03-31';

/*
Prediction Result:
('e2', 'Room 101', 'Open')
('e3', 'Room 102', 'Closed')
('e4', 'Main Quad', 'Planning')
('e5', 'Room 201', 'Open')
*/