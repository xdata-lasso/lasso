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
-- DATASET 1
-- Tests basic >, <, = boundary conditions against AVG(cost), and DISTINCT vs non-DISTINCT for a member with multiple above-average expenses.
INSERT INTO "member" (member_id, first_name, last_name, phone) VALUES ('M1', 'Alice', 'Smith', '111-1111');
INSERT INTO "member" (member_id, first_name, last_name, phone) VALUES ('M2', 'Bob', 'Jones', '222-2222');
INSERT INTO "member" (member_id, first_name, last_name, phone) VALUES ('M3', 'Charlie', 'Brown', '333-3333');
INSERT INTO "budget" (budget_id, spent, remaining, amount) VALUES ('B1', 5.0, 5.0, 5);
INSERT INTO "budget" (budget_id, spent, remaining, amount) VALUES ('B2', 100.0, 100.0, 100);
INSERT INTO "expense" (expense_id, cost, link_to_member, link_to_budget) VALUES ('E1', 10.0, 'M1', 'B1');
INSERT INTO "expense" (expense_id, cost, link_to_member, link_to_budget) VALUES ('E2', 20.0, 'M2', 'B1');
INSERT INTO "expense" (expense_id, cost, link_to_member, link_to_budget) VALUES ('E3', 30.0, 'M3', 'B2');
INSERT INTO "expense" (expense_id, cost, link_to_member, link_to_budget) VALUES ('E4', 30.0, 'M3', 'B2');
INSERT INTO "expense" (expense_id, cost, link_to_member, link_to_budget) VALUES ('E5', 10.0, 'M1', 'B2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.first_name, T3.last_name, T3.phone FROM expense AS T1 INNER JOIN budget AS T2 ON T1.link_to_budget = T2.budget_id INNER JOIN member AS T3 ON T3.member_id = T1.link_to_member WHERE T1.cost > (SELECT AVG(T1.cost) FROM expense AS T1 INNER JOIN budget AS T2 ON T1.link_to_budget = T2.budget_id INNER JOIN member AS T3 ON T3.member_id = T1.link_to_member);

/*
Gold Result:
('Charlie', 'Brown', '333-3333')
*/

-- Prediction Query
SELECT T2.first_name, T2.last_name, T2.phone FROM expense AS T1 INNER JOIN member AS T2 ON T1.link_to_member = T2.member_id WHERE T1.cost > (SELECT AVG(cost) FROM expense);

/*
Prediction Result:
('Charlie', 'Brown', '333-3333')
('Charlie', 'Brown', '333-3333')
*/