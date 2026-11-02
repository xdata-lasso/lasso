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
INSERT INTO major (major_id, major_name, department, college) VALUES ('2019-01-10', 'true', 'default1', '2019-11-19'), ('default1', '2019-11-19', 'default1', '2019-01-10'), ('true', '2019-11-19', NULL, '2019-01-10'), ('2019-11-19', NULL, 'true', 'true'), ('default2', 'default2', '2019-11-19', '2019-01-10'), ('unique_5', NULL, NULL, NULL), ('unique_6', 'default1', '2019-11-19', '2019-01-10'), ('unique_7', 'true', 'true', 'default1');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('2019-01-10', 'default1', NULL, 'true', NULL, 'default2', 'default1', 'default2', 'default2'), ('2019-11-19', '2019-11-19', NULL, 'default2', '2019-01-10', NULL, '2019-01-10', NULL, 'true'), ('true', 'unique_6', NULL, 'true', 'default1', NULL, 'default1', '2019-11-19', 'default1');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('true', 'default2', 'default2', 'default2', 'default1', '2019-11-19', NULL), ('default2', NULL, '2019-01-10', '2019-01-10', 'default2', 'default2', '2019-11-19'), ('2019-01-10', NULL, 'default2', 'default1', '2019-01-10', NULL, '2019-11-19'), ('default1', 'default2', '2019-11-19', NULL, 'true', '2019-01-10', 'true'), ('2019-11-19', '2019-11-19', 'default2', '2019-01-10', '2019-01-10', 'true', NULL), ('unique_5', 'true', NULL, '2019-01-10', 'true', NULL, NULL), ('unique_6', '2019-11-19', 'default2', 'default2', '2019-01-10', '2019-11-19', '2019-01-10'), ('unique_7', 'true', '2019-01-10', 'true', '2019-11-19', 'default1', '2019-01-10'), ('unique_8', NULL, 'true', NULL, 'default2', 'true', NULL), ('unique_9', 'default1', 'true', 'true', 'default2', 'default2', '2019-11-19'), ('unique_10', 'true', 'true', 'default2', '2019-11-19', '2019-01-10', 'default1'), ('unique_11', 'true', NULL, 'default2', 'true', 'default1', '2019-01-10'), ('unique_12', '2019-01-10', '2019-11-19', NULL, NULL, 'true', 'default2'), ('unique_13', 'default1', 'default2', '2019-11-19', 'default1', '2019-11-19', NULL), ('unique_14', '2019-11-19', NULL, 'default1', NULL, 'default2', 'default2'), ('unique_15', '2019-11-19', '2019-11-19', NULL, '2019-01-10', NULL, NULL), ('unique_16', 'default2', 'default1', 'true', 'default1', NULL, 'default1'), ('unique_17', '2019-01-10', 'default2', 'default1', '2019-11-19', NULL, 'default1'), ('unique_18', '2019-01-10', NULL, '2019-11-19', NULL, 'default2', 'true');
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('2019-01-10', 'unique_10', 'default2', NULL, 11.0, 0, NULL), ('default2', 'unique_6', '2019-11-19', 1.0, 0.0, 10, 'true'), ('true', 'unique_10', 'default1', 10.0, NULL, 11, '2019-01-10'), ('2019-11-19', 'unique_7', 'true', 9.0, 9.0, 9, 'default1'), ('default1', 'true', 'true', 9.0, NULL, 10, '2019-11-19'), ('unique_5', 'unique_5', 'default1', 2.0, 10.0, 2, '2019-01-10'), ('unique_6', 'unique_10', '2019-11-19', 1.0, 11.0, 1, '2019-01-10'), ('unique_7', '2019-11-19', 'default2', 2.0, NULL, 1, '2019-11-19'), ('unique_8', 'unique_7', 'default1', 1.0, 9.0, 1, 'default1'), ('unique_9', 'unique_8', '2019-01-10', 9.0, 9.0, 11, NULL), ('unique_10', NULL, '2019-01-10', NULL, 9.0, 2, 'default2');
INSERT INTO expense (expense_id, link_to_budget, link_to_member, expense_description, expense_date, cost, approved) VALUES ('2019-01-10', 'unique_8', 'true', '2019-01-10', '2019-11-19', 1.0, 'default2'), ('default2', NULL, '2019-11-19', '2019-01-10', NULL, 0.0, 'default2'), ('default1', 'unique_5', NULL, '2019-01-10', 'default2', NULL, 'default2'), ('true', 'unique_8', 'true', '2019-11-19', 'true', 1.0, 'true'), ('2019-11-19', '2019-01-10', NULL, '2019-11-19', 'default2', 9.0, 'default1'), ('unique_5', 'true', '2019-11-19', 'true', '2019-11-19', 10.0, 'default1'), ('unique_6', 'default2', NULL, NULL, '2019-11-19', 10.0, NULL), ('unique_7', '2019-01-10', '2019-01-10', NULL, 'default1', 10.0, 'default2'), ('unique_8', 'unique_5', '2019-01-10', '2019-11-19', '2019-01-10', 11.0, 'true'), ('unique_9', '2019-01-10', '2019-11-19', '2019-11-19', NULL, 2.0, '2019-01-10'), ('unique_10', 'unique_8', '2019-11-19', 'default1', '2019-01-10', NULL, 'default2'), ('unique_11', '2019-01-10', 'true', 'default1', 'true', 10.0, '2019-01-10'), ('unique_12', 'default2', NULL, 'default2', '2019-01-10', 0.0, '2019-11-19'), ('unique_13', 'unique_7', 'true', '2019-11-19', '2019-01-10', 2.0, 'default1'), ('unique_14', 'unique_10', '2019-11-19', NULL, '2019-01-10', 11.0, '2019-01-10'), ('unique_15', '2019-11-19', 'true', '2019-11-19', 'default2', 10.0, NULL), ('unique_16', 'unique_8', 'true', 'true', '2019-11-19', 10.0, '2019-11-19'), ('unique_17', 'unique_10', NULL, NULL, NULL, 2.0, '2019-11-19'), ('unique_18', 'unique_8', 'true', 'true', NULL, 1.0, '2019-01-10'), ('unique_19', 'unique_8', '2019-01-10', 'default2', '2019-01-10', 2.0, 'true'), ('unique_20', 'true', 'true', 'default2', 'true', 0.0, 'default2'), ('unique_21', 'unique_7', '2019-01-10', '2019-11-19', 'default1', NULL, 'default1'), ('unique_22', '2019-01-10', '2019-11-19', 'default1', 'default2', 2.0, 'default2'), ('unique_23', 'unique_6', '2019-11-19', '2019-01-10', '2019-01-10', 2.0, NULL), ('unique_24', '2019-01-10', '2019-01-10', NULL, NULL, 1.0, NULL), ('unique_25', 'unique_8', '2019-01-10', '2019-11-19', NULL, 10.0, '2019-01-10'), ('unique_26', 'true', '2019-11-19', 'true', 'true', 2.0, 'default1'), ('unique_27', '2019-01-10', 'true', '2019-01-10', 'default1', 1.0, 'default2'), ('unique_28', 'unique_6', '2019-11-19', NULL, 'default2', 1.0, '2019-11-19');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('unique_6', '2019-11-19'), ('unique_14', '2019-11-19'), ('true', '2019-01-10');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.link_to_member, T3.link_to_event FROM expense AS T1 INNER JOIN member AS T2 ON T1.link_to_member = T2.member_id INNER JOIN attendance AS T3 ON T2.member_id = T3.link_to_member WHERE DATE(SUBSTRING(T1.expense_date, 1, 10)) BETWEEN '2019-01-10' AND '2019-11-19' AND T1.approved = 'true';

/*
Gold Result:
('2019-01-10', 'true')
*/

-- Prediction Query
SELECT T2.link_to_member, T2.link_to_event FROM expense AS T1 INNER JOIN attendance AS T2 ON T1.link_to_member = T2.link_to_member INNER JOIN member AS T3 ON T2.link_to_member = T3.member_id WHERE T1.approved = 'true' AND T1.expense_date BETWEEN '2019-01-10' AND '2019-11-19';

/*
Prediction Result:
('2019-01-10', 'true')
('2019-01-10', 'true')
*/