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
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('Yearly Kickoff', NULL, 'Yearly Kickoff', 'Advertisement', NULL, 'October Meeting', 'October Meeting'), ('Advertisement', 'Advertisement', 'default2', 'Meeting', 'default1', 'default2', 'Yearly Kickoff'), ('default1', 'Yearly Kickoff', 'Yearly Kickoff', 'default2', 'default2', 'October Meeting', 'default1'), ('default2', 'Yearly Kickoff', 'Meeting', NULL, 'October Meeting', 'Meeting', 'Meeting'), ('October Meeting', 'default1', 'Advertisement', 'Advertisement', 'October Meeting', NULL, NULL), ('Meeting', 'default2', 'default2', 'Advertisement', 'default2', 'Meeting', 'Yearly Kickoff'), ('unique_6', 'Advertisement', 'Yearly Kickoff', 'default2', 'Meeting', 'Yearly Kickoff', 'Yearly Kickoff'), ('unique_7', NULL, 'Yearly Kickoff', 'Yearly Kickoff', 'default1', 'default1', 'Meeting'), ('unique_8', 'default1', 'October Meeting', 'default1', 'default2', 'October Meeting', 'October Meeting'), ('unique_9', 'Yearly Kickoff', 'default1', 'Meeting', NULL, 'default2', 'Yearly Kickoff'), ('unique_10', 'Advertisement', 'Meeting', NULL, 'Meeting', 'October Meeting', 'October Meeting'), ('unique_11', 'Meeting', 'Advertisement', NULL, NULL, 'Advertisement', 'Yearly Kickoff'), ('unique_12', 'October Meeting', 'default2', 'Meeting', 'default1', 'Advertisement', 'Yearly Kickoff'), ('unique_13', 'Yearly Kickoff', 'Meeting', 'Yearly Kickoff', 'Advertisement', NULL, 'Meeting'), ('unique_14', 'October Meeting', NULL, 'Meeting', 'Meeting', 'default2', NULL), ('unique_15', 'October Meeting', 'Advertisement', NULL, 'default2', 'Advertisement', 'Meeting'), ('unique_16', 'Advertisement', 'Meeting', 'default2', 'Advertisement', 'default1', 'October Meeting'), ('unique_17', 'Yearly Kickoff', 'Yearly Kickoff', 'default1', 'Meeting', 'October Meeting', 'default1'), ('unique_18', 'Advertisement', NULL, 'default2', 'default2', 'default1', NULL);
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('default1', 'Yearly Kickoff', 'default2', NULL, -1.0, -1, 'Advertisement'), ('October Meeting', 'unique_7', 'October Meeting', 0.0, NULL, -1, NULL), ('default2', 'unique_18', 'Yearly Kickoff', -1.0, 0.0, -1, 'default1'), ('Meeting', 'unique_15', 'Advertisement', -1.0, NULL, 1, 'October Meeting'), ('Advertisement', 'Yearly Kickoff', 'Meeting', NULL, 1.0, 0, 'Yearly Kickoff'), ('Yearly Kickoff', 'Advertisement', 'October Meeting', NULL, 1.0, NULL, NULL), ('unique_6', 'default2', 'default1', -1.0, 1.0, -1, 'October Meeting'), ('unique_7', 'default1', 'default1', -1.0, NULL, 1, 'default2'), ('unique_8', 'Advertisement', 'default2', NULL, 1.0, 1, 'October Meeting'), ('unique_9', 'unique_6', 'Yearly Kickoff', NULL, 0.0, -1, 'Advertisement'), ('unique_10', 'unique_11', 'Meeting', -1.0, NULL, 0, NULL), ('unique_11', 'unique_7', 'Advertisement', -1.0, 1.0, 0, 'default1'), ('unique_12', 'unique_18', 'default2', -1.0, 1.0, 0, 'October Meeting'), ('unique_13', NULL, NULL, 1.0, NULL, -1, 'Advertisement'), ('unique_14', 'unique_8', NULL, NULL, NULL, -1, 'October Meeting'), ('unique_15', 'unique_17', 'Yearly Kickoff', NULL, 0.0, NULL, 'default1'), ('unique_16', 'default1', 'Meeting', 0.0, NULL, 0, 'default1'), ('unique_17', 'Advertisement', 'October Meeting', -1.0, NULL, 0, NULL), ('unique_18', 'unique_7', 'October Meeting', 1.0, -1.0, 0, 'Advertisement'), ('unique_19', 'unique_8', 'default1', NULL, NULL, 1, 'default2'), ('unique_20', 'unique_17', NULL, -1.0, -1.0, -1, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN T2.event_name = 'Yearly Kickoff' THEN T1.amount ELSE 0 END) AS REAL) / SUM(CASE WHEN T2.event_name = 'October Meeting' THEN T1.amount ELSE 0 END) FROM budget AS T1 INNER JOIN event AS T2 ON T1.link_to_event = T2.event_id WHERE T1.category = 'Advertisement' AND T2.type = 'Meeting';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT SUM(CASE WHEN T2.event_name = 'Yearly Kickoff' THEN T1.amount ELSE 0 END) / SUM(CASE WHEN T2.event_name = 'October Meeting' THEN T1.amount ELSE 0 END) AS budget_ratio FROM budget AS T1 INNER JOIN event AS T2 ON T1.link_to_event = T2.event_id WHERE T1.category = 'Advertisement';

/*
Prediction Result:
(0,)
*/