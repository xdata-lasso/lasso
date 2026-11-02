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
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('October Meeting', 'October Meeting', 'default1', 'default2', 'October Meeting', 'October Meeting', 'Yearly Kickoff'), ('Yearly Kickoff', NULL, 'Advertisement', 'Meeting', NULL, NULL, 'October Meeting'), ('Meeting', 'default1', 'Meeting', 'Yearly Kickoff', 'October Meeting', 'Yearly Kickoff', NULL), ('default2', 'default2', 'default2', 'Meeting', 'Yearly Kickoff', 'Advertisement', 'October Meeting'), ('Advertisement', 'October Meeting', 'October Meeting', NULL, 'default1', NULL, 'Advertisement'), ('default1', 'Meeting', 'Yearly Kickoff', 'October Meeting', 'Yearly Kickoff', 'default2', NULL), ('unique_6', 'October Meeting', 'default2', 'default2', 'Yearly Kickoff', 'default2', 'October Meeting'), ('unique_7', 'Advertisement', 'default2', 'Meeting', 'default1', 'Yearly Kickoff', 'default1'), ('unique_8', 'default2', 'Meeting', 'Yearly Kickoff', 'default2', 'October Meeting', 'default1'), ('unique_9', 'default1', 'Yearly Kickoff', 'default1', 'October Meeting', 'Yearly Kickoff', 'default2'), ('unique_10', 'Yearly Kickoff', 'Yearly Kickoff', 'October Meeting', 'default1', 'default1', 'Yearly Kickoff'), ('unique_11', 'default2', 'October Meeting', 'October Meeting', 'default1', 'default1', 'October Meeting'), ('unique_12', 'October Meeting', 'default1', 'default2', 'default2', 'default2', 'default1'), ('unique_13', 'October Meeting', 'default1', 'default1', NULL, 'Yearly Kickoff', 'default2'), ('unique_14', 'Meeting', NULL, NULL, 'default2', NULL, 'Yearly Kickoff'), ('unique_15', 'default1', 'Yearly Kickoff', 'default2', 'Advertisement', 'default2', 'Meeting'), ('unique_16', 'Advertisement', 'default2', 'Advertisement', 'October Meeting', 'Meeting', 'Meeting'), ('unique_17', 'Yearly Kickoff', 'Advertisement', 'October Meeting', 'October Meeting', 'Meeting', 'Meeting'), ('unique_18', 'Yearly Kickoff', 'Meeting', 'Meeting', 'October Meeting', 'October Meeting', 'Advertisement'), ('unique_19', 'Advertisement', 'Advertisement', NULL, NULL, 'Advertisement', 'Advertisement'), ('unique_20', 'Meeting', 'Yearly Kickoff', 'default1', 'Advertisement', 'default2', NULL), ('unique_21', 'Yearly Kickoff', 'October Meeting', 'Meeting', NULL, 'default2', 'October Meeting'), ('unique_22', NULL, 'Meeting', 'Advertisement', 'default1', 'Meeting', NULL);
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('October Meeting', 'unique_21', 'October Meeting', 1.0, NULL, NULL, 'default2'), ('default2', 'Meeting', 'Yearly Kickoff', -1.0, -1.0, 0, 'Yearly Kickoff'), ('Yearly Kickoff', 'unique_22', 'default2', 0.0, NULL, 1, 'default2'), ('Meeting', 'unique_10', 'Yearly Kickoff', 1.0, NULL, 1, 'Yearly Kickoff'), ('Advertisement', 'unique_9', 'default2', -1.0, 0.0, 0, 'October Meeting'), ('default1', 'unique_21', 'Meeting', 1.0, -1.0, 1, 'October Meeting'), ('unique_6', 'unique_22', 'default2', 0.0, 1.0, -1, 'Meeting'), ('unique_7', 'unique_6', 'Advertisement', 0.0, -1.0, 1, 'default2'), ('unique_8', 'unique_19', 'Meeting', 0.0, -1.0, -1, 'default1'), ('unique_9', 'Advertisement', 'Yearly Kickoff', 1.0, -1.0, 0, 'Advertisement'), ('unique_10', 'unique_21', 'Meeting', 1.0, 0.0, 0, 'Advertisement'), ('unique_11', 'unique_6', 'default2', -1.0, 1.0, 1, 'default1'), ('unique_12', 'unique_22', 'October Meeting', 1.0, 0.0, 0, 'Yearly Kickoff'), ('unique_13', 'unique_19', 'Advertisement', 0.0, -1.0, NULL, 'Advertisement'), ('unique_14', 'unique_19', 'October Meeting', NULL, NULL, 0, 'default2'), ('unique_15', 'October Meeting', 'Yearly Kickoff', 1.0, 0.0, 0, 'default1'), ('unique_16', 'unique_22', 'default2', NULL, -1.0, 1, 'default1'), ('unique_17', 'Yearly Kickoff', 'default1', -1.0, -1.0, 0, NULL), ('unique_18', 'unique_21', 'October Meeting', NULL, 1.0, 0, 'Advertisement'), ('unique_19', 'unique_20', 'default2', 1.0, 1.0, -1, 'default2'), ('unique_20', 'unique_16', NULL, NULL, 1.0, 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN T2.event_name = 'Yearly Kickoff' THEN T1.amount ELSE 0 END) AS REAL) / SUM(CASE WHEN T2.event_name = 'October Meeting' THEN T1.amount ELSE 0 END) FROM budget AS T1 INNER JOIN event AS T2 ON T1.link_to_event = T2.event_id WHERE T1.category = 'Advertisement' AND T2.type = 'Meeting';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T2.event_name = 'Yearly Kickoff' THEN T1.amount ELSE 0 END) AS REAL) / SUM(CASE WHEN T2.event_name = 'October Meeting' THEN T1.amount ELSE 0 END) FROM budget AS T1 INNER JOIN event AS T2 ON T1.link_to_event = T2.event_id WHERE T1.category = 'Advertisement';

/*
Prediction Result:
(0.0,)
*/