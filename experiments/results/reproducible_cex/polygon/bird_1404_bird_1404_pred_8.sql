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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('true21', 'October Meeting', 'October Meeting34', 'true35', 'October Meeting36', 'true37', 'October Meeting38');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('true27', NULL, 'true45', 'October Meeting46', 'true47', 'October Meeting48', 'true49');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('true23', 'October Meeting64', 'October Meeting64', 'October Meeting64');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('October Meeting22', 'October Meeting64', 'October Meeting64', 'October Meeting64');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (25, 'October Meeting64', 'October Meeting64', 'October Meeting64', 'October Meeting64', 'October Meeting64');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (24, 'October Meeting64', 'October Meeting64', 'October Meeting64', 'October Meeting64', 'October Meeting64');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('true21', 'October Meeting62');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('October Meeting64', 'true21', 'true65', 66, 67, 68, 'true69');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('October Meeting26', 'true27', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('October Meeting56', 'October Meeting64', 'true57', NULL, 'true59', NULL, 'true');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('true61', 'October Meeting64', 'October Meeting62', 'true35', 'true63', -1, 'true');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('true29', 'true57', 'October Meeting64', 64, 'October Meeting64', 'October Meeting64');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('October Meeting28', 'true57', 'October Meeting64', 64, 'October Meeting64', 'October Meeting64');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('October Meeting62', NULL, 25, 'October Meeting64', 'October Meeting64', 'October Meeting64', 'October Meeting64', 'October Meeting64', 'October Meeting64');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('true57', NULL, 25, 'October Meeting64', 'October Meeting64', 'October Meeting64', 'October Meeting64', 'October Meeting64', 'October Meeting64');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.type, SUM(T3.cost) FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget WHERE T1.event_name = 'October Meeting';

/*
Gold Result:
('true35', -1.0)
*/

-- Prediction Query
SELECT "expense"."expense_description", SUM("expense"."cost") AS "total_value" FROM "expense" INNER JOIN "budget" ON "expense"."link_to_budget" = "budget"."budget_id" INNER JOIN "event" ON "budget"."link_to_event" = "event"."event_id" WHERE "event"."event_name" = 'October Meeting' AND "expense"."approved" = 'true' GROUP BY "expense"."expense_description";

/*
Prediction Result:
(None, None)
('true35', -1.0)
*/