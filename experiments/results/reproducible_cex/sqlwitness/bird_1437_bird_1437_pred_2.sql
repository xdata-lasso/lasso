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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (1, 'default2', 'default1', '2019-11-19', 'default2', NULL), (10, 'default2', 'default1', NULL, 'default2', '2019-01-10');
INSERT INTO major (major_id, major_name, department, college) VALUES ('2019-01-10', '2019-01-10', 'true', NULL), ('default2', 'true', '2019-01-10', '2019-11-19'), ('2019-11-19', 'true', '2019-01-10', '2019-01-10'), ('true', NULL, '2019-01-10', NULL), ('default1', '2019-01-10', '2019-01-10', '2019-11-19'), ('unique_5', NULL, '2019-01-10', NULL), ('unique_6', '2019-11-19', NULL, '2019-11-19'), ('unique_7', '2019-01-10', 'default1', NULL), ('unique_8', '2019-11-19', 'default2', 'true'), ('unique_9', 'default2', 'true', '2019-01-10'), ('unique_10', NULL, 'default1', '2019-11-19'), ('unique_11', '2019-11-19', NULL, '2019-11-19');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('true', 'unique_9', NULL, '2019-11-19', 'true', '2019-01-10', NULL, NULL, NULL), ('default1', 'unique_7', 10, '2019-11-19', '2019-01-10', '2019-01-10', '2019-11-19', 'default1', NULL), ('2019-11-19', 'default2', NULL, NULL, 'true', 'default2', '2019-01-10', 'true', '2019-11-19'), ('2019-01-10', 'unique_9', 10, 'default1', '2019-01-10', 'default2', 'true', 'default2', 'true'), ('default2', NULL, NULL, 'true', NULL, 'true', '2019-01-10', '2019-11-19', '2019-01-10'), ('unique_5', 'default1', NULL, NULL, 'default1', '2019-01-10', 'true', 'true', 'default2'), ('unique_6', 'unique_6', 1, 'default1', 'default1', '2019-11-19', '2019-11-19', '2019-01-10', 'default2'), ('unique_7', 'unique_5', 1, 'true', 'true', '2019-11-19', '2019-11-19', '2019-11-19', 'default2'), ('unique_8', '2019-01-10', 1, 'default2', NULL, 'true', '2019-11-19', 'true', '2019-11-19');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('2019-01-10', NULL, 'default2', 'true', 'default1', NULL, NULL), ('default1', '2019-01-10', 'default1', 'default2', 'default1', '2019-11-19', 'default2'), ('default2', NULL, '2019-11-19', NULL, '2019-01-10', '2019-01-10', '2019-11-19'), ('2019-11-19', 'default1', NULL, '2019-01-10', 'default1', 'default2', '2019-01-10'), ('true', 'default2', 'true', 'true', 'default1', 'default1', 'default1'), ('unique_5', '2019-01-10', '2019-11-19', '2019-01-10', NULL, 'default2', 'default1'), ('unique_6', 'default1', '2019-01-10', '2019-11-19', '2019-01-10', 'true', 'default1'), ('unique_7', '2019-01-10', '2019-01-10', 'default2', 'true', '2019-01-10', 'true'), ('unique_8', '2019-11-19', NULL, 'default2', 'true', 'default2', 'default1'), ('unique_9', 'default1', 'default1', '2019-01-10', 'default1', 'default1', 'true'), ('unique_10', 'default1', NULL, 'default1', '2019-11-19', '2019-01-10', NULL), ('unique_11', 'default1', 'true', 'true', 'true', 'true', NULL), ('unique_12', '2019-01-10', NULL, 'default2', '2019-11-19', '2019-11-19', '2019-01-10'), ('unique_13', NULL, '2019-11-19', NULL, '2019-11-19', '2019-11-19', '2019-11-19'), ('unique_14', 'true', NULL, 'default2', '2019-11-19', 'true', NULL), ('unique_15', 'true', '2019-11-19', 'default2', NULL, 'default1', 'true'), ('unique_16', '2019-01-10', 'true', 'default1', 'default2', NULL, 'default2');
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('true', 'unique_15', '2019-11-19', 0.0, 0.0, 1, 'default2'), ('2019-11-19', 'unique_12', 'default2', 0.0, NULL, 11, '2019-01-10'), ('default2', '2019-11-19', '2019-01-10', 0.0, 1.0, 11, 'default1'), ('default1', 'unique_14', NULL, 11.0, 1.0, NULL, '2019-11-19'), ('2019-01-10', 'true', '2019-11-19', NULL, 9.0, 11, '2019-01-10'), ('unique_5', 'unique_12', 'true', NULL, 9.0, 2, '2019-11-19'), ('unique_6', 'true', 'true', 0.0, 9.0, 2, 'default2'), ('unique_7', 'unique_15', NULL, 9.0, 0.0, 10, 'true'), ('unique_8', 'unique_14', 'default1', 0.0, 11.0, 10, '2019-11-19'), ('unique_9', 'unique_16', 'default2', 0.0, 9.0, 0, 'true'), ('unique_10', 'unique_15', '2019-11-19', NULL, NULL, 9, '2019-01-10'), ('unique_11', '2019-11-19', 'true', 1.0, 10.0, 0, 'default1');
INSERT INTO expense (expense_id, link_to_budget, link_to_member, expense_description, expense_date, cost, approved) VALUES ('default1', 'unique_11', 'unique_5', '2019-01-10', '2019-01-10', 0.0, 'true'), ('true', 'default2', NULL, 'default1', NULL, 11.0, 'default2'), ('2019-01-10', 'unique_5', NULL, NULL, 'default2', 2.0, '2019-01-10'), ('default2', 'unique_5', 'unique_7', 'default2', NULL, 1.0, 'true'), ('2019-11-19', 'unique_10', 'unique_5', NULL, '2019-01-10', 0.0, '2019-11-19'), ('unique_5', 'unique_8', 'unique_7', 'default1', '2019-01-10', 11.0, NULL), ('unique_6', 'unique_10', 'default2', '2019-01-10', '2019-01-10', 1.0, '2019-01-10'), ('unique_7', 'unique_6', 'true', '2019-11-19', '2019-01-10', 9.0, 'true'), ('unique_8', NULL, '2019-01-10', '2019-01-10', NULL, 2.0, '2019-11-19'), ('unique_9', '2019-01-10', 'unique_8', 'default1', 'true', 10.0, '2019-11-19');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('unique_6', 'unique_8'), ('unique_14', 'unique_5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.link_to_member, T3.link_to_event FROM expense AS T1 INNER JOIN member AS T2 ON T1.link_to_member = T2.member_id INNER JOIN attendance AS T3 ON T2.member_id = T3.link_to_member WHERE DATE(SUBSTRING(T1.expense_date, 1, 10)) BETWEEN '2019-01-10' AND '2019-11-19' AND T1.approved = 'true';

/*
Gold Result:
('unique_5', 'unique_14')
*/

-- Prediction Query
SELECT DISTINCT "member"."first_name", "member"."last_name", "attendance"."link_to_event" FROM "member" INNER JOIN "expense" ON "member"."member_id" = "expense"."link_to_member" INNER JOIN "attendance" ON "member"."member_id" = "attendance"."link_to_member" WHERE "expense"."approved" = 'true' AND "expense"."expense_date" BETWEEN '2019-01-10' AND '2019-11-19';

/*
Prediction Result:
(None, 'default1', 'unique_14')
*/