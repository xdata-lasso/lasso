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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Laugh Out Loud23', 'Laugh Out Loud22', 'Laugh Out Loud22', 'Laugh Out Loud22', 'Laugh Out Loud22', 'Laugh Out Loud22', 'Laugh Out Loud22');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Laugh Out Loud22', 'Laugh Out Loud', 'Laugh Out Loud34', 'Laugh Out Loud35', 'Laugh Out Loud36', 'Laugh Out Loud37', 'Laugh Out Loud38');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Laugh Out Loud39', 'Laugh Out Loud22', 'Laugh Out Loud22', 'Laugh Out Loud22');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Laugh Out Loud48', 'Laugh Out Loud22', 'Laugh Out Loud22', 'Laugh Out Loud22');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (49, 'Laugh Out Loud22', 'Laugh Out Loud22', 'Laugh Out Loud22', 'Laugh Out Loud22', 'Laugh Out Loud22');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Laugh Out Loud22', 'Laugh Out Loud47');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Laugh Out Loud22', 'Laugh Out Loud54');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Laugh Out Loud25', NULL, 'Laugh Out Loud22', 22, 22, 22, 'Laugh Out Loud22');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Laugh Out Loud24', 'Laugh Out Loud22', 'Laugh Out Loud22', 22, 22, 22, 'Laugh Out Loud22');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Laugh Out Loud22', NULL, 'Laugh Out Loud54', 'Laugh Out Loud22', 'Laugh Out Loud22', 22, 'Laugh Out Loud22');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Laugh Out Loud27', 'Laugh Out Loud47', 'Laugh Out Loud22', 22, 'Laugh Out Loud22', 'Laugh Out Loud22');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Laugh Out Loud26', 'Laugh Out Loud54', 'Laugh Out Loud22', 22, 'Laugh Out Loud22', 'Laugh Out Loud22');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Laugh Out Loud47', 'Laugh Out Loud39', NULL, 'Laugh Out Loud41', 'Laugh Out Loud42', 'Laugh Out Loud43', 'Laugh Out Loud44', 'Laugh Out Loud45', 'Laugh Out Loud46');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Laugh Out Loud54', 'Laugh Out Loud48', 49, 'Laugh Out Loud41', 'Laugh Out Loud42', 'Laugh Out Loud50', 'Laugh Out Loud51', 'Laugh Out Loud52', 'Laugh Out Loud53');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.first_name, T1.last_name FROM member AS T1 INNER JOIN attendance AS T2 ON T1.member_id = T2.link_to_member INNER JOIN event AS T3 ON T2.link_to_event = T3.event_id WHERE T3.event_name = 'Laugh Out Loud';

/*
Gold Result:
('Laugh Out Loud41', 'Laugh Out Loud42')
('Laugh Out Loud41', 'Laugh Out Loud42')
*/

-- Prediction Query
SELECT DISTINCT member.first_name, member.last_name FROM member INNER JOIN attendance ON member.member_id = attendance.link_to_member INNER JOIN event ON attendance.link_to_event = event.event_id WHERE event.event_name = 'Laugh Out Loud';

/*
Prediction Result:
('Laugh Out Loud41', 'Laugh Out Loud42')
*/