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
INSERT INTO major (major_id, major_name, department, college) VALUES ('true', '2019-01-10', NULL, 'default1'), ('2019-01-10', 'true', '2019-01-10', NULL), ('default2', 'default2', NULL, 'default1'), ('default1', NULL, 'default1', 'default2'), ('2019-11-19', '2019-11-19', 'true', '2019-11-19'), ('unique_5', 'true', NULL, NULL);
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('2019-11-19', 'default2', NULL, 'true', 'true', 'default2', '2019-01-10', 'true', '2019-11-19'), ('2019-01-10', 'default1', NULL, 'true', '2019-01-10', '2019-01-10', 'default2', NULL, 'default1'), ('default2', 'true', NULL, 'true', '2019-01-10', '2019-01-10', '2019-01-10', '2019-11-19', '2019-11-19'), ('default1', 'default2', NULL, '2019-11-19', 'default2', 'true', '2019-11-19', '2019-11-19', 'true'), ('true', 'default1', NULL, 'default2', '2019-11-19', '2019-01-10', '2019-01-10', 'default2', 'true'), ('unique_5', 'default2', NULL, 'true', 'default2', NULL, 'default1', 'true', 'default2'), ('unique_6', NULL, NULL, '2019-01-10', 'true', '2019-11-19', 'true', '2019-11-19', 'default2'), ('unique_7', '2019-01-10', NULL, 'default2', '2019-01-10', 'default1', NULL, 'true', 'default1');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('2019-01-10', 'true', 'default2', 'true', NULL, 'default1', '2019-11-19'), ('default2', '2019-01-10', 'default1', 'true', '2019-11-19', '2019-01-10', '2019-11-19'), ('true', 'default2', '2019-01-10', NULL, NULL, 'true', '2019-11-19'), ('2019-11-19', NULL, '2019-11-19', '2019-01-10', 'default2', 'default2', 'default1'), ('default1', 'default1', '2019-11-19', '2019-11-19', 'true', '2019-01-10', 'default1'), ('unique_5', NULL, '2019-11-19', '2019-11-19', NULL, '2019-01-10', '2019-11-19'), ('unique_6', '2019-11-19', '2019-11-19', 'default1', 'default2', '2019-01-10', 'default2');
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('2019-01-10', NULL, '2019-11-19', 9.0, 9.0, 0, 'true'), ('true', 'unique_5', 'default1', NULL, NULL, 0, 'true'), ('default2', '2019-11-19', 'default1', 0.0, 0.0, 2, '2019-11-19'), ('default1', '2019-11-19', 'default1', 0.0, 10.0, 9, 'true'), ('2019-11-19', NULL, '2019-11-19', 2.0, 10.0, 10, NULL), ('unique_5', 'true', 'true', 10.0, 2.0, 11, 'true'), ('unique_6', NULL, NULL, NULL, 11.0, 1, 'true'), ('unique_7', 'unique_5', '2019-01-10', 11.0, 0.0, 11, 'true');
INSERT INTO expense (expense_id, link_to_budget, link_to_member, expense_description, expense_date, cost, approved) VALUES ('default1', 'unique_5', 'default2', '2019-11-19', 'default2', 9.0, NULL), ('true', 'unique_7', '2019-11-19', NULL, '2019-01-10', 11.0, 'true'), ('2019-01-10', 'unique_7', 'unique_7', NULL, 'true', 0.0, 'true'), ('2019-11-19', 'unique_7', 'unique_7', NULL, '2019-11-19', 11.0, '2019-01-10');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('unique_6', '2019-01-10'), ('unique_6', 'unique_6'), ('unique_6', 'default2'), ('default2', 'unique_6'), ('2019-01-10', '2019-11-19'), ('2019-01-10', '2019-01-10'), ('unique_5', 'unique_6');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.link_to_member, T3.link_to_event FROM expense AS T1 INNER JOIN member AS T2 ON T1.link_to_member = T2.member_id INNER JOIN attendance AS T3 ON T2.member_id = T3.link_to_member WHERE DATE(SUBSTRING(T1.expense_date, 1, 10)) BETWEEN '2019-01-10' AND '2019-11-19' AND T1.approved = 'true';

/*
Gold Result:
('2019-11-19', '2019-01-10')
*/

-- Prediction Query
SELECT T1.first_name, T1.last_name, T3.event_name, T3.event_id FROM member AS T1 INNER JOIN expense AS T2 ON T1.member_id = T2.link_to_member INNER JOIN event AS T3 ON T2.link_to_budget = T3.event_id WHERE T2.approved = 'true' AND T2.expense_date BETWEEN '2019-01-10' AND '2019-11-19';

/*
Prediction Result:
*/