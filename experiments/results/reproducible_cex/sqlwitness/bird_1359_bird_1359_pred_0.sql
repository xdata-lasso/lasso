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
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('October Meeting', 'October Meeting', 'October Meeting', 'Yearly Kickoff', 'default2', 'Yearly Kickoff', 'October Meeting'), ('Yearly Kickoff', 'October Meeting', 'October Meeting', 'October Meeting', 'default2', NULL, 'default2'), ('Meeting', 'Advertisement', 'Advertisement', 'Yearly Kickoff', 'Yearly Kickoff', 'Meeting', 'default1'), ('Advertisement', 'default2', 'Meeting', NULL, 'Yearly Kickoff', NULL, 'Yearly Kickoff'), ('default1', 'Yearly Kickoff', 'Meeting', NULL, 'Advertisement', NULL, 'Yearly Kickoff'), ('default2', 'Meeting', NULL, NULL, 'default2', 'Yearly Kickoff', 'Yearly Kickoff'), ('unique_6', 'default2', 'October Meeting', 'Yearly Kickoff', 'Meeting', 'Yearly Kickoff', 'Meeting'), ('unique_7', NULL, 'October Meeting', 'Yearly Kickoff', 'default2', 'October Meeting', 'Yearly Kickoff');
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('Advertisement', 'October Meeting', 'Meeting', NULL, -1.0, -1, 'default1'), ('default2', 'Advertisement', 'Yearly Kickoff', 0.0, NULL, 1, 'Yearly Kickoff'), ('Meeting', 'Advertisement', 'default2', 1.0, -1.0, NULL, 'Yearly Kickoff'), ('Yearly Kickoff', 'default2', 'Advertisement', NULL, 0.0, 1, 'October Meeting'), ('default1', NULL, 'default1', 0.0, 0.0, 1, 'default1'), ('October Meeting', 'Yearly Kickoff', 'Yearly Kickoff', 0.0, NULL, 1, 'Yearly Kickoff'), ('unique_6', 'October Meeting', 'Advertisement', 0.0, 1.0, -1, 'Advertisement'), ('unique_7', 'Yearly Kickoff', 'Yearly Kickoff', NULL, 1.0, 1, 'Advertisement'), ('unique_8', NULL, 'default2', -1.0, 1.0, 0, 'default1'), ('unique_9', 'default1', 'Advertisement', NULL, -1.0, 1, 'Yearly Kickoff'), ('unique_10', 'default1', 'default1', NULL, -1.0, -1, 'Advertisement'), ('unique_11', 'unique_7', 'Advertisement', 0.0, 1.0, 0, NULL), ('unique_12', 'default1', 'default2', -1.0, NULL, 0, 'Yearly Kickoff'), ('unique_13', 'Yearly Kickoff', 'Yearly Kickoff', -1.0, NULL, 0, NULL), ('unique_14', 'Meeting', 'Yearly Kickoff', 1.0, 0.0, 0, 'Meeting'), ('unique_15', 'default2', 'default2', 1.0, NULL, 0, 'Advertisement'), ('unique_16', NULL, 'Yearly Kickoff', 0.0, 1.0, 0, 'Yearly Kickoff'), ('unique_17', 'Meeting', 'default2', -1.0, 1.0, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN T2.event_name = 'Yearly Kickoff' THEN T1.amount ELSE 0 END) AS REAL) / SUM(CASE WHEN T2.event_name = 'October Meeting' THEN T1.amount ELSE 0 END) FROM budget AS T1 INNER JOIN event AS T2 ON T1.link_to_event = T2.event_id WHERE T1.category = 'Advertisement' AND T2.type = 'Meeting';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T1.category = 'Advertisement' AND T2.event_name = 'Yearly Kickoff' THEN T1.amount ELSE 0 END) AS REAL) / SUM(CASE WHEN T1.category = 'Advertisement' AND T2.event_name = 'October Meeting' THEN T1.amount ELSE 0 END) FROM budget AS T1 INNER JOIN event AS T2 ON T1.link_to_event = T2.event_id;

/*
Prediction Result:
(-1.0,)
*/