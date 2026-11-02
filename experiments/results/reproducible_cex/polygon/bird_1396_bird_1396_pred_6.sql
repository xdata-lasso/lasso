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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Luisa24', 'Guidi25', 'Guidi25', 'Guidi25', 'Guidi25', 'Guidi25', 'Guidi25');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Guidi23', 'Guidi25', 'Guidi25', 'Guidi25', 'Guidi25', 'Guidi25', 'Guidi25');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Luisa30', 'Luisa36', 'Guidi37', 'Luisa38');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (31, 'Guidi25', 'Guidi25', 'Guidi25', 'Guidi25', 'Guidi25');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Luisa24', 'Guidi25');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Guidi23', 'Guidi25');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Guidi27', NULL, 'Guidi25', 25, 25, 25, 'Guidi25');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Guidi25', 'Luisa30', 31, 'Luisa', NULL, 'Luisa40', NULL, 'Luisa42', 'Guidi43');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T3.link_to_event), T1.major_name FROM major AS T1 INNER JOIN member AS T2 ON T1.major_id = T2.link_to_major INNER JOIN attendance AS T3 ON T2.member_id = T3.link_to_member WHERE T2.first_name = 'Luisa' AND T2.last_name = 'Guidi';

/*
Gold Result:
(0, None)
*/

-- Prediction Query
SELECT COUNT(attendance.link_to_event) AS event_count, major.major_name FROM member LEFT JOIN attendance ON member.member_id = attendance.link_to_member LEFT JOIN major ON member.link_to_major = major.major_id WHERE member.first_name = 'Luisa' AND member.last_name = 'Guidi';

/*
Prediction Result:
(0, None)
*/