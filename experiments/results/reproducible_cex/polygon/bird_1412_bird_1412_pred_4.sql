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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('X-Large18', 'X-Large41', 'X-Large41', 'X-Large41', 'X-Large41', 'X-Large41', 'X-Large41');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('X-Large17', 'X-Large41', 'X-Large41', 'X-Large41', 'X-Large41', 'X-Large41', 'X-Large41');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('X-Large32', 'X-Large41', 'X-Large41', 'X-Large41');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('X-Large19', 'X-Large41', 'X-Large41', 'X-Large41');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (33, 'X-Large41', 'X-Large41', 'X-Large41', 'X-Large41', 'X-Large41');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('X-Large18', 'X-Large41');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('X-Large17', 'X-Large20');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('X-Large28', 'X-Large18', 'X-Large41', 41, 41, 41, 'X-Large41');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('X-Large40', 'X-Large17', 'X-Large41', 41, 41, 41, 'X-Large41');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('X-Large27', 'X-Large28', 'X-Large41', 'X-Large45', 'X-Large29', 30, 'X-Large31');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('X-Large39', 'X-Large40', 'X-Large41', 'X-Large45', 'X-Large42', 43, 'X-Large44');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('X-Large22', 'X-Large20', 'X-Large41', 41, 'X-Large41', 'X-Large41');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('X-Large21', 'X-Large20', 'X-Large41', 41, 'X-Large41', 'X-Large41');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('X-Large41', 'X-Large32', 33, 'X-Large34', 'X-Large35', 'X-Large36', 'X-Large37', 'X-Large', 'X-Large38');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('X-Large20', 'X-Large19', 33, 'X-Large41', 'X-Large41', 'X-Large41', 'X-Large41', 'X-Large41', 'X-Large41');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.expense_description FROM member AS T1 INNER JOIN expense AS T2 ON T1.member_id = T2.link_to_member WHERE T1.t_shirt_size = 'X-Large';

/*
Gold Result:
('X-Large45',)
('X-Large45',)
*/

-- Prediction Query
SELECT DISTINCT expense.expense_description FROM expense INNER JOIN member ON expense.link_to_member = member.member_id WHERE member.t_shirt_size = 'X-Large';

/*
Prediction Result:
('X-Large45',)
*/