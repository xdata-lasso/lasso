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
-- Inserting into table: member --
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_1', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr', -2147483648, 'major_id_1');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__e147a9', 'October Meeting', '2019-10-08', '5k5swwqcgs', '9n8', '4', 'gu7v');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__cf7700', 'October Meeting', '2019-10-08', 'yp5qi2rk', '9v', 'x58pz', 'f8jegd2');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('O', 'October Meeting', '2019-10-08', 'k3zbily', 'kn6vc', '6ah', 'f8jswwl');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', '7xb72', 'xa', '7ryfdrz16n', 'jja', '5dh', 'ogrgjd8y');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__c2c9e2', 'October Meeting', '2019-10-08', '7p2r94gth2m', 'ajjl', '3', 'okv8uttmu2');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('@', 'October Meeting', NULL, '5k5swwqcgs', '9n8', '4', 'gu7v');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('B', 'October Meeting', NULL, '5u', 'w6kl', 'a9', '00t5c4e');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('!', 'October Meeting', NULL, 'liqa1', 'ryytoo3', '9hl7', 'klex14ji');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('H', 'October Meeting', NULL, 'x58pz', 'f8jegd2', 'vy9uxj4', 'wb');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('I', 'October Meeting', NULL, 'qv0gcb98ozk', 'zbilyrkn', '6vck6ah0f8js', 'wlq7xb');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('C', 'October Meeting', NULL, 'ri', 'tsj3ayxp1q4', '01jh3den', 'c68x8vacx');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('"', 'October Meeting', NULL, 'ou5z', '36c', 'bfkfoacd', '7z2zezj');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('`', 'October Meeting', NULL, 'ajjl', '3', 'okv8uttmu2', 'e578');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', 'uzhsrwbbp6lu', 'hvdlttilbnpr', 'dpos');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'ie5', 'nw6klf', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof');

-- Inserting into table: budget --
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t2__f0346e', 'e4', 779.409124, 640.719621, 1160656988, 'ia2yp', 't1__e147a9');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t2__7735e2', 'vy9uxj4', 124.573829, 22.63964, -736979194, 'h2gn', 't1__e147a9');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('O', 'sj3ay', 360.694313, 959.196496, 1792827279, '4301jh3den8', 't1__e147a9');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('A', '68x8vacx7a', 983.924121, 313.653498, -47052816, '1of77pzo72c', 't1__e147a9');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('_', '07cvtjpt', 605.666938, 107.390057, 1467355421, 'ou5z', 't1__e147a9');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t3__5a26d2', 'yvkv42q7sx58', 682.232894, 476.006677, 681598285, 'aus3', 't1__e147a9');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('G', '9mo7', 417.509954, 858.19408, 238533676, 'jxfofws', 't2__c2c9e2');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('@', 'e4', 779.409124, 640.719621, 1160656988, 'ia2yp', '@');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('C', 'cigce376nium', 779.28645, 566.030342, 742285925, 'u', 'B');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('B', '7zwau2dwyr', 262.105498, 591.461096, 2142703426, 'u78d99r', '!');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('D', 'v', 185.427628, 243.480613, 1581736075, 'gndqwnqc', 'H');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('`', '72fxa7ryfd', 276.61064, 399.319982, 564390026, '6nijjai5dh', 'I');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('F', 'afu5w1of7', 517.927187, 398.637058, 1992637800, 'dctmf', 'C');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('H', '7wgx', 50.798088, 486.564401, -915385605, 'm', '"');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('K', 'fvy', 392.947196, 527.633597, -451030047, 'be8yvkv42q7', '`');

-- Inserting into table: expense --
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_1', '13pyu', '8d99rljsl', 419.361606, 't3__799bd4', 'member_id_1', 't2__f0346e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('A', 'wnqcx', '5hncprjtu0d', 395.809081, 't3__799bd4', 'member_id_1', 't2__f0346e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('C', 'gq8', 'n2f3dqv0gcb9', 540.154414, 't3__799bd4', 'member_id_1', 't2__f0346e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_4', '1afgo', 'ri', 630.468925, 't3__799bd4', 'member_id_1', 't2__f0346e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_5', 'c', 'mfg62', 93.813527, 't3__799bd4', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_6', 'q8qdjpe1', 'o22', 518.274259, 't3__799bd4', 'member_id_1', 't2__f0346e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_7', '6c4bfkfo', 'c', 60.937725, 't3__799bd4', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_8', '7z2zezjo7wg', 'd5ysxc', 187.71278, 't3__799bd4', 'member_id_1', 't2__f0346e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_9', '0oztdgj5i3lq', '5lnpim5k58qs', 876.038555, 't3__799bd4', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_10', '57', 'lfvyz7zzb', 70.267562, 't3__799bd4', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('Q', 'vmkrpd', 'wzw', 487.079129, 't3__799bd4', 'member_id_1', 't3__5a26d2');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_12', 'o', '2zobb0q0k32o', 57.929422, 't3__799bd4', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('G', '5am', 'sorlwyngc1', 48.973066, 't3__799bd4', 'member_id_1', 't3__5a26d2');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_14', 'rhizgk1yoey', 'o6l0hdt6fu', 254.178165, 't3__799bd4', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('O', 'uzkb52', 'gwnlas6', 907.723998, 't3__799bd4', 'member_id_1', 't3__5a26d2');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_16', 'boeowii1z5nx', 'h66', 441.511648, 't3__799bd4', 'member_id_1', 't2__f0346e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_17', 'lyotow', 'oaawg96aq', 19.988339, 't3__799bd4', 'member_id_1', 't2__f0346e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_18', 'indz39tajz', 'td8n5wcgu', 203.071475, NULL, 'member_id_1', 't2__f0346e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('@', 'hsrwbbp', 'luhvdltti', 182.319045, 'nprmdposii', 'member_id_1', '@');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('D', 'nrqrofqy', '5s5b', 22.720462, '02eu', 'member_id_1', 'C');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('E', 'sl0', '4', 884.000446, 'p5qi2rkf9v', 'member_id_1', 'B');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('H', '5hncprjtu0d', '79fjgq8', 915.268032, '2f3d', 'member_id_1', 'D');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('B', 'grgj', '8', 740.059813, 'zt1afgo', 'member_id_1', '`');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('`', '2g0v5q8qd', 'jpe1io22785', 993.555996, '7cvtjpttg6b', 'member_id_1', 'F');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('a', '0oztdgj5i3lq', '5lnpim5k58qs', 876.038555, '7p2r94gth2m', 'member_id_1', 'H');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('F', '58b4pm', 'u', 771.198983, 'auvmkrpd', 'member_id_1', 'K');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.approved FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget WHERE T1.event_name = 'October Meeting' AND T1.event_date LIKE '2019-10-08%';

/*
Gold Result:
('t3__799bd4',)
('t3__799bd4',)
('t3__799bd4',)
('t3__799bd4',)
('t3__799bd4',)
('t3__799bd4',)
('t3__799bd4',)
('t3__799bd4',)
('t3__799bd4',)
('t3__799bd4',)
('t3__799bd4',)
('t3__799bd4',)
('t3__799bd4',)
('t3__799bd4',)
('t3__799bd4',)
('t3__799bd4',)
('t3__799bd4',)
(None,)
*/

-- Prediction Query
SELECT "expense"."expense_description", CASE WHEN "expense"."approved" = 'true' THEN 'Yes' ELSE 'No' END AS "approved" FROM "expense" INNER JOIN "budget" ON "expense"."link_to_budget" = "budget"."budget_id" INNER JOIN "event" ON "budget"."link_to_event" = "event"."event_id" WHERE "event"."event_name" = 'October Meeting' AND "expense"."expense_date" = '2019-10-08';

/*
Prediction Result:
*/