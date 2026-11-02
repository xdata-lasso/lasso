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
-- Tests SUM(T2.amount) vs MAX(T2.amount) vs COUNT(*) vs AVG(T2.amount), and grouping by T2.source
INSERT INTO member (member_id, first_name, last_name) VALUES ('m1', 'Alice', 'Smith');
INSERT INTO member (member_id, first_name, last_name) VALUES ('m2', 'Bob', 'Jones');
INSERT INTO member (member_id, first_name, last_name) VALUES ('m3', 'Charlie', 'Brown');
INSERT INTO income (income_id, amount, source, link_to_member) VALUES ('i1', 60, 'Donation', 'm1');
INSERT INTO income (income_id, amount, source, link_to_member) VALUES ('i2', 60, 'Donation', 'm1');
INSERT INTO income (income_id, amount, source, link_to_member) VALUES ('i3', 100, 'Grant', 'm2');
INSERT INTO income (income_id, amount, source, link_to_member) VALUES ('i4', 30, 'Grant', 'm2');
INSERT INTO income (income_id, amount, source, link_to_member) VALUES ('i5', 100, 'Sponsor', 'm3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.first_name, T1.last_name, T2.source FROM member AS T1 INNER JOIN income AS T2 ON T1.member_id = T2.link_to_member GROUP BY T1.first_name, T1.last_name, T2.source ORDER BY SUM(T2.amount) DESC, T1.first_name NULLS LAST, T1.last_name NULLS LAST, T2.source NULLS LAST LIMIT 1;

/*
Gold Result:
('Bob', 'Jones', 'Grant')
*/

-- Prediction Query
SELECT m.first_name, m.last_name, i.source FROM member AS m JOIN income AS i ON m.member_id = i.link_to_member WHERE m.member_id IN (SELECT member_id FROM (SELECT link_to_member, SUM(amount) AS total_income, RANK() OVER (ORDER BY SUM(amount) DESC) AS income_rank FROM income GROUP BY link_to_member) WHERE income_rank = 1);

/*
Prediction Result:
('Alice', 'Smith', 'Donation')
('Alice', 'Smith', 'Donation')
('Bob', 'Jones', 'Grant')
('Bob', 'Jones', 'Grant')
('Charlie', 'Brown', 'Sponsor')
*/