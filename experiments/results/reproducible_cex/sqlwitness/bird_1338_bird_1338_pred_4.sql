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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (0, 'Not Approved', 'true', NULL, 'Approved', 'default1'), (1, 'default2', 'October Meeting', 'Approved', '2019-10-08', 'true'), (2, NULL, 'Not Approved', NULL, 'Not Approved', '2019-10-08%'), (3, 'default2', NULL, 'October Meeting', 'Not Approved', 'default2'), (4, 'true', 'default2', 'Not Approved', 'default2', '2019-10-08%');
INSERT INTO major (major_id, major_name, department, college) VALUES ('Approved', NULL, 'October Meeting', 'Not Approved'), ('default2', NULL, 'October Meeting', 'default2'), ('default1', NULL, 'true', '2019-10-08%'), ('2019-10-08%', 'true', 'October Meeting', 'true'), ('true', 'Approved', 'Approved', 'true'), ('October Meeting', 'Not Approved', 'default1', 'true'), ('2019-10-08', 'default1', 'default1', 'default2'), ('Not Approved', NULL, 'default2', 'true'), ('unique_8', 'default2', 'Approved', 'October Meeting');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('2019-10-08%', '2019-10-08', 1, 'October Meeting', 'October Meeting', '2019-10-08', '2019-10-08%', 'true', 'default1'), ('Approved', 'unique_8', 2, NULL, 'Not Approved', 'true', '2019-10-08', '2019-10-08%', '2019-10-08');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('Not Approved', 'Approved', 'Not Approved', 'default2', 'October Meeting', 'October Meeting', 'default1'), ('default2', 'true', 'true', 'default2', '2019-10-08%', 'Approved', 'default1'), ('Approved', 'October Meeting', NULL, 'default2', 'default1', 'true', 'Approved');
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('true', 'default2', 'default2', 1.0, 0.0, 0, 'Approved'), ('default2', 'default2', 'true', NULL, NULL, NULL, '2019-10-08'), ('default1', 'Not Approved', 'default1', NULL, NULL, 1, NULL), ('2019-10-08%', 'Approved', 'Not Approved', 0.0, 1.0, 0, 'Approved'), ('Approved', 'Approved', 'Approved', 1.0, NULL, 0, '2019-10-08'), ('2019-10-08', NULL, 'default1', 0.0, 0.0, NULL, 'default1');
INSERT INTO expense (expense_id, link_to_budget, link_to_member, expense_description, expense_date, cost, approved) VALUES ('2019-10-08', '2019-10-08%', NULL, 'true', 'true', NULL, 'October Meeting'), ('October Meeting', '2019-10-08', 'Approved', 'default1', '2019-10-08', 0.0, 'default1'), ('Approved', 'Approved', NULL, 'Not Approved', 'true', 0.0, '2019-10-08%'), ('Not Approved', 'default1', NULL, NULL, 'Approved', 1.0, 'Not Approved'), ('true', 'default1', 'Approved', '2019-10-08', 'Approved', 1.0, 'default1'), ('default1', '2019-10-08%', '2019-10-08%', 'Approved', '2019-10-08', NULL, 'default1'), ('2019-10-08%', 'default2', 'Approved', '2019-10-08%', 'October Meeting', 1.0, 'October Meeting'), ('default2', '2019-10-08%', NULL, 'default1', '2019-10-08%', 1.0, 'true'), ('unique_8', '2019-10-08', '2019-10-08%', 'default1', '2019-10-08%', 1.0, 'October Meeting');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.approved FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget WHERE T1.event_name = 'October Meeting' AND T1.event_date LIKE '2019-10-08%';

/*
Gold Result:
*/

-- Prediction Query
SELECT CASE WHEN expense.approved = 'true' THEN 'Approved' ELSE 'Not Approved' END AS is_expense_approved FROM event INNER JOIN budget ON event.event_id = budget.link_to_event INNER JOIN expense ON budget.budget_id = expense.link_to_budget WHERE event.event_name = 'October Meeting' AND expense.expense_date = '2019-10-08';

/*
Prediction Result:
('Not Approved',)
*/