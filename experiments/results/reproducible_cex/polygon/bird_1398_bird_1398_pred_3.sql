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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Advertisement35', 'Advertisement47', NULL, NULL, NULL, 'Advertisement51', 'Advertisement52');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Advertisement26', 'Advertisement35', 'Advertisement35', 'Advertisement35', 'Advertisement35', 'Advertisement35', 'Advertisement35');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Advertisement28', 'Advertisement35', 'Advertisement35', 'Advertisement35');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Advertisement27', 'Advertisement35', 'Advertisement35', 'Advertisement35');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (30, 'Advertisement35', 'Advertisement35', 'Advertisement35', 'Advertisement35', 'Advertisement35');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (29, 'Advertisement35', 'Advertisement35', 'Advertisement35', 'Advertisement35', 'Advertisement35');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Advertisement26', 'Advertisement32');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Advertisement34', 'Advertisement35', 'Advertisement', NULL, NULL, NULL, NULL);
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Advertisement33', 'Advertisement35', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Advertisement37', 'Advertisement33', 'Advertisement32', 'Advertisement35', 'Advertisement35', 35, 'Advertisement35');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Advertisement36', 'Advertisement33', 'Advertisement32', 'Advertisement35', 'Advertisement35', 35, 'Advertisement35');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Advertisement39', 'Advertisement32', 'Advertisement35', 35, 'Advertisement35', 'Advertisement35');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Advertisement38', 'Advertisement31', 'Advertisement35', 35, 'Advertisement35', 'Advertisement35');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Advertisement31', 'Advertisement27', 29, 'Advertisement35', 'Advertisement35', 'Advertisement35', 'Advertisement35', 'Advertisement35', 'Advertisement35');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Advertisement32', 'Advertisement27', 30, 'Advertisement35', 'Advertisement35', 'Advertisement35', 'Advertisement35', 'Advertisement35', 'Advertisement35');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.event_name FROM budget AS T1 INNER JOIN event AS T2 ON T1.link_to_event = T2.event_id WHERE T1.category = 'Advertisement' ORDER BY T1.spent DESC, T1.budget_id NULLS LAST, T2.event_id NULLS LAST LIMIT 1;

/*
Gold Result:
('Advertisement47',)
*/

-- Prediction Query
SELECT t1.event_name FROM event AS t1 INNER JOIN budget AS t2 ON t1.event_id = t2.link_to_event WHERE t2.category = 'Advertisement' AND t2.spent = (SELECT MAX(spent) FROM budget WHERE category = 'Advertisement');

/*
Prediction Result:
*/