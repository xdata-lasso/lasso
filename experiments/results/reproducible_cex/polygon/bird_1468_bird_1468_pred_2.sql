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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Gerke19', 'Girke41', 'Girke41', 'Girke41', 'Girke41', 'Girke41', 'Girke41');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Garrett18', 'Girke41', 'Girke41', 'Girke41', 'Girke41', 'Girke41', 'Girke41');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Gerke31', 'Girke41', 'Girke41', 'Girke41');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (41, 'Garrett42', 'Gerke46', 'Gerke43', 'Girke44', 'Garrett45');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Garrett18', 'Garrett36');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Garrett21', 'Garrett18', 'Girke41', 41, 41, 41, 'Girke41');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Girke20', 'Gerke19', 'Girke41', 41, 41, 41, 'Girke41');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Girke23', 'Garrett21', 'Garrett36', 'Girke41', 'Girke41', 41, 'Girke41');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Gerke22', 'Girke20', 'Garrett36', 'Girke41', 'Girke41', 41, 'Girke41');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Gerke25', 'Garrett36', 'Girke41', 41, 'Girke41', 'Girke41');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Garrett24', 'Garrett36', 'Girke41', 41, 'Girke41', 'Girke41');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Garrett30', 'Gerke31', 41, 'Garrett', 'Girke', 'Girke32', 'Garrett33', 'Gerke34', 'Girke35');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Garrett36', 'Gerke31', 41, 'Garrett', 'Girke', 'Gerke37', 'Girke38', 'Garrett39', 'Gerke40');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.city FROM member AS T1 INNER JOIN zip_code AS T2 ON T2.zip_code = T1.zip WHERE T1.first_name = 'Garrett' AND T1.last_name = 'Gerke';

/*
Gold Result:
*/

-- Prediction Query
SELECT T2.city FROM member AS T1 INNER JOIN zip_code AS T2 ON T1.zip = T2.zip_code WHERE T1.first_name = 'Garrett' AND T1.last_name = 'Girke';

/*
Prediction Result:
('Gerke46',)
('Gerke46',)
*/