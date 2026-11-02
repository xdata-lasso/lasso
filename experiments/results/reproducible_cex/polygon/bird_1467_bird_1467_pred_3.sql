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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Speaker Gifts19', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Speaker Gifts18', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Speaker Gifts21', NULL, NULL, NULL);
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Speaker Gifts20', NULL, NULL, NULL);
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (23, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (22, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Speaker Gifts18', 'Speaker Gifts25');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Speaker Gifts18', 'Speaker Gifts24');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Speaker Gifts27', 'Speaker Gifts19', 'Speaker Gifts36', 37, NULL, 39, NULL);
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Speaker Gifts26', 'Speaker Gifts19', 'Speaker Gifts47', NULL, NULL, NULL, NULL);
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Speaker Gifts29', 'Speaker Gifts26', 'Speaker Gifts25', NULL, NULL, NULL, NULL);
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Speaker Gifts28', 'Speaker Gifts27', 'Speaker Gifts25', NULL, NULL, NULL, NULL);
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Speaker Gifts31', 'Speaker Gifts25', NULL, NULL, NULL, NULL);
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Speaker Gifts30', 'Speaker Gifts25', NULL, NULL, NULL, NULL);
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Speaker Gifts24', 'Speaker Gifts20', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Speaker Gifts25', 'Speaker Gifts20', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(T1.spent), T2.event_name FROM budget AS T1 INNER JOIN event AS T2 ON T1.link_to_event = T2.event_id WHERE T1.category = 'Speaker Gifts';

/*
Gold Result:
(None, None)
*/

-- Prediction Query
SELECT SUM(b.spent) AS total_spent, e.event_name FROM budget AS b INNER JOIN event AS e ON b.link_to_event = e.event_id WHERE b.category = 'Speaker Gifts';

/*
Prediction Result:
(None, None)
*/