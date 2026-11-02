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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (2, NULL, 'default2', 'default2', 'Water, chips, cookies', 'default2'), (0, 'default2', NULL, 'default1', 'default2', NULL), (1, 'Water, chips, cookies', 'Water, chips, cookies', 'Water, chips, cookies', 'default1', NULL), (3, NULL, 'default2', NULL, 'default2', NULL), (4, NULL, 'default1', 'default2', 'default2', NULL), (5, NULL, 'default2', 'Water, chips, cookies', 'default2', 'Water, chips, cookies');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('default1', NULL, 1, NULL, 'default2', NULL, 'default1', 'Water, chips, cookies', 'default2'), ('Water, chips, cookies', NULL, 5, 'default2', 'default2', 'default2', 'default2', 'Water, chips, cookies', 'Water, chips, cookies'), ('default2', NULL, 4, 'Water, chips, cookies', 'Water, chips, cookies', 'Water, chips, cookies', 'default1', 'Water, chips, cookies', 'default2'), ('unique_3', NULL, 3, 'default1', 'default2', 'default2', 'default1', 'default2', 'default1'), ('unique_4', NULL, 5, 'default2', NULL, 'Water, chips, cookies', NULL, NULL, 'default2'), ('unique_5', NULL, NULL, 'default1', 'default2', 'default1', NULL, 'default2', NULL), ('unique_6', NULL, 4, 'default1', 'default1', 'default2', 'Water, chips, cookies', NULL, 'Water, chips, cookies');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('default2', 'default2', 'Water, chips, cookies', 'default1', 'Water, chips, cookies', NULL, 'default2'), ('Water, chips, cookies', 'Water, chips, cookies', NULL, 'Water, chips, cookies', NULL, 'default1', 'Water, chips, cookies'), ('default1', 'Water, chips, cookies', 'default1', NULL, 'default1', 'default1', NULL), ('unique_3', 'default2', 'Water, chips, cookies', 'default1', 'default1', 'default1', 'default2'), ('unique_4', 'default1', 'default1', 'default2', 'Water, chips, cookies', 'default1', 'default2'), ('unique_5', 'default1', NULL, 'Water, chips, cookies', 'Water, chips, cookies', 'Water, chips, cookies', NULL), ('unique_6', NULL, NULL, 'default2', 'default1', 'default1', 'default1'), ('unique_7', NULL, 'default1', NULL, 'Water, chips, cookies', NULL, 'default1'), ('unique_8', NULL, 'default1', 'default2', 'Water, chips, cookies', NULL, 'default1'), ('unique_9', 'default1', 'default1', NULL, 'default1', 'default2', 'default2'), ('unique_10', 'default2', 'default2', NULL, 'default1', NULL, 'default1'), ('unique_11', NULL, 'default1', 'default2', NULL, 'default2', 'Water, chips, cookies'), ('unique_12', 'Water, chips, cookies', 'default2', NULL, NULL, 'default1', NULL), ('unique_13', 'default1', NULL, 'default2', 'Water, chips, cookies', 'Water, chips, cookies', NULL), ('unique_14', 'default1', NULL, 'Water, chips, cookies', 'default2', 'default1', NULL), ('unique_15', 'default2', 'default1', NULL, 'default1', 'default2', 'Water, chips, cookies');
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('default2', 'unique_6', 'default1', 2.0, NULL, 2, 'Water, chips, cookies'), ('Water, chips, cookies', 'default1', 'default1', 0.0, NULL, 1, 'Water, chips, cookies'), ('default1', 'unique_4', 'Water, chips, cookies', 1.0, 2.0, 2, 'default2'), ('unique_3', 'default2', 'default2', NULL, 1.0, 2, 'Water, chips, cookies'), ('unique_4', 'unique_7', 'Water, chips, cookies', 1.0, 2.0, NULL, NULL), ('unique_5', 'unique_3', NULL, 0.0, 0.0, 2, 'default2'), ('unique_6', 'unique_4', 'default1', 2.0, 2.0, NULL, 'default1'), ('unique_7', 'unique_8', 'default2', 0.0, 0.0, NULL, 'Water, chips, cookies'), ('unique_8', 'default1', NULL, 1.0, 2.0, 1, NULL), ('unique_9', 'default2', 'Water, chips, cookies', NULL, 2.0, NULL, 'Water, chips, cookies'), ('unique_10', 'unique_10', 'default1', 0.0, 1.0, NULL, 'default2'), ('unique_11', 'unique_11', 'default1', 0.0, 1.0, NULL, 'default2'), ('unique_12', 'unique_3', 'Water, chips, cookies', 1.0, 2.0, NULL, 'default2'), ('unique_13', 'unique_15', 'Water, chips, cookies', 2.0, 0.0, 0, 'default1'), ('unique_14', 'Water, chips, cookies', 'default1', NULL, NULL, 1, 'default1');
INSERT INTO expense (expense_id, link_to_budget, link_to_member, expense_description, expense_date, cost, approved) VALUES ('default1', 'unique_5', 'unique_6', NULL, NULL, 2.0, 'default2'), ('default2', 'unique_9', 'unique_3', 'Water, chips, cookies', 'default2', NULL, 'Water, chips, cookies'), ('Water, chips, cookies', 'unique_6', 'unique_3', 'default1', NULL, 0.0, 'default1'), ('unique_3', 'unique_11', 'default2', 'default2', 'Water, chips, cookies', 2.0, 'Water, chips, cookies'), ('unique_4', 'unique_9', NULL, 'Water, chips, cookies', NULL, NULL, NULL), ('unique_5', 'unique_14', NULL, 'default1', 'default1', 0.0, 'default1'), ('unique_6', 'unique_13', 'default2', NULL, 'Water, chips, cookies', NULL, 'default1'), ('unique_7', 'unique_11', 'default2', 'Water, chips, cookies', 'default2', NULL, NULL), ('unique_8', 'unique_3', 'unique_4', 'default2', 'default2', 1.0, 'default1'), ('unique_9', 'unique_11', 'unique_3', 'default1', 'default1', 1.0, 'default2'), ('unique_10', 'default2', 'default1', 'default1', NULL, 1.0, 'default1'), ('unique_11', 'unique_13', 'unique_6', NULL, 'Water, chips, cookies', NULL, NULL), ('unique_12', 'unique_13', 'unique_4', NULL, 'Water, chips, cookies', 2.0, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.budget_id FROM expense AS T1 INNER JOIN budget AS T2 ON T1.link_to_budget = T2.budget_id WHERE T1.expense_description = 'Water, chips, cookies' ORDER BY T1.cost DESC, T1.expense_id NULLS LAST, T2.budget_id NULLS LAST LIMIT 1;

/*
Gold Result:
('unique_9',)
*/

-- Prediction Query
SELECT T1.budget_id FROM budget AS T1 INNER JOIN expense AS T2 ON T1.budget_id = T2.link_to_budget WHERE T2.expense_description = 'Water, chips, cookies' ORDER BY T2.cost DESC, T1.budget_id NULLS LAST, T2.expense_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('unique_11',)
*/