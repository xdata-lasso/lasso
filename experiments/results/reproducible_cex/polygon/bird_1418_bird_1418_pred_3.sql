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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('MU 21537', 'MU 21531', 'MU 21532', 'MU 21533', 'MU 21534', 'MU 215', 'MU 21535');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('MU 21548', 'MU 21542', 'MU 21543', 'MU 21544', 'MU 21545', 'MU 215', 'MU 21546');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('MU 21520', 'MU 21553', 'MU 21553', 'MU 21553');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('MU 21519', 'MU 21553', 'MU 21553', 'MU 21553');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (22, 'MU 21553', 'MU 21553', 'MU 21553', 'MU 21553', 'MU 21553');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (21, 'MU 21553', 'MU 21553', 'MU 21553', 'MU 21553', 'MU 21553');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('MU 21548', 'MU 21523');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('MU 21537', 'MU 21524');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('MU 21536', 'MU 21537', 'MU 21553', 38, 39, 40, 'MU 21541');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('MU 21547', 'MU 21548', 'MU 21553', 49, 50, 51, 'MU 21552');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('MU 21553', 'MU 21536', 'MU 21524', 'MU 21553', 'MU 21553', 53, 'MU 21553');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('MU 21523', 'MU 21519', 21, 'MU 21553', 'MU 21553', 'MU 21553', 'MU 21553', 'MU 21553', 'MU 21553');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('MU 21524', 'MU 21519', 21, 'MU 21553', 'MU 21553', 'MU 21553', 'MU 21553', 'MU 21553', 'MU 21553');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.category FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event WHERE T1.location = 'MU 215';

/*
Gold Result:
('MU 21553',)
('MU 21553',)
*/

-- Prediction Query
SELECT DISTINCT T2.category FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event WHERE T1.location = 'MU 215';

/*
Prediction Result:
('MU 21553',)
*/