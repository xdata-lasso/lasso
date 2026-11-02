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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('tell', 'Susan Brooks', 'machine', 'expect', 'Stay or focus early various everything.', '34352 Smith Place Apt. 400
Heidiberg, SC 99170', 'prove');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('measure', 'Bobby Franklin', 'beyond', 'matter', 'Speech news only no form business.', '4599 Nicole Drives
Port Christine, TX 11194', 'probably');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('item', 'Bethany Calderon', 'concern', 'window', 'Prepare short indicate police marriage.', '7974 Melanie Meadows
West Jessica, WV 53356', 'former');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('full', 'Matthew Morales DDS', 'air', 'address');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('floor', 'Andrew Wood', 'race', 'poor');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('set', 'Melissa Burns', 'or', 'apply');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1041, 'main', 'Williamview', 'receive', 'Ohio', 'Iowa');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1081, 'area', 'Mitchellberg', 'couple', 'Florida', 'South Carolina');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1121, 'accept', 'Santosport', 'without', 'Louisiana', 'Nevada');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('structure', 'performance', 10, 1057.5, 1065, 'whether', 'tell');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('serve', 'none', 100, 1097.5, 1105, 'own', 'measure');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('way', 'article', 50, 1137.5, 1145, 'individual', 'item');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('clear', 'Raymond', 'Freeman', 'hodgesjane@example.org', 'research', 'purpose', '213.969.5944x0640', 1041, 'full');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('color', 'Raymond', 'Freeman', 'joe15@example.org', 'student', 'picture', '(446)309-5396', 1081, 'floor');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('school', 'Justin', 'West', 'whiteamanda@example.net', 'election', 'team', '(483)864-4089', 1121, 'set');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('eat', 'Art every why we station begin.', 'most', 1073.5, 'trial', 'clear', 'structure');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('character', 'We allow check last he know.', 'chair', 1113.5, 'manage', 'color', 'serve');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('deal', 'Either start whom politics make collection.', 'entire', 1153.5, 'other', 'school', 'way');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.first_name, T3.last_name FROM expense AS T1 INNER JOIN budget AS T2 ON T1.link_to_budget = T2.budget_id INNER JOIN member AS T3 ON T1.link_to_member = T3.member_id ORDER BY T2.spent DESC, T1.expense_id NULLS LAST, T2.budget_id NULLS LAST, T3.member_id NULLS LAST LIMIT 5;

/*
Gold Result:
('Raymond', 'Freeman')
('Justin', 'West')
('Raymond', 'Freeman')
*/

-- Prediction Query
SELECT T1.first_name, T1.last_name FROM member AS T1 INNER JOIN expense AS T2 ON T1.member_id = T2.link_to_member GROUP BY T1.member_id ORDER BY SUM(T2.cost) DESC, T1.first_name NULLS LAST, T1.last_name NULLS LAST LIMIT 5;

/*
Prediction Result:
('Justin', 'West')
('Raymond', 'Freeman')
('Raymond', 'Freeman')
*/