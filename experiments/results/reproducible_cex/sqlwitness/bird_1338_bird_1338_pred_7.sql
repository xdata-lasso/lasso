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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (1, 'October Meeting', '%October Meeting%', '2019-10-08%', 'October Meeting', '2019-10-08%'), (0, 'October Meeting', '%October Meeting%', 'October Meeting', 'October Meeting', '2019-10-08%'), (2, 'October Meeting', '%October Meeting%', 'default1', 'default1', '2019-10-08%'), (3, '%2019-10-08%', '%October Meeting%', '2019-10-08%', '2019-10-08%', 'October Meeting'), (4, '%October Meeting%', NULL, '%October Meeting%', 'default1', 'default1'), (5, 'default2', NULL, 'default2', '%October Meeting%', 'default1'), (6, 'default2', '%2019-10-08%', 'October Meeting', 'October Meeting', '%October Meeting%'), (7, '2019-10-08%', 'October Meeting', '2019-10-08%', 'default1', '%October Meeting%');
INSERT INTO major (major_id, major_name, department, college) VALUES ('%October Meeting%', '%October Meeting%', 'October Meeting', NULL);
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('default1', '%October Meeting%', 1, '%2019-10-08%', NULL, 'October Meeting', NULL, '2019-10-08%', '2019-10-08%'), ('2019-10-08%', '%October Meeting%', 6, '%2019-10-08%', '%2019-10-08%', NULL, 'default2', '%2019-10-08%', NULL), ('%2019-10-08%', '%October Meeting%', 6, NULL, 'default1', '2019-10-08%', 'default1', '2019-10-08%', '2019-10-08%');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('October Meeting', '%2019-10-08%', '%October Meeting%', '2019-10-08%', 'default2', NULL, NULL), ('default2', '%October Meeting%', NULL, NULL, '%October Meeting%', '2019-10-08%', NULL), ('2019-10-08%', 'default1', NULL, '%October Meeting%', '2019-10-08%', 'default2', NULL), ('%October Meeting%', 'October Meeting', '2019-10-08%', 'October Meeting', 'default2', 'October Meeting', '2019-10-08%'), ('%2019-10-08%', 'default2', NULL, '%2019-10-08%', 'default1', '%October Meeting%', '%October Meeting%'), ('default1', 'October Meeting', NULL, NULL, 'October Meeting', NULL, NULL);
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('default1', 'default2', NULL, NULL, 0.0, 0, NULL), ('%2019-10-08%', '%October Meeting%', NULL, 1.0, 1.0, 0, 'default1'), ('October Meeting', '%October Meeting%', NULL, 1.0, 1.0, 0, '%2019-10-08%');
INSERT INTO expense (expense_id, link_to_budget, link_to_member, expense_description, expense_date, cost, approved) VALUES ('default2', NULL, '%2019-10-08%', 'October Meeting', 'default1', 1.0, '2019-10-08%'), ('2019-10-08%', NULL, NULL, 'default2', NULL, 0.0, 'default1'), ('%2019-10-08%', '%2019-10-08%', 'default1', 'default2', '%October Meeting%', 0.0, 'October Meeting'), ('October Meeting', '%2019-10-08%', 'default1', 'October Meeting', '%October Meeting%', 0.0, 'October Meeting'), ('%October Meeting%', NULL, '2019-10-08%', 'default2', '2019-10-08%', NULL, 'default2'), ('default1', 'default1', NULL, 'default1', 'default1', 0.0, 'October Meeting');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.approved FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget WHERE T1.event_name = 'October Meeting' AND T1.event_date LIKE '2019-10-08%';

/*
Gold Result:
('October Meeting',)
('October Meeting',)
*/

-- Prediction Query
SELECT T1.expense_id, T1.expense_description, T1.approved FROM expense AS T1 INNER JOIN budget AS T2 ON T1.link_to_budget = T2.budget_id INNER JOIN event AS T3 ON T2.link_to_event = T3.event_id WHERE T3.event_name LIKE '%October Meeting%' AND T3.event_date LIKE '%2019-10-08%';

/*
Prediction Result:
('%2019-10-08%', 'default2', 'October Meeting')
('October Meeting', 'October Meeting', 'October Meeting')
*/