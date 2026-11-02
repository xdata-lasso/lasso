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
-- DATASET 4
-- Tests lack of GROUP BY vs GROUP BY T2.member_id or T1.major_name, and COUNT(DISTINCT) vs COUNT, using two members named Luisa Guidi attending the same event.
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (40001, 'Standard', 'Louisville', 'Jefferson', 'Kentucky', 'KY');
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ1', 'Economics', 'Econ Dept', 'Business');
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ2', 'Finance', 'Fin Dept', 'Business');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('EV1', 'Networking', '2023-09-15', 'Social', 'None', 'Hall B', 'Open');
INSERT INTO "member" (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM1', 'Luisa', 'Guidi', 'luisa1@example.com', 'Member', 'M', '444-555-6666', 40001, 'MAJ1');
INSERT INTO "member" (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM2', 'Luisa', 'Guidi', 'luisa2@example.com', 'Secretary', 'L', '444-555-6667', 40001, 'MAJ2');
INSERT INTO "attendance" (link_to_event, link_to_member) VALUES ('EV1', 'MEM1');
INSERT INTO "attendance" (link_to_event, link_to_member) VALUES ('EV1', 'MEM2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T3.link_to_event), T1.major_name FROM major AS T1 INNER JOIN member AS T2 ON T1.major_id = T2.link_to_major INNER JOIN attendance AS T3 ON T2.member_id = T3.link_to_member WHERE T2.first_name = 'Luisa' AND T2.last_name = 'Guidi';

/*
Gold Result:
(2, 'Economics')
*/

-- Prediction Query
SELECT COUNT(DISTINCT "attendance"."link_to_event") AS "number_of_events", "major"."major_name" FROM "member" INNER JOIN "attendance" ON "member"."member_id" = "attendance"."link_to_member" INNER JOIN "major" ON "member"."link_to_major" = "major"."major_id" WHERE "member"."first_name" = 'Luisa' AND "member"."last_name" = 'Guidi';

/*
Prediction Result:
(1, 'Economics')
*/