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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (0, NULL, 'default2', 'default1', NULL, NULL), (1, 'default1', NULL, NULL, 'default2', 'default1'), (2, 'default1', 'default2', 'default1', 'default1', 'default2');
INSERT INTO major (major_id, major_name, department, college) VALUES ('default2', 'default2', NULL, 'default2'), ('default1', 'default1', NULL, NULL), ('unique_2', NULL, 'default1', 'default1'), ('unique_3', 'default1', 'default1', 'default2');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('default2', 'unique_3', 0, 'default2', NULL, 'default2', 'default2', 'default1', NULL), ('default1', NULL, 1, NULL, NULL, 'default1', 'default1', 'default1', 'default1'), ('unique_2', 'default2', NULL, 'default1', 'default2', NULL, 'default2', NULL, 'default2'), ('unique_3', 'unique_3', 1, 'default2', 'default1', NULL, 'default2', NULL, NULL), ('unique_4', 'default2', NULL, 'default2', 'default2', 'default1', 'default1', 'default1', 'default2'), ('unique_5', NULL, 2, 'default1', NULL, 'default2', NULL, 'default2', 'default1');
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('default2', NULL, NULL, NULL, 1.0, 0, 'default2'), ('default1', NULL, 'default1', NULL, 0.0, 2, 'default2'), ('unique_2', NULL, 'default1', 2.0, NULL, NULL, NULL), ('unique_3', NULL, 'default2', 1.0, 0.0, 2, NULL), ('unique_4', NULL, NULL, NULL, NULL, 0, 'default1'), ('unique_5', NULL, 'default2', 0.0, 1.0, 1, 'default2'), ('unique_6', NULL, NULL, 1.0, 2.0, 2, NULL);
INSERT INTO expense (expense_id, link_to_budget, link_to_member, expense_description, expense_date, cost, approved) VALUES ('default2', 'default1', 'unique_5', 'default1', NULL, 1.0, 'default2'), ('default1', 'default1', NULL, 'default2', 'default1', 0.0, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.expense_description FROM budget AS T1 INNER JOIN expense AS T2 ON T1.budget_id = T2.link_to_budget ORDER BY T1.remaining, T1.budget_id NULLS LAST, T2.expense_id NULLS LAST LIMIT 1;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT T2.expense_description FROM budget AS T1 INNER JOIN expense AS T2 ON T1.budget_id = T2.link_to_budget WHERE T1.remaining = (SELECT MIN(remaining) FROM budget);

/*
Prediction Result:
('default1',)
('default2',)
*/