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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Large19', 'Human Development and Family Studies41', 'Human Development and Family Studies41', 'Human Development and Family Studies41', 'Human Development and Family Studies41', 'Human Development and Family Studies41', 'Human Development and Family Studies41');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Human Development AND Family Studies18', 'Human Development and Family Studies41', 'Human Development and Family Studies41', 'Human Development and Family Studies41', 'Human Development and Family Studies41', 'Human Development and Family Studies41', 'Human Development and Family Studies41');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Human Development and Family Studies41', 'Human Development AND Family Studies', NULL, NULL);
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Human Development and Family Studies20', 'Human Development AND Family Studies', NULL, NULL);
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (21, 'Human Development and Family Studies41', 'Human Development and Family Studies41', 'Human Development and Family Studies41', 'Human Development and Family Studies41', 'Human Development and Family Studies41');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (29, 'Human Development and Family Studies41', 'Human Development and Family Studies41', 'Human Development and Family Studies41', 'Human Development and Family Studies41', 'Human Development and Family Studies41');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Human Development AND Family Studies18', 'Large22');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Human Development AND Family Studies24', 'Large19', 'Human Development and Family Studies41', 41, 41, 41, 'Human Development and Family Studies41');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Human Development and Family Studies23', 'Human Development AND Family Studies18', 'Human Development and Family Studies41', 41, 41, 41, 'Human Development and Family Studies41');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Human Development and Family Studies26', 'Human Development AND Family Studies24', 'Large22', 'Human Development and Family Studies41', 'Human Development and Family Studies41', 41, 'Human Development and Family Studies41');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Large28', 'Large22', 'Human Development and Family Studies41', 41, 'Human Development and Family Studies41', 'Human Development and Family Studies41');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Human Development AND Family Studies27', 'Large34', 'Human Development and Family Studies41', 41, 'Human Development and Family Studies41', 'Human Development and Family Studies41');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Large34', 'Human Development and Family Studies41', NULL, NULL, NULL, NULL, NULL, 'Large', NULL);
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Large22', 'Human Development and Family Studies20', 29, NULL, NULL, NULL, NULL, 'Large', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.member_id) FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id WHERE T2.major_name = 'Human Development AND Family Studies' AND T1.t_shirt_size = 'Large';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(T1.member_id) FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id WHERE T2.major_name = 'Human Development and Family Studies' AND T1.t_shirt_size = 'Large';

/*
Prediction Result:
(0,)
*/