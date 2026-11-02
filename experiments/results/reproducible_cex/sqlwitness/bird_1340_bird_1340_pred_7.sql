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
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('2019', NULL, '2019', NULL, NULL, 'default1', 'default2'), ('default2', 'default1', 'default1', '2020', '2020', '2020', NULL), ('default1', 'default2', '2020', 'default2', '2020', NULL, '2020'), ('2020', '2020', '2019', 'default1', 'default1', NULL, NULL), ('unique_4', 'default1', 'default2', NULL, 'default1', 'default2', 'default1');
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('default2', 'default1', '2020', 3.0, 2.0, 4, '2020'), ('2020', 'unique_4', '2020', NULL, 3.0, 0, '2019');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(CASE WHEN SUBSTRING(T1.event_date, 1, 4) = '2019' THEN T2.spent ELSE 0 END) - SUM(CASE WHEN SUBSTRING(T1.event_date, 1, 4) = '2020' THEN T2.spent ELSE 0 END) AS num FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event;

/*
Gold Result:
(-3.0,)
*/

-- Prediction Query
SELECT (SELECT SUM(budget.spent) FROM budget INNER JOIN event ON budget.link_to_event = event.event_id WHERE SUBSTRING(event.event_date, 1, 4) = '2019') - (SELECT SUM(budget.spent) FROM budget INNER JOIN event ON budget.link_to_event = event.event_id WHERE SUBSTRING(event.event_date, 1, 4) = '2020') AS difference;

/*
Prediction Result:
(None,)
*/