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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Virginia13', 'Virginia27', 'Virginia27', 'Virginia27', 'Virginia27', 'Virginia27', 'Virginia27');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Orange County12', 'Virginia27', 'Virginia27', 'Virginia27', 'Virginia27', 'Virginia27', 'Virginia27');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Virginia15', 'Virginia27', 'Virginia27', 'Virginia27');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Orange County14', 'Virginia27', 'Virginia27', 'Virginia27');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (17, 'Orange County26', 'Virginia27', 'Orange County', 'Virginia', 'Orange County28');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (16, 'Virginia29', 'Virginia27', 'Orange County', 'Virginia', NULL);
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Virginia13', 'Virginia19');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Virginia21', 'Virginia13', 'Virginia27', 27, 27, 27, 'Virginia27');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Orange County20', 'Virginia13', 'Virginia27', 27, 27, 27, 'Virginia27');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Virginia23', 'Virginia21', NULL, 'Virginia27', 'Virginia27', 27, 'Virginia27');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Orange County22', 'Orange County20', 'Virginia19', 'Virginia27', 'Virginia27', 27, 'Virginia27');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Virginia25', 'Virginia19', 'Virginia27', 27, 'Virginia27', 'Virginia27');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Orange County24', 'Virginia19', 'Virginia27', 27, 'Virginia27', 'Virginia27');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Orange County18', NULL, 16, 'Virginia27', 'Virginia27', 'Virginia27', 'Virginia27', 'Virginia27', 'Virginia27');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Virginia19', 'Orange County14', 16, 'Virginia27', 'Virginia27', 'Virginia27', 'Virginia27', 'Virginia27', 'Virginia27');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(city) FROM zip_code WHERE county = 'Orange County' AND state = 'Virginia';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT city) FROM zip_code WHERE county = 'Orange County' AND state = 'Virginia';

/*
Prediction Result:
(1,)
*/