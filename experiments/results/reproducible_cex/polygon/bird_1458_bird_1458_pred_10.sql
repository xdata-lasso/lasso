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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Vermont16', 'Maine30', 'Maine30', 'Maine30', 'Maine30', 'Maine30', 'Maine30');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Maine15', 'Maine30', 'Maine30', 'Maine30', 'Maine30', 'Maine30', 'Maine30');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Maine18', 'Maine30', 'Maine30', 'Maine30');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('New Jersey17', 'Maine30', 'Maine30', 'Maine30');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (30, 'New Jersey41', 'Maine42', 'Vermont43', NULL, 'Maine45');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Maine24', 'Vermont16', 'Maine30', 30, 30, 30, 'Maine30');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('New Jersey23', 'Maine15', 'Maine30', 30, 30, 30, 'Maine30');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('New Jersey26', 'New Jersey23', 'Vermont22', 'Maine30', 'Maine30', 30, 'Maine30');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Vermont25', NULL, 'Maine21', 'Maine30', 'Maine30', 30, 'Maine30');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Maine21', NULL, 30, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Vermont22', NULL, NULL, 'Maine30', 'Maine30', 'Maine30', 'Maine30', 'Maine30', 'Maine30');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST((SUM(CASE WHEN T2.state = 'Maine' THEN 1 ELSE 0 END) - SUM(CASE WHEN T2.state = 'Vermont' THEN 1 ELSE 0 END)) AS REAL) * 100 / COUNT(T1.member_id) AS diff FROM member AS T1 INNER JOIN zip_code AS T2 ON T2.zip_code = T1.zip;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT (CAST(SUM(CASE WHEN "zip_code"."state" = 'New Jersey' THEN 1 ELSE 0 END) AS REAL) / COUNT("member"."position")) - (CAST(SUM(CASE WHEN "zip_code"."state" = 'Vermont' THEN 1 ELSE 0 END) AS REAL) / COUNT("member"."position")) FROM "member" INNER JOIN "zip_code" ON "member"."zip" = "zip_code"."zip_code";

/*
Prediction Result:
(None,)
*/