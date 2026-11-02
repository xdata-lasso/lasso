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
-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__a4aa73', '5k5swwqcgs', '9n8', 'Meeting', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('C', 'c4ecigce', '76nium52', 'Meeting', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr', '13pyu', '8d99rljsl');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('G', 'd2', 'vy9uxj4', 'Meeting', 'wb', 'v', 'ph2');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__0ff3f6', 'ogrgjd8y', 't1afgog', 'itsj3', 'y', 'p1q430', 'jh3den8');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('K', 'October Meeting', '5k5swwqcgs', 'Meeting', '9n8', '4', 'gu7v');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('@', 'Yearly Kickoff', 'uzhsrwbbp6lu', 'Meeting', 'hvdlttilbnpr', 'dpos', 'ie5');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('`', 'gce376nium52', 'zbuo4nrqrof', NULL, 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('B', 'ji7zwau2', 'dwyrq13pyu78', 't2__b49f8b', '9', 'rljsl0b4y', 'p5qi2rkf9v');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('D', 'd2', 'vy9uxj4', NULL, 'wb', 'v', 'ph2');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('F', 'cprj', 'u0dz7', 'Meeting', 'fjgq8n2f3', 'dqv0gcb98ozk', 'zbilyrkn');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('E', 'q7x', '7', 't2__b49f8b', '2fxa7ryfdrz', '16nijjai5dh', 'ogrgjd8y');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('%', 'itsj3', 'y', NULL, 'p1q430', 'jh3den8', 'c68x8vacx7');

-- Inserting into table: budget --
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_1', 'Advertisement', 779.409124, 640.719621, 1160656988, 'ia2yp', 't1__a4aa73');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_2', 'Advertisement', 718.397869, 324.940703, -1670923962, 'rwbbp6luhvd', 't1__a4aa73');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_3', 'Advertisement', 179.378884, 304.02808, -1364429300, 'nprmdposii', 't1__a4aa73');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_4', 'Advertisement', 75.403642, 327.753528, -1209887326, 'klfa9000t', 't1__a4aa73');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_5', 'Advertisement', 419.361606, 470.165282, 1692174491, 'qi2rkf9v', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_6', 'Advertisement', 263.638479, 778.01524, 556727997, '8pz0f8je', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_7', 'Advertisement', 109.083092, 802.414724, 1968874827, 'nqcx5h', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_8', 'Advertisement', 210.05299, 866.804244, -988981234, 'u0dz7', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('_', 'Advertisement', 552.472052, 593.552739, -1485777725, '8n2f3', 't1__a4aa73');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('A', 'Advertisement', 687.701166, 656.638403, 513454646, '0gcb98', 't1__a4aa73');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('?', 'Advertisement', 221.227801, 401.142827, -1454058168, 'bilyrkn', 't1__a4aa73');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('O', 'Advertisement', 692.775559, 339.789525, 1784916884, 'ah0f8jsww', 't1__a4aa73');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_13', 't1__7563df', 176.824244, 842.831917, -566887085, '72fxa7ryfd', 't1__a4aa73');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_14', 'Advertisement', 276.61064, 399.319982, 564390026, '6nijjai5dh', 't1__a4aa73');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_15', 'Advertisement', 596.764785, 46.611179, 195720193, 'vacx7afu5', 't1__a4aa73');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_16', 'Advertisement', 354.593207, 432.405958, 76996700, 'o72ctdc', 't1__a4aa73');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_17', 'Advertisement', 803.582738, 695.452114, -1284905200, '62', 't1__a4aa73');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_18', 'Advertisement', 93.813527, 935.463334, 820970595, 'qdjpe1io2', 't1__a4aa73');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('@', 'Advertisement', 86.520366, 65.761562, 1160656988, 'ia2yp', 'K');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('`', 'Advertisement', 327.753528, 218.301157, -1399556171, 'a9000t5c4eci', '@');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('a', 'Advertisement', 111.926013, 731.301441, 1178636309, 'ex1', '`');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('D', 't1__7563df', 263.638479, 778.01524, 556727997, '8pz0f8je', 'B');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('B', 't1__7563df', 109.083092, 802.414724, 1968874827, 'nqcx5h', 'D');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('C', NULL, 692.775559, 339.789525, 1784916884, 'ah0f8jsww', 'F');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('F', NULL, 763.019095, 308.482994, 1250290042, 'og', 'E');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('H', NULL, 854.793228, 983.924121, -47052816, '1of77pzo72c', '%');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN T2.event_name = 'Yearly Kickoff' THEN T1.amount ELSE 0 END) AS REAL) / SUM(CASE WHEN T2.event_name = 'October Meeting' THEN T1.amount ELSE 0 END) FROM budget AS T1 INNER JOIN event AS T2 ON T1.link_to_event = T2.event_id WHERE T1.category = 'Advertisement' AND T2.type = 'Meeting';

/*
Gold Result:
(-1.205830995263865,)
*/

-- Prediction Query
SELECT SUM(CASE WHEN "event"."event_name" = 'Yearly Kickoff' THEN "budget"."amount" ELSE 0 END) / SUM(CASE WHEN "event"."event_name" = 'October Meeting' THEN "budget"."amount" ELSE 0 END) FROM "budget" INNER JOIN "event" ON "budget"."link_to_event" = "event"."event_id" WHERE "budget"."category" = 'Advertisement';

/*
Prediction Result:
(-1,)
*/