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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (0, '2019-8-20', '2019-08-20', '2019-8-20', '2019-8-20', 'Post Cards, Posters'), (1, NULL, 'Post Cards, Posters', '2019-08-20', 'Post Cards, Posters', 'default2'), (2, NULL, 'default2', NULL, 'default2', '2019-8-20'), (3, 'default1', NULL, 'Post Cards, Posters', '2019-08-20', '2019-08-20'), (4, '2019-08-20', '2019-8-20', NULL, NULL, '2019-08-20'), (5, '2019-08-20', '2019-08-20', NULL, 'Post Cards, Posters', 'Post Cards, Posters'), (6, '2019-08-20', '2019-8-20', 'Post Cards, Posters', NULL, 'default1'), (7, 'default2', NULL, 'default1', '2019-8-20', 'default2'), (8, 'Post Cards, Posters', '2019-08-20', NULL, '2019-08-20', 'default1');
INSERT INTO major (major_id, major_name, department, college) VALUES ('2019-08-20', 'default2', 'default1', '2019-08-20');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('2019-08-20', '2019-08-20', 8, NULL, '2019-8-20', 'Post Cards, Posters', '2019-08-20', 'default1', 'default2'), ('Post Cards, Posters', '2019-08-20', NULL, '2019-8-20', 'Post Cards, Posters', 'Post Cards, Posters', NULL, NULL, '2019-8-20'), ('default1', '2019-08-20', 0, NULL, 'default1', 'Post Cards, Posters', 'Post Cards, Posters', '2019-8-20', NULL), ('2019-8-20', '2019-08-20', 0, '2019-8-20', 'Post Cards, Posters', 'default1', 'default2', 'default1', 'Post Cards, Posters');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('default1', 'default1', 'default2', 'default2', 'default1', 'default2', '2019-08-20'), ('default2', 'default1', '2019-08-20', NULL, '2019-8-20', 'Post Cards, Posters', 'default1'), ('2019-8-20', 'Post Cards, Posters', 'default2', 'Post Cards, Posters', '2019-8-20', '2019-08-20', 'Post Cards, Posters'), ('Post Cards, Posters', 'default1', '2019-8-20', 'default2', 'default1', '2019-08-20', '2019-8-20'), ('2019-08-20', NULL, '2019-8-20', '2019-08-20', '2019-8-20', 'default1', 'default1'), ('unique_5', '2019-8-20', NULL, '2019-08-20', '2019-8-20', 'default2', NULL), ('unique_6', 'default2', NULL, '2019-8-20', 'default2', 'default1', '2019-8-20'), ('unique_7', 'default1', NULL, 'default2', NULL, '2019-08-20', '2019-8-20'), ('unique_8', 'default1', NULL, 'default2', 'default1', '2019-8-20', NULL);
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('2019-8-20', 'Post Cards, Posters', '2019-08-20', 0.0, NULL, 0, '2019-08-20'), ('default2', 'unique_5', NULL, NULL, 0.0, NULL, 'default1'), ('Post Cards, Posters', 'unique_8', 'default1', 1.0, 0.0, 0, NULL), ('2019-08-20', NULL, NULL, 1.0, NULL, NULL, 'default1'), ('default1', 'unique_6', 'default2', NULL, 0.0, 0, 'Post Cards, Posters');
INSERT INTO expense (expense_id, link_to_budget, link_to_member, expense_description, expense_date, cost, approved) VALUES ('2019-8-20', 'default1', '2019-8-20', 'default1', 'Post Cards, Posters', 0.0, 'default1'), ('default2', 'Post Cards, Posters', 'default1', 'Post Cards, Posters', '2019-08-20', 0.0, NULL), ('Post Cards, Posters', 'default2', NULL, '2019-8-20', 'default1', 1.0, '2019-8-20'), ('default1', '2019-08-20', 'Post Cards, Posters', 'default2', NULL, 1.0, 'default1'), ('2019-08-20', 'Post Cards, Posters', 'Post Cards, Posters', '2019-8-20', '2019-08-20', 0.0, 'default1'), ('unique_5', 'default2', '2019-08-20', '2019-8-20', 'default2', NULL, 'Post Cards, Posters'), ('unique_6', '2019-08-20', '2019-8-20', 'Post Cards, Posters', '2019-8-20', NULL, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_status FROM budget AS T1 INNER JOIN expense AS T2 ON T1.budget_id = T2.link_to_budget WHERE T2.expense_description = 'Post Cards, Posters' AND T2.expense_date = '2019-08-20';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT T3.status FROM expense AS T1 INNER JOIN budget AS T2 ON T1.link_to_budget = T2.budget_id INNER JOIN event AS T3 ON T2.link_to_event = T3.event_id WHERE T1.expense_description = 'Post Cards, Posters' AND T1.expense_date = '2019-8-20';

/*
Prediction Result:
*/