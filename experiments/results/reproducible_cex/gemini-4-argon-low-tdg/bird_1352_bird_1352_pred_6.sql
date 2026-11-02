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
-- Tests basic matching, non-matching predicates (OR vs AND mutations), and COUNT(DISTINCT T2.major_id) vs COUNT(T1.member_id).
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (10001, 'Standard', 'New York', 'New York', 'New York', 'NY');
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ1', 'Human Development AND Family Studies', 'Humanities', 'Arts and Sciences');
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ2', 'Computer Science', 'Engineering', 'Engineering');
INSERT INTO "member" (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM1', 'Alice', 'Smith', 'alice@example.com', 'Member', 'Large', '111-222-3333', 10001, 'MAJ1');
INSERT INTO "member" (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM2', 'Bob', 'Jones', 'bob@example.com', 'Member', 'Large', '222-333-4444', 10001, 'MAJ1');
INSERT INTO "member" (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM3', 'Charlie', 'Brown', 'charlie@example.com', 'Member', 'Medium', '333-444-5555', 10001, 'MAJ1');
INSERT INTO "member" (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM4', 'Diana', 'Prince', 'diana@example.com', 'Member', 'Large', '444-555-6666', 10001, 'MAJ2');
INSERT INTO "member" (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM5', 'Evan', 'Wright', 'evan@example.com', 'Member', 'Small', '555-666-7777', 10001, 'MAJ2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.member_id) FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id WHERE T2.major_name = 'Human Development AND Family Studies' AND T1.t_shirt_size = 'Large';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(m.member_id) AS count FROM member AS m INNER JOIN major AS maj ON m.link_to_major = maj.major_id WHERE maj.major_name = 'Business' AND m.t_shirt_size = 'Medium';

/*
Prediction Result:
(0,)
*/