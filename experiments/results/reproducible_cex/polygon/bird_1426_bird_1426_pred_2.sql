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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Environmental Engineering17', 'Member46', 'Member46', 'Member46', 'Member46', 'Member46', 'Member46');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Member16', 'Member46', 'Member46', 'Member46', 'Member46', 'Member46', 'Member46');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Environmental Engineering41', 'Environmental Engineering', NULL, 'Member46');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Member34', 'Environmental Engineering', NULL, 'Member46');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (36, 'Member46', 'Member46', 'Member46', 'Member46', 'Member46');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (18, 'Member46', 'Member46', 'Member46', 'Member46', 'Member46');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Environmental Engineering17', 'Environmental Engineering35');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Member16', 'Environmental Engineering27');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Member20', NULL, 'Member46', 46, 46, 46, 'Member46');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Environmental Engineering19', 'Environmental Engineering17', 'Member46', 46, 46, 46, 'Member46');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Member46', 'Member20', 'Environmental Engineering27', 'Member46', 'Member46', 46, 'Member46');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Environmental Engineering21', 'Environmental Engineering27', 'Member46', 46, 'Member46', 'Member46');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Environmental Engineering27', 'Member34', NULL, NULL, NULL, 'Member30', 'Environmental Engineering31', 'Member32', 'Environmental Engineering33');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Environmental Engineering35', 'Environmental Engineering41', 36, 'Environmental Engineering37', NULL, 'Member38', 'Member', 'Environmental Engineering39', 'Member40');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.last_name, T1.department, T1.college FROM major AS T1 INNER JOIN member AS T2 ON T1.major_id = T2.link_to_major WHERE T2.position = 'Member' AND T1.major_name = 'Environmental Engineering';

/*
Gold Result:
(None, None, 'Member46')
*/

-- Prediction Query
SELECT member.last_name, major.department, major.college FROM member INNER JOIN major ON member.link_to_major = major.major_id WHERE major.major_name = 'Environmental Engineering';

/*
Prediction Result:
(None, None, 'Member46')
(None, None, 'Member46')
*/