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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (1, 'Education', '%Education%', 'Education', 'default2', '%Education%'), (0, 'default2', 'default2', NULL, 'default2', 'default2'), (2, 'College of Education & Human Services', 'default1', 'default2', 'Education', 'Education'), (3, 'default1', 'College of Education & Human Services', 'default1', 'College of Education & Human Services', 'Education'), (4, 'Member', 'Member', NULL, NULL, 'default2'), (5, 'College of Education & Human Services', '%Education%', 'College of Education & Human Services', 'College of Education & Human Services', 'default1'), (6, '%Education%', NULL, 'Member', 'Member', 'Member'), (7, 'Education', 'default2', 'Member', 'Member', 'College of Education & Human Services'), (8, '%Education%', '%Education%', '%Education%', '%Education%', 'Member'), (9, NULL, NULL, 'Member', NULL, NULL), (10, 'default2', 'default2', '%Education%', 'Education', 'Member'), (11, '%Education%', 'College of Education & Human Services', 'Member', 'default1', 'Education'), (12, 'College of Education & Human Services', 'default1', 'default2', NULL, 'Education'), (13, 'default1', '%Education%', '%Education%', 'default1', 'Member'), (14, 'Education', '%Education%', 'Education', '%Education%', 'default1'), (15, 'Member', 'default2', '%Education%', 'Education', 'default1');
INSERT INTO major (major_id, major_name, department, college) VALUES ('%Education%', '%Education%', 'default2', 'Member'), ('Member', 'College of Education & Human Services', NULL, 'College of Education & Human Services'), ('College of Education & Human Services', NULL, 'Education', 'Member'), ('Education', '%Education%', 'default2', 'default2'), ('default1', 'Education', 'College of Education & Human Services', NULL);
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('Education', '%Education%', 9, 'College of Education & Human Services', 'Education', 'Member', 'Member', 'default1', 'College of Education & Human Services'), ('default1', 'Member', 3, '%Education%', 'default2', '%Education%', 'default1', 'College of Education & Human Services', 'Education'), ('College of Education & Human Services', 'Member', 3, 'College of Education & Human Services', '%Education%', 'default2', '%Education%', 'College of Education & Human Services', 'Member'), ('%Education%', NULL, 0, 'default2', NULL, 'default2', 'default2', 'default2', 'default2'), ('default2', 'Member', NULL, 'default1', 'College of Education & Human Services', '%Education%', 'Member', NULL, 'Education'), ('Member', '%Education%', 14, 'College of Education & Human Services', 'Member', 'default1', 'College of Education & Human Services', 'College of Education & Human Services', 'Education');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.member_id) FROM member AS T1 INNER JOIN major AS T2 ON T2.major_id = T1.link_to_major WHERE T1.position = 'Member' AND T2.major_name LIKE '%Education%' AND T2.college = 'College of Education & Human Services';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id WHERE T2.major_name = 'Education' AND T1.position = 'Member' AND T2.college = 'College of Education & Human Services';

/*
Prediction Result:
(0,)
*/