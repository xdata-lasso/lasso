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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('thus', 'Vicki Sutton', 'sometimes', 'my', 'Land condition we process.', 'Unit 7503 Box 7314
DPO AA 31174', 'and');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('boy', 'Joseph Blankenship', 'return', 'kind', 'Painting concern top outside.', '72980 Boyd Land
Lake Alyssabury, AS 63693', 'strategy');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('relate', 'Terry Ward', 'manager', 'whose');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('specific', 'Kevin Figueroa', 'sort', 'third');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1310, 'look', 'North Tinamouth', 'board', 'Virginia', 'North Dakota');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1320, 'same', 'South Dennisfort', 'space', 'Iowa', 'Colorado');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('property', 'themselves', 1311.5, 1312.5, 1313, 'eye', 'thus');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('piece', 'under', 1321.5, 1322.5, 1323, 'of', 'boy');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('they', 'Judy', 'Lane', 'nicholasgray@example.net', 'ready', 'water', '984-963-8655', 1310, 'relate');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('issue', 'Jonathan', 'Smith', 'lanedavid@example.org', 'how', 'real', '656.851.2694', 1320, 'specific');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('federal', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('very', 'Water, chips, cookies', 'PM', 1314.5, 'according', 'they', 'property');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('human', 'Water, chips, cookies', 'image', 1319.5, 'cause', 'federal', 'property');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('other', 'Water, chips, cookies', 'history', 1324.5, 'population', 'issue', 'piece');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.budget_id FROM expense AS T1 INNER JOIN budget AS T2 ON T1.link_to_budget = T2.budget_id WHERE T1.expense_description = 'Water, chips, cookies' ORDER BY T1.cost DESC, T1.expense_id NULLS LAST, T2.budget_id NULLS LAST LIMIT 1;

/*
Gold Result:
('piece',)
*/

-- Prediction Query
SELECT budget.budget_id FROM budget INNER JOIN expense ON budget.budget_id = expense.link_to_budget WHERE expense.expense_description = 'Water, chips, cookies' GROUP BY budget.budget_id ORDER BY SUM(expense.cost) DESC, budget.budget_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('property',)
*/