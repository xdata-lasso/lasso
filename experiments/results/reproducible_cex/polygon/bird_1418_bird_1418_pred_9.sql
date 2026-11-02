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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('MU 21530', 'MU 21535', 'MU 21536', 'MU 21537', 'MU 21538', 'MU 215', 'MU 21539');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('MU 21541', 'MU 21546', 'MU 21547', 'MU 21548', 'MU 21549', 'MU 215', 'MU 21550');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('MU 21520', 'MU 21551', 'MU 21551', 'MU 21551');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('MU 21519', 'MU 21551', 'MU 21551', 'MU 21551');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (22, 'MU 21551', 'MU 21551', 'MU 21551', 'MU 21551', 'MU 21551');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (21, 'MU 21551', 'MU 21551', 'MU 21551', 'MU 21551', 'MU 21551');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('MU 21530', 'MU 21523');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('MU 21541', 'MU 21524');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('MU 21529', 'MU 21530', 'MU 21551', 31, 32, 33, 'MU 21534');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('MU 21540', 'MU 21541', 'MU 21551', 42, 43, 44, 'MU 21545');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('MU 21551', NULL, 'MU 21551', 51, 'MU 21551', 'MU 21551');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('MU 21523', 'MU 21519', 21, 'MU 21551', 'MU 21551', 'MU 21551', 'MU 21551', 'MU 21551', 'MU 21551');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('MU 21524', 'MU 21519', 21, 'MU 21551', 'MU 21551', 'MU 21551', 'MU 21551', 'MU 21551', 'MU 21551');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.category FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event WHERE T1.location = 'MU 215';

/*
Gold Result:
('MU 21551',)
('MU 21551',)
*/

-- Prediction Query
SELECT DISTINCT T1.category FROM budget AS T1 INNER JOIN event AS T2 ON T2.event_id = T1.link_to_event WHERE T2.location = 'MU 215';

/*
Prediction Result:
('MU 21551',)
*/