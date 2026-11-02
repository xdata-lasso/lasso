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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('October Meeting51', 'October Meeting', 'Advertisement52', 'Meeting53', 'Yearly Kickoff54', 'October Meeting55', 'Advertisement56');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Advertisement16', 'October Meeting51', 'October Meeting51', 'October Meeting51');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (18, 'October Meeting51', 'October Meeting51', 'October Meeting51', 'October Meeting51', 'October Meeting51');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (17, 'October Meeting51', 'October Meeting51', 'October Meeting51', 'October Meeting51', 'October Meeting51');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('October Meeting51', 'Meeting21');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('October Meeting43', 'October Meeting51', 'Advertisement', 44, 45, 2063, 'Yearly Kickoff46');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('October Meeting47', 'October Meeting51', 'Advertisement', 48, 49, -1, 'Yearly Kickoff50');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('October Meeting23', 'October Meeting43', 'Meeting21', 'October Meeting51', 'October Meeting51', 51, 'October Meeting51');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Meeting25', 'Advertisement20', 'October Meeting51', 51, 'October Meeting51', 'October Meeting51');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Advertisement24', 'Advertisement20', 'October Meeting51', 51, 'October Meeting51', 'October Meeting51');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Advertisement20', NULL, 17, 'October Meeting51', 'October Meeting51', 'October Meeting51', 'October Meeting51', 'October Meeting51', 'October Meeting51');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Meeting21', 'Advertisement16', 17, 'October Meeting51', 'October Meeting51', 'October Meeting51', 'October Meeting51', 'October Meeting51', 'October Meeting51');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN T2.event_name = 'Yearly Kickoff' THEN T1.amount ELSE 0 END) AS REAL) / SUM(CASE WHEN T2.event_name = 'October Meeting' THEN T1.amount ELSE 0 END) FROM budget AS T1 INNER JOIN event AS T2 ON T1.link_to_event = T2.event_id WHERE T1.category = 'Advertisement' AND T2.type = 'Meeting';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN event.event_name = 'Yearly Kickoff' THEN budget.amount ELSE 0 END) AS REAL) / SUM(CASE WHEN event.event_name = 'October Meeting' THEN budget.amount ELSE 0 END) AS ratio FROM budget INNER JOIN event ON budget.link_to_event = event.event_id WHERE budget.category = 'Advertisement';

/*
Prediction Result:
(0.0,)
*/