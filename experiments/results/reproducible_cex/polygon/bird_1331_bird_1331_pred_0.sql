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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Vice President19', 'Vice President44', 'Vice President44', 'Vice President44', 'Vice President44', 'Vice President44', 'Vice President44');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Vice President18', 'Vice President44', 'Vice President44', 'Vice President44', 'Vice President44', 'Vice President44', 'Vice President44');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Vice President20', 'Vice President44', 'Vice President44', 'Vice President44');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Vice President36', 'Vice President44', 'Vice President44', 'Vice President44');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (37, 'Vice President44', 'Vice President44', 'Vice President44', 'Vice President44', 'Vice President44');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Vice President19', 'Vice President44');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Vice President18', 'Vice President44');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Vice President21', 'Vice President18', 'Vice President44', 44, 44, 44, 'Vice President44');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Vice President44', 'Vice President21', 'Vice President44', 'Vice President44', 'Vice President44', 44, 'Vice President44');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Vice President31', 'Vice President32', 'Vice President33', 0, 'Vice President34', 'Vice President35');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Vice President43', 'Vice President44', 'Vice President45', 0, 'Vice President46', 'Vice President47');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Vice President32', 'Vice President36', 37, 'Vice President26', 'Vice President27', 'Vice President28', 'Vice President', 'Vice President29', 'Vice President30');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Vice President44', 'Vice President36', 37, 'Vice President38', 'Vice President39', 'Vice President40', 'Vice President', 'Vice President41', 'Vice President42');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.amount FROM member AS T1 INNER JOIN income AS T2 ON T1.member_id = T2.link_to_member WHERE T1.position = 'Vice President';

/*
Gold Result:
(0,)
(0,)
*/

-- Prediction Query
SELECT SUM(T1.amount) FROM income AS T1 INNER JOIN member AS T2 ON T1.link_to_member = T2.member_id WHERE T2.position = 'Vice President';

/*
Prediction Result:
(0,)
*/