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
-- Tests the necessity of SUBSTRING(event_date, 1, 10) vs raw string comparison or direct DATE(event_date) on the upper boundary, and tests invalid date strings that fall alphabetically within the range.
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('e1', 'Upper Bound With Timestamp', '2020-03-31T18:30:00', 'Social', 'Has timestamp', 'Auditorium', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('e2', 'Upper Bound With Suffix', '2020-03-31_extra_text', 'Meeting', 'Invalid full date but valid 10-char prefix', 'Library', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('e3', 'Invalid Date In Lexical Range', '2020-02-31T12:00:00', 'Game', 'Feb 31 is not a valid date', 'Gym', 'Planning');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('e4', 'Null Date', NULL, 'Other', 'Null date check', 'Nowhere', 'Closed');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT event_id, location, status FROM event WHERE DATE(SUBSTRING(event_date, 1, 10)) BETWEEN '2019-11-01' AND '2020-03-31';

/*
Gold Result:
('e1', 'Auditorium', 'Open')
('e2', 'Library', 'Closed')
('e3', 'Gym', 'Planning')
*/

-- Prediction Query
SELECT event_id, location, status FROM event WHERE event_date BETWEEN '2019-11-01' AND '2020-03-31';

/*
Prediction Result:
('e3', 'Gym', 'Planning')
*/