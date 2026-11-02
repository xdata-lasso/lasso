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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Pizza25', 'Pizza59', 'Pizza59', 'Pizza59', 'Pizza59', 'Pizza59', 'Pizza59');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Pizza59', 'Pizza53', NULL, 'Pizza55', 'Pizza56', 'Pizza57', 'Pizza58');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Pizza27', 'Pizza59', 'Pizza59', 'Pizza59');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Pizza26', 'Pizza59', 'Pizza59', 'Pizza59');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (29, 'Pizza59', 'Pizza59', 'Pizza59', 'Pizza59', 'Pizza59');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (28, 'Pizza59', 'Pizza59', 'Pizza59', 'Pizza59', 'Pizza59');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Pizza59', 'Pizza35');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Pizza59', 'Pizza30');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Pizza34', 'Pizza59', 'Pizza48', 49, 50, 51, 'Pizza52');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Pizza33', 'Pizza59', 'Pizza60', 61, 62, 63, 'Pizza64');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Pizza32', 'Pizza33', 'Pizza35', 'Pizza', 'Pizza44', 98, 'Pizza45');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Pizza31', 'Pizza34', 'Pizza35', 'Pizza', 'Pizza46', 97, 'Pizza47');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Pizza37', 'Pizza30', 'Pizza59', 59, 'Pizza59', 'Pizza59');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Pizza36', 'Pizza30', 'Pizza59', 59, 'Pizza59', 'Pizza59');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Pizza35', 'Pizza26', 29, 'Pizza59', 'Pizza59', 'Pizza59', 'Pizza59', 'Pizza59', 'Pizza59');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Pizza30', NULL, 28, 'Pizza59', 'Pizza59', 'Pizza59', 'Pizza59', 'Pizza59', 'Pizza59');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_name, T1.event_date FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget WHERE T3.expense_description = 'Pizza' AND T3.cost > 50 AND T3.cost < 100;

/*
Gold Result:
('Pizza53', None)
('Pizza53', None)
*/

-- Prediction Query
SELECT DISTINCT e.event_name, e.event_date FROM event AS e INNER JOIN budget AS b ON e.event_id = b.link_to_event INNER JOIN expense AS ex ON b.budget_id = ex.link_to_budget WHERE ex.expense_description = 'Pizza' AND ex.cost > 50 AND ex.cost < 100;

/*
Prediction Result:
('Pizza53', None)
*/