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
-- DATASET 3
-- Tests MAX(spent)/MAX(amount) or MIN(spent)/MIN(amount) when grouped by event.
-- E1 has B1 (spent 100, amount 200 -> 0.50) and B2 (spent 10, amount 15 -> 0.66). Max(spent)/Max(amount) for E1 = 100/200 = 0.5.
-- What if E1 has B1 (spent 100, amount 1000 -> 0.10) and B2 (spent 1, amount 10 -> 0.10)?
-- Wait: if E1 has B1 (spent 95, amount 1000 -> 0.095) and B2 (spent 10, amount 100 -> 0.10). MAX(spent)=95, MIN(amount)=100.
-- What if someone writes SUM(spent) DESC? Covered in Dataset 1.
-- Let's test tie-breaking on T1.budget_id ASC (NULLS LAST) when T1.spent / T1.amount is tied.
INSERT INTO event (event_id, event_name, status) VALUES ('E1', 'Second_By_Budget_ID', 'Closed');
INSERT INTO event (event_id, event_name, status) VALUES ('E2', 'First_By_Budget_ID', 'Closed');
INSERT INTO budget (budget_id, spent, remaining, amount, event_status, link_to_event) VALUES ('B_Z', 50.0, 50.0, 100, 'Closed', 'E1');
INSERT INTO budget (budget_id, spent, remaining, amount, event_status, link_to_event) VALUES ('B_A', 100.0, 100.0, 200, 'Closed', 'E2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.event_name FROM budget AS T1 INNER JOIN event AS T2 ON T1.link_to_event = T2.event_id WHERE T2.status = 'Closed' ORDER BY T1.spent / T1.amount DESC, T1.budget_id NULLS LAST, T2.event_id NULLS LAST LIMIT 1;

/*
Gold Result:
('First_By_Budget_ID',)
*/

-- Prediction Query
SELECT "event"."event_name" FROM "event" INNER JOIN "budget" ON "event"."event_id" = "budget"."link_to_event" WHERE "event"."status" = 'Closed' ORDER BY ("budget"."spent" / "budget"."amount") DESC, event.event_id NULLS LAST, budget.budget_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Second_By_Budget_ID',)
*/