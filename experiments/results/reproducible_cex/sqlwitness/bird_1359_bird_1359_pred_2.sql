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
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('Yearly Kickoff', NULL, 'default2', 'October Meeting', 'Advertisement', 'Meeting', 'default1'), ('Meeting', 'October Meeting', 'Meeting', 'default1', 'October Meeting', 'Yearly Kickoff', 'default2'), ('default1', 'Meeting', 'Meeting', 'Meeting', 'default1', 'Advertisement', 'Yearly Kickoff'), ('October Meeting', 'Yearly Kickoff', 'default2', 'default2', 'Meeting', 'default1', 'Advertisement'), ('default2', 'default1', 'default1', 'Yearly Kickoff', 'default1', 'default2', 'Yearly Kickoff'), ('Advertisement', 'default1', 'default1', 'default2', NULL, 'October Meeting', 'October Meeting'), ('unique_6', 'October Meeting', 'default2', 'Yearly Kickoff', 'default1', 'Advertisement', 'October Meeting');
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('default1', 'October Meeting', 'Advertisement', 0.0, 0.0, 1, 'Advertisement'), ('default2', 'Meeting', 'Advertisement', -1.0, NULL, 1, 'October Meeting'), ('October Meeting', 'default2', 'Yearly Kickoff', NULL, -1.0, 1, 'default1'), ('Meeting', 'Meeting', 'October Meeting', NULL, NULL, -1, 'October Meeting');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN T2.event_name = 'Yearly Kickoff' THEN T1.amount ELSE 0 END) AS REAL) / SUM(CASE WHEN T2.event_name = 'October Meeting' THEN T1.amount ELSE 0 END) FROM budget AS T1 INNER JOIN event AS T2 ON T1.link_to_event = T2.event_id WHERE T1.category = 'Advertisement' AND T2.type = 'Meeting';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT SUM(CASE WHEN "event"."event_name" = 'Yearly Kickoff' THEN "budget"."amount" ELSE 0 END) / SUM(CASE WHEN "event"."event_name" = 'October Meeting' THEN "budget"."amount" ELSE 0 END) FROM "budget" INNER JOIN "event" ON "budget"."link_to_event" = "event"."event_id" WHERE "budget"."category" = 'Advertisement';

/*
Prediction Result:
(1,)
*/