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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('PO Box12', 'PO Box24', 'PO Box24', 'PO Box24', 'PO Box24', 'PO Box24', 'PO Box24');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('San Juan Municipio13', 'PO Box24', 'PO Box24', 'PO Box24');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (20, 'PO Box', 'San Juan Municipio21', 'San Juan Municipio', 'Puerto Rico', NULL);
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (24, 'PO Box', 'San Juan', 'San Juan Municipio', 'Puerto Rico', 'San Juan23');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('San Juan Municipio17', 'PO Box12', 'PO Box24', 24, 24, 24, 'PO Box24');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('PO Box16', 'PO Box12', 'PO Box24', 24, 24, 24, 'PO Box24');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('San Juan19', 'San Juan Municipio17', 'San Juan15', 'PO Box24', 'PO Box24', 24, 'PO Box24');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Puerto Rico18', 'San Juan Municipio17', 'San Juan15', 'PO Box24', 'PO Box24', 24, 'PO Box24');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('PO Box24', 'San Juan15', 'PO Box24', 24, 'PO Box24', 'PO Box24');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Puerto Rico14', 'San Juan Municipio13', 24, 'PO Box24', 'PO Box24', 'PO Box24', 'PO Box24', 'PO Box24', 'PO Box24');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('San Juan15', 'San Juan Municipio13', 24, 'PO Box24', 'PO Box24', 'PO Box24', 'PO Box24', 'PO Box24', 'PO Box24');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT zip_code FROM zip_code WHERE type = 'PO Box' AND county = 'San Juan Municipio' AND state = 'Puerto Rico';

/*
Gold Result:
(20,)
(24,)
*/

-- Prediction Query
SELECT zip_code FROM zip_code WHERE type = 'PO Box' AND city = 'San Juan' AND county = 'San Juan Municipio' AND state = 'Puerto Rico';

/*
Prediction Result:
(24,)
*/