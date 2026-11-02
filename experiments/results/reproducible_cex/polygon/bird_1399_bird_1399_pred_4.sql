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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Mclean25', 'Maya54', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Maya24', 'Maya60', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('YES27', NULL, NULL, NULL);
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Women''s Soccer26', NULL, NULL, NULL);
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (29, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (28, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Maya24', 'Mclean31');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Mclean25', 'Maya30');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('YES33', 'Maya24', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Women''s Soccer32', 'Maya24', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('no35', 'Women''s Soccer32', 'Mclean31', NULL, NULL, NULL, NULL);
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('yes34', 'YES33', 'Mclean31', NULL, NULL, NULL, NULL);
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Mclean31', 'Mclean31', NULL, NULL, NULL, NULL);
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Maya30', NULL, NULL, 'Maya', 'Mclean', NULL, NULL, NULL, NULL);
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Mclean31', NULL, NULL, 'Maya', 'Mclean', NULL, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CASE WHEN T3.event_name = 'Women''s Soccer' THEN 'YES' END AS result FROM member AS T1 INNER JOIN attendance AS T2 ON T1.member_id = T2.link_to_member INNER JOIN event AS T3 ON T2.link_to_event = T3.event_id WHERE T1.first_name = 'Maya' AND T1.last_name = 'Mclean';

/*
Gold Result:
(None,)
(None,)
*/

-- Prediction Query
SELECT CASE WHEN COUNT(*) > 0 THEN 'yes' ELSE 'no' END FROM member AS T1 INNER JOIN attendance AS T2 ON T1.member_id = T2.link_to_member INNER JOIN event AS T3 ON T2.link_to_event = T3.event_id WHERE T1.first_name = 'Maya' AND T1.last_name = 'Mclean' AND T3.event_name = 'Women''s Soccer';

/*
Prediction Result:
('no',)
*/