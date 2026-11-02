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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (1, 'default2', 'default1', 'default1', 'default2', 'default2'), (0, NULL, 'default2', 'default2', 'default1', 'default1'), (2, NULL, 'default2', NULL, 'default1', 'default2'), (3, 'default1', NULL, 'default2', 'default2', 'default2'), (4, NULL, NULL, NULL, NULL, 'default2');
INSERT INTO major (major_id, major_name, department, college) VALUES ('default1', 'default1', 'default2', NULL), ('default2', NULL, 'default2', 'default1'), ('unique_2', 'default1', NULL, 'default2'), ('unique_3', 'default2', NULL, NULL), ('unique_4', 'default1', 'default2', NULL), ('unique_5', NULL, 'default1', 'default1'), ('unique_6', 'default1', 'default1', 'default1'), ('unique_7', NULL, 'default2', 'default2');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('default1', 'unique_5', 0, 'default1', 'default2', 'default2', 'default1', 'default1', NULL), ('default2', 'unique_6', NULL, 'default1', NULL, NULL, 'default1', 'default1', 'default1');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('default2', NULL, 'default1', NULL, 'default2', 'default1', NULL), ('default1', 'default2', 'default2', NULL, 'default2', 'default1', 'default2'), ('unique_2', 'default1', 'default2', NULL, 'default1', NULL, NULL), ('unique_3', NULL, 'default1', NULL, 'default1', NULL, 'default2'), ('unique_4', 'default1', NULL, 'default2', NULL, 'default1', 'default2');
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('default2', NULL, 'default2', 0.0, 2.0, 1, 'default2'), ('default1', 'unique_4', 'default2', 2.0, NULL, NULL, NULL), ('unique_2', 'unique_2', 'default2', 2.0, NULL, NULL, 'default2'), ('unique_3', NULL, NULL, 0.0, 1.0, NULL, 'default2'), ('unique_4', 'default1', 'default2', 1.0, 1.0, NULL, 'default2'), ('unique_5', 'unique_3', 'default2', 0.0, 2.0, NULL, NULL), ('unique_6', 'unique_4', NULL, 1.0, 0.0, 1, 'default1');
INSERT INTO expense (expense_id, link_to_budget, link_to_member, expense_description, expense_date, cost, approved) VALUES ('default2', 'default1', 'default2', 'default1', 'default1', NULL, 'default2'), ('default1', NULL, 'default1', 'default1', 'default2', 0.0, 'default2'), ('unique_2', 'default1', 'default2', 'default1', 'default1', 2.0, 'default1'), ('unique_3', 'default1', 'default1', 'default1', 'default2', NULL, 'default1'), ('unique_4', 'unique_2', 'default2', 'default1', NULL, 2.0, NULL), ('unique_5', 'unique_6', 'default1', 'default2', NULL, 2.0, NULL), ('unique_6', 'unique_2', 'default1', NULL, 'default1', NULL, 'default1'), ('unique_7', 'unique_2', NULL, 'default1', 'default1', 2.0, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.member_id FROM expense AS T1 INNER JOIN member AS T2 ON T1.link_to_member = T2.member_id INNER JOIN budget AS T3 ON T1.link_to_budget = T3.budget_id INNER JOIN event AS T4 ON T3.link_to_event = T4.event_id GROUP BY T2.member_id HAVING COUNT(DISTINCT T4.event_id) > 1 ORDER BY SUM(T1.cost) DESC, T2.member_id NULLS LAST LIMIT 1;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT T1.first_name, T1.last_name FROM member AS T1 INNER JOIN (SELECT T2.link_to_member, SUM(T2.cost) AS total_cost FROM expense AS T2 INNER JOIN budget AS T3 ON T2.link_to_budget = T3.budget_id GROUP BY T2.link_to_member HAVING COUNT(DISTINCT T3.link_to_event) > 1) AS T4 ON T1.member_id = T4.link_to_member ORDER BY T4.total_cost DESC, T1.member_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('default1', None)
*/