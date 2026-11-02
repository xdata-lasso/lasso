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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('purpose', 'Patrick Sanchez', '2020', 'Meeting', 'Say quality throughout beautiful.', '33890 Jennifer Squares
Robinsonshire, KY 01352', 'song');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('sure', 'Jay Ramirez', 'dinner', 'source');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1001, 'great', 'North Noahstad', 'throw', 'Minnesota', 'Rhode Island');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://www.stevens.com/', 'Andrea', 'Calderon', 'barbara10@example.net', 'drive', 'spring', '313-416-4752x5534', 1001, 'sure');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('purpose', 'https://www.stevens.com/');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(T2.link_to_event) AS REAL) / COUNT(DISTINCT T2.link_to_event) FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event WHERE SUBSTRING(T1.event_date, 1, 4) = '2020' AND T1.type = 'Meeting';

/*
Gold Result:
(1.0,)
*/

-- Prediction Query
SELECT CAST(COUNT("attendance"."link_to_member") AS REAL) / COUNT(DISTINCT "event"."event_name") FROM "attendance" INNER JOIN "event" ON "attendance"."link_to_event" = "event"."event_id" WHERE "event"."type" = 'Meeting' AND STRFTIME('%Y', "event"."event_date") = '2020';

/*
Prediction Result:
(None,)
*/