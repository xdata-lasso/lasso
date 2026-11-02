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
-- DATASET 5
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (90001, 'Standard', 'Los Angeles', 'Los Angeles', 'California', 'CA');
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ1', 'History', 'History', 'Humanities');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M1', 'Eve', 'Davis', 'eve@example.com', 'Officer', 'M', '555-0505', 90001, 'MAJ1');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('EV1', 'Banquet', '2023-12-15', 'Social', 'End of year', 'Ballroom', 'Closed');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B_1', 'Food', 100.0, 50.0, 150, 'Closed', 'EV1');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('B_2', 'Food', 200.0, 50.0, 250, 'Closed', 'EV1');
INSERT INTO budget (budget_id, category, spent, remaining, amount, event_status, link_to_event) VALUES ('EXP_Z', 'Decoy', 75.5, 24.5, 100, 'Closed', 'EV1');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('EXP_Z', 'Water, chips, cookies', '2023-12-15', 75.5, 'true', 'M1', 'B_1');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('EXP_A', 'Water, chips, cookies', '2023-12-15', 75.5, 'true', 'M1', 'B_2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.budget_id FROM expense AS T1 INNER JOIN budget AS T2 ON T1.link_to_budget = T2.budget_id WHERE T1.expense_description = 'Water, chips, cookies' ORDER BY T1.cost DESC, T1.expense_id NULLS LAST, T2.budget_id NULLS LAST LIMIT 1;

/*
Gold Result:
('B_2',)
*/

-- Prediction Query
SELECT "budget"."budget_id", "budget"."category", "budget"."spent", "budget"."remaining", "budget"."amount", "budget"."event_status", "budget"."link_to_event" FROM "budget" INNER JOIN "expense" ON "budget"."budget_id" = "expense"."link_to_budget" WHERE "expense"."expense_description" = 'Water, chips, cookies' ORDER BY "expense"."cost" DESC, budget.budget_id NULLS LAST, expense.expense_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('B_1', 'Food', 100.0, 50.0, 150, 'Closed', 'EV1')
*/