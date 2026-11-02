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
-- DATASET 6
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('ev_no_budget_18', 'Unfunded 2018', '2018-03-03', 'Meeting', 'No budget', 'Room A', 'Closed');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('ev_no_budget_19', 'Unfunded 2019', '2019-07-07', 'Meeting', 'No budget', 'Room B', 'Closed');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('b_orphan', 'General', 500.00, 100.00, 600, 'Closed', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(CASE WHEN SUBSTRING(T1.event_date, 1, 4) = '2019' THEN T2.spent ELSE 0 END) - SUM(CASE WHEN SUBSTRING(T1.event_date, 1, 4) = '2020' THEN T2.spent ELSE 0 END) AS num FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT CAST((SELECT COALESCE(SUM(spent), 0) FROM budget JOIN event ON budget.link_to_event = event.event_id WHERE event.event_date LIKE '2019%') AS REAL) - CAST((SELECT COALESCE(SUM(spent), 0) FROM budget JOIN event ON budget.link_to_event = event.event_id WHERE event.event_date LIKE '2020%') AS REAL) AS difference;

/*
Prediction Result:
(0.0,)
*/