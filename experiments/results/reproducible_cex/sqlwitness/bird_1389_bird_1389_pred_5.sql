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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (1, 'Open', NULL, 'default1', 'default2', NULL), (0, 'default1', 'default1', NULL, NULL, 'default2'), (2, 'default1', 'default1', NULL, 'Open', NULL), (3, NULL, 'default1', NULL, 'default2', NULL), (4, 'Open', NULL, NULL, NULL, 'default2');
INSERT INTO major (major_id, major_name, department, college) VALUES ('Open', 'default2', 'Open', NULL), ('default2', NULL, 'Open', 'Open'), ('default1', NULL, 'Open', 'default1'), ('unique_3', 'Open', 'Open', 'Open'), ('unique_4', NULL, 'Open', 'default2'), ('unique_5', 'default2', NULL, 'default1');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('default2', 'unique_4', 2, 'Open', NULL, 'default1', NULL, 'Open', NULL), ('default1', 'unique_4', 4, 'default1', 'Open', 'Open', 'Open', 'default2', NULL), ('Open', 'unique_5', 0, 'Open', 'default1', 'Open', 'default2', 'default2', 'Open'), ('unique_3', 'unique_4', 1, 'default1', 'Open', NULL, NULL, 'default1', 'Open'), ('unique_4', 'unique_4', 0, 'default2', 'default1', 'default1', 'default1', 'Open', 'default2'), ('unique_5', 'unique_4', 1, NULL, 'Open', 'Open', NULL, NULL, NULL), ('unique_6', 'default2', 2, 'default2', NULL, 'default2', 'default2', 'default2', 'default2'), ('unique_7', 'unique_4', NULL, 'default2', 'default2', 'Open', 'Open', 'Open', 'default2'), ('unique_8', 'default1', 3, 'Open', 'default1', 'default2', NULL, 'default1', 'default2'), ('unique_9', 'Open', NULL, 'default1', 'default2', 'default2', NULL, 'default2', 'default2'), ('unique_10', 'unique_3', NULL, 'default1', 'default1', NULL, NULL, NULL, 'default1'), ('unique_11', 'unique_5', NULL, 'default2', 'Open', 'default2', 'default2', 'default2', 'default1'), ('unique_12', 'unique_5', 2, 'default2', 'default1', 'default2', 'Open', NULL, 'default1');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('default2', 'Open', 'default2', NULL, 'default2', 'default2', 'Open'), ('Open', 'Open', 'default1', NULL, 'default2', NULL, NULL), ('default1', NULL, NULL, 'default2', 'default2', 'Open', NULL), ('unique_3', 'Open', 'default2', 'default1', 'default2', 'Open', 'default1'), ('unique_4', 'default1', 'default2', NULL, 'Open', NULL, 'default2'), ('unique_5', 'Open', NULL, 'default1', 'default1', 'Open', 'Open'), ('unique_6', NULL, 'default2', NULL, 'Open', 'Open', 'default2'), ('unique_7', NULL, NULL, 'default1', NULL, 'default1', NULL), ('unique_8', 'default2', 'default1', 'default1', NULL, 'Open', 'Open'), ('unique_9', NULL, NULL, 'Open', 'Open', NULL, 'default1'), ('unique_10', 'default1', 'default2', 'default1', 'Open', 'default1', 'default1'), ('unique_11', 'default1', 'default1', 'Open', NULL, 'default2', NULL), ('unique_12', 'default2', NULL, NULL, 'default1', NULL, 'Open');
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('default2', 'unique_6', 'default1', 1.0, 1.0, 2, 'default1'), ('Open', NULL, NULL, 1.0, 0.0, 1, 'default1'), ('default1', NULL, 'default2', 1.0, 1.0, 1, 'default1'), ('unique_3', 'default2', 'default1', 0.0, 1.0, 1, 'default2'), ('unique_4', 'unique_4', NULL, 0.0, NULL, 0, 'default1'), ('unique_5', 'unique_10', 'Open', 0.0, 2.0, 1, 'Open'), ('unique_6', 'unique_10', NULL, 2.0, 1.0, 0, 'default1');
INSERT INTO expense (expense_id, link_to_budget, link_to_member, expense_description, expense_date, cost, approved) VALUES ('Open', 'unique_6', NULL, 'Open', 'default2', 2.0, 'Open'), ('default1', 'unique_3', 'unique_9', 'default2', 'default1', 2.0, 'default2'), ('default2', 'default1', 'unique_4', 'default1', NULL, NULL, 'Open');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_name FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget ORDER BY T3.cost, T1.event_id NULLS LAST, T2.budget_id NULLS LAST, T3.expense_id NULLS LAST LIMIT 1;

/*
Gold Result:
('Open',)
*/

-- Prediction Query
SELECT T1.event_name FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.event_status = 'Open' ORDER BY T3.cost ASC, T1.event_id NULLS LAST, T2.budget_id NULLS LAST, T3.expense_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('default1',)
*/