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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (0, NULL, 'Orange County', 'default1', 'default2', 'default2'), (1, NULL, NULL, NULL, 'Orange County', 'default2'), (2, 'Orange County', 'default1', 'Virginia', 'default1', NULL), (3, 'default2', 'default2', 'default1', 'Virginia', NULL), (4, NULL, 'default2', 'default1', 'default1', 'default2'), (5, 'default2', NULL, 'Orange County', 'Orange County', 'Orange County'), (6, NULL, 'Orange County', NULL, NULL, 'Orange County'), (7, 'default1', 'Virginia', 'default2', NULL, NULL), (8, NULL, 'default1', 'Orange County', 'Virginia', NULL), (9, 'default1', 'default1', 'default1', 'default2', 'Orange County'), (10, 'default2', 'default1', NULL, 'default2', 'Orange County'), (11, 'default1', 'Orange County', 'Virginia', 'default1', 'Virginia'), (12, NULL, NULL, NULL, 'Virginia', 'default2'), (13, NULL, NULL, 'default2', 'Virginia', NULL), (14, 'Virginia', 'Virginia', 'Virginia', 'Virginia', 'default1'), (15, 'Orange County', 'Virginia', 'default1', 'default2', 'default2'), (16, 'default1', 'Virginia', NULL, 'Virginia', 'Orange County'), (17, NULL, 'default1', 'Orange County', 'default2', 'Orange County'), (18, 'default2', 'default2', 'Orange County', 'default2', 'Virginia'), (19, 'Virginia', 'default1', 'Orange County', 'Virginia', 'default2'), (20, 'Virginia', 'Orange County', 'default1', 'default2', 'Orange County'), (21, 'Orange County', 'default2', 'default2', 'default1', 'default1'), (22, 'Virginia', 'default1', 'default2', 'default1', 'default2'), (23, 'default1', NULL, 'default1', NULL, 'Virginia'), (24, NULL, NULL, 'default1', NULL, 'Orange County'), (25, 'Orange County', NULL, 'Orange County', 'Virginia', 'Virginia'), (26, NULL, NULL, 'default1', 'Orange County', 'Virginia');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(city) FROM zip_code WHERE county = 'Orange County' AND state = 'Virginia';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(*) AS city_count FROM zip_code WHERE county = 'Orange County' AND state = 'Virginia';

/*
Prediction Result:
(3,)
*/