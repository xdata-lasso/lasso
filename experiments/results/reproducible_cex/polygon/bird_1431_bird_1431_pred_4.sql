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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Member23', 'Women''s Soccer', 'Women''s Soccer34', 'Member35', 'Women''s Soccer36', 'Member37', 'Women''s Soccer38');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Women''s Soccer22', 'Women''s Soccer', 'Member39', 'Women''s Soccer40', 'Member41', 'Women''s Soccer42', 'Member43');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Women''s Soccer24', 'Member53', 'Member53', 'Member53');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Women''s Soccer46', 'Member53', 'Member53', 'Member53');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (47, 'Member53', 'Member53', 'Member53', 'Member53', 'Member53');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Women''s Soccer22', 'Member53');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Member23', 'Member53');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Member27', NULL, 'Member53', 53, 53, 53, 'Member53');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Women''s Soccer26', 'Women''s Soccer22', 'Member53', 53, 53, 53, 'Member53');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Member29', 'Women''s Soccer26', 'Member25', 'Member53', 'Member53', 53, 'Member53');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Women''s Soccer28', 'Women''s Soccer26', 'Member25', 'Member53', 'Member53', 53, 'Member53');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Member53', 'Member25', 'Member53', 53, 'Member53', 'Member53');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Member53', 'Women''s Soccer46', 47, 'Women''s Soccer48', NULL, 'Women''s Soccer50', 'Member', 'Member51', 'Women''s Soccer52');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Member25', NULL, NULL, 'Member53', 'Member53', 'Member53', 'Member53', 'Member53', 'Member53');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.last_name FROM attendance AS T1 INNER JOIN event AS T2 ON T2.event_id = T1.link_to_event INNER JOIN member AS T3 ON T1.link_to_member = T3.member_id WHERE T2.event_name = 'Women''s Soccer' AND T3.position = 'Member';

/*
Gold Result:
(None,)
(None,)
*/

-- Prediction Query
SELECT DISTINCT member.last_name FROM member INNER JOIN attendance ON member.member_id = attendance.link_to_member INNER JOIN event ON attendance.link_to_event = event.event_id WHERE member.position = 'Member' AND event.event_name = 'Women''s Soccer';

/*
Prediction Result:
(None,)
*/