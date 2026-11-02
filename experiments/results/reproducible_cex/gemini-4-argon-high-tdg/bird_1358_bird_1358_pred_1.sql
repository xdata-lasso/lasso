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
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M1', 'Grace', 'Green', 'grace@example.com', 'Member', 'M', '555-0301', NULL, NULL);
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M2', 'Henry', 'Hall', 'henry@example.com', 'Member', 'L', '555-0302', NULL, NULL);
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('I1', '2020-01-01', 50, 'Dues', 'Unlinked anonymous dues', NULL);
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('I2', '2021-04-10', 50, 'Dues', 'Earliest member dues', 'M1');
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('I3', '2022-09-15', 50, 'Dues', 'Second member dues', 'M2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.first_name, T1.last_name FROM member AS T1 INNER JOIN income AS T2 ON T1.member_id = T2.link_to_member WHERE T2.source = 'Dues' ORDER BY T2.date_received, T1.member_id NULLS LAST, T2.income_id NULLS LAST LIMIT 1;

/*
Gold Result:
('Grace', 'Green')
*/

-- Prediction Query
SELECT m.first_name, m.last_name FROM income AS i INNER JOIN member AS m ON i.link_to_member = m.member_id WHERE i.source = 'Dues' AND i.date_received = (SELECT MIN(date_received) FROM income WHERE source = 'Dues') LIMIT 1;

/*
Prediction Result:
*/