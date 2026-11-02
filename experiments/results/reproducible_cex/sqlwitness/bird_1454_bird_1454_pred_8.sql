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
INSERT INTO major (major_id, major_name, department, college) VALUES ('default2', 'default1', 'default1', 'default2'), ('default1', 'Game', 'Meeting', 'Meeting'), ('Meeting', NULL, 'Game', 'Game'), ('Game', 'default1', 'Game', NULL);
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('Meeting', 'default1', NULL, NULL, 'default1', 'Game', 'Game', NULL, NULL);
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('default1', 'Game', NULL, NULL, 'default2', NULL, 'default1'), ('Game', 'Meeting', 'Meeting', 'Game', 'Game', 'Game', 'default1'), ('Meeting', 'Game', 'default1', 'default2', 'default1', 'Game', 'default1');
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('Meeting', 'Game', NULL, NULL, 101.0, 99, 'Meeting'), ('Game', 'Meeting', 'default1', 0.0, 100.0, 100, NULL), ('default1', 'Meeting', 'default2', 0.0, NULL, 99, 'default2'), ('default2', 'Game', 'default1', 1.0, 0.0, -1, 'Game');
INSERT INTO expense (expense_id, link_to_budget, link_to_member, expense_description, expense_date, cost, approved) VALUES ('Meeting', 'Meeting', 'Meeting', 'default2', 'default1', 1.0, 'Meeting'), ('default1', 'Game', NULL, 'Meeting', 'Meeting', NULL, 'Game'), ('Game', 'Meeting', NULL, 'Meeting', 'default1', 0.0, 'Game');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(CASE WHEN T1.type = 'Game' THEN T3.cost ELSE 0 END) * 100 / SUM(T3.cost) FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget;

/*
Gold Result:
(100.0,)
*/

-- Prediction Query
SELECT CAST(SUM(T3.cost) AS REAL) * 100 / COUNT(T1.event_id) FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget WHERE T1.type = 'Meeting';

/*
Prediction Result:
(None,)
*/