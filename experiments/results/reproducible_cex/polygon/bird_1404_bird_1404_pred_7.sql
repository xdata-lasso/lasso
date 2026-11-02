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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('October Meeting52', 'October Meeting', 'true47', 'October Meeting48', 'true49', 'October Meeting50', 'true51');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('true63', 'October Meeting', 'October Meeting58', 'true59', 'October Meeting60', 'true61', 'October Meeting62');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('true25', 'October Meeting52', 'October Meeting52', 'October Meeting52');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('October Meeting24', 'October Meeting52', 'October Meeting52', 'October Meeting52');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (26, 'October Meeting52', 'October Meeting52', 'October Meeting52', 'October Meeting52', 'October Meeting52');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('October Meeting52', 'true31');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('true63', 'October Meeting32');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('October Meeting30', 'true63', 'October Meeting64', 65, 66, 67, 'October Meeting68');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('true29', 'October Meeting52', NULL, 54, 55, 56, 'true57');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('October Meeting28', 'true29', 'true31', 'true69', 'true41', -916, 'true');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('true27', 'October Meeting30', 'October Meeting32', 'true69', 'October Meeting42', 533, 'true');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('October Meeting34', 'October Meeting32', 'October Meeting52', 52, 'October Meeting52', 'October Meeting52');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('true33', 'October Meeting32', 'October Meeting52', 52, 'October Meeting52', 'October Meeting52');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('true31', 'October Meeting24', 26, 'October Meeting52', 'October Meeting52', 'October Meeting52', 'October Meeting52', 'October Meeting52', 'October Meeting52');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('October Meeting32', 'true25', 26, 'October Meeting52', 'October Meeting52', 'October Meeting52', 'October Meeting52', 'October Meeting52', 'October Meeting52');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.type, SUM(T3.cost) FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget WHERE T1.event_name = 'October Meeting';

/*
Gold Result:
('October Meeting48', -383.0)
*/

-- Prediction Query
SELECT T3.expense_description, CAST(SUM(T3.cost) AS REAL) FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget WHERE T1.event_name = 'October Meeting' AND T3.approved = 'true' GROUP BY T3.expense_description ORDER BY T3.expense_description, CAST(SUM(T3.cost) AS REAL) NULLS LAST;

/*
Prediction Result:
('true69', -383.0)
*/