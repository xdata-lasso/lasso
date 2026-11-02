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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('954-555-624022', '954-555-624021', '954-555-624021', '954-555-624021', '954-555-624021', '954-555-624021', '954-555-624021');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('954-555-624021', '954-555-624055', '954-555-624056', '954-555-624057', '954-555-624058', '954-555-624059', '954-555-624060');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('954-555-624037', '954-555-624021', '954-555-624021', '954-555-624021');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('954-555-624023', '954-555-624021', '954-555-624021', '954-555-624021');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (24, '954-555-624021', '954-555-624021', '954-555-624021', '954-555-624021', '954-555-624021');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (38, '954-555-624021', '954-555-624021', '954-555-624021', '954-555-624021', '954-555-624021');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('954-555-624021', '954-555-624044');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('954-555-624021', '954-555-624052');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('954-555-624026', '954-555-624021', '954-555-624021', 21, 21, 21, '954-555-624021');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('954-555-624025', '954-555-624021', '954-555-624021', 21, 21, 21, '954-555-624021');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('954-555-624028', '954-555-624025', '954-555-624052', '954-555-624021', '954-555-624021', 21, '954-555-624021');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('954-555-624027', '954-555-624025', '954-555-624044', '954-555-624021', '954-555-624021', 21, '954-555-624021');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('954-555-624021', '954-555-624052', '954-555-624021', 21, '954-555-624021', '954-555-624021');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('954-555-624044', '954-555-624037', 38, '954-555-624039', '954-555-624040', '954-555-624041', '954-555-624042', '954-555-624043', '954-555-6240');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('954-555-624052', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '954-555-6240');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T2.link_to_event) FROM member AS T1 INNER JOIN attendance AS T2 ON T1.member_id = T2.link_to_member WHERE T1.phone = '954-555-6240';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT e.event_id) AS number_of_events_attended FROM member AS m JOIN attendance AS a ON m.member_id = a.link_to_member JOIN event AS e ON a.link_to_event = e.event_id WHERE m.phone = '954-555-6240';

/*
Prediction Result:
(1,)
*/