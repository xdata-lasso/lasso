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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Yearly Kickoff22', 'Yearly Kickoff65', 'Yearly Kickoff65', 'Yearly Kickoff65', 'Yearly Kickoff65', 'Yearly Kickoff65', 'Yearly Kickoff65');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Yearly Kickoff21', 'Yearly Kickoff35', 'Yearly Kickoff36', 'Yearly Kickoff37', 'Yearly Kickoff38', 'Yearly Kickoff39', 'Yearly Kickoff40');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Yearly Kickoff24', 'Yearly Kickoff65', 'Yearly Kickoff65', 'Yearly Kickoff65');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Yearly Kickoff23', 'Yearly Kickoff65', 'Yearly Kickoff65', 'Yearly Kickoff65');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (26, 'Yearly Kickoff65', 'Yearly Kickoff65', 'Yearly Kickoff65', 'Yearly Kickoff65', 'Yearly Kickoff65');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (25, 'Yearly Kickoff65', 'Yearly Kickoff65', 'Yearly Kickoff65', 'Yearly Kickoff65', 'Yearly Kickoff65');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Yearly Kickoff21', 'Yearly Kickoff61');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Yearly Kickoff22', 'Yearly Kickoff61');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Yearly Kickoff65', 'Yearly Kickoff21', 'Yearly Kickoff66', 67, 68, 69, 'Yearly Kickoff70');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Yearly Kickoff27', NULL, 'Yearly Kickoff65', 65, 65, 65, 'Yearly Kickoff65');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Yearly Kickoff60', 'Yearly Kickoff65', 'Yearly Kickoff61', 'Yearly Kickoff62', 'Yearly Kickoff63', 1, 'Yearly Kickoff64');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Yearly Kickoff71', 'Yearly Kickoff65', 'Yearly Kickoff61', 'Yearly Kickoff72', 'Yearly Kickoff73', NULL, 'Yearly Kickoff75');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Yearly Kickoff29', 'Yearly Kickoff61', 'Yearly Kickoff65', 65, 'Yearly Kickoff65', 'Yearly Kickoff65');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Yearly Kickoff61', 'Yearly Kickoff23', 26, 'Yearly Kickoff65', 'Yearly Kickoff65', 'Yearly Kickoff65', 'Yearly Kickoff65', 'Yearly Kickoff65', 'Yearly Kickoff65');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN T1.event_name = 'Yearly Kickoff' THEN T3.cost ELSE 0 END) AS REAL) * 100 / SUM(T3.cost) FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT (SUM("expense"."cost") FILTER(WHERE "event"."event_name" = 'Yearly Kickoff') * 100.0 / SUM("expense"."cost")) AS percentage FROM "expense" INNER JOIN "budget" ON "expense"."link_to_budget" = "budget"."budget_id" INNER JOIN "event" ON "budget"."link_to_event" = "event"."event_id";

/*
Prediction Result:
(None,)
*/