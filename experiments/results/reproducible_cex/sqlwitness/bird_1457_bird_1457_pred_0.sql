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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (0, 'default2', 'default1', 'default1', 'default1', NULL), (1, 'default1', NULL, NULL, 'default2', NULL), (2, NULL, 'default1', 'default2', NULL, 'default1'), (3, 'default2', NULL, 'default2', 'default2', 'default2'), (4, 'default1', 'default1', 'default1', 'default2', 'default1'), (5, 'default1', 'default1', 'default2', NULL, 'default1'), (6, NULL, 'default1', 'default1', 'default1', NULL), (7, 'default1', NULL, 'default2', 'default1', 'default1'), (8, 'default1', 'default2', 'default2', 'default1', 'default1'), (9, NULL, NULL, 'default2', NULL, 'default1'), (10, 'default2', 'default2', NULL, 'default1', NULL), (11, 'default1', 'default2', NULL, 'default1', NULL);
INSERT INTO major (major_id, major_name, department, college) VALUES ('default1', 'default2', 'default2', 'default2'), ('default2', NULL, NULL, 'default2'), ('unique_2', 'default2', 'default2', 'default2'), ('unique_3', 'default1', 'default2', 'default1'), ('unique_4', 'default2', NULL, 'default2'), ('unique_5', 'default1', 'default2', 'default1'), ('unique_6', 'default1', 'default2', NULL);
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('default2', 'unique_5', 4, 'default2', 'default2', 'default1', NULL, 'default2', NULL), ('default1', 'default2', 10, 'default2', 'default2', NULL, 'default2', 'default1', 'default1'), ('unique_2', 'unique_6', 10, NULL, 'default1', 'default2', NULL, 'default2', NULL), ('unique_3', 'unique_4', 6, 'default1', 'default1', NULL, 'default1', 'default2', NULL);
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('default2', 'default2', NULL, 'default1', 'default2', 'default2', 'default2'), ('default1', 'default2', NULL, 'default2', NULL, 'default2', NULL), ('unique_2', 'default2', 'default1', NULL, 'default1', NULL, 'default2'), ('unique_3', 'default2', 'default1', NULL, 'default1', NULL, 'default1'), ('unique_4', 'default2', 'default2', 'default1', 'default1', 'default2', NULL), ('unique_5', 'default2', 'default2', NULL, 'default2', 'default1', 'default1'), ('unique_6', 'default1', NULL, 'default2', 'default2', 'default2', NULL), ('unique_7', 'default2', 'default2', NULL, 'default2', NULL, NULL), ('unique_8', NULL, 'default2', 'default1', 'default1', 'default2', NULL), ('unique_9', 'default1', NULL, 'default2', 'default2', 'default1', 'default2'), ('unique_10', 'default2', 'default2', 'default2', 'default2', 'default1', NULL), ('unique_11', 'default2', 'default1', 'default2', 'default1', NULL, NULL), ('unique_12', NULL, 'default1', 'default2', 'default2', 'default1', 'default1'), ('unique_13', 'default1', NULL, 'default1', NULL, 'default1', 'default1');
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('default1', 'unique_4', 'default1', NULL, 0.0, NULL, 'default1'), ('default2', 'unique_12', NULL, 0.0, NULL, 0, NULL), ('unique_2', 'unique_12', 'default1', 0.0, 0.0, 0, NULL), ('unique_3', 'unique_12', 'default1', 0.0, 1.0, NULL, 'default2'), ('unique_4', 'unique_6', 'default2', 1.0, 0.0, 1, 'default1'), ('unique_5', 'default2', 'default1', 0.0, NULL, 1, 'default1'), ('unique_6', 'unique_9', 'default2', 1.0, 1.0, NULL, NULL), ('unique_7', NULL, 'default1', NULL, 1.0, 1, 'default2'), ('unique_8', 'unique_5', 'default1', NULL, NULL, 1, NULL), ('unique_9', 'unique_4', NULL, 0.0, 0.0, NULL, 'default2'), ('unique_10', 'unique_12', 'default2', 1.0, 1.0, NULL, 'default2'), ('unique_11', 'unique_4', 'default2', NULL, NULL, 1, NULL), ('unique_12', 'default2', 'default1', 1.0, 1.0, 1, 'default2');
INSERT INTO expense (expense_id, link_to_budget, link_to_member, expense_description, expense_date, cost, approved) VALUES ('default1', NULL, 'default2', 'default1', NULL, NULL, 'default1'), ('default2', 'unique_9', 'unique_3', 'default1', 'default1', 0.0, 'default2'), ('unique_2', 'default1', 'default1', 'default2', 'default2', 1.0, 'default2'), ('unique_3', 'unique_4', 'default2', 'default2', 'default2', NULL, 'default1'), ('unique_4', 'unique_11', NULL, 'default2', 'default1', NULL, NULL), ('unique_5', 'unique_2', 'default1', NULL, 'default1', NULL, 'default2'), ('unique_6', 'default2', NULL, 'default2', NULL, NULL, 'default2'), ('unique_7', 'unique_2', 'default2', 'default2', 'default2', 1.0, NULL), ('unique_8', 'unique_4', 'default2', 'default1', NULL, 1.0, 'default1'), ('unique_9', 'default1', NULL, 'default1', NULL, 1.0, 'default1'), ('unique_10', NULL, 'unique_3', NULL, 'default2', NULL, 'default1'), ('unique_11', 'unique_5', 'default2', 'default2', 'default1', 0.0, NULL), ('unique_12', NULL, 'unique_2', NULL, 'default2', 0.0, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.first_name, T3.last_name, T3.phone FROM expense AS T1 INNER JOIN budget AS T2 ON T1.link_to_budget = T2.budget_id INNER JOIN member AS T3 ON T3.member_id = T1.link_to_member WHERE T1.cost > (SELECT AVG(T1.cost) FROM expense AS T1 INNER JOIN budget AS T2 ON T1.link_to_budget = T2.budget_id INNER JOIN member AS T3 ON T3.member_id = T1.link_to_member);

/*
Gold Result:
('default2', 'default2', 'default1')
('default2', 'default2', None)
*/

-- Prediction Query
SELECT T2.first_name, T2.last_name, T2.phone FROM expense AS T1 INNER JOIN member AS T2 ON T1.link_to_member = T2.member_id WHERE T1.cost > (SELECT AVG(cost) FROM expense);

/*
Prediction Result:
('default2', 'default2', 'default1')
('default2', 'default2', None)
('default2', 'default2', None)
*/