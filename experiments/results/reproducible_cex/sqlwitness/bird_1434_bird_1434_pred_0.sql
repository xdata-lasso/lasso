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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (1, 'PO Box', NULL, 'San Juan Municipio', 'San Juan Municipio', 'PO Box'), (0, 'San Juan Municipio', 'default1', 'Puerto Rico', 'default1', 'default2'), (2, 'San Juan Municipio', 'San Juan Municipio', 'default1', 'San Juan Municipio', 'San Juan'), (3, 'PO Box', 'San Juan Municipio', 'PO Box', 'San Juan Municipio', 'default1'), (4, 'Puerto Rico', 'PO Box', 'default2', 'Puerto Rico', 'San Juan Municipio'), (5, 'default1', NULL, 'default2', NULL, 'default2'), (6, 'default1', 'Puerto Rico', 'San Juan Municipio', 'PO Box', 'default1'), (7, 'default2', 'San Juan Municipio', 'PO Box', 'San Juan', 'default1'), (8, 'PO Box', 'San Juan Municipio', 'San Juan Municipio', 'Puerto Rico', 'Puerto Rico'), (9, 'San Juan', 'default2', 'PO Box', 'PO Box', 'default1'), (10, NULL, 'default1', 'PO Box', 'Puerto Rico', NULL), (11, 'San Juan Municipio', 'San Juan', 'Puerto Rico', 'PO Box', 'default1'), (12, 'San Juan Municipio', 'default2', 'PO Box', 'San Juan', 'default1'), (13, 'San Juan', 'Puerto Rico', 'San Juan Municipio', 'Puerto Rico', 'default2'), (14, NULL, NULL, 'San Juan Municipio', 'PO Box', 'Puerto Rico'), (15, 'PO Box', 'Puerto Rico', NULL, NULL, 'San Juan'), (16, 'default1', 'default2', NULL, 'San Juan Municipio', NULL), (17, 'Puerto Rico', 'San Juan', 'Puerto Rico', 'default1', NULL), (18, 'San Juan Municipio', NULL, 'PO Box', 'default2', 'default2'), (19, 'default2', 'PO Box', 'default1', 'San Juan', 'PO Box'), (20, 'Puerto Rico', 'default2', 'Puerto Rico', NULL, 'San Juan'), (21, NULL, 'San Juan', 'San Juan', 'default1', 'default1'), (22, 'PO Box', 'Puerto Rico', 'default1', NULL, 'PO Box'), (23, 'San Juan Municipio', 'San Juan Municipio', 'PO Box', 'Puerto Rico', 'San Juan Municipio'), (24, 'San Juan', 'San Juan', 'San Juan Municipio', 'default1', 'PO Box'), (25, 'Puerto Rico', NULL, 'default2', 'San Juan Municipio', 'PO Box'), (26, 'PO Box', 'San Juan Municipio', 'default2', 'Puerto Rico', NULL), (27, 'San Juan', 'San Juan', 'Puerto Rico', 'PO Box', 'San Juan Municipio');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT zip_code FROM zip_code WHERE type = 'PO Box' AND county = 'San Juan Municipio' AND state = 'Puerto Rico';

/*
Gold Result:
(8,)
*/

-- Prediction Query
SELECT zip_code FROM zip_code WHERE type = 'PO Box' AND city = 'San Juan' AND county = 'San Juan Municipio' AND state = 'Puerto Rico';

/*
Prediction Result:
*/