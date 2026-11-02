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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Meeting53', 'October Meeting', 'October Meeting47', 'Advertisement48', 'Meeting49', 'Yearly Kickoff50', 'October Meeting51');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('October Meeting19', 'Meeting53', 'Meeting53', 'Meeting53');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Yearly Kickoff18', 'Meeting53', 'Meeting53', 'Meeting53');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (21, 'Meeting53', 'Meeting53', 'Meeting53', 'Meeting53', 'Meeting53');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (20, 'Meeting53', 'Meeting53', 'Meeting53', 'Meeting53', 'Meeting53');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Meeting53', 'October Meeting23');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Meeting25', 'Meeting53', 'Advertisement', 32, 33, 1, 'Yearly Kickoff34');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Advertisement52', 'Meeting53', 'Advertisement', 54, 55, 0, 'Advertisement56');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('October Meeting27', 'Advertisement52', 'October Meeting23', 'Meeting53', 'Meeting53', 53, 'Meeting53');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Yearly Kickoff26', 'Advertisement52', 'October Meeting23', 'Meeting53', 'Meeting53', 53, 'Meeting53');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Meeting53', 'October Meeting23', 'Meeting53', 53, 'Meeting53', 'Meeting53');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('October Meeting23', 'Yearly Kickoff18', 20, 'Meeting53', 'Meeting53', 'Meeting53', 'Meeting53', 'Meeting53', 'Meeting53');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Advertisement24', 'Yearly Kickoff18', 20, 'Meeting53', 'Meeting53', 'Meeting53', 'Meeting53', 'Meeting53', 'Meeting53');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN T2.event_name = 'Yearly Kickoff' THEN T1.amount ELSE 0 END) AS REAL) / SUM(CASE WHEN T2.event_name = 'October Meeting' THEN T1.amount ELSE 0 END) FROM budget AS T1 INNER JOIN event AS T2 ON T1.link_to_event = T2.event_id WHERE T1.category = 'Advertisement' AND T2.type = 'Meeting';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT SUM(CASE WHEN e.event_name = 'Yearly Kickoff' THEN b.amount ELSE 0 END) / SUM(CASE WHEN e.event_name = 'October Meeting' THEN b.amount ELSE 0 END) AS budget_ratio FROM event AS e INNER JOIN budget AS b ON e.event_id = b.link_to_event WHERE b.category = 'Advertisement';

/*
Prediction Result:
(0,)
*/