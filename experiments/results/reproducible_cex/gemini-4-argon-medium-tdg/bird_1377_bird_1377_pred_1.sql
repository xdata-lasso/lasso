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
-- DATASET 1
-- Tests basic filtering, partial string matches (LIKE '%President%'), case sensitivity, NULL positions, and orphan foreign keys (INNER JOIN traps with major/zip_code).
INSERT INTO major (major_id, major_name, department, college) VALUES ('maj1', 'Computer Science', 'CS', 'Engineering');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (10001, 'Standard', 'New York', 'New York', 'New York', 'NY');
INSERT INTO "member" (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('m1', 'Alice', 'Smith', 'alice@example.com', 'President', 'M', '111-222-3333', 10001, 'maj1');
INSERT INTO "member" (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('m2', 'Bob', 'Jones', 'bob@example.com', 'President', NULL, NULL, NULL, NULL);
INSERT INTO "member" (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('m3', 'Charlie', 'Brown', 'charlie@example.com', 'Vice President', 'L', '222-333-4444', 10001, 'maj1');
INSERT INTO "member" (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('m4', 'David', 'Wilson', 'david@example.com', 'president', 'S', '333-444-5555', 10001, 'maj1');
INSERT INTO "member" (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('m5', 'Eve', 'Davis', 'eve@example.com', 'Secretary', 'M', '444-555-6666', 10001, 'maj1');
INSERT INTO "member" (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('m6', 'Frank', 'Miller', 'frank@example.com', NULL, 'XL', '555-666-7777', 10001, 'maj1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(member_id) FROM member WHERE position = 'President';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(*) FROM member WHERE LOWER(position) = 'president';

/*
Prediction Result:
(3,)
*/