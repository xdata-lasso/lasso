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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('purpose', 'Danielle Taylor', 'early', 'agreement', 'Information last everything thank serve civil institution.', '310 Kendra Common Apt. 164
Reidstad, GA 49021', 'benefit');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('brother', 'Patrick Gardner', 'mouth', 'option', 'Choice whatever from behavior benefit.', '192 Frank Light Suite 835
East Lydiamouth, MO 35594', 'someone');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('ago', 'Amanda Davis', 'play', 'decide', 'Page southern role movie win her.', '76724 John Points Suite 969
Coxberg, NY 65187', 'anyone');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('traditional', 'Rebecca Henderson', 'activity', 'building');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('break', 'James Ferrell', 'response', 'rest');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('claim', 'Tricia Valencia', 'set', 'value');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1001, 'not', 'Danielchester', 'movement', 'South Dakota', 'Rhode Island');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1002, 'social', 'South Aaron', 'while', 'Maryland', 'Illinois');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1003, 'example', 'Teresaburgh', 'born', 'North Carolina', 'Georgia');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('hour', 'notice', 1004.5, 1007.5, 1010, 'nice', 'purpose');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('sound', 'start', 1011.5, 1016.5, 1021.0, 'why', 'purpose');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('color', 'win', 1018.5, 1025.5, 1032.0, 'a', 'purpose');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('place', 'after', 1013.5, 1016.5, 1019, 'unit', 'purpose');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('game', 'woman', 1020.5, 1025.5, 1030.0, 'theory', 'purpose');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('middle', 'him', 1027.5, 1034.5, 1041.0, 'surface', 'purpose');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('food', 'John', 'Dennis', 'davidalvarez@example.net', 'deep', 'inside', '(578)571-3315x098', 1001, 'traditional');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('education', 'Ashley', 'Cabrera', 'josephbrennan@example.com', 'sell', 'remain', '5106310518', 1001, 'traditional');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('article', 'Christian', 'Spence', 'sarahcampos@example.net', 'forget', 'rate', '+1-873-782-9973x76311', 1001, 'traditional');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('land', 'Michelle', 'Lucas', 'wrightjames@example.com', 'billion', 'now', '432-867-7360', 1001, 'traditional');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('item', 'Brian', 'Brown', 'robertramirez@example.org', 'apply', 'think', '5646746872', 1001, 'traditional');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('manage', 'Denise', 'Chandler', 'ramosmichelle@example.net', 'reach', 'administration', '909.480.5009', 1001, 'traditional');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('art', 'Attention attack technology identify.', 'lot', 1029.5, 'would', 'food', 'hour');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('movie', 'East organization people information on mission various.', 'four', 1031.5, 'baby', 'food', 'hour');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('be', 'Prove fire enter capital population.', 'society', 1033.5, 'act', 'food', 'hour');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('low', 'Available defense enter value.', 'firm', 1025.5, 'body', 'land', 'place');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('pretty', 'These hard citizen street.', 'work', 1034.5, 'wrong', 'land', 'place');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('order', 'Particularly would pressure account stage.', 'record', 1043.5, 'center', 'land', 'place');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.first_name, T3.last_name, T3.phone FROM expense AS T1 INNER JOIN budget AS T2 ON T1.link_to_budget = T2.budget_id INNER JOIN member AS T3 ON T3.member_id = T1.link_to_member WHERE T1.cost > (SELECT AVG(T1.cost) FROM expense AS T1 INNER JOIN budget AS T2 ON T1.link_to_budget = T2.budget_id INNER JOIN member AS T3 ON T3.member_id = T1.link_to_member);

/*
Gold Result:
('John', 'Dennis', '(578)571-3315x098')
('Michelle', 'Lucas', '432-867-7360')
*/

-- Prediction Query
SELECT T2.first_name, T2.last_name, T2.phone FROM expense AS T1 INNER JOIN member AS T2 ON T1.link_to_member = T2.member_id WHERE T1.cost > (SELECT AVG(cost) FROM expense);

/*
Prediction Result:
('John', 'Dennis', '(578)571-3315x098')
('Michelle', 'Lucas', '432-867-7360')
('Michelle', 'Lucas', '432-867-7360')
*/