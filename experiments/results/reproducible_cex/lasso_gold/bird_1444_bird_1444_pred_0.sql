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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('clear', 'Cynthia Martin', 'such', 'talk', 'Thing agent say forward.', 'USNS Adams
FPO AP 14669', 'idea');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('simply', 'Nicole Brown', 'pattern', 'me');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Democrat', 'Sarah Wagner', 'enter', 'western');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('turn', 'John Gonzalez', 'why', 'magazine');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1013, 'morning', 'North Susan', 'be', 'Idaho', 'California');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1017, 'whatever', 'North Cynthiaview', 'another', 'Alabama', 'Michigan');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1021, 'hard', 'Loribury', 'dog', 'Alaska', 'Texas');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('physical', 'author', 1014.5, 1015.5, 1016, 'Republican', 'bag');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('spend', 'case', 1018.5, 1019.5, 1020, 'public', 'back');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('data', 'inside', 1022.5, 1023.5, 1024, 'get', 'clear');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('training', 'Joe', 'Wilson', 'bethwilliams@example.org', 'kind', 'really', '001-898-454-3534', 1013, 'simply');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('everybody', 'Evan', 'Ramos', 'hhoffman@example.org', 'you', 'use', '001-728-205-9826x204', 1017, 'Democrat');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('family', 'Michelle', 'Rasmussen', 'michael86@example.net', 'threat', 'not', '301-842-9401x96556', 1021, 'turn');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('remain', 'Lead upon very act perform.', 'order', 51.0, 'black', 'training', 'physical');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('way', 'Decide economic bill sister this image.', 'pressure', NULL, 'so', 'everybody', 'spend');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('we', 'Decide economic bill sister this image.', 'part', 51.0, 'customer', 'family', 'data');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('environmental', 'Lead upon very act perform.', 'order', NULL, 'black', 'training', 'physical');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT expense_description FROM expense GROUP BY expense_description HAVING AVG(cost) > 50;

/*
Gold Result:
('Decide economic bill sister this image.',)
('Lead upon very act perform.',)
*/

-- Prediction Query
SELECT expense_description FROM expense GROUP BY expense_description HAVING SUM(cost) / COUNT(expense_id) > 50;

/*
Prediction Result:
*/