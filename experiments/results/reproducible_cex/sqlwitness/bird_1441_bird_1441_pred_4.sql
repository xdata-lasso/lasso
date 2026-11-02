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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (1, 'default1', '%education%', 'College of Education & Human Services', '%Education%', NULL), (0, NULL, '%education%', 'College of Education & Human Services', '%Education%', NULL), (2, '%education%', 'default2', NULL, '%Education%', '%education%'), (3, 'default2', '%education%', '%Education%', '%Education%', 'default2'), (4, 'College of Education & Human Services', 'College of Education & Human Services', '%Education%', 'College of Education & Human Services', NULL), (5, 'default2', 'default2', 'default1', 'default2', 'Member');
INSERT INTO major (major_id, major_name, department, college) VALUES ('default2', 'default1', 'Member', '%education%'), ('default1', 'College of Education & Human Services', '%Education%', 'College of Education & Human Services'), ('%education%', 'default1', '%education%', 'College of Education & Human Services'), ('Member', '%education%', 'default2', 'College of Education & Human Services'), ('College of Education & Human Services', '%education%', '%education%', 'College of Education & Human Services');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('College of Education & Human Services', 'default1', 2, 'default2', 'Member', 'default2', NULL, NULL, 'default2'), ('Member', '%education%', 1, 'Member', 'Member', 'College of Education & Human Services', 'default1', 'College of Education & Human Services', '%education%'), ('%Education%', 'Member', 3, '%education%', 'College of Education & Human Services', 'College of Education & Human Services', NULL, 'default2', 'default1'), ('default1', 'default1', 2, '%Education%', 'College of Education & Human Services', NULL, NULL, 'default2', '%Education%'), ('default2', '%education%', NULL, 'College of Education & Human Services', '%education%', 'default2', NULL, 'College of Education & Human Services', '%Education%'), ('%education%', 'College of Education & Human Services', 5, NULL, 'default2', NULL, '%education%', '%Education%', '%education%'), ('unique_6', 'Member', 3, 'Member', '%education%', '%Education%', 'Member', 'Member', '%education%'), ('unique_7', 'default2', 5, 'College of Education & Human Services', '%Education%', 'default2', 'default2', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.member_id) FROM member AS T1 INNER JOIN major AS T2 ON T2.major_id = T1.link_to_major WHERE T1.position = 'Member' AND T2.major_name LIKE '%Education%' AND T2.college = 'College of Education & Human Services';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(T1.member_id) FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id WHERE T2.major_name LIKE '%education%' AND LOWER(T2.college) = LOWER('College of Education & Human Services');

/*
Prediction Result:
(5,)
*/