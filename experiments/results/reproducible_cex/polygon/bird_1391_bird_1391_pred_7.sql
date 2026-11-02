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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Finance14', 'Finance20', 'Finance20', 'Finance20', 'Finance20', 'Finance20', 'Finance20');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Physics13', 'Finance20', 'Finance20', 'Finance20', 'Finance20', 'Finance20', 'Finance20');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Finance16', 'Physics', 'Physics47', 'Finance48');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Physics15', 'Finance', 'Finance20', 'Finance20');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (18, 'Finance20', 'Finance20', 'Finance20', 'Finance20', 'Finance20');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (17, 'Finance20', 'Finance20', 'Finance20', 'Finance20', 'Finance20');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Finance14', 'Finance20');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Finance22', 'Finance14', 'Finance20', 20, 20, 20, 'Finance20');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Physics21', 'Physics13', 'Finance20', 20, 20, 20, 'Finance20');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Finance24', 'Physics21', 'Finance20', 'Finance20', 'Finance20', 20, 'Finance20');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Physics23', 'Physics21', 'Finance20', 'Finance20', 'Finance20', 20, 'Finance20');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Finance26', 'Finance20', 'Finance20', 20, 'Finance20', 'Finance20');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Physics25', 'Finance20', 'Finance20', 20, 'Finance20', 'Finance20');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Finance20', 'Finance16', NULL, 'Physics41', 'Finance42', 'Physics43', 'Finance44', 'Physics45', 'Finance46');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(CASE WHEN major_name = 'Finance' THEN 1 ELSE 0 END) / SUM(CASE WHEN major_name = 'Physics' THEN 1 ELSE 0 END) AS ratio FROM major;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T2.major_name = 'Finance' THEN 1 ELSE 0 END) AS REAL) / SUM(CASE WHEN T2.major_name = 'Physics' THEN 1 ELSE 0 END) AS finance_to_physics_ratio FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id;

/*
Prediction Result:
(0.0,)
*/