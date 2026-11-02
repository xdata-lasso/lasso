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
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('Parking', 'default2', 'default2', 'default2', 'default1', NULL, 'default2'), ('November Speaker', 'Parking', 'default1', 'Parking', 'November Speaker', 'default1', 'Parking'), ('default2', 'default1', 'Parking', 'Parking', 'default1', 'default2', NULL), ('default1', 'November Speaker', 'default2', 'November Speaker', 'default1', 'default1', 'November Speaker'), ('unique_4', 'November Speaker', 'default2', 'default2', 'Parking', 'default1', 'default1'), ('unique_5', 'default1', 'default1', 'default2', 'Parking', 'default1', 'Parking'), ('unique_6', NULL, NULL, 'November Speaker', 'default1', 'default2', NULL), ('unique_7', 'default2', NULL, 'default1', 'default2', 'November Speaker', NULL), ('unique_8', 'Parking', 'November Speaker', 'November Speaker', NULL, 'default2', 'November Speaker'), ('unique_9', NULL, 'Parking', 'default1', 'November Speaker', 'default1', 'default2'), ('unique_10', 'Parking', 'default2', NULL, NULL, 'Parking', 'November Speaker'), ('unique_11', 'November Speaker', 'Parking', 'November Speaker', 'Parking', 'Parking', 'default1'), ('unique_12', 'default2', 'default2', 'November Speaker', 'Parking', 'Parking', 'default1'), ('unique_13', 'Parking', 'default1', 'default2', 'default1', 'November Speaker', 'Parking'), ('unique_14', 'default2', NULL, 'Parking', 'default1', NULL, 'Parking'), ('unique_15', 'Parking', NULL, 'Parking', 'default2', 'default1', 'default2'), ('unique_16', 'Parking', 'Parking', 'default2', 'November Speaker', NULL, 'November Speaker');
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('default1', 'unique_5', 'default2', 101.0, 100.0, 100, 'default2'), ('Parking', 'default1', 'default2', 100.0, 0.0, 101, 'default2'), ('default2', 'unique_4', 'November Speaker', 101.0, 100.0, 0, 'default2'), ('November Speaker', 'unique_5', 'default2', 1.0, 100.0, 100, 'Parking'), ('unique_4', 'unique_16', NULL, 100.0, 101.0, 0, 'default1'), ('unique_5', 'unique_11', NULL, -1.0, 99.0, -1, NULL), ('unique_6', 'Parking', NULL, -1.0, 99.0, 101, 'November Speaker');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN T1.category = 'Parking' THEN T1.amount ELSE 0 END) AS REAL) * 100 / SUM(T1.amount) FROM budget AS T1 INNER JOIN event AS T2 ON T1.link_to_event = T2.event_id WHERE T2.event_name = 'November Speaker';

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT (SUM(b."amount") FILTER(WHERE b."category" = 'Parking') * 100.0 / SUM(b."amount")) AS percentage FROM "budget" AS b INNER JOIN "event" AS e ON b."link_to_event" = e."event_id" WHERE e."event_name" = 'November Speaker';

/*
Prediction Result:
(None,)
*/