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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (1, 'true', 'true', 'default1', NULL, 'default2'), (0, 'default2', 'default2', 'default1', 'true', 'true'), (2, 'default1', NULL, 'default2', 'default1', 'true');
INSERT INTO major (major_id, major_name, department, college) VALUES ('October Meeting', NULL, 'true', 'October Meeting'), ('true', NULL, 'true', 'default2'), ('default1', NULL, 'true', NULL), ('default2', NULL, 'true', NULL), ('unique_4', 'true', 'default2', NULL), ('unique_5', 'default1', 'default1', 'default1'), ('unique_6', 'true', NULL, 'default1'), ('unique_7', 'default2', 'true', NULL), ('unique_8', 'true', 'default1', 'default1'), ('unique_9', 'default2', 'October Meeting', 'default1'), ('unique_10', 'true', 'default2', 'default2');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('true', 'default2', 0, 'default1', 'true', 'default1', 'default1', 'default1', 'true'), ('default2', 'unique_10', 2, 'default2', NULL, NULL, 'default2', 'default2', 'true'), ('default1', 'unique_5', NULL, NULL, 'default1', 'default2', NULL, 'true', 'October Meeting'), ('October Meeting', 'October Meeting', 1, 'true', 'October Meeting', 'default2', 'October Meeting', 'default2', 'default2');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('true', 'default2', 'true', 'true', 'October Meeting', 'October Meeting', 'October Meeting'), ('default2', 'October Meeting', 'October Meeting', 'true', 'default1', NULL, 'true'), ('October Meeting', NULL, NULL, 'October Meeting', 'default1', 'default1', 'default1');
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('true', 'true', 'October Meeting', 1.0, NULL, 1, 'true'), ('default2', NULL, 'default1', 1.0, NULL, NULL, 'default2'), ('default1', 'October Meeting', 'default2', 0.0, 0.0, 0, 'true'), ('October Meeting', NULL, 'default2', NULL, NULL, 1, 'default2'), ('unique_4', 'true', 'October Meeting', NULL, NULL, 1, 'default1'), ('unique_5', NULL, 'default2', 0.0, 1.0, NULL, 'default1'), ('unique_6', 'default2', NULL, NULL, NULL, 1, 'October Meeting'), ('unique_7', 'October Meeting', 'true', 0.0, 1.0, NULL, 'default1'), ('unique_8', 'default2', 'true', NULL, NULL, NULL, 'October Meeting');
INSERT INTO expense (expense_id, link_to_budget, link_to_member, expense_description, expense_date, cost, approved) VALUES ('October Meeting', 'unique_6', 'default2', NULL, 'true', 0.0, NULL), ('true', 'unique_5', 'true', 'default1', NULL, 1.0, 'default2'), ('default1', 'default1', NULL, 'default1', 'default1', 0.0, NULL), ('default2', 'unique_4', 'October Meeting', 'true', 'default2', 1.0, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.type, SUM(T3.cost) FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget WHERE T1.event_name = 'October Meeting';

/*
Gold Result:
('true', 0.0)
*/

-- Prediction Query
SELECT T3.event_name, SUM(T2.cost) FROM budget AS T1 INNER JOIN expense AS T2 ON T1.budget_id = T2.link_to_budget INNER JOIN event AS T3 ON T1.link_to_event = T3.event_id WHERE T3.event_name = 'October Meeting' AND T2.approved = 'true';

/*
Prediction Result:
(None, None)
*/