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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Pizza15', 'Pizza34', 'Pizza34', 'Pizza34', 'Pizza34', 'Pizza34', 'Pizza34');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Pizza38', 'Pizza34', 'Pizza34', 'Pizza34', 'Pizza34', 'Pizza34', 'Pizza34');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Pizza16', 'Pizza34', 'Pizza34', 'Pizza34');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (18, 'Pizza34', 'Pizza34', 'Pizza34', 'Pizza34', 'Pizza34');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (17, 'Pizza34', 'Pizza34', 'Pizza34', 'Pizza34', 'Pizza34');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Pizza38', 'Pizza34');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Pizza15', 'Pizza19');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Pizza37', 'Pizza38', 'Pizza39', 40, 41, 42, 'Pizza43');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Pizza20', NULL, NULL, 'Pizza', NULL, -1791, NULL);
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Pizza33', 'Pizza37', 'Pizza34', 'Pizza', 'Pizza35', 891, 'Pizza36');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Pizza24', 'Pizza34', 'Pizza34', 34, 'Pizza34', 'Pizza34');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Pizza23', 'Pizza19', 'Pizza34', 34, 'Pizza34', 'Pizza34');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Pizza34', 'Pizza16', 18, 'Pizza34', 'Pizza34', 'Pizza34', 'Pizza34', 'Pizza34', 'Pizza34');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Pizza19', NULL, 17, 'Pizza34', 'Pizza34', 'Pizza34', 'Pizza34', 'Pizza34', 'Pizza34');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(cost) FROM expense WHERE expense_description = 'Pizza';

/*
Gold Result:
(-900.0,)
*/

-- Prediction Query
SELECT SUM(T1.cost) FROM expense AS T1 INNER JOIN budget AS T2 ON T1.link_to_budget = T2.budget_id WHERE T1.expense_description = 'Pizza';

/*
Prediction Result:
(891.0,)
*/