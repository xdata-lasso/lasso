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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (1, 'Member', 'education', '%Education%', 'education', 'education');
INSERT INTO major (major_id, major_name, department, college) VALUES ('default1', 'default1', 'Member', 'College of Education & Human Services'), ('College of Education & Human Services', 'Member', 'education', 'Member'), ('%Education%', '%Education%', 'College of Education & Human Services', 'education'), ('Member', NULL, 'Member', 'College of Education & Human Services'), ('education', 'default2', 'College of Education & Human Services', 'Member'), ('default2', '%Education%', '%Education%', 'College of Education & Human Services'), ('unique_6', '%Education%', 'Member', 'default2'), ('unique_7', 'Member', 'education', 'default2'), ('unique_8', '%Education%', '%Education%', 'default2'), ('unique_9', '%Education%', NULL, 'default2'), ('unique_10', 'default2', 'College of Education & Human Services', 'Member'), ('unique_11', '%Education%', '%Education%', '%Education%'), ('unique_12', '%Education%', 'Member', 'College of Education & Human Services'), ('unique_13', 'default1', 'default2', 'College of Education & Human Services'), ('unique_14', '%Education%', 'Member', NULL), ('unique_15', 'College of Education & Human Services', 'Member', NULL), ('unique_16', 'default1', NULL, 'College of Education & Human Services'), ('unique_17', 'Member', 'default2', 'default2'), ('unique_18', 'default2', '%Education%', 'College of Education & Human Services'), ('unique_19', NULL, 'default2', 'College of Education & Human Services'), ('unique_20', '%Education%', NULL, 'Member'), ('unique_21', 'education', 'default1', 'Member');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('Member', '%Education%', NULL, 'College of Education & Human Services', '%Education%', 'College of Education & Human Services', 'default1', 'education', '%Education%'), ('default2', 'unique_21', 1, NULL, 'education', NULL, 'default1', '%Education%', NULL), ('default1', 'default2', 1, 'Member', 'default2', 'education', 'Member', '%Education%', 'education'), ('College of Education & Human Services', 'unique_20', 1, 'Member', 'default1', '%Education%', 'education', 'Member', '%Education%'), ('%Education%', 'education', 1, 'default2', 'default2', 'default1', 'Member', 'Member', 'College of Education & Human Services');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.member_id) FROM member AS T1 INNER JOIN major AS T2 ON T2.major_id = T1.link_to_major WHERE T1.position = 'Member' AND T2.major_name LIKE '%Education%' AND T2.college = 'College of Education & Human Services';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT("member"."member_id") FROM "member" INNER JOIN "major" ON "member"."link_to_major" = "major"."major_id" WHERE "major"."major_name" = 'education' AND "major"."college" = 'College of Education & Human Services' AND "member"."position" = 'Member';

/*
Prediction Result:
(0,)
*/