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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('yourself', 'Randy Conley', 'table', 'left', 'Wide particular sell six doctor.', '986 Carpenter Turnpike
South Reginashire, SD 25173', 'religious');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('prepare', 'Jeffrey Morales', 'build', 'western', 'Check service away week physical less nor often.', '207 Lisa Villages Suite 182
East Jasminemouth, NC 69018', 'land');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('magazine', 'Seth Reese', 'nice', 'stand', 'Poor worry follow wife firm key light.', '4665 Kristina Rue Suite 151
Mitchellberg, MA 11183', 'movie');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('theory', 'Richard Jones', 'Mrs', 'happy', 'Field ever argue medical financial later arm story.', '4629 Kyle Lane
Lisahaven, CO 85176', 'high');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('bank', 'Heidi Kim', 'property', 'daughter', 'Road standard spring door chair culture.', '7826 Stacey Forges
Wilkersontown, MT 07481', 'bed');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('find', 'Amanda Rogers', 'weight', 'animal', 'Finally speak light strong happy.', '61530 Galvan Villages Suite 220
Samanthafort, UT 18692', 'need');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('three', 'Bonnie Bennett', 'company', 'item', 'Worker left example high month whom stage.', '9010 Lewis Drive Suite 143
Davidbury, MT 84249', 'herself');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('story', 'Ronald Wise', 'set', 'his', 'Catch economic political them never bill suffer surface.', '17980 Jennifer Highway Suite 095
New Robert, TN 88085', 'author');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('affect', 'once', 1145.5, 1149.5, 2186.0, 'many', 'yourself');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('him', 'growth', 1140.5, 1146.5, 2166.0, 'draw', 'yourself');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('for', 'space', 1147.5, 1155.5, 2156.0, 'certain', 'yourself');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('couple', 'mention', 1154.5, 1164.5, 2146.0, 'clear', 'yourself');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('never', 'difficult', 1133.5, 1137.5, 2186.0, 'dark', 'bank');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('off', 'again', 1152.5, 1158.5, 2076.0, 'prove', 'bank');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('movement', 'in', 1159.5, 1167.5, 2066.0, 'impact', 'bank');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('stop', 'TV', 1166.5, 1176.5, 2056.0, 'hour', 'bank');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.event_name FROM budget AS T1 INNER JOIN event AS T2 ON T1.link_to_event = T2.event_id ORDER BY T1.amount DESC, T1.budget_id NULLS LAST, T2.event_id NULLS LAST LIMIT 1;

/*
Gold Result:
('Randy Conley',)
*/

-- Prediction Query
SELECT e.event_name FROM event AS e JOIN budget AS b ON e.event_id = b.link_to_event ORDER BY b.amount DESC, e.event_id NULLS LAST, b.budget_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Heidi Kim',)
*/