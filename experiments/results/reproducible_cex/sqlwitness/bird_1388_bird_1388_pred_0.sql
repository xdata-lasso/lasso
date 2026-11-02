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
INSERT INTO major (major_id, major_name, department, college) VALUES ('default2', NULL, 'default2', 'default2'), ('default1', NULL, NULL, 'default2'), ('unique_2', NULL, 'default2', 'default1'), ('unique_3', 'default2', 'default2', NULL), ('unique_4', NULL, 'default2', 'default1'), ('unique_5', 'default2', 'default2', 'default1'), ('unique_6', NULL, 'default2', NULL), ('unique_7', 'default2', 'default2', 'default1'), ('unique_8', NULL, NULL, 'default1'), ('unique_9', NULL, NULL, 'default1'), ('unique_10', 'default2', 'default1', NULL), ('unique_11', 'default2', 'default1', 'default1'), ('unique_12', 'default1', NULL, NULL), ('unique_13', NULL, 'default2', NULL), ('unique_14', 'default2', NULL, 'default1'), ('unique_15', 'default1', 'default1', 'default2'), ('unique_16', 'default2', 'default2', 'default2'), ('unique_17', NULL, 'default2', 'default2'), ('unique_18', NULL, 'default2', 'default1');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('default2', 'unique_4', NULL, 'default2', 'default1', NULL, 'default2', NULL, NULL), ('default1', 'unique_9', NULL, 'default1', 'default1', NULL, 'default1', NULL, NULL), ('unique_2', 'default2', NULL, 'default1', NULL, NULL, 'default1', NULL, 'default2'), ('unique_3', 'unique_15', NULL, 'default2', NULL, 'default2', 'default1', NULL, 'default2'), ('unique_4', 'default2', NULL, 'default1', NULL, 'default1', 'default1', 'default2', 'default2'), ('unique_5', 'unique_5', NULL, NULL, NULL, 'default2', NULL, 'default1', 'default2'), ('unique_6', 'unique_9', NULL, 'default1', NULL, NULL, 'default2', NULL, 'default2'), ('unique_7', 'unique_18', NULL, NULL, 'default1', 'default2', 'default2', 'default2', NULL), ('unique_8', 'unique_7', NULL, NULL, 'default1', 'default1', NULL, 'default1', 'default2'), ('unique_9', 'unique_18', NULL, NULL, 'default2', 'default1', 'default2', NULL, 'default1'), ('unique_10', 'default1', NULL, NULL, 'default1', 'default2', 'default2', 'default2', 'default2'), ('unique_11', 'default1', NULL, 'default1', NULL, 'default1', 'default2', 'default2', NULL), ('unique_12', 'unique_15', NULL, NULL, 'default1', NULL, NULL, 'default2', NULL), ('unique_13', 'unique_16', NULL, 'default1', 'default2', 'default1', NULL, 'default2', NULL), ('unique_14', 'unique_8', NULL, 'default2', NULL, NULL, 'default2', 'default2', 'default1');
INSERT INTO income (income_id, link_to_member, date_received, amount, source, notes) VALUES ('default2', 'unique_11', 'default1', 0, 'default2', 'default2'), ('default1', 'unique_13', 'default2', 0, NULL, NULL), ('unique_2', 'unique_2', 'default1', 1, 'default2', 'default1'), ('unique_3', 'unique_9', NULL, 0, 'default2', 'default2'), ('unique_4', 'unique_6', 'default2', 0, 'default1', NULL), ('unique_5', 'unique_8', NULL, 0, NULL, 'default1'), ('unique_6', 'unique_10', 'default1', 2, 'default1', 'default1'), ('unique_7', 'unique_2', 'default2', 1, NULL, 'default1'), ('unique_8', 'unique_2', 'default1', 2, 'default1', 'default1'), ('unique_9', 'unique_12', NULL, 1, NULL, 'default1'), ('unique_10', NULL, 'default1', 2, NULL, 'default2'), ('unique_11', 'default2', 'default1', 1, 'default2', NULL), ('unique_12', 'unique_8', 'default1', 1, 'default2', NULL), ('unique_13', 'unique_5', 'default1', 0, 'default1', 'default2'), ('unique_14', 'unique_6', 'default2', 2, 'default2', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.first_name, T1.last_name, T2.source FROM member AS T1 INNER JOIN income AS T2 ON T1.member_id = T2.link_to_member GROUP BY T1.first_name, T1.last_name, T2.source ORDER BY SUM(T2.amount) DESC, T1.first_name NULLS LAST, T1.last_name NULLS LAST, T2.source NULLS LAST LIMIT 1;

/*
Gold Result:
('default1', None, 'default2')
*/

-- Prediction Query
SELECT T1.first_name, T1.last_name, T2.source FROM member AS T1 INNER JOIN income AS T2 ON T1.member_id = T2.link_to_member ORDER BY T2.amount DESC, T1.member_id NULLS LAST, T2.income_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(None, 'default1', 'default1')
*/