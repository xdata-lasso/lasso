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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('November Meeting36', 'November Meeting', 'November Meeting37', 'November Meeting38', NULL, 'November Meeting40', 'November Meeting41');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('November Meeting17', NULL, 'November Meeting36', 'November Meeting36', 'November Meeting36', 'November Meeting36', 'November Meeting36');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('November Meeting18', 'November Meeting36', 'November Meeting36', 'November Meeting36');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (19, 'November Meeting36', 'November Meeting36', 'November Meeting36', 'November Meeting36', 'November Meeting36');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('November Meeting17', 'November Meeting20');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('November Meeting36', 'November Meeting21');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('November Meeting31', 'November Meeting36', 'November Meeting32', 33, -463, 34, 'November Meeting35');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('November Meeting22', NULL, 'November Meeting36', 36, 36, 36, 'November Meeting36');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('November Meeting24', 'November Meeting22', 'November Meeting21', 'November Meeting36', 'November Meeting36', 36, 'November Meeting36');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('November Meeting23', 'November Meeting22', 'November Meeting21', 'November Meeting36', 'November Meeting36', 36, 'November Meeting36');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('November Meeting26', 'November Meeting21', 'November Meeting36', 36, 'November Meeting36', 'November Meeting36');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('November Meeting25', 'November Meeting21', 'November Meeting36', 36, 'November Meeting36', 'November Meeting36');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('November Meeting20', 'November Meeting18', 19, 'November Meeting36', 'November Meeting36', 'November Meeting36', 'November Meeting36', 'November Meeting36', 'November Meeting36');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('November Meeting21', 'November Meeting18', 19, 'November Meeting36', 'November Meeting36', 'November Meeting36', 'November Meeting36', 'November Meeting36', 'November Meeting36');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T2.event_id) FROM budget AS T1 INNER JOIN event AS T2 ON T1.link_to_event = T2.event_id WHERE T2.event_name = 'November Meeting' AND T1.remaining < 0;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM budget WHERE link_to_event IN (SELECT event_id FROM event WHERE event_name = 'November Meeting') AND remaining < 0;

/*
Prediction Result:
(1,)
*/