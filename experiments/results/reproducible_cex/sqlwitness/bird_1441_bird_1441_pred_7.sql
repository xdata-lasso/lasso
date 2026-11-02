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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (0, 'default2', 'default2', '%education%', 'College of Education & Human Services', 'College of Education & Human Services'), (1, 'default1', '%education%', '%college of education & human services%', 'Member', 'default2'), (2, '%college of education & human services%', 'Member', NULL, 'default2', '%college of education & human services%');
INSERT INTO major (major_id, major_name, department, college) VALUES ('%Education%', '%college of education & human services%', 'Member', '%college of education & human services%'), ('default2', 'Member', 'Member', 'default1'), ('College of Education & Human Services', '%education%', '%Education%', '%Education%'), ('Member', 'Member', '%education%', '%college of education & human services%'), ('%college of education & human services%', '%education%', '%education%', NULL), ('%education%', '%college of education & human services%', 'College of Education & Human Services', '%college of education & human services%'), ('default1', '%education%', NULL, 'default1');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('%college of education & human services%', 'Member', 0, 'default1', 'College of Education & Human Services', 'Member', 'Member', '%education%', '%Education%'), ('default1', '%college of education & human services%', 2, '%Education%', '%Education%', '%Education%', 'default1', 'default1', '%education%'), ('College of Education & Human Services', '%education%', 0, '%Education%', '%college of education & human services%', '%college of education & human services%', 'Member', 'default1', NULL), ('%education%', '%college of education & human services%', NULL, 'Member', '%education%', '%Education%', NULL, 'College of Education & Human Services', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.member_id) FROM member AS T1 INNER JOIN major AS T2 ON T2.major_id = T1.link_to_major WHERE T1.position = 'Member' AND T2.major_name LIKE '%Education%' AND T2.college = 'College of Education & Human Services';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(T1.member_id) FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id WHERE LOWER(T2.major_name) LIKE '%education%' AND LOWER(T2.college) LIKE '%college of education & human services%';

/*
Prediction Result:
(1,)
*/