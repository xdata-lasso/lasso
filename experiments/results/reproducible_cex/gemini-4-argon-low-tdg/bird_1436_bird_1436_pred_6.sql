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
-- DATASET 2
-- Tests:
-- 1. DISTINCT requirement: One member with multiple expenses > 50 attending the same event, and multiple members with expenses > 50 attending the same event.
-- 2. Aggregation mutation: A member with two expenses of 30.0 (SUM(cost) = 60 > 50, but no single expense > 50).
-- 3. Unnecessary table joins: Valid members with NULL zip and NULL link_to_major, and expenses with NULL link_to_budget (kills mutants that INNER JOIN zip_code, major, or budget).
-- 4. Hallucinated predicates: expense.approved = 'No', event.status = 'Cancelled'.
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E_DUP_TEST', 'Conference', '2023-02-01', 'Academic', NULL, 'Center', 'Cancelled');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('E_SUM_TRAP', 'Bake Sale', '2023-02-02', 'Fundraiser', NULL, 'Quad', 'Active');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M_MULTI_EXP', 'Grace', 'Hopper', 'g@test.com', 'Member', 'S', '777-7777', NULL, NULL);
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M_SECOND_MEM', 'Alan', 'Turing', 'a@test.com', 'Member', 'M', '888-8888', NULL, NULL);
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M_SUM_TRAP', 'Ada', 'Lovelace', 'ada@test.com', 'Member', 'M', '999-9999', NULL, NULL);
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E_DUP_TEST', 'M_MULTI_EXP');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E_DUP_TEST', 'M_SECOND_MEM');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('E_SUM_TRAP', 'M_SUM_TRAP');
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('EXP_DUP1', 'Flight', '2023-02-01', 120.0, 'No', 'M_MULTI_EXP', NULL);
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('EXP_DUP2', 'Hotel', '2023-02-01', 200.0, NULL, 'M_MULTI_EXP', NULL);
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('EXP_DUP3', 'Registration', '2023-02-01', 75.0, 'No', 'M_SECOND_MEM', NULL);
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('EXP_SUM1', 'Flour', '2023-02-02', 30.0, 'Yes', 'M_SUM_TRAP', NULL);
INSERT INTO expense (expense_id, expense_description, expense_date, cost, approved, link_to_member, link_to_budget) VALUES ('EXP_SUM2', 'Sugar', '2023-02-02', 30.0, 'Yes', 'M_SUM_TRAP', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.link_to_event FROM expense AS T1 INNER JOIN member AS T2 ON T1.link_to_member = T2.member_id INNER JOIN attendance AS T3 ON T2.member_id = T3.link_to_member WHERE T1.cost > 50;

/*
Gold Result:
('E_DUP_TEST',)
*/

-- Prediction Query
SELECT T2.link_to_event FROM expense AS T1 INNER JOIN attendance AS T2 ON T1.link_to_member = T2.link_to_member WHERE T1.cost > 50;

/*
Prediction Result:
('E_DUP_TEST',)
('E_DUP_TEST',)
('E_DUP_TEST',)
*/