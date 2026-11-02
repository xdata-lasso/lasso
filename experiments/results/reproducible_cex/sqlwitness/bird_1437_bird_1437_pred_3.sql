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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (11, '2019-11-19', 'default1', '2019-11-19', '2019-11-19', 'default1'), (2, 'default1', 'default2', NULL, '2019-11-19', NULL);
INSERT INTO major (major_id, major_name, department, college) VALUES ('2019-11-19', 'default2', NULL, '2019-01-10');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('2019-01-10', '2019-11-19', NULL, 'default2', NULL, 'true', '2019-11-19', '2019-11-19', 'true'), ('default1', NULL, 2, 'true', NULL, '2019-01-10', '2019-01-10', 'default2', 'true'), ('default2', '2019-11-19', 11, 'true', NULL, 'default2', '2019-11-19', '2019-11-19', 'default2'), ('2019-11-19', '2019-11-19', NULL, 'default2', '2019-11-19', 'true', 'default1', 'default2', '2019-01-10'), ('true', '2019-11-19', 2, 'default2', '2019-01-10', '2019-11-19', 'default1', '2019-11-19', '2019-11-19'), ('unique_5', NULL, 11, 'true', 'true', NULL, 'true', '2019-11-19', '2019-11-19'), ('unique_6', '2019-11-19', NULL, '2019-01-10', 'default1', 'default2', 'default1', 'default2', '2019-01-10');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('2019-11-19', '2019-11-19', NULL, NULL, '2019-01-10', 'default2', '2019-11-19'), ('2019-01-10', 'true', 'true', NULL, NULL, 'default1', 'default1'), ('default1', '2019-11-19', '2019-01-10', NULL, 'true', '2019-11-19', NULL), ('true', 'true', NULL, 'true', 'true', 'default2', 'true'), ('default2', '2019-01-10', 'true', 'default2', NULL, 'true', '2019-11-19');
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('default1', NULL, '2019-11-19', 11.0, 0.0, 2, 'default2'), ('2019-01-10', '2019-01-10', 'true', 11.0, 11.0, NULL, 'default1'), ('2019-11-19', 'default1', 'default1', 11.0, 1.0, 9, NULL), ('true', '2019-01-10', '2019-01-10', 11.0, 9.0, 11, 'default1'), ('default2', NULL, 'default2', NULL, 11.0, 10, 'default2'), ('unique_5', 'default2', 'default1', 2.0, NULL, 10, 'default1'), ('unique_6', '2019-11-19', '2019-11-19', 2.0, 0.0, 10, '2019-01-10');
INSERT INTO expense (expense_id, link_to_budget, link_to_member, expense_description, expense_date, cost, approved) VALUES ('default2', 'true', 'unique_6', NULL, NULL, 9.0, '2019-01-10'), ('2019-11-19', NULL, 'default2', 'true', '2019-01-10', 2.0, '2019-01-10'), ('true', 'true', 'unique_6', 'default1', '2019-11-19', 0.0, 'true');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('2019-11-19', 'default2'), ('2019-11-19', '2019-01-10'), ('default1', '2019-01-10'), ('default2', 'default2'), ('true', 'unique_6');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.link_to_member, T3.link_to_event FROM expense AS T1 INNER JOIN member AS T2 ON T1.link_to_member = T2.member_id INNER JOIN attendance AS T3 ON T2.member_id = T3.link_to_member WHERE DATE(SUBSTRING(T1.expense_date, 1, 10)) BETWEEN '2019-01-10' AND '2019-11-19' AND T1.approved = 'true';

/*
Gold Result:
('unique_6', 'true')
*/

-- Prediction Query
SELECT T2.first_name, T2.last_name, T3.link_to_event FROM expense AS T1 INNER JOIN member AS T2 ON T1.link_to_member = T2.member_id INNER JOIN attendance AS T3 ON T1.link_to_member = T3.link_to_member WHERE T1.approved = 'true' AND T1.expense_date BETWEEN '2019-01-10' AND '2019-11-19';

/*
Prediction Result:
('2019-01-10', 'default1', 'true')
*/