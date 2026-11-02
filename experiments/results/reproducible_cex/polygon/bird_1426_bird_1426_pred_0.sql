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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Environmental Engineering19', 'Environmental Engineering43', 'Environmental Engineering43', 'Environmental Engineering43', 'Environmental Engineering43', 'Environmental Engineering43', 'Environmental Engineering43');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Member18', 'Environmental Engineering43', 'Environmental Engineering43', 'Environmental Engineering43', 'Environmental Engineering43', 'Environmental Engineering43', 'Environmental Engineering43');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Environmental Engineering43', 'Environmental Engineering', NULL, NULL);
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (20, 'Environmental Engineering43', 'Environmental Engineering43', 'Environmental Engineering43', 'Environmental Engineering43', 'Environmental Engineering43');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (37, 'Environmental Engineering43', 'Environmental Engineering43', 'Environmental Engineering43', 'Environmental Engineering43', 'Environmental Engineering43');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Environmental Engineering21', 'Member18', 'Environmental Engineering43', 43, 43, 43, 'Environmental Engineering43');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Environmental Engineering23', 'Environmental Engineering21', 'Member36', 'Environmental Engineering43', 'Environmental Engineering43', 43, 'Environmental Engineering43');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Member22', 'Environmental Engineering21', 'Member36', 'Environmental Engineering43', 'Environmental Engineering43', 43, 'Environmental Engineering43');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Environmental Engineering25', 'Member36', 'Environmental Engineering43', 43, 'Environmental Engineering43', 'Environmental Engineering43');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Member24', 'Member30', 'Environmental Engineering43', 43, 'Environmental Engineering43', 'Environmental Engineering43');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Member30', 'Environmental Engineering43', NULL, 'Member32', NULL, 'Environmental Engineering33', 'Member', 'Member34', 'Environmental Engineering35');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Member36', 'Environmental Engineering43', 37, 'Member38', NULL, 'Environmental Engineering39', 'Member40', 'Environmental Engineering41', 'Member42');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.last_name, T1.department, T1.college FROM major AS T1 INNER JOIN member AS T2 ON T1.major_id = T2.link_to_major WHERE T2.position = 'Member' AND T1.major_name = 'Environmental Engineering';

/*
Gold Result:
(None, None, None)
*/

-- Prediction Query
SELECT T1.last_name, T2.department, T2.college FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id WHERE T2.major_name = 'Environmental Engineering';

/*
Prediction Result:
(None, None, None)
(None, None, None)
*/