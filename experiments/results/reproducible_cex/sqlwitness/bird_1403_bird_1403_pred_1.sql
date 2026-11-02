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
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('default2', NULL, 'default1', NULL, 'default2', 'default1', 'Closed');
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('default1', NULL, 'default2', 1.0, 0.0, 0, NULL), ('default2', 'default2', 'default2', 2.0, -1.0, 2, NULL), ('Closed', NULL, 'default2', 2.0, NULL, -1, 'default2'), ('unique_3', 'default2', 'default1', 1.0, 0.0, 2, 'Closed'), ('unique_4', 'default2', 'Closed', 1.0, 1.0, NULL, 'Closed'), ('unique_5', NULL, 'default1', NULL, NULL, 0, 'default2'), ('unique_6', 'default2', 'default2', 1.0, -1.0, -1, 'default1'), ('unique_7', NULL, 'Closed', -1.0, NULL, 0, 'default1'), ('unique_8', 'default2', 'default2', -1.0, NULL, -1, 'default2'), ('unique_9', NULL, 'default1', -1.0, 1.0, 2, 'Closed');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.event_name FROM budget AS T1 INNER JOIN event AS T2 ON T2.event_id = T1.link_to_event WHERE T1.event_status = 'Closed' AND T1.remaining < 0 ORDER BY T1.remaining, T1.budget_id NULLS LAST, T2.event_id NULLS LAST LIMIT 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT event.event_name FROM event INNER JOIN budget ON event.event_id = budget.link_to_event WHERE event.status = 'Closed' AND budget.remaining < 0 ORDER BY budget.remaining ASC, event.event_id NULLS LAST, budget.budget_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/