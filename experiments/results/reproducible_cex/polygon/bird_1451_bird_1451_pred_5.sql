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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('30', NULL, NULL, NULL, NULL, NULL, '83');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('32', '34', '34', '34', '34', '34', '34');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('61', '34', '34', '34');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('47', '34', '34', '34');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (62, '34', '34', '34', '34', '34');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (31, '34', '34', '34', '34', '34');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('30', '46');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('32', '46');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('34', '30', NULL, 72, 73, 74, NULL);
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('33', '32', '34', 34, 34, 34, '34');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('41', '34', '46', '42', '43', 44, '45');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('55', '34', '60', '56', '57', NULL, NULL);
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('36', '46', '34', 34, '34', '34');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('35', '46', '34', 34, '34', '34');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('60', '61', 62, NULL, '64', '65', '66', NULL, NULL);
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('46', '47', NULL, NULL, '50', '51', '52', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.member_id FROM expense AS T1 INNER JOIN member AS T2 ON T1.link_to_member = T2.member_id INNER JOIN budget AS T3 ON T1.link_to_budget = T3.budget_id INNER JOIN event AS T4 ON T3.link_to_event = T4.event_id GROUP BY T2.member_id HAVING COUNT(DISTINCT T4.event_id) > 1 ORDER BY SUM(T1.cost) DESC, T2.member_id NULLS LAST LIMIT 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT e.link_to_member FROM expense AS e INNER JOIN attendance AS a ON e.link_to_member = a.link_to_member GROUP BY e.link_to_member HAVING COUNT(DISTINCT a.link_to_event) > 1 ORDER BY SUM(e.cost) DESC, e.link_to_member NULLS LAST LIMIT 1;

/*
Prediction Result:
('46',)
*/