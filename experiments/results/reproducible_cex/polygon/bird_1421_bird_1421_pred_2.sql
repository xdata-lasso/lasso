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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Member18', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Mathematics17', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Mathematics29', NULL, NULL, NULL);
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Mathematics19', NULL, NULL, NULL);
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (21, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (20, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Member18', 'Mathematics23');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Mathematics17', 'Mathematics23');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Member24', 'Mathematics17', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Member26', 'Member24', 'Mathematics23', NULL, NULL, NULL, NULL);
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Mathematics25', 'Member24', 'Mathematics23', NULL, NULL, NULL, NULL);
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Member28', 'Mathematics23', NULL, NULL, NULL, NULL);
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Mathematics27', 'Mathematics23', NULL, NULL, NULL, NULL);
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Member22', 'Mathematics29', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Mathematics23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN T2.major_name = 'Mathematics' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.member_id) FROM member AS T1 INNER JOIN major AS T2 ON T2.major_id = T1.link_to_major WHERE T1.position = 'Member';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T1.major_name = 'Mathematics' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T2.member_id) FROM major AS T1 INNER JOIN member AS T2 ON T1.major_id = T2.link_to_major;

/*
Prediction Result:
(0.0,)
*/