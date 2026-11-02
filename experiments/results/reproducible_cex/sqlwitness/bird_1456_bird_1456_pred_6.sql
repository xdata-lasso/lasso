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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (5, NULL, 'default1', 'default1', NULL, 'default2'), (4, 'default2', NULL, 'default1', 'default2', NULL), (0, NULL, 'default1', 'default1', 'default2', 'default2'), (1, 'default2', 'default2', NULL, NULL, 'default1'), (6, 'default1', NULL, 'default1', 'default1', 'default2'), (2, 'default2', NULL, 'default2', NULL, NULL), (3, NULL, NULL, 'default1', 'default1', 'default2'), (7, 'default1', NULL, 'default2', 'default1', 'default2'), (8, NULL, 'default2', NULL, 'default1', 'default2'), (9, NULL, NULL, 'default1', 'default1', 'default2');
INSERT INTO major (major_id, major_name, department, college) VALUES ('default1', NULL, NULL, NULL), ('default2', 'default2', 'default1', 'default2'), ('unique_2', 'default1', NULL, 'default2'), ('unique_3', 'default2', 'default2', 'default2'), ('unique_4', 'default2', NULL, 'default2'), ('unique_5', 'default2', 'default2', 'default2'), ('unique_6', 'default2', 'default2', NULL), ('unique_7', 'default1', NULL, 'default1'), ('unique_8', 'default2', 'default2', 'default1');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('default2', 'unique_5', NULL, NULL, 'default1', NULL, 'default1', NULL, 'default2'), ('default1', 'unique_8', 3, NULL, 'default2', NULL, 'default1', 'default1', NULL), ('unique_2', NULL, 0, NULL, 'default2', 'default2', 'default2', NULL, 'default1'), ('unique_3', 'unique_4', 5, 'default1', NULL, NULL, 'default2', 'default1', 'default1'), ('unique_4', 'unique_2', 3, 'default1', 'default2', 'default1', NULL, 'default2', 'default1'), ('unique_5', 'default2', 5, 'default1', NULL, 'default1', 'default2', 'default1', 'default2');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('default2', 'default2', 'default2', NULL, NULL, 'default2', 'default1'), ('default1', 'default1', 'default2', 'default1', 'default1', 'default1', 'default1'), ('unique_2', 'default1', 'default2', 'default1', 'default1', 'default1', NULL), ('unique_3', 'default2', 'default1', 'default2', NULL, NULL, NULL), ('unique_4', 'default2', 'default1', 'default2', 'default2', 'default1', 'default1'), ('unique_5', 'default2', NULL, 'default1', 'default1', 'default1', 'default1'), ('unique_6', NULL, NULL, 'default1', NULL, 'default1', 'default1'), ('unique_7', 'default2', 'default2', 'default1', 'default1', NULL, 'default1'), ('unique_8', 'default2', 'default2', NULL, NULL, 'default1', NULL);
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('default1', 'unique_5', NULL, 1.0, 5.0, 6, 'default2'), ('default2', NULL, 'default2', 4.0, 0.0, 0, NULL), ('unique_2', 'unique_4', 'default2', 5.0, NULL, 6, 'default2'), ('unique_3', 'unique_2', 'default1', 1.0, 6.0, 1, NULL), ('unique_4', 'unique_6', NULL, 0.0, NULL, 4, 'default2'), ('unique_5', NULL, 'default2', 1.0, 6.0, NULL, NULL);
INSERT INTO expense (expense_id, link_to_budget, link_to_member, expense_description, expense_date, cost, approved) VALUES ('default1', 'default2', 'unique_5', 'default1', 'default1', 0.0, 'default2'), ('default2', 'unique_2', 'default1', NULL, 'default1', 0.0, NULL), ('unique_2', 'default2', 'unique_3', 'default2', 'default2', 0.0, NULL), ('unique_3', 'default2', NULL, 'default2', 'default2', 4.0, NULL), ('unique_4', 'default1', 'unique_3', 'default2', 'default2', 4.0, 'default2'), ('unique_5', 'default2', 'unique_5', NULL, 'default1', 1.0, 'default2'), ('unique_6', 'default1', 'default2', NULL, NULL, 1.0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.first_name, T3.last_name FROM expense AS T1 INNER JOIN budget AS T2 ON T1.link_to_budget = T2.budget_id INNER JOIN member AS T3 ON T1.link_to_member = T3.member_id ORDER BY T2.spent DESC, T1.expense_id NULLS LAST, T2.budget_id NULLS LAST, T3.member_id NULLS LAST LIMIT 5;

/*
Gold Result:
(None, 'default2')
('default1', None)
('default1', None)
('default1', None)
('default1', None)
*/

-- Prediction Query
SELECT member.first_name, member.last_name FROM member JOIN (SELECT link_to_member, SUM(cost) AS total_spending FROM expense GROUP BY link_to_member ORDER BY total_spending DESC, link_to_member NULLS LAST LIMIT 5) AS top_spenders ON member.member_id = top_spenders.link_to_member ORDER BY top_spenders.total_spending DESC, member.member_id NULLS LAST;

/*
Prediction Result:
('default1', None)
(None, 'default1')
('default1', None)
(None, 'default2')
*/