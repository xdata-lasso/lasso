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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('66', '60', '61', NULL, NULL, '64', '65');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('73', '67', '68', NULL, NULL, '71', '72');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('38', '37', '37', '37');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (39, '55', NULL, '57', '58', '59');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (31, '37', '37', '37', '37', '37');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('73', '37');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('66', '37');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('33', NULL, '37', 37, 37, 37, '37');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('36', '37', '50', 611, '51', '52');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('37', '38', 39, '44', '45', NULL, NULL, '48', '49');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.city, T3.county FROM income AS T1 INNER JOIN member AS T2 ON T1.link_to_member = T2.member_id INNER JOIN zip_code AS T3 ON T3.zip_code = T2.zip WHERE T1.amount > 40;

/*
Gold Result:
(None, '57')
*/

-- Prediction Query
SELECT "zip_code"."city", "zip_code"."county" FROM "event" INNER JOIN "attendance" ON "event"."event_id" = "attendance"."link_to_event" INNER JOIN "income" ON "attendance"."link_to_member" = "income"."link_to_member" INNER JOIN "member" ON "income"."link_to_member" = "member"."member_id" INNER JOIN "zip_code" ON "member"."zip" = "zip_code"."zip_code" GROUP BY "event"."event_id", "zip_code"."city", "zip_code"."county" HAVING COUNT("income"."income_id") > 40;

/*
Prediction Result:
*/