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
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E10', 'Late Oct Event', '2019-10-31T23:59:59', 'Social', 'N10', 'Hall A', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E11', 'Early Nov Event', '2019-11-01T00:00:00', 'Meeting', 'N11', 'Hall B', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E12', 'Midday Nov Event', '2019-11-01T14:30:00', 'Workshop', 'N12', 'Hall C', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E13', 'Late March Afternoon', '2020-03-31T18:45:00', 'Election', 'N13', 'Hall D', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E14', 'Late March Night', '2020-03-31T23:59:59', 'Social', 'N14', 'Hall E', 'Planned');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E15', 'Early April Event', '2020-04-01T00:00:00', 'Meeting', 'N15', 'Hall F', 'Planned');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT event_id, location, status FROM event WHERE DATE(SUBSTRING(event_date, 1, 10)) BETWEEN '2019-11-01' AND '2020-03-31';

/*
Gold Result:
('E11', 'Hall B', 'Closed')
('E12', 'Hall C', 'Open')
('E13', 'Hall D', 'Open')
('E14', 'Hall E', 'Planned')
*/

-- Prediction Query
SELECT event_id, location, status FROM event WHERE event_date BETWEEN '2019-11-01' AND '2020-03-31';

/*
Prediction Result:
('E11', 'Hall B', 'Closed')
('E12', 'Hall C', 'Open')
*/