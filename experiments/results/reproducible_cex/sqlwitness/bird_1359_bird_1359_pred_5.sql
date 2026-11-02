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
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('Yearly Kickoff', 'Advertisement', 'Yearly Kickoff', NULL, 'Yearly Kickoff', NULL, 'default1'), ('default2', 'October Meeting', 'Advertisement', 'Advertisement', 'default2', 'October Meeting', NULL), ('October Meeting', 'default1', 'October Meeting', 'Meeting', 'Yearly Kickoff', 'October Meeting', 'October Meeting'), ('Meeting', 'default1', 'Meeting', 'Advertisement', 'default1', 'Meeting', 'Advertisement'), ('default1', 'Yearly Kickoff', NULL, NULL, 'Advertisement', 'default1', 'default1'), ('Advertisement', NULL, 'Yearly Kickoff', 'default1', 'default2', 'default2', 'default2'), ('unique_6', NULL, 'Meeting', 'Yearly Kickoff', 'default1', 'October Meeting', NULL), ('unique_7', 'default1', NULL, NULL, 'Advertisement', 'Yearly Kickoff', NULL), ('unique_8', 'October Meeting', NULL, 'Meeting', 'Yearly Kickoff', 'Yearly Kickoff', 'Meeting'), ('unique_9', NULL, NULL, 'October Meeting', 'Meeting', 'Yearly Kickoff', 'October Meeting'), ('unique_10', 'Advertisement', 'default2', 'Meeting', 'Advertisement', 'default2', 'October Meeting'), ('unique_11', 'Yearly Kickoff', 'default1', 'default2', NULL, 'Meeting', 'default2'), ('unique_12', 'default1', 'Yearly Kickoff', 'October Meeting', 'default2', 'Yearly Kickoff', 'Advertisement'), ('unique_13', 'default2', 'default2', 'default2', 'default1', 'default1', 'default1'), ('unique_14', 'default1', 'Yearly Kickoff', 'October Meeting', 'Meeting', 'October Meeting', 'Yearly Kickoff'), ('unique_15', 'default1', 'default1', 'Advertisement', NULL, 'default1', NULL), ('unique_16', 'October Meeting', 'Yearly Kickoff', 'Advertisement', 'default1', 'Yearly Kickoff', 'Yearly Kickoff'), ('unique_17', 'default2', 'Advertisement', 'Meeting', 'Meeting', 'default1', 'October Meeting'), ('unique_18', 'October Meeting', 'October Meeting', 'default1', 'October Meeting', 'Meeting', 'default2');
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('default2', 'default1', 'Yearly Kickoff', NULL, NULL, 1, 'default2'), ('default1', 'unique_16', 'default2', -1.0, 0.0, 1, 'Meeting'), ('Yearly Kickoff', NULL, 'default1', 0.0, 1.0, 0, 'Advertisement'), ('Advertisement', 'unique_9', NULL, 1.0, NULL, 0, 'Advertisement'), ('Meeting', 'unique_6', 'October Meeting', NULL, NULL, NULL, 'Yearly Kickoff'), ('October Meeting', 'Yearly Kickoff', 'default1', 0.0, NULL, -1, 'October Meeting'), ('unique_6', 'unique_14', 'default2', 0.0, 1.0, 0, 'Meeting'), ('unique_7', 'unique_10', 'default2', 0.0, 1.0, 1, 'Advertisement'), ('unique_8', 'October Meeting', 'Yearly Kickoff', 1.0, 1.0, 1, 'default2'), ('unique_9', 'unique_10', 'Yearly Kickoff', 1.0, NULL, 1, 'Advertisement'), ('unique_10', 'Yearly Kickoff', 'default1', 0.0, -1.0, -1, 'October Meeting'), ('unique_11', 'default2', 'Advertisement', -1.0, -1.0, 0, 'Meeting'), ('unique_12', 'unique_12', 'default1', -1.0, 0.0, -1, 'default1'), ('unique_13', 'default2', 'default1', NULL, 0.0, NULL, NULL), ('unique_14', 'unique_11', NULL, NULL, -1.0, NULL, 'Yearly Kickoff'), ('unique_15', 'October Meeting', 'Yearly Kickoff', 0.0, -1.0, NULL, 'default1'), ('unique_16', 'Advertisement', 'Advertisement', 0.0, NULL, NULL, 'October Meeting'), ('unique_17', 'unique_16', 'Advertisement', 1.0, 0.0, -1, 'Advertisement'), ('unique_18', NULL, 'default2', NULL, -1.0, NULL, 'Advertisement');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN T2.event_name = 'Yearly Kickoff' THEN T1.amount ELSE 0 END) AS REAL) / SUM(CASE WHEN T2.event_name = 'October Meeting' THEN T1.amount ELSE 0 END) FROM budget AS T1 INNER JOIN event AS T2 ON T1.link_to_event = T2.event_id WHERE T1.category = 'Advertisement' AND T2.type = 'Meeting';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T1.link_to_event IN (SELECT event_id FROM event WHERE event_name = 'Yearly Kickoff') THEN T1.amount ELSE 0 END) AS REAL) / SUM(CASE WHEN T1.link_to_event IN (SELECT event_id FROM event WHERE event_name = 'October Meeting') THEN T1.amount ELSE 0 END) FROM budget AS T1 WHERE T1.category = 'Advertisement';

/*
Prediction Result:
(-0.0,)
*/