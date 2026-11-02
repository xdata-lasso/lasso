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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('bag', 'Scott Pierce', 'apply', 'reach', 'Structure why unit support coach magazine degree.', '60647 Henderson Street
Mooreport, IL 08166', 'particularly');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('back', 'Katie Anderson', 'happy', 'upon', 'These hard citizen street.', '841 Joseph Coves
West Juan, IL 94559', 'gun');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('simply', 'Nicole Brown', 'pattern', 'me');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Democrat', 'Sarah Wagner', 'enter', 'western');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1016, 'morning', 'North Susan', 'be', 'Idaho', 'California');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1021, 'whatever', 'North Cynthiaview', 'another', 'Alabama', 'Michigan');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('physical', 'author', 1017.5, 1018.5, 1019, 'Republican', 'bag');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('spend', 'case', 1022.5, 1023.5, 1024, 'public', 'back');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('training', 'Joe', 'Wilson', 'bethwilliams@example.org', 'kind', 'really', '001-898-454-3534', 1016, 'simply');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('everybody', 'Evan', 'Ramos', 'hhoffman@example.org', 'you', 'use', '001-728-205-9826x204', 1021, 'Democrat');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('remain', 'Lead upon very act perform.', 'order', 1020.5, 'black', 'training', 'physical');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('way', 'Decide economic bill sister this image.', 'pressure', NULL, 'so', 'everybody', 'spend');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T1.cost) FROM expense AS T1 INNER JOIN member AS T2 ON T1.link_to_member = T2.member_id WHERE T2.position <> 'Member';

/*
Gold Result:
(1020.5,)
*/

-- Prediction Query
SELECT CAST(SUM(e.cost) AS REAL) / COUNT(*) AS average_amount_paid FROM expense AS e INNER JOIN member AS m ON e.link_to_member = m.member_id WHERE m.position <> 'Member';

/*
Prediction Result:
(510.25,)
*/