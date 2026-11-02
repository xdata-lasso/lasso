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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Women''s Soccer56', 'Women''s Soccer', 'Women''s Soccer51', 'Women''s Soccer52', 'Women''s Soccer53', 'Women''s Soccer54', 'Women''s Soccer55');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Women''s Soccer62', 'Women''s Soccer', 'Women''s Soccer57', 'Women''s Soccer58', 'Women''s Soccer59', 'Women''s Soccer60', 'Women''s Soccer61');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Women''s Soccer31', 'Women''s Soccer56', 'Women''s Soccer56', 'Women''s Soccer56');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Women''s Soccer32', 'Women''s Soccer56', 'Women''s Soccer56', 'Women''s Soccer56');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (33, 'Women''s Soccer56', 'Women''s Soccer56', 'Women''s Soccer56', 'Women''s Soccer56', 'Women''s Soccer56');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (34, 'Women''s Soccer56', 'Women''s Soccer56', 'Women''s Soccer56', 'Women''s Soccer56', 'Women''s Soccer56');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Women''s Soccer56', 'Women''s Soccer25');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Women''s Soccer62', 'Women''s Soccer26');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Women''s Soccer28', 'Women''s Soccer56', 'Women''s Soccer56', 56, 56, 56, 'Women''s Soccer56');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Women''s Soccer27', 'Women''s Soccer62', 'Women''s Soccer56', 56, 56, 56, 'Women''s Soccer56');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Women''s Soccer30', 'Women''s Soccer27', 'Women''s Soccer26', 'Women''s Soccer56', 'Women''s Soccer56', 56, 'Women''s Soccer56');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Women''s Soccer29', 'Women''s Soccer27', 'Women''s Soccer26', 'Women''s Soccer56', 'Women''s Soccer56', 56, 'Women''s Soccer56');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Women''s Soccer56', 'Women''s Soccer26', 'Women''s Soccer56', 56, 'Women''s Soccer56', 'Women''s Soccer56');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Women''s Soccer25', 'Women''s Soccer31', 33, 'Women''s Soccer41', 'Women''s Soccer42', 'Women''s Soccer43', 'Women''s Soccer44', 'Women''s Soccer45', 'Women''s Soccer63');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Women''s Soccer26', 'Women''s Soccer32', 34, 'Women''s Soccer46', 'Women''s Soccer47', 'Women''s Soccer48', 'Women''s Soccer49', 'Women''s Soccer50', 'Women''s Soccer63');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.phone FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event INNER JOIN member AS T3 ON T2.link_to_member = T3.member_id WHERE T1.event_name = 'Women''s Soccer';

/*
Gold Result:
("Women's Soccer63",)
("Women's Soccer63",)
*/

-- Prediction Query
SELECT DISTINCT T3.phone FROM event AS T1 JOIN attendance AS T2 ON T1.event_id = T2.link_to_event JOIN member AS T3 ON T2.link_to_member = T3.member_id WHERE T1.event_name = 'Women''s Soccer';

/*
Prediction Result:
("Women's Soccer63",)
*/