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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('McLean25', 'YES24', 'YES24', 'YES24', 'YES24', 'YES24', 'YES24');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('YES24', NULL, 'McLean39', 'Yes40', 'No41', 'Maya42', 'Mclean43');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Women''s Soccer44', 'YES24', 'YES24', 'YES24');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('McLean53', 'YES24', 'YES24', 'YES24');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (54, 'YES24', 'YES24', 'YES24', 'YES24', 'YES24');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (45, 'YES24', 'YES24', 'YES24', 'YES24', 'YES24');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('YES24', 'YES52');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('YES24', 'Yes61');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('No27', 'YES24', 'YES24', 24, 24, 24, 'YES24');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Yes26', 'YES24', 'YES24', 24, 24, 24, 'YES24');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Mclean29', 'No27', 'Yes61', 'YES24', 'YES24', 24, 'YES24');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Maya28', 'Yes26', 'Yes61', 'YES24', 'YES24', 24, 'YES24');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('YES31', 'Yes61', 'YES24', 24, 'YES24', 'YES24');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Women''s Soccer30', 'Yes61', 'YES24', 24, 'YES24', 'YES24');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('YES52', 'Women''s Soccer44', 45, NULL, NULL, NULL, 'Maya49', 'Mclean50', 'Women''s Soccer51');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Yes61', 'McLean53', 54, NULL, NULL, 'Mclean57', 'Women''s Soccer58', 'YES59', 'McLean60');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CASE WHEN T3.event_name = 'Women''s Soccer' THEN 'YES' END AS result FROM member AS T1 INNER JOIN attendance AS T2 ON T1.member_id = T2.link_to_member INNER JOIN event AS T3 ON T2.link_to_event = T3.event_id WHERE T1.first_name = 'Maya' AND T1.last_name = 'Mclean';

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT CASE WHEN t1.first_name = 'Maya' AND t1.last_name = 'McLean' AND t3.event_name = 'Women''s Soccer' THEN 'Yes' ELSE 'No' END AS attended FROM member AS t1 INNER JOIN attendance AS t2 ON t1.member_id = t2.link_to_member INNER JOIN event AS t3 ON t2.link_to_event = t3.event_id;

/*
Prediction Result:
('No',)
*/