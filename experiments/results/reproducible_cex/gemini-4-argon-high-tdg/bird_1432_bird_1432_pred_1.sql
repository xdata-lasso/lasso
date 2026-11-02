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
-- DATASET 4
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ1', 'Mathematics', 'Math', 'Science');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (60601, 'Standard', 'Chicago', 'Cook', 'Illinois', 'IL');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M1', 'Ivy', 'Lee', 'ivy@example.com', 'Member', 'Medium', '555-111-1111', 60601, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M2', 'Jack', 'Moore', 'jack@example.com', 'Member', 'Medium', '555-222-2222', 60601, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M3', 'Kara', 'Nash', 'kara@example.com', 'Member', 'Medium', '555-333-3333', 60601, 'MAJ1');
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('I1', '2023-05-01', 50, 'Dues', 'First 50', 'M1');
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('I2', '2023-05-02', 50, 'Dues', 'Second 50', 'M1');
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('I3', '2023-05-03', NULL, 'Pledge', 'Null amount', 'M1');
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('I4', '2023-05-04', 50, 'Anonymous', 'No member linked', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN T2.amount = 50 THEN 1.0 ELSE 0 END) AS REAL) * 100 / COUNT(T2.income_id) FROM member AS T1 INNER JOIN income AS T2 ON T1.member_id = T2.link_to_member WHERE T1.position = 'Member' AND T1.t_shirt_size = 'Medium';

/*
Gold Result:
(66.66666666666667,)
*/

-- Prediction Query
SELECT (CAST(SUM(CASE WHEN T2.amount = 50 THEN 1 ELSE 0 END) AS REAL) * 100) / COUNT(T1.member_id) AS percentage FROM member AS T1 LEFT JOIN income AS T2 ON T1.member_id = T2.link_to_member WHERE T1.t_shirt_size = 'Medium' AND T1.position = 'Member';

/*
Prediction Result:
(40.0,)
*/