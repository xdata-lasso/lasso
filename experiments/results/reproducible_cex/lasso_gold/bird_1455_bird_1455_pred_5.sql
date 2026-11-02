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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('fish', 'Larry Taylor', 'necessary', 'college', 'Read lose doctor actually become.', '1100 Elizabeth Extension Suite 579
Natalieland, MN 45422', 'image');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('kitchen', 'Ashley Higgins', 'help', 'among', 'Structure protect chance bed.', '7467 Banks Union Apt. 120
North Robert, OR 63766', 'church');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('recognize', 'Brian Rodriguez', 'score', 'official', 'Avoid rich toward popular lead with enough.', '96590 Timothy Oval Apt. 670
West Dianatown, VT 89358', 'those');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('nature', 'Curtis Baker', 'find', 'model', 'Between company always.', '588 Ryan Stream
South Michael, TX 84571', 'the');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('open', 'Kathy Harrison', 'bar', 'line');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('position', 'Christopher Walton MD', 'machine', 'behavior');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('activity', 'Donald Hunter', 'suddenly', 'tough');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('question', 'Jamie Montoya', 'page', 'moment');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1282, 'likely', 'North Richardton', 'technology', 'Michigan', 'Virginia');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1283, 'by', 'Port Christopherport', 'dog', 'Oklahoma', 'Texas');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1284, 'modern', 'Lake Emily', 'three', 'Wyoming', 'Mississippi');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1285, 'skill', 'Michaelton', 'look', 'Rhode Island', 'Connecticut');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('song', 'Matthew', 'Boyd', 'lydianewton@example.com', 'third', 'little', '708.869.7829x22169', 1282, 'open');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('reason', 'Maria', 'Park', 'kingjames@example.org', 'remember', 'mother', '(793)546-5472x26984', 1282, 'open');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('doctor', 'Tamara', 'Williams', 'ylewis@example.org', 'per', 'center', '739.345.2288', 1282, 'open');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('able', 'Kelly', 'Martin', 'daniel60@example.net', 'sport', 'above', '001-858-479-9684x60810', 1282, 'open');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('religious', 'Water, chips, cookies', 'stock', 1286.5, 'child', 'song', NULL);
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('arrive', 'Water, chips, cookies', 'few', 1295.5, 'rock', 'song', NULL);
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('example', 'Water, chips, cookies', 'result', 1304.5, 'still', 'song', NULL);
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('social', 'Water, chips, cookies', 'enough', 1313.5, 'Democrat', 'song', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.budget_id FROM expense AS T1 INNER JOIN budget AS T2 ON T1.link_to_budget = T2.budget_id WHERE T1.expense_description = 'Water, chips, cookies' ORDER BY T1.cost DESC, T1.expense_id NULLS LAST, T2.budget_id NULLS LAST LIMIT 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.link_to_budget FROM expense AS T1 WHERE T1.expense_description = 'Water, chips, cookies' ORDER BY T1.cost DESC, T1.expense_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/