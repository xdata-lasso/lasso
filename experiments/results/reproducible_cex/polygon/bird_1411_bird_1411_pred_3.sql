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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Sacha18', 'Harrison41', 'Harrison41', 'Harrison41', 'Harrison41', 'Harrison41', 'Harrison41');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Harrison17', 'Harrison41', 'Harrison41', 'Harrison41', 'Harrison41', 'Harrison41', 'Harrison41');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Harrison19', 'Harrison41', 'Harrison41', 'Harrison41');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Harrison33', 'Harrison41', 'Harrison41', 'Harrison41');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (20, 'Harrison41', 'Harrison41', 'Harrison41', 'Harrison41', 'Harrison41');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (34, 'Harrison41', 'Harrison41', 'Harrison41', 'Harrison41', 'Harrison41');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Sacha18', 'Harrison21');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Sacha40', 'Harrison17', 'Harrison41', 41, 41, 41, 'Harrison41');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Harrison29', 'Sacha40', 'Harrison41', 'Harrison45', 'Sacha30', 31, 'Sacha32');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Harrison39', 'Sacha40', 'Harrison41', 'Harrison45', 'Sacha42', 43, 'Sacha44');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Sacha24', 'Harrison41', 'Harrison41', 41, 'Harrison41', 'Harrison41');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Harrison23', 'Harrison21', 'Harrison41', 41, 'Harrison41', 'Harrison41');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Harrison41', 'Harrison33', 34, 'Sacha', 'Harrison', 'Harrison35', 'Sacha36', 'Harrison37', 'Sacha38');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Harrison21', 'Harrison33', NULL, 'Harrison41', 'Harrison41', 'Harrison41', 'Harrison41', 'Harrison41', 'Harrison41');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.expense_description FROM member AS T1 INNER JOIN expense AS T2 ON T1.member_id = T2.link_to_member WHERE T1.first_name = 'Sacha' AND T1.last_name = 'Harrison';

/*
Gold Result:
('Harrison45',)
('Harrison45',)
*/

-- Prediction Query
SELECT DISTINCT "expense"."expense_description" FROM "expense" INNER JOIN "member" ON "expense"."link_to_member" = "member"."member_id" WHERE "member"."first_name" = 'Sacha' AND "member"."last_name" = 'Harrison';

/*
Prediction Result:
('Harrison45',)
*/