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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('health', 'Yearly Kickoff', 'land', 'item', 'Tell approach president position art rock song.', '87262 Ford Well
South Lindseyside, CT 07131', 'reach');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('phone', 'Yearly Kickoff', 'among', 'president', 'Information on mission various.', '46247 Hickman Cliffs Apt. 799
North Amandahaven, KS 17862', 'worker');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('act', 'Yearly Kickoff', 'brother', 'bag', 'Nation strong old challenge.', '0533 Michael Points Suite 923
Port Lisa, FM 54541', 'ago');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('now', 'Tracy House', 'time', 'economic');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('happy', 'Sherry Wood', 'coach', 'left');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('country', 'Evelyn Galvan', 'suffer', 'relationship');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1016, 'compare', 'Tuckerborough', 'treatment', 'Montana', 'Arkansas');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1021, 'these', 'Cherylhaven', 'across', 'Texas', 'Oklahoma');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1026, 'treat', 'West Erik', 'science', 'Connecticut', 'Missouri');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('community', 'hundred', 1017.5, 1018.5, 1019, 'able', 'health');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('firm', 'work', 1022.5, 1023.5, 1024, 'record', 'phone');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('turn', 'American', 1027.5, 1028.5, 1029, 'town', 'act');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('in', 'Joseph', 'Bowers', 'smitchell@example.net', 'step', 'only', '+1-972-434-3098x05009', 1016, 'now');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('body', 'Sheila', 'Taylor', 'prestonjulia@example.org', 'expert', 'father', '+1-235-234-8740x164', 1021, 'happy');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('many', 'Jeffrey', 'Velasquez', 'ybailey@example.org', 'dog', 'agent', '+1-636-454-1458x68501', 1026, 'country');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('art', 'Bag control organization push dog build three.', 'employee', 1020.5, 'particular', 'in', 'community');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('goal', 'Pm energy scientist necessary.', 'late', NULL, 'option', 'body', 'firm');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('partner', 'Although others generation skill job.', 'much', 1030.5, 'business', 'many', 'turn');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('image', 'Bag control organization push dog build three.', 'employee', NULL, 'particular', 'in', 'community');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(T3.cost) FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget WHERE T1.event_name = 'Yearly Kickoff';

/*
Gold Result:
(2051.0,)
*/

-- Prediction Query
SELECT SUM(cost) FROM expense WHERE link_to_budget IN (SELECT budget_id FROM budget WHERE link_to_event = (SELECT event_id FROM event WHERE event_name = 'Yearly Kickoff'));

/*
Prediction Result:
(1020.5,)
*/