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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (101, NULL, 'default1', 'Game', 'Meeting', 'Meeting'), (99, 'Game', 'Game', 'Game', 'default2', 'Meeting'), (0, 'default2', 'default1', NULL, 'Meeting', 'Meeting');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('default1', NULL, 0, 'default2', 'default1', 'Meeting', 'default1', 'Game', 'default2'), ('Game', NULL, 101, NULL, 'default2', 'Meeting', 'Meeting', 'default2', NULL);
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('Meeting', 'Meeting', 'default2', 'default1', 'Meeting', 'default2', 'default1'), ('default2', 'Game', 'Meeting', NULL, 'Game', 'default1', 'default2'), ('Game', 'Game', 'Game', 'default1', NULL, 'Game', NULL), ('default1', 'default2', 'default1', 'Meeting', 'default2', 'default1', 'Meeting');
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('default1', 'Game', 'Game', 1.0, 0.0, NULL, 'Game'), ('default2', NULL, 'Meeting', 100.0, 0.0, 99, 'Game'), ('Meeting', 'default1', 'Meeting', NULL, 101.0, NULL, 'Meeting'), ('Game', 'Game', 'default1', 0.0, 0.0, 0, 'default2'), ('unique_4', NULL, 'default2', 100.0, 1.0, -1, 'Meeting'), ('unique_5', 'Game', 'Meeting', -1.0, 100.0, 1, 'default2'), ('unique_6', NULL, 'default1', 99.0, NULL, NULL, 'Game'), ('unique_7', 'default2', 'default2', 1.0, 0.0, -1, 'Meeting');
INSERT INTO expense (expense_id, link_to_budget, link_to_member, expense_description, expense_date, cost, approved) VALUES ('default2', 'unique_7', NULL, 'default2', NULL, 99.0, 'Meeting'), ('Meeting', 'default1', 'Game', 'default1', 'Game', 1.0, NULL), ('Game', 'Game', 'default1', 'default1', 'default2', 0.0, 'default2'), ('default1', 'Game', NULL, 'default1', 'default2', 1.0, 'Meeting'), ('unique_4', 'unique_4', 'default1', NULL, 'default2', 101.0, 'Game'), ('unique_5', 'Game', NULL, 'Meeting', 'Meeting', 1.0, 'default1'), ('unique_6', 'unique_4', 'default1', 'Game', NULL, NULL, 'default1'), ('unique_7', NULL, 'Game', 'default2', 'default2', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(CASE WHEN T1.type = 'Game' THEN T3.cost ELSE 0 END) * 100 / SUM(T3.cost) FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT CAST(SUM(T1.cost) AS REAL) * 100.0 / SUM(T2.spent) AS percentage FROM expense AS T1 INNER JOIN budget AS T2 ON T1.link_to_budget = T2.budget_id INNER JOIN event AS e ON T2.link_to_event = e.event_id WHERE e.type = 'Meeting';

/*
Prediction Result:
(None,)
*/