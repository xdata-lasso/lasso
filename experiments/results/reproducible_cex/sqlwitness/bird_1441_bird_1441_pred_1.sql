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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (1, '%Education%', 'default2', 'Education', 'default2', 'Member');
INSERT INTO major (major_id, major_name, department, college) VALUES ('Member', '%Education%', '%Education%', NULL), ('College of Education & Human Services', 'default2', 'default2', 'Education'), ('%Education%', 'College of Education & Human Services', 'default2', 'College of Education & Human Services'), ('Education', 'default2', 'default1', 'default2'), ('default1', 'default1', NULL, NULL), ('default2', 'default2', 'default1', NULL), ('unique_6', 'Member', 'default2', 'College of Education & Human Services'), ('unique_7', 'Education', '%Education%', NULL);
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('Education', 'unique_6', NULL, 'default1', 'College of Education & Human Services', 'default2', 'College of Education & Human Services', NULL, NULL), ('%Education%', 'unique_7', 1, 'Member', 'College of Education & Human Services', NULL, 'Member', 'default1', '%Education%'), ('default2', NULL, NULL, 'Member', 'Member', 'default2', '%Education%', NULL, 'default2'), ('default1', 'unique_7', 1, 'Member', '%Education%', 'Member', '%Education%', NULL, 'default1'), ('College of Education & Human Services', 'default1', NULL, 'Member', 'Education', 'default1', 'default2', 'Education', NULL), ('Member', 'default1', NULL, 'College of Education & Human Services', NULL, NULL, 'default2', NULL, 'College of Education & Human Services'), ('unique_6', NULL, NULL, NULL, NULL, 'default2', '%Education%', NULL, 'default2'), ('unique_7', 'Education', NULL, 'default1', 'Member', NULL, 'default2', 'default2', '%Education%'), ('unique_8', 'unique_6', 1, 'Member', 'default2', 'Education', 'default2', 'Education', 'default2'), ('unique_9', 'default1', 1, '%Education%', '%Education%', '%Education%', 'Member', NULL, 'Education'), ('unique_10', 'College of Education & Human Services', 1, 'default1', 'Member', 'default1', 'default1', 'Member', 'College of Education & Human Services'), ('unique_11', '%Education%', NULL, '%Education%', 'College of Education & Human Services', 'default2', NULL, 'Member', 'default2'), ('unique_12', 'College of Education & Human Services', NULL, 'College of Education & Human Services', 'Member', 'default1', '%Education%', 'default2', 'Education'), ('unique_13', 'Education', NULL, '%Education%', 'College of Education & Human Services', 'Education', NULL, 'Education', 'Member'), ('unique_14', '%Education%', NULL, 'Member', 'Member', 'default1', 'Member', NULL, NULL), ('unique_15', 'unique_7', 1, 'default1', NULL, 'Education', NULL, 'default2', 'College of Education & Human Services'), ('unique_16', 'Education', NULL, 'College of Education & Human Services', 'Member', 'default1', 'default1', 'default2', 'Member'), ('unique_17', NULL, 1, 'default1', 'default2', 'default1', NULL, 'College of Education & Human Services', 'College of Education & Human Services'), ('unique_18', 'College of Education & Human Services', NULL, NULL, 'default2', NULL, '%Education%', 'College of Education & Human Services', 'Education'), ('unique_19', 'default1', 1, '%Education%', 'College of Education & Human Services', NULL, 'College of Education & Human Services', 'Education', NULL), ('unique_20', 'Education', 1, '%Education%', 'Education', 'Education', 'Education', 'default2', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.member_id) FROM member AS T1 INNER JOIN major AS T2 ON T2.major_id = T1.link_to_major WHERE T1.position = 'Member' AND T2.major_name LIKE '%Education%' AND T2.college = 'College of Education & Human Services';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) AS member_count FROM member INNER JOIN major ON member.link_to_major = major.major_id WHERE member.position = 'Member' AND major.major_name = 'Education' AND major.college = 'College of Education & Human Services';

/*
Prediction Result:
(0,)
*/