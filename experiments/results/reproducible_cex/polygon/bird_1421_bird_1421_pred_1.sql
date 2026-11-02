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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Mathematics16', 'Mathematics37', 'Mathematics37', 'Mathematics37', 'Mathematics37', 'Mathematics37', 'Mathematics37');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Member15', 'Mathematics37', 'Mathematics37', 'Mathematics37', 'Mathematics37', 'Mathematics37', 'Mathematics37');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Mathematics37', 'Business', 'Business44', 'Member45');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (25, 'Mathematics37', 'Mathematics37', 'Mathematics37', 'Mathematics37', 'Mathematics37');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (17, 'Mathematics37', 'Mathematics37', 'Mathematics37', 'Mathematics37', 'Mathematics37');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Mathematics16', 'Member36');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Member15', 'Member36');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Business20', 'Member15', 'Mathematics37', 37, 37, 37, 'Mathematics37');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Mathematics19', 'Mathematics16', 'Mathematics37', 37, 37, 37, 'Mathematics37');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Mathematics22', 'Business20', 'Member36', 'Mathematics37', 'Mathematics37', 37, 'Mathematics37');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Member21', 'Mathematics19', 'Member36', 'Mathematics37', 'Mathematics37', 37, 'Mathematics37');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Member24', 'Member36', 'Mathematics37', 37, 'Mathematics37', 'Mathematics37');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Business23', 'Member36', 'Mathematics37', 37, 'Mathematics37', 'Mathematics37');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Member18', 'Mathematics37', 25, 'Member30', 'Mathematics31', 'Business32', NULL, 'Mathematics34', 'Business35');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Member36', 'Mathematics37', NULL, NULL, NULL, NULL, 'Member', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN T2.major_name = 'Mathematics' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.member_id) FROM member AS T1 INNER JOIN major AS T2 ON T2.major_id = T1.link_to_major WHERE T1.position = 'Member';

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT (SUM(CASE WHEN position = 'Member' AND major_name = 'Business' THEN 1 ELSE 0 END) * 100.0 / COUNT(member_id)) AS business_major_percentage FROM member JOIN major ON member.link_to_major = major.major_id;

/*
Prediction Result:
(50.0,)
*/