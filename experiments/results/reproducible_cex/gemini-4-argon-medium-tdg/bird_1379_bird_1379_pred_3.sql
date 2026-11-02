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
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E1', 'Exact Year', '2020', 'Meeting', 'N1', 'L1', 'S1');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E2', 'End Year', '05-15-2020', 'Meeting', 'N2', 'L2', 'S2');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E3', 'Sub Type', '2020-08-01', 'Annual Meeting', 'N3', 'L3', 'S3');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E4', 'Lowercase', '2020-08-02', 'meeting', 'N4', 'L4', 'S4');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E5', 'Standard Match', '2020-11-30', 'Meeting', 'N5', 'L5', 'S5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(event_id) FROM event WHERE type = 'Meeting' AND SUBSTRING(event_date, 1, 4) = '2020';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(*) FROM event WHERE type = 'Meeting' AND STRFTIME('%Y', event_date) = '2020';

/*
Prediction Result:
(1,)
*/