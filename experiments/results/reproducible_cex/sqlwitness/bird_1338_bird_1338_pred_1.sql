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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (0, 'default1', 'default1', '2019-10-08', 'default2', 'Yes'), (1, 'true', '2019-10-08%', '2019-10-08%', 'true', '2019-10-08'), (2, 'true', '2019-10-08%', 'Yes', 'default2', 'October Meeting'), (3, 'default1', 'No', '2019-10-08', 'default1', '2019-10-08'), (4, 'true', 'Yes', '2019-10-08%', 'No', 'October Meeting'), (5, 'No', '2019-10-08%', 'No', '2019-10-08%', 'default1'), (6, NULL, 'default2', '2019-10-08', 'No', NULL);
INSERT INTO major (major_id, major_name, department, college) VALUES ('October Meeting', NULL, 'default1', 'October Meeting'), ('default2', 'Yes', 'Yes', 'Yes'), ('true', '2019-10-08%', '2019-10-08%', 'default2'), ('2019-10-08', NULL, NULL, '2019-10-08%'), ('2019-10-08%', '2019-10-08', NULL, '2019-10-08%'), ('No', 'true', 'October Meeting', 'No'), ('Yes', 'true', 'Yes', 'true'), ('default1', NULL, 'Yes', 'default2'), ('unique_8', NULL, '2019-10-08', '2019-10-08%'), ('unique_9', '2019-10-08%', 'October Meeting', 'No'), ('unique_10', 'No', 'No', 'No'), ('unique_11', 'true', 'default2', '2019-10-08%'), ('unique_12', 'default2', 'default1', 'Yes'), ('unique_13', NULL, 'true', 'true'), ('unique_14', 'Yes', '2019-10-08', 'default1');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('2019-10-08', 'unique_11', 1, 'October Meeting', 'default1', 'default2', 'default1', 'default2', '2019-10-08'), ('2019-10-08%', 'unique_13', 2, 'No', '2019-10-08', 'default1', 'default1', 'No', 'No'), ('October Meeting', 'unique_14', 6, 'true', NULL, '2019-10-08%', '2019-10-08', 'Yes', 'No'), ('true', 'default1', 3, 'Yes', 'October Meeting', 'default1', 'default1', NULL, '2019-10-08%'), ('Yes', 'unique_11', NULL, 'true', 'October Meeting', 'October Meeting', 'Yes', '2019-10-08', 'default2'), ('default2', 'October Meeting', 2, 'Yes', 'Yes', 'default1', 'Yes', 'No', 'default1'), ('No', NULL, 6, 'Yes', 'true', '2019-10-08', 'No', 'Yes', '2019-10-08%'), ('default1', 'true', 6, 'default2', 'No', 'Yes', NULL, 'Yes', 'October Meeting'), ('unique_8', 'default2', 2, 'default2', '2019-10-08', 'true', 'No', 'true', 'default1'), ('unique_9', 'unique_8', 1, 'No', 'October Meeting', '2019-10-08%', 'No', NULL, 'default1'), ('unique_10', 'default2', 2, 'true', 'default2', 'October Meeting', 'default2', '2019-10-08%', NULL), ('unique_11', 'true', 5, NULL, '2019-10-08%', NULL, 'Yes', 'default1', 'default2'), ('unique_12', 'No', 1, 'Yes', 'No', 'true', NULL, 'true', 'true'), ('unique_13', '2019-10-08%', NULL, 'October Meeting', 'October Meeting', 'default1', 'default2', '2019-10-08', 'default1'), ('unique_14', 'default2', 6, '2019-10-08', NULL, 'No', 'October Meeting', 'true', '2019-10-08%'), ('unique_15', 'default1', 3, '2019-10-08%', '2019-10-08', 'default1', '2019-10-08', 'default1', 'default2'), ('unique_16', 'unique_9', 6, 'default2', 'October Meeting', NULL, 'Yes', 'October Meeting', 'October Meeting'), ('unique_17', 'No', NULL, '2019-10-08%', NULL, 'default2', '2019-10-08%', 'default1', 'October Meeting'), ('unique_18', 'default2', 4, NULL, 'No', '2019-10-08', 'true', 'October Meeting', 'No');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('default1', 'No', '2019-10-08%', 'October Meeting', 'default2', 'October Meeting', 'default2'), ('true', 'Yes', 'No', 'October Meeting', '2019-10-08%', '2019-10-08', 'default1'), ('2019-10-08', 'October Meeting', '2019-10-08%', 'October Meeting', 'Yes', 'true', 'default2');
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('Yes', '2019-10-08', '2019-10-08', 1.0, NULL, NULL, 'No'), ('default1', NULL, NULL, 0.0, 0.0, 0, 'No'), ('default2', 'default1', 'true', 1.0, 1.0, 0, '2019-10-08'), ('true', 'default1', 'true', 0.0, 1.0, 1, NULL), ('2019-10-08', 'default1', 'default1', NULL, 1.0, NULL, '2019-10-08%'), ('October Meeting', '2019-10-08', 'Yes', 0.0, 1.0, NULL, 'true'), ('2019-10-08%', 'default1', 'October Meeting', 0.0, NULL, 1, 'No'), ('No', 'default1', 'No', NULL, NULL, 1, 'default1'), ('unique_8', 'default1', '2019-10-08%', 1.0, 0.0, NULL, 'No'), ('unique_9', 'default1', 'default1', NULL, 0.0, 1, '2019-10-08'), ('unique_10', 'true', 'Yes', 0.0, NULL, 1, 'default2');
INSERT INTO expense (expense_id, link_to_budget, link_to_member, expense_description, expense_date, cost, approved) VALUES ('October Meeting', NULL, 'true', 'October Meeting', '2019-10-08', 0.0, 'default1'), ('No', 'October Meeting', 'unique_12', 'No', 'true', 1.0, NULL), ('2019-10-08%', 'true', 'true', NULL, 'default1', 1.0, '2019-10-08'), ('2019-10-08', 'default2', '2019-10-08%', 'October Meeting', 'default2', 1.0, 'October Meeting'), ('default2', 'true', 'true', 'Yes', 'true', NULL, 'true'), ('Yes', 'No', 'October Meeting', 'No', '2019-10-08%', 1.0, 'default2'), ('true', 'unique_9', '2019-10-08%', 'October Meeting', '2019-10-08', 0.0, '2019-10-08%'), ('default1', 'default1', '2019-10-08', '2019-10-08%', NULL, NULL, 'October Meeting'), ('unique_8', 'unique_10', 'No', 'October Meeting', 'default2', NULL, 'No'), ('unique_9', NULL, 'unique_13', 'true', 'Yes', 1.0, 'default1'), ('unique_10', '2019-10-08', 'unique_8', 'default1', 'October Meeting', 1.0, 'default2'), ('unique_11', NULL, 'October Meeting', 'default1', 'default1', 0.0, 'true'), ('unique_12', 'default2', 'unique_17', 'Yes', '2019-10-08', NULL, 'No'), ('unique_13', 'No', 'unique_11', 'October Meeting', 'October Meeting', NULL, 'true'), ('unique_14', 'unique_8', '2019-10-08%', '2019-10-08', '2019-10-08%', 1.0, '2019-10-08'), ('unique_15', 'unique_10', 'unique_16', '2019-10-08%', 'default1', 1.0, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.approved FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget WHERE T1.event_name = 'October Meeting' AND T1.event_date LIKE '2019-10-08%';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT "expense"."expense_description", CASE WHEN "expense"."approved" = 'true' THEN 'Yes' ELSE 'No' END AS "approved" FROM "expense" INNER JOIN "budget" ON "expense"."link_to_budget" = "budget"."budget_id" INNER JOIN "event" ON "budget"."link_to_event" = "event"."event_id" WHERE "event"."event_name" = 'October Meeting' AND "expense"."expense_date" = '2019-10-08';

/*
Prediction Result:
*/