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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (0, NULL, 'Game', 'default1', 'default1', 'default1'), (101, 'default2', 'Game', 'default2', NULL, NULL), (100, 'Game', 'default2', 'default2', 'Game', 'Game'), (-1, 'Game', 'Game', 'Game', 'Game', 'default1'), (99, 'Game', 'default2', 'Game', NULL, 'Game'), (1, 'default1', 'default1', NULL, 'default1', 'default1'), (2, NULL, 'default1', 'default1', 'Game', NULL), (3, NULL, 'default2', 'default1', 'default1', 'default1'), (4, 'default2', NULL, 'default2', 'default1', 'default2');
INSERT INTO major (major_id, major_name, department, college) VALUES ('default2', 'Game', 'Game', 'default1'), ('default1', 'default2', 'Game', NULL), ('Game', 'Game', 'Game', 'Game'), ('unique_3', 'Game', 'default1', 'default2'), ('unique_4', 'default1', 'default1', 'Game'), ('unique_5', NULL, 'Game', NULL), ('unique_6', 'default1', 'default2', 'default2'), ('unique_7', 'default1', NULL, 'default1'), ('unique_8', NULL, 'Game', 'Game'), ('unique_9', 'default1', 'Game', 'Game'), ('unique_10', NULL, 'default2', NULL);
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('Game', 'unique_5', 101, NULL, 'default2', 'Game', 'Game', 'Game', 'default1'), ('default1', 'Game', 3, 'default1', 'default2', 'default1', 'default1', 'default2', 'Game'), ('default2', 'unique_6', 100, 'default2', 'default2', NULL, NULL, NULL, NULL), ('unique_3', 'unique_3', 99, 'default1', 'default1', 'default1', 'Game', 'Game', NULL), ('unique_4', 'unique_3', 100, 'Game', 'default2', 'default2', 'default1', 'default1', NULL), ('unique_5', NULL, 100, 'default2', 'Game', 'default2', 'default2', 'default1', 'Game'), ('unique_6', 'unique_5', 0, 'default2', 'default2', NULL, 'default1', 'default1', 'default2'), ('unique_7', 'unique_9', 4, 'default2', NULL, 'default1', NULL, 'default1', NULL), ('unique_8', 'unique_3', 1, 'Game', 'Game', 'default2', 'default1', 'default2', NULL), ('unique_9', 'unique_5', 101, 'default2', NULL, 'default2', 'default1', 'default1', 'default1');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('Game', 'Game', 'Game', 'default1', 'Game', NULL, 'Game'), ('default2', 'default2', 'Game', NULL, 'Game', 'default2', 'Game'), ('default1', NULL, NULL, NULL, NULL, 'default2', 'Game'), ('unique_3', 'Game', 'default2', 'default1', NULL, NULL, NULL), ('unique_4', 'default2', 'Game', NULL, 'default1', 'default1', 'Game'), ('unique_5', NULL, NULL, 'Game', 'default1', 'default1', 'Game'), ('unique_6', 'default2', NULL, 'default1', 'default1', 'Game', 'Game');
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('default1', 'Game', NULL, 100.0, 99.0, 1, 'default2'), ('default2', 'Game', 'Game', 0.0, 100.0, -1, NULL), ('Game', 'Game', NULL, 0.0, NULL, 1, 'default2'), ('unique_3', 'unique_3', 'default1', NULL, 101.0, 100, 'default2'), ('unique_4', 'default1', NULL, NULL, 0.0, 101, 'default1'), ('unique_5', 'unique_4', 'default2', 1.0, 0.0, 100, NULL), ('unique_6', 'default2', NULL, -1.0, 1.0, 101, 'default1'), ('unique_7', 'unique_4', NULL, NULL, 101.0, -1, 'default2'), ('unique_8', 'default1', NULL, 99.0, 100.0, 101, 'default2');
INSERT INTO expense (expense_id, link_to_budget, link_to_member, expense_description, expense_date, cost, approved) VALUES ('Game', 'unique_7', 'default2', NULL, 'Game', 101.0, 'default1'), ('default1', 'unique_6', 'unique_6', NULL, 'default2', NULL, NULL), ('default2', NULL, 'Game', 'default1', NULL, 99.0, 'default2'), ('unique_3', 'unique_6', 'unique_6', NULL, NULL, 0.0, NULL), ('unique_4', 'unique_8', 'unique_9', NULL, 'default1', NULL, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(CASE WHEN T1.type = 'Game' THEN T3.cost ELSE 0 END) * 100 / SUM(T3.cost) FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT CAST(SUM(T3.cost) AS REAL) * 100 / COUNT(T1.event_id) AS percentage_cost FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget WHERE T1.type = 'Game' AND NOT T3.cost IS NULL;

/*
Prediction Result:
(None,)
*/