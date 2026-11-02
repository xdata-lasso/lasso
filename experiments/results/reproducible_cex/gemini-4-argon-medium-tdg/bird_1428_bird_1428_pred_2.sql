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
-- DATASET 2
-- Tests projection multiplicity (SELECT vs SELECT DISTINCT) and multiple members sharing the same or different zip codes/majors.
INSERT INTO major (major_id, major_name, department, college) VALUES ('M1', 'Electrical Engineering', 'Electrical and Computer Engineering Department', 'Engineering');
INSERT INTO major (major_id, major_name, department, college) VALUES ('M2', 'Computer Engineering', 'Electrical and Computer Engineering Department', 'Engineering');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (90210, 'Standard', 'Beverly Hills', 'Los Angeles', 'California', 'CA');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (90211, 'Standard', 'Beverly Hills', 'Los Angeles', 'California', 'CA');
INSERT INTO "member" (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM1', 'Dave', 'Wilson', 'dave@example.com', 'Member', 'XL', '444-555-6666', 90210, 'M1');
INSERT INTO "member" (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM2', 'Eve', 'Davis', 'eve@example.com', 'Member', 'M', '555-666-7777', 90210, 'M2');
INSERT INTO "member" (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM3', 'Frank', 'Miller', 'frank@example.com', 'Member', 'L', '666-777-8888', 90211, 'M1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT city, state FROM member AS T1 INNER JOIN major AS T2 ON T2.major_id = T1.link_to_major INNER JOIN zip_code AS T3 ON T3.zip_code = T1.zip WHERE department = 'Electrical and Computer Engineering Department' AND position = 'Member';

/*
Gold Result:
('Beverly Hills', 'California')
('Beverly Hills', 'California')
('Beverly Hills', 'California')
*/

-- Prediction Query
SELECT DISTINCT "zip_code"."city", "zip_code"."state" FROM "member" INNER JOIN "zip_code" ON "member"."zip" = "zip_code"."zip_code" INNER JOIN "major" ON "member"."link_to_major" = "major"."major_id" WHERE "major"."department" = 'Electrical and Computer Engineering Department' AND "member"."position" = 'Member';

/*
Prediction Result:
('Beverly Hills', 'California')
*/