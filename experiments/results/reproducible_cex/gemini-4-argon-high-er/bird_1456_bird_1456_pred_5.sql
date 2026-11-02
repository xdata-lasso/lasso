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
INSERT INTO event (event_id, event_name) VALUES ('E1', 'Event 1');
INSERT INTO major (major_id, major_name) VALUES ('M1', 'CS');
INSERT INTO zip_code (zip_code, city) VALUES (12345, 'City');
INSERT INTO member (member_id, first_name, last_name, zip, link_to_major) VALUES ('MEM1', 'John', 'Doe', 12345, 'M1');
INSERT INTO budget (budget_id, spent, link_to_event) VALUES ('B1', 100.0, 'E1');
INSERT INTO expense (expense_id, cost, link_to_member, link_to_budget) VALUES ('EXP1', 50.0, 'MEM1', 'B1');
INSERT INTO expense (expense_id, cost, link_to_member, link_to_budget) VALUES ('EXP2', 50.0, 'MEM1', 'B1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.first_name, T3.last_name FROM expense AS T1 INNER JOIN budget AS T2 ON T1.link_to_budget = T2.budget_id INNER JOIN member AS T3 ON T1.link_to_member = T3.member_id ORDER BY T2.spent DESC, T1.expense_id NULLS LAST, T2.budget_id NULLS LAST, T3.member_id NULLS LAST LIMIT 5;

/*
Gold Result:
('John', 'Doe')
('John', 'Doe')
*/

-- Prediction Query
SELECT m.first_name, m.last_name FROM member AS m INNER JOIN expense AS e ON m.member_id = e.link_to_member GROUP BY m.first_name, m.last_name ORDER BY SUM(e.cost) DESC, m.first_name NULLS LAST, m.last_name NULLS LAST LIMIT 5;

/*
Prediction Result:
('John', 'Doe')
*/