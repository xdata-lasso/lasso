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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('19', '32', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('18', '32', '38', '39', '40', '41', '42');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('15', '32', '32', '32');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('14', '32', '32', '32');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (17, '32', '32', '32', '32', '32');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (16, '32', '32', '32', '32', '32');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('19', '20');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('18', '21');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('23', '19', '32', 32, 32, 32, '32');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('22', '19', '32', 32, 32, 32, '32');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('25', '22', '21', '32', '32', 32, '32');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('24', NULL, '21', '32', '32', 32, '32');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('27', '21', '32', 32, '32', '32');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('26', '21', '32', 32, '32', '32');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('20', '14', 16, '32', '32', '32', '32', '32', '32');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('21', '15', 16, '32', '32', '32', '32', '32', '32');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_name FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event GROUP BY T1.event_name ORDER BY COUNT(T2.link_to_event) DESC, T1.event_name NULLS LAST LIMIT 1;

/*
Gold Result:
('32',)
*/

-- Prediction Query
SELECT "event"."event_name" FROM "event" INNER JOIN "attendance" ON "event"."event_id" = "attendance"."link_to_event" GROUP BY "event"."event_id" ORDER BY COUNT("attendance"."link_to_event") DESC, "event"."event_name" NULLS LAST LIMIT 1;

/*
Prediction Result:
('32',)
*/