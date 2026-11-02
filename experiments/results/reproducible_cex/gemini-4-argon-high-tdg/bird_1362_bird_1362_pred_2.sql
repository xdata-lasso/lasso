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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (22960, NULL, 'Orange', 'Orange County', 'Virginia', NULL);
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (22961, 'Standard', NULL, 'Orange County', 'Virginia', 'VA');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (22962, 'PO Box', NULL, 'Orange County', 'Virginia', 'VA');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (22963, 'Standard', 'Locust Grove', NULL, 'Virginia', 'VA');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (22964, 'Standard', 'Unionville', 'Orange County', NULL, 'VA');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(city) FROM zip_code WHERE county = 'Orange County' AND state = 'Virginia';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) AS city_count FROM zip_code WHERE county = 'Orange County' AND state = 'Virginia';

/*
Prediction Result:
(3,)
*/