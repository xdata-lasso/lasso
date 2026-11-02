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
-- Tests difference between COUNT(type) and COUNT(*) when type is NULL, and tests CASE sensitivity / substring matching on 'Community Service'.
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('e1', 'Food Drive', '2019-01-01', 'Community Service', 'Notes', 'Center', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('e2', 'Bake Sale', '2019-02-01', 'Fundraising', 'Notes', 'Quad', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('e3', 'Mystery Event', '2019-03-01', NULL, 'Unassigned type', 'Unknown', 'Open');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('e4', 'Extra Service', '2019-04-01', 'Community Service Extra', 'Should not match exact equality', 'Center', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('e5', 'Lower Service', '2019-05-01', 'community service', 'Case check', 'Center', 'Closed');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN type = 'Community Service' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(type) FROM event WHERE SUBSTRING(event_date, 1, 4) = '2019';

/*
Gold Result:
(25.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN type = 'Community Service' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(event_id) FROM event WHERE event_date BETWEEN '2019-01-01' AND '2019-12-31';

/*
Prediction Result:
(20.0,)
*/