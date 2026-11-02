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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Member12', 'X-Large15', 'X-Large15', 'X-Large15', 'X-Large15', 'X-Large15', 'X-Large15');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('X-Large13', 'X-Large15', 'X-Large15', 'X-Large15');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('X-Large21', 'X-Large15', 'X-Large15', 'X-Large15');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (22, 'X-Large15', 'X-Large15', 'X-Large15', 'X-Large15', 'X-Large15');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Member12', 'X-Large15');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Member16', 'Member12', 'X-Large15', 15, 15, 15, 'X-Large15');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Member18', 'Member16', 'X-Large15', 'X-Large15', 'X-Large15', 15, 'X-Large15');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('X-Large17', 'Member16', 'X-Large15', 'X-Large15', 'X-Large15', 15, 'X-Large15');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Member20', 'X-Large15', 'X-Large15', 15, 'X-Large15', 'X-Large15');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('X-Large19', 'X-Large15', 'X-Large15', 15, 'X-Large15', 'X-Large15');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Member14', 'X-Large21', 22, 'X-Large23', 'Member24', 'X-Large25', 'Member', 'X-Large', 'Member26');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('X-Large15', NULL, NULL, 'X-Large15', 'X-Large15', 'X-Large15', NULL, NULL, 'X-Large15');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(member_id) FROM member WHERE position = 'Member' AND t_shirt_size = 'X-Large';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM member WHERE position = 'Member' AND t_shirt_size = 'X-Large';

/*
Prediction Result:
(1,)
*/