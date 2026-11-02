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
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('default1', NULL, '2019', 'default1', NULL, '%Y', '2020'), ('%Y', '2020', 'default1', '2019', '%Y', '%Y', NULL), ('2020', '2019', '%Y', NULL, 'default2', '2019', 'default1'), ('2019', '2019', 'default2', '2019', '2019', 'default2', 'default1'), ('default2', 'default1', '2019', '%Y', 'default1', '2020', '%Y'), ('unique_5', '%Y', '2019', '%Y', '2020', 'default2', '2019');
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('default1', 'default1', '%Y', 4.0, NULL, 1, '2019'), ('2019', 'unique_5', NULL, 0.0, 1.0, 3, '2020'), ('2020', 'default1', '2019', 3.0, 1.0, 0, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(CASE WHEN SUBSTRING(T1.event_date, 1, 4) = '2019' THEN T2.spent ELSE 0 END) - SUM(CASE WHEN SUBSTRING(T1.event_date, 1, 4) = '2020' THEN T2.spent ELSE 0 END) AS num FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event;

/*
Gold Result:
(7.0,)
*/

-- Prediction Query
SELECT SUM(CASE WHEN STRFTIME('%Y', T1.event_date) = '2019' THEN T2.spent ELSE 0 END) - SUM(CASE WHEN STRFTIME('%Y', T1.event_date) = '2020' THEN T2.spent ELSE 0 END) AS difference FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event;

/*
Prediction Result:
(0,)
*/