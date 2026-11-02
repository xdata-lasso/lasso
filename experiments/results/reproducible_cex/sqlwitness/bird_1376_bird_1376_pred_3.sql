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
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('Closed', NULL, NULL, NULL, 'default2', 'default2', 'default2'), ('default1', 'Closed', 'Closed', 'default1', 'default1', 'Closed', NULL), ('default2', 'default2', 'default2', NULL, 'default2', 'default1', 'default2'), ('unique_3', 'default2', NULL, 'default2', 'default2', 'Closed', 'default1'), ('unique_4', NULL, 'Closed', 'Closed', NULL, 'default2', 'default2'), ('unique_5', 'default2', 'Closed', 'default2', 'default1', 'Closed', 'default1'), ('unique_6', 'Closed', 'Closed', 'default2', 'default1', 'default2', 'default2'), ('unique_7', 'Closed', NULL, 'default1', 'default1', NULL, 'default2'), ('unique_8', NULL, 'Closed', 'Closed', 'Closed', NULL, 'Closed'), ('unique_9', 'default2', NULL, NULL, 'default2', 'default2', NULL), ('unique_10', 'Closed', 'default2', 'default1', 'Closed', NULL, NULL), ('unique_11', 'default1', NULL, NULL, 'Closed', 'Closed', NULL), ('unique_12', 'Closed', NULL, 'Closed', 'default2', 'default1', 'Closed');
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('default2', 'unique_12', 'default2', 1.0, NULL, NULL, 'default1'), ('Closed', 'unique_5', 'default1', 0.0, 0.0, 2, 'Closed'), ('default1', 'unique_8', 'default2', 1.0, 2.0, NULL, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.event_name FROM budget AS T1 INNER JOIN event AS T2 ON T1.link_to_event = T2.event_id WHERE T2.status = 'Closed' ORDER BY T1.spent / T1.amount DESC, T1.budget_id NULLS LAST, T2.event_id NULLS LAST LIMIT 1;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT e.event_name FROM event AS e JOIN budget AS b ON e.event_id = b.link_to_event WHERE e.status = 'Closed' ORDER BY (CAST(b.spent AS REAL) / CAST(b.amount AS REAL)) DESC, e.event_id NULLS LAST, b.budget_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Closed',)
*/