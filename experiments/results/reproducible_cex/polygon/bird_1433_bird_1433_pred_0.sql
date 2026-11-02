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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('PO Box15', 'PO Box33', 'PO Box33', 'PO Box33', 'PO Box33', 'PO Box33', 'PO Box33');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('PO Box14', 'PO Box33', 'PO Box33', 'PO Box33', 'PO Box33', 'PO Box33', 'PO Box33');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('PO Box17', 'PO Box33', 'PO Box33', 'PO Box33');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('PO Box16', 'PO Box33', 'PO Box33', 'PO Box33');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (19, 'PO Box', 'PO Box29', 'PO Box33', NULL, 'PO Box30');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (18, 'PO Box', 'PO Box31', 'PO Box33', 'PO Box35', 'PO Box32');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('PO Box14', 'PO Box21');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('PO Box24', 'PO Box14', 'PO Box33', 33, 33, 33, 'PO Box33');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('PO Box23', NULL, 'PO Box33', 33, 33, 33, 'PO Box33');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('PO Box26', 'PO Box23', 'PO Box22', 'PO Box33', 'PO Box33', 33, 'PO Box33');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('PO Box25', 'PO Box23', 'PO Box22', 'PO Box33', 'PO Box33', 33, 'PO Box33');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('PO Box28', 'PO Box22', 'PO Box33', 33, 'PO Box33', 'PO Box33');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('PO Box27', 'PO Box22', 'PO Box33', 33, 'PO Box33', 'PO Box33');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('PO Box21', 'PO Box16', 18, 'PO Box33', 'PO Box33', 'PO Box33', 'PO Box33', 'PO Box33', 'PO Box33');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('PO Box22', 'PO Box16', 19, 'PO Box33', 'PO Box33', 'PO Box33', 'PO Box33', 'PO Box33', 'PO Box33');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT county FROM zip_code WHERE type = 'PO Box' AND NOT county IS NULL;

/*
Gold Result:
('PO Box33',)
*/

-- Prediction Query
SELECT DISTINCT state FROM zip_code WHERE type = 'PO Box';

/*
Prediction Result:
('PO Box35',)
(None,)
*/