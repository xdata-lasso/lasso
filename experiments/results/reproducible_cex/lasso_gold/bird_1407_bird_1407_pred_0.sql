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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('purpose', 'Noah Rhodes', 'save', 'source', 'Suggest page southern role movie win.', '05641 Robin Port
Jasonfort, MO 84760', 'someone');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('brother', 'Angie Henderson', 'knowledge', 'great', 'Bad fall pick those gun court.', '38849 Hurst Locks Suite 328
Daviston, VI 14872', 'show');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('ago', 'Daniel Wagner', 'grow', 'blue', 'Animal direction eye bag.', '691 James Mountain
Tashatown, TX 94967', 'road');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('site', 'Cristian Santos', 'fall', 'best', 'Term herself law street class.', '514 Moore Alley Suite 828
Port Colleenhaven, PA 26572', 'deep');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('face', 'Connie Lawrence', 'clearly', 'husband', 'Decide environment view possible participant commercial.', '809 Burns Creek
Natashaport, IA 08093', 'sell');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('election', 'Abigail Shaffer', 'dinner', 'bill', 'Clear here writer policy news.', '71822 Arroyo Expressway
Allisonchester, IL 71187', 'forget');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('inside', 'Advertisement', 1001.5, 1007.5, 1013, 'nation', 'purpose');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('remain', 'Advertisement', 1008.5, 1016.5, 1024.0, 'live', 'brother');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('rate', 'Advertisement', 1015.5, 1025.5, 1035.0, 'camera', 'ago');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('hour', 'Advertisement', 1022.5, 1034.5, 1046.0, 'end', 'site');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('left', 'Advertisement', 1029.5, 1043.5, 1057.0, 'down', 'face');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('we', 'Advertisement', 1036.5, 1052.5, 1068.0, 'attack', 'election');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT budget_id FROM budget WHERE category = 'Advertisement' ORDER BY amount DESC, budget.budget_id NULLS LAST LIMIT 3;

/*
Gold Result:
('we',)
('left',)
('hour',)
*/

-- Prediction Query
SELECT budget_id, amount FROM budget WHERE category = 'Advertising' ORDER BY amount DESC, budget.budget_id NULLS LAST LIMIT 3;

/*
Prediction Result:
*/