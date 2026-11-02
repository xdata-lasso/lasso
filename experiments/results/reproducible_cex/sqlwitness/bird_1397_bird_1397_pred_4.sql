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
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('Closed', 'Food', 'Closed', 'default1', 'default1', 'Food', NULL), ('default1', 'Closed', 'default1', NULL, 'default1', 'Closed', 'default2'), ('default2', 'Food', NULL, 'Closed', 'default1', NULL, 'default2'), ('Food', 'Closed', 'Food', 'default2', 'default1', 'default2', 'default1'), ('unique_4', NULL, 'Closed', 'default1', 'default1', 'default1', 'Food'), ('unique_5', 'Food', NULL, 'default2', NULL, 'Closed', 'default2'), ('unique_6', 'Food', 'Closed', 'default1', 'Closed', 'Closed', 'Food');
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('default1', 'default2', NULL, NULL, 1.0, 1, 'Food'), ('Food', NULL, 'default1', 0.0, 1.0, 1, 'Food'), ('Closed', 'default2', NULL, NULL, 1.0, NULL, 'Food'), ('default2', 'Food', 'Closed', NULL, 1.0, NULL, 'Food'), ('unique_4', 'default1', 'Food', 0.0, 1.0, 1, 'Food'), ('unique_5', 'unique_6', NULL, NULL, NULL, NULL, 'Closed'), ('unique_6', 'default1', 'default1', NULL, 0.0, 0, 'default2'), ('unique_7', 'Closed', 'Food', 1.0, 0.0, 0, 'Food'), ('unique_8', 'Closed', 'default2', 0.0, 1.0, 1, 'Food'), ('unique_9', NULL, 'default2', NULL, NULL, 0, 'default2'), ('unique_10', 'default2', 'default2', NULL, 1.0, 0, 'default1'), ('unique_11', 'Food', 'default2', 0.0, 1.0, 0, 'default2'), ('unique_12', 'Food', 'default1', NULL, 0.0, 0, 'Food'), ('unique_13', 'default2', 'Food', 1.0, 1.0, 0, 'Closed'), ('unique_14', 'default1', 'default1', NULL, NULL, NULL, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(spent) / COUNT(spent) FROM budget WHERE category = 'Food' AND event_status = 'Closed';

/*
Gold Result:
(1.0,)
*/

-- Prediction Query
SELECT AVG(b.spent) AS avg_spent FROM budget AS b JOIN event AS e ON b.link_to_event = e.event_id WHERE b.category = 'Food' AND e.status = 'Closed';

/*
Prediction Result:
(None,)
*/