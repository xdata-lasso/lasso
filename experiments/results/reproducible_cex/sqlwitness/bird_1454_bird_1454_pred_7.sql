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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (100, 'default1', 'Meeting', NULL, 'Game', 'Meeting'), (1, NULL, NULL, 'default1', 'Game', 'default1'), (0, 'default1', 'Game', 'default2', NULL, NULL), (-1, 'default1', 'default1', 'Meeting', 'default2', 'Meeting'), (99, NULL, 'default1', 'Meeting', 'Meeting', 'default2'), (101, 'Game', 'Game', 'Meeting', 'default2', 'Game'), (2, 'default1', 'Meeting', 'default1', 'default2', 'default2'), (3, 'default1', NULL, 'Meeting', NULL, 'Meeting'), (4, 'default1', 'Game', NULL, 'Game', 'default1'), (5, NULL, 'default1', 'default1', 'default2', NULL);
INSERT INTO major (major_id, major_name, department, college) VALUES ('default1', 'default1', 'Game', NULL), ('default2', 'Meeting', 'Game', 'Game'), ('Game', 'Meeting', NULL, 'Game'), ('Meeting', NULL, 'default1', 'Game'), ('unique_4', NULL, 'Game', 'Game'), ('unique_5', 'default2', 'Game', NULL), ('unique_6', 'default2', NULL, 'Game'), ('unique_7', 'Game', 'Game', NULL), ('unique_8', 'default1', 'Meeting', 'Game'), ('unique_9', 'default2', 'Game', 'Game'), ('unique_10', NULL, 'default1', NULL), ('unique_11', NULL, 'default2', 'Meeting'), ('unique_12', 'Game', 'Meeting', 'default2');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('default2', 'unique_12', 5, 'Game', 'Game', 'default1', 'Meeting', NULL, 'default2'), ('Game', 'default2', 3, 'default1', 'default1', 'Meeting', 'default1', 'default2', 'Game'), ('Meeting', 'unique_6', -1, 'Meeting', 'default2', 'Game', 'default2', 'default2', NULL), ('default1', 'unique_9', 5, 'default2', 'default1', 'Meeting', 'default2', NULL, NULL), ('unique_4', NULL, 101, 'default1', 'Meeting', NULL, 'default1', 'default1', NULL), ('unique_5', 'unique_7', 1, 'default2', 'default2', 'default1', 'Meeting', 'default1', 'default2'), ('unique_6', 'unique_9', 101, 'Game', 'default2', 'default2', 'Game', 'Game', 'Game'), ('unique_7', 'unique_11', 3, NULL, 'Game', NULL, 'Game', NULL, 'default1'), ('unique_8', 'default1', -1, 'Game', NULL, 'Meeting', NULL, 'Meeting', 'Game'), ('unique_9', 'default2', 101, 'Game', 'Game', 'Game', 'default2', 'Meeting', 'Meeting'), ('unique_10', 'default1', 3, 'default1', NULL, 'Meeting', 'default2', NULL, 'default1');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('default2', 'default2', 'default1', 'Game', 'default2', 'Game', 'Game'), ('Meeting', 'Game', 'default2', NULL, NULL, 'default1', 'default2'), ('Game', 'Game', 'Game', NULL, NULL, 'Game', NULL), ('default1', NULL, NULL, 'Meeting', 'Meeting', 'Meeting', 'default2'), ('unique_4', 'default2', 'Meeting', NULL, 'default2', 'default2', 'default2'), ('unique_5', 'default1', 'default2', 'Game', 'Meeting', 'Meeting', 'Meeting'), ('unique_6', 'default1', 'Game', 'Meeting', 'default1', NULL, 'Meeting');
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('Game', 'unique_4', NULL, -1.0, NULL, 100, 'default1'), ('Meeting', 'unique_6', NULL, 0.0, NULL, -1, 'default2'), ('default2', 'unique_6', 'Meeting', 1.0, NULL, 0, 'Meeting'), ('default1', 'unique_6', NULL, 1.0, 101.0, 100, 'default1'), ('unique_4', 'default2', NULL, 100.0, 99.0, 99, 'Game'), ('unique_5', 'default1', 'Game', NULL, 100.0, 0, 'Meeting'), ('unique_6', 'unique_5', 'default2', 0.0, NULL, 100, 'default2'), ('unique_7', NULL, 'default1', 101.0, 1.0, 99, 'Game'), ('unique_8', 'default1', 'default1', 1.0, -1.0, 101, 'default2');
INSERT INTO expense (expense_id, link_to_budget, link_to_member, expense_description, expense_date, cost, approved) VALUES ('default1', 'unique_5', 'unique_6', 'Meeting', 'Meeting', 99.0, 'Meeting'), ('Game', 'Meeting', 'default1', 'Meeting', 'default1', 0.0, 'Meeting'), ('Meeting', 'unique_4', NULL, 'Game', 'Meeting', 101.0, NULL), ('default2', 'unique_7', 'default2', 'default2', 'default2', 101.0, 'default2'), ('unique_4', 'unique_4', 'Game', 'default2', 'default2', NULL, 'Meeting');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(CASE WHEN T1.type = 'Game' THEN T3.cost ELSE 0 END) * 100 / SUM(T3.cost) FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget;

/*
Gold Result:
(50.5,)
*/

-- Prediction Query
SELECT CAST(SUM(expense.cost) AS REAL) * 100 / COUNT(event.event_id) FROM event INNER JOIN budget ON event.event_id = budget.link_to_event INNER JOIN expense ON budget.budget_id = expense.link_to_budget WHERE event.type = 'Meeting';

/*
Prediction Result:
(4950.0,)
*/