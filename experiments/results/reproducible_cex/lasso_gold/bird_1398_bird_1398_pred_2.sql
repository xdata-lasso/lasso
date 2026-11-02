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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('shake', 'James Hunter', 'specific', 'yeah', 'Produce beat peace something require bank child Republican.', '757 Samuel Square
Floresport, AZ 93664', 'why');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('bar', 'Gina Mack', 'drive', 'how', 'Science first blood accept.', '54379 Stephen Dale Suite 065
Brockmouth, NV 44375', 'money');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('month', 'Jennifer Ayala', 'heart', 'lay', 'Know seven bill beautiful issue.', '5937 Thompson Locks
Kellyfort, OK 32276', 'chair');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('skill', 'Donald Riddle', 'on', 'cultural', 'Never impact ago government behavior our foot.', '5193 Erin Plaza Apt. 737
Marieland, GU 54128', 'property');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('huge', 'Amy Kim', 'military', 'hear', 'None population position.', '6183 Gina Extension Apt. 444
Thomasburgh, NE 36671', 'report');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('back', 'Melissa Stephens', 'energy', 'compare', 'Whole involve action else member million.', '123 Andrea Isle Suite 736
East Danielle, NE 52350', 'possible');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('list', 'Heather Woodard', 'really', 'radio', 'Reach determine hear leg quickly real character young.', '9660 Jamie Terrace
New Cristianside, HI 48446', 'performance');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('piece', 'Margaret Miller', 'red', 'position', 'Bit indeed which break wait center find.', '47859 Carr Radial Apt. 557
Port Emily, AS 39487', 'become');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('floor', 'Advertisement', 2286.5, 1269.5, 1273, 'edge', 'shake');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('effort', 'Advertisement', 2266.5, 1266.5, 1272.0, 'senior', 'shake');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('entire', 'Advertisement', 2256.5, 1275.5, 1283.0, 'land', 'shake');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('reason', 'Advertisement', 2246.5, 1284.5, 1294.0, 'strategy', 'shake');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('remember', 'Advertisement', 2286.5, 1257.5, 1261, 'class', 'huge');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('center', 'Advertisement', 2176.5, 1278.5, 1284.0, 'focus', 'huge');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('form', 'Advertisement', 2166.5, 1287.5, 1295.0, 'but', 'huge');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('buy', 'Advertisement', 2156.5, 1296.5, 1306.0, 'cover', 'huge');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.event_name FROM budget AS T1 INNER JOIN event AS T2 ON T1.link_to_event = T2.event_id WHERE T1.category = 'Advertisement' ORDER BY T1.spent DESC, T1.budget_id NULLS LAST, T2.event_id NULLS LAST LIMIT 1;

/*
Gold Result:
('James Hunter',)
*/

-- Prediction Query
SELECT e.event_name FROM event AS e JOIN budget AS b ON e.event_id = b.link_to_event WHERE b.category = 'Advertisement' ORDER BY b.spent DESC, e.event_id NULLS LAST, b.budget_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Amy Kim',)
*/