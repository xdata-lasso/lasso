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
INSERT INTO major (major_id, major_name, department, college) VALUES ('2019-11-19', 'true', 'true', '2019-01-10'), ('default1', 'default1', 'default1', 'default1'), ('true', '2019-11-19', NULL, 'true'), ('2019-01-10', 'default1', 'default1', '2019-11-19'), ('default2', '2019-01-10', '2019-01-10', 'true'), ('unique_5', 'default2', '2019-11-19', NULL), ('unique_6', NULL, NULL, '2019-01-10'), ('unique_7', 'default2', 'default1', 'default2'), ('unique_8', '2019-11-19', '2019-01-10', '2019-11-19'), ('unique_9', 'default1', '2019-11-19', 'default2'), ('unique_10', NULL, '2019-11-19', '2019-11-19');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('default2', 'unique_5', NULL, NULL, '2019-01-10', '2019-01-10', 'true', '2019-11-19', NULL);
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('2019-11-19', '2019-11-19', '2019-11-19', NULL, '2019-01-10', '2019-01-10', 'default1'), ('2019-01-10', 'default1', NULL, '2019-11-19', 'default1', '2019-01-10', 'default2'), ('default1', '2019-01-10', '2019-11-19', '2019-01-10', 'default1', 'default2', 'default2'), ('default2', NULL, '2019-01-10', 'default1', 'true', 'default1', 'true');
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('default2', 'default2', 'default2', 10.0, 11.0, 11, 'true');
INSERT INTO expense (expense_id, link_to_budget, link_to_member, expense_description, expense_date, cost, approved) VALUES ('2019-11-19', NULL, NULL, 'default1', NULL, 0.0, '2019-01-10'), ('default1', NULL, 'default2', '2019-11-19', 'default2', 9.0, 'true'), ('default2', NULL, NULL, '2019-11-19', 'default2', 11.0, 'default2'), ('2019-01-10', 'default2', 'default2', '2019-11-19', '2019-01-10', 0.0, 'true'), ('true', 'default2', NULL, 'true', 'default1', 9.0, '2019-11-19'), ('unique_5', NULL, NULL, '2019-11-19', 'default1', 1.0, '2019-01-10');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('2019-11-19', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.link_to_member, T3.link_to_event FROM expense AS T1 INNER JOIN member AS T2 ON T1.link_to_member = T2.member_id INNER JOIN attendance AS T3 ON T2.member_id = T3.link_to_member WHERE DATE(SUBSTRING(T1.expense_date, 1, 10)) BETWEEN '2019-01-10' AND '2019-11-19' AND T1.approved = 'true';

/*
Gold Result:
('default2', '2019-11-19')
*/

-- Prediction Query
SELECT T1.first_name, T1.last_name, T2.link_to_event FROM member AS T1 INNER JOIN attendance AS T2 ON T1.member_id = T2.link_to_member INNER JOIN expense AS T3 ON T1.member_id = T3.link_to_member WHERE T3.approved = 'true' AND T3.expense_date BETWEEN '2019-01-10' AND '2019-11-19';

/*
Prediction Result:
(None, '2019-01-10', '2019-11-19')
*/