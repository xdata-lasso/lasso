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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (1, 'default1', NULL, 'default2', 'Yearly Kickoff', 'default2'), (0, 'Yearly Kickoff', 'Yearly Kickoff', 'Yearly Kickoff', 'default2', 'default2'), (2, 'default2', 'default2', 'Yearly Kickoff', 'default2', 'default1'), (3, 'default2', NULL, 'Yearly Kickoff', NULL, 'Yearly Kickoff'), (4, 'default1', 'Yearly Kickoff', 'default2', 'default1', NULL), (5, 'Yearly Kickoff', NULL, NULL, 'Yearly Kickoff', 'Yearly Kickoff'), (6, 'Yearly Kickoff', 'default2', 'default1', 'default2', 'Yearly Kickoff');
INSERT INTO major (major_id, major_name, department, college) VALUES ('default2', 'default2', 'default2', 'default1'), ('Yearly Kickoff', 'default1', 'default2', 'Yearly Kickoff'), ('default1', NULL, 'Yearly Kickoff', 'default2');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('default2', 'default1', 3, 'default2', 'default1', 'default2', 'default2', 'Yearly Kickoff', 'default2'), ('default1', NULL, 3, 'default1', NULL, 'default2', NULL, 'default2', 'Yearly Kickoff'), ('Yearly Kickoff', 'default1', 1, NULL, 'default2', NULL, NULL, NULL, 'default1'), ('unique_3', 'default1', 2, NULL, 'Yearly Kickoff', 'default2', 'default1', 'default1', 'default1');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('default2', 'Yearly Kickoff', 'Yearly Kickoff', 'Yearly Kickoff', NULL, NULL, 'default2');
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('default1', 'default2', NULL, 0.0, 1.0, 1, 'default1'), ('Yearly Kickoff', 'default2', 'default1', NULL, 0.0, 1, 'Yearly Kickoff'), ('default2', NULL, 'default1', 0.0, 1.0, 0, 'Yearly Kickoff'), ('unique_3', NULL, NULL, NULL, 0.0, NULL, 'default1'), ('unique_4', 'default2', 'Yearly Kickoff', NULL, 1.0, 0, 'Yearly Kickoff'), ('unique_5', NULL, 'default1', 1.0, 0.0, 1, 'Yearly Kickoff');
INSERT INTO expense (expense_id, link_to_budget, link_to_member, expense_description, expense_date, cost, approved) VALUES ('default1', 'unique_5', 'default2', 'Yearly Kickoff', 'Yearly Kickoff', 1.0, 'Yearly Kickoff'), ('Yearly Kickoff', 'Yearly Kickoff', 'unique_3', 'default2', 'default2', 1.0, 'default1'), ('default2', 'unique_4', 'unique_3', 'Yearly Kickoff', 'default2', NULL, 'default1'), ('unique_3', 'unique_3', 'Yearly Kickoff', 'default2', 'default2', 0.0, 'default1'), ('unique_4', 'default1', 'Yearly Kickoff', NULL, 'default2', 0.0, 'Yearly Kickoff'), ('unique_5', NULL, 'Yearly Kickoff', 'Yearly Kickoff', 'default2', 0.0, 'Yearly Kickoff');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T4.first_name, T4.last_name FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget INNER JOIN member AS T4 ON T3.link_to_member = T4.member_id WHERE T1.event_name = 'Yearly Kickoff';

/*
Gold Result:
(None, 'Yearly Kickoff')
(None, 'Yearly Kickoff')
(None, 'default2')
*/

-- Prediction Query
SELECT DISTINCT m.first_name, m.last_name FROM member AS m INNER JOIN expense AS e ON m.member_id = e.link_to_member INNER JOIN budget AS b ON e.link_to_budget = b.budget_id INNER JOIN event AS ev ON b.link_to_event = ev.event_id WHERE ev.event_name = 'Yearly Kickoff';

/*
Prediction Result:
(None, 'Yearly Kickoff')
(None, 'default2')
*/