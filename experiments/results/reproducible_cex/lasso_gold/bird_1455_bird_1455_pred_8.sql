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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('purpose', 'Daniel Doyle', 'rate', 'discussion', 'Serve civil institution.', '16475 Mitchell Fords
Jacquelineland, PA 83728', 'building');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('brother', 'Stephanie Miller', 'science', 'list', 'Choice whatever from behavior benefit.', '76483 Cameron Trail
East Lydiamouth, MO 35594', 'rest');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('ago', 'Allen Robinson', 'offer', 'perform', 'Page southern role movie win her.', '76724 John Points Suite 969
Coxberg, NY 65187', 'value');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('site', 'Alyssa Gonzalez', 'kind', 'fall', 'Fall pick those gun court attorney product.', '22691 James Mountain
Tashatown, TX 94967', 'not');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('social', 'Edward Moore', 'movement', 'hour');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('example', 'Nathan Cortez', 'politics', 'sound');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('specific', 'Pamela Romero', 'decide', 'color');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('put', 'Mario Skinner', 'claim', 'notice');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1001, 'start', 'New Mariotown', 'soon', 'Florida', 'Hawaii');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1002, 'win', 'West Natashaport', 'no', 'Texas', 'Kentucky');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1003, 'nice', 'North John', 'space', 'New Mexico', 'North Dakota');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1004, 'why', 'North Jessicaland', 'car', 'Oklahoma', 'Rhode Island');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('land', 'show', 1005.5, 1009.5, 1013, 'forget', 'purpose');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('development', 'road', 1012.5, 1018.5, 1024.0, 'inside', 'purpose');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('woman', 'deep', 1019.5, 1027.5, 1035.0, 'remain', 'purpose');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('someone', 'sell', 1026.5, 1036.5, 1046.0, 'left', 'purpose');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('we', 'John', 'Chapman', 'whiteheadmichele@example.org', 'customer', 'lawyer', '001-801-406-5133x3872', 1001, 'social');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('nation', 'Caleb', 'Smith', 'joshuawashington@example.net', 'between', 'health', '473-817-8108x013', 1001, 'social');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('live', 'Andrew', 'Zimmerman', 'jenniferkhan@example.net', 'bill', 'item', '973.460.2606x4746', 1001, 'social');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('camera', 'Angela', 'Brown', 'esanchez@example.com', 'reason', 'manage', '243.909.8050', 1001, 'social');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('morning', 'Water, chips, cookies', 'art', 1017.5, 'cultural', 'we', 'land');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('wide', 'Water, chips, cookies', 'movie', 1026.5, 'authority', 'we', 'land');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('tonight', 'Water, chips, cookies', 'be', 1035.5, 'physical', 'we', 'land');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('coach', 'Water, chips, cookies', 'today', 1044.5, 'author', 'we', 'land');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.budget_id FROM expense AS T1 INNER JOIN budget AS T2 ON T1.link_to_budget = T2.budget_id WHERE T1.expense_description = 'Water, chips, cookies' ORDER BY T1.cost DESC, T1.expense_id NULLS LAST, T2.budget_id NULLS LAST LIMIT 1;

/*
Gold Result:
('land',)
*/

-- Prediction Query
SELECT expense_description FROM expense WHERE expense_description = 'Water, chips, cookies' ORDER BY cost DESC, expense.expense_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Water, chips, cookies',)
*/