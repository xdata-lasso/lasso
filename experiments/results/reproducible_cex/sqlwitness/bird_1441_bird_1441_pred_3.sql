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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (1, 'College of Education & Human Services', NULL, NULL, 'default2', 'default2'), (0, 'College of Education & Human Services', 'Member', 'College of Education & Human Services', 'Member', 'Member'), (2, 'default1', '%Education%', NULL, 'College of Education & Human Services', 'Member');
INSERT INTO major (major_id, major_name, department, college) VALUES ('College of Education & Human Services', '%Education%', 'College of Education & Human Services', '%Education%'), ('default2', NULL, 'Member', NULL), ('default1', 'default1', 'College of Education & Human Services', NULL), ('Member', 'Member', 'Member', NULL), ('%Education%', 'College of Education & Human Services', '%Education%', 'default1'), ('unique_5', NULL, '%Education%', 'College of Education & Human Services'), ('unique_6', 'default1', 'default1', 'College of Education & Human Services'), ('unique_7', 'College of Education & Human Services', NULL, '%Education%'), ('unique_8', 'default1', 'default2', NULL), ('unique_9', 'default2', 'default1', 'default1'), ('unique_10', 'default1', '%Education%', 'Member');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('College of Education & Human Services', NULL, 0, '%Education%', 'College of Education & Human Services', 'College of Education & Human Services', 'default2', '%Education%', '%Education%'), ('%Education%', 'unique_5', 1, '%Education%', NULL, 'Member', 'College of Education & Human Services', NULL, 'College of Education & Human Services'), ('default1', '%Education%', 1, 'default2', 'College of Education & Human Services', 'College of Education & Human Services', 'Member', 'default1', 'Member'), ('default2', NULL, NULL, '%Education%', 'default2', 'College of Education & Human Services', 'default1', 'default1', '%Education%'), ('Member', '%Education%', 0, 'College of Education & Human Services', 'College of Education & Human Services', NULL, 'Member', 'default2', '%Education%'), ('unique_5', '%Education%', 2, 'default1', NULL, '%Education%', 'Member', NULL, 'Member'), ('unique_6', 'unique_6', 1, NULL, 'Member', 'default2', 'default2', 'default1', 'default1'), ('unique_7', 'College of Education & Human Services', 0, 'College of Education & Human Services', 'Member', 'default1', 'default1', 'default1', '%Education%');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.member_id) FROM member AS T1 INNER JOIN major AS T2 ON T2.major_id = T1.link_to_major WHERE T1.position = 'Member' AND T2.major_name LIKE '%Education%' AND T2.college = 'College of Education & Human Services';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(*) FROM member JOIN major ON member.link_to_major = major.major_id WHERE major.college = 'College of Education & Human Services';

/*
Prediction Result:
(2,)
*/