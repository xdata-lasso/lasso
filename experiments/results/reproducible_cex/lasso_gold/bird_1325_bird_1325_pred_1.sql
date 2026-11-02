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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('popular', 'Cynthia Allen', 'morning', 'technology', 'Appear lose he various represent.', '04727 Gilbert Common
West Jasonberg, OH 95821', 'simple');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('feel', 'Rachel Mckee', 'news', 'decision', 'Surface expect several evening town challenge join.', '43410 Robert Underpass Suite 117
Lake Zacharybury, VT 19319', 'something');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('soldier', 'Michael Hudson', 'kid', 'suddenly', 'Stage this us increase how.', '539 Lopez Skyway
New Theresaland, NC 71814', 'go');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('smile', 'Randy Strickland', 'color', 'certainly', 'Dog yes heart agreement us stuff.', '7065 Burgess Knolls
West Johnville, WI 76772', 'cell');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('another', 'Carrie Maxwell', 'various', 'myself');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('he', 'Michael Welch', 'four', 'information');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('office', 'Amy Parsons', 'worker', 'teacher');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('ground', 'Edward Williams', 'force', 'of');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1102, 'material', 'West Michael', 'group', 'New York', 'Nevada');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1103, 'environment', 'Port Dianaview', 'culture', 'North Dakota', 'Idaho');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1104, 'although', 'Port Michealfurt', 'model', 'Louisiana', 'Ohio');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1105, 'some', 'Klinefurt', 'role', 'Washington', 'Massachusetts');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('board', 'Kenneth', 'Wallace', 'yhill@example.org', 'start', 'identify', '+1-375-257-1928x56543', 1102, 'another');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('base', 'Sean', 'West', 'lambertrichard@example.net', 'quite', 'our', '001-927-586-8144x7394', 1102, 'another');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('generation', 'Jennifer', 'Acosta', 'stephaniethomas@example.net', 'hit', 'alone', '321-672-7155', 1102, 'another');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('recent', 'Garrett', 'Buck', 'ejohnson@example.org', 'high', 'class', '722-958-3132x3705', 1102, 'another');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('suggest', 'Assume huge response long.', 'worry', 1106.5, 'yourself', 'board', NULL);
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('ok', 'Shoulder statement available win politics last.', 'security', 1115.5, 'yeah', 'board', NULL);
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('carry', 'General there sister policy consider whom item.', 'down', 1124.5, 'natural', 'board', NULL);
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('population', 'Story million fight class.', 'half', 1133.5, 'want', 'board', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT expense_description FROM expense ORDER BY cost DESC, expense.expense_id NULLS LAST LIMIT 1;

/*
Gold Result:
('Story million fight class.',)
*/

-- Prediction Query
SELECT expense.expense_description FROM expense INNER JOIN budget ON expense.link_to_budget = budget.budget_id ORDER BY expense.cost DESC, expense.expense_id NULLS LAST, budget.budget_id NULLS LAST LIMIT 1;

/*
Prediction Result:
*/