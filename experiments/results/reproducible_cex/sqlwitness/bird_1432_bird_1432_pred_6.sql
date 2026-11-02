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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (1, 'default1', 'default1', 'default2', 'Member', 'Medium'), (51, 'default2', 'Member', NULL, 'Member', 'default2'), (100, NULL, 'Member', 'Medium', 'Medium', 'default2'), (50, NULL, 'Member', 'Medium', 'default2', 'Medium'), (0, 'Medium', 'default2', 'Medium', 'Medium', 'Member');
INSERT INTO major (major_id, major_name, department, college) VALUES ('default1', 'default2', 'default1', 'default1'), ('default2', 'Member', 'default2', 'default2'), ('Member', 'Member', NULL, 'default1');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('default1', 'default2', 0, NULL, 'default1', 'Medium', 'default1', 'Medium', 'default1'), ('Member', 'default2', 1, 'default1', 'default2', 'Medium', 'default2', 'Medium', NULL), ('Medium', 'Member', NULL, 'Medium', 'Medium', 'Member', 'default1', 'Medium', 'default1'), ('default2', 'default2', 1, 'Member', 'Medium', NULL, 'default1', 'default2', 'default1'), ('unique_4', 'Member', NULL, 'Member', 'Medium', NULL, 'Medium', 'Member', NULL);
INSERT INTO income (income_id, link_to_member, date_received, amount, source, notes) VALUES ('default1', 'default2', 'default1', NULL, NULL, 'default1'), ('Member', 'unique_4', 'default1', 51, 'default1', 'Member'), ('Medium', 'Medium', NULL, NULL, NULL, 'default1'), ('default2', 'Member', NULL, 49, NULL, 'Medium');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN T2.amount = 50 THEN 1.0 ELSE 0 END) AS REAL) * 100 / COUNT(T2.income_id) FROM member AS T1 INNER JOIN income AS T2 ON T1.member_id = T2.link_to_member WHERE T1.position = 'Member' AND T1.t_shirt_size = 'Medium';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN income.amount = 50 THEN 1 ELSE 0 END) AS REAL) * 100.0 / COUNT(*) AS percentage FROM member INNER JOIN income ON member.member_id = income.link_to_member WHERE member.t_shirt_size = 'Medium';

/*
Prediction Result:
(0.0,)
*/