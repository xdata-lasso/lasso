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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (100, NULL, NULL, 'Yearly Kickoff', NULL, 'default2'), (0, NULL, 'default1', 'default2', 'Yearly Kickoff', 'default1'), (-1, NULL, 'Yearly Kickoff', 'default1', 'default2', NULL), (101, 'default1', 'Yearly Kickoff', NULL, 'Yearly Kickoff', 'default1'), (1, 'Yearly Kickoff', NULL, 'Yearly Kickoff', 'default1', 'default1');
INSERT INTO major (major_id, major_name, department, college) VALUES ('default1', NULL, 'default1', NULL), ('default2', 'Yearly Kickoff', 'Yearly Kickoff', NULL), ('Yearly Kickoff', 'Yearly Kickoff', 'default2', 'default1'), ('unique_3', 'default1', NULL, 'default1'), ('unique_4', 'default1', 'Yearly Kickoff', 'default1'), ('unique_5', 'default1', NULL, 'Yearly Kickoff'), ('unique_6', NULL, 'Yearly Kickoff', 'Yearly Kickoff'), ('unique_7', NULL, 'default1', 'Yearly Kickoff');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('default2', 'Yearly Kickoff', 'default1', NULL, 'Yearly Kickoff', 'default2', NULL), ('default1', 'Yearly Kickoff', NULL, 'default1', NULL, NULL, 'default2'), ('Yearly Kickoff', 'default2', NULL, 'Yearly Kickoff', NULL, 'default1', NULL), ('unique_3', 'default1', 'default2', 'default1', 'default1', 'Yearly Kickoff', NULL), ('unique_4', NULL, 'default1', NULL, NULL, 'default1', 'Yearly Kickoff'), ('unique_5', 'default1', NULL, 'default2', NULL, 'default2', 'default2'), ('unique_6', 'Yearly Kickoff', 'Yearly Kickoff', 'Yearly Kickoff', 'default1', NULL, 'Yearly Kickoff');
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('default1', 'Yearly Kickoff', 'Yearly Kickoff', 1.0, 101.0, 99, 'default1'), ('Yearly Kickoff', NULL, NULL, -1.0, 0.0, -1, NULL), ('default2', 'unique_3', 'Yearly Kickoff', -1.0, 1.0, 0, 'default2'), ('unique_3', 'unique_3', NULL, 99.0, -1.0, 0, 'Yearly Kickoff'), ('unique_4', 'Yearly Kickoff', 'Yearly Kickoff', -1.0, 0.0, -1, 'default2'), ('unique_5', NULL, 'default2', NULL, 100.0, 101, 'default2');
INSERT INTO expense (expense_id, link_to_budget, link_to_member, expense_description, expense_date, cost, approved) VALUES ('Yearly Kickoff', 'default2', NULL, 'default1', 'Yearly Kickoff', 101.0, 'default2'), ('default1', 'default2', NULL, 'Yearly Kickoff', 'default2', NULL, 'default2'), ('default2', 'default2', NULL, 'Yearly Kickoff', NULL, 101.0, 'default1'), ('unique_3', 'unique_5', NULL, 'default2', NULL, 101.0, 'Yearly Kickoff');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN T1.event_name = 'Yearly Kickoff' THEN T3.cost ELSE 0 END) AS REAL) * 100 / SUM(T3.cost) FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT (SELECT SUM(cost) FROM expense INNER JOIN budget ON expense.link_to_budget = budget.budget_id INNER JOIN event ON budget.link_to_event = event.event_id WHERE event.event_name = 'Yearly Kickoff') * 100.0 / (SELECT SUM(cost) FROM expense) AS yearly_kickoff_percentage;

/*
Prediction Result:
(None,)
*/