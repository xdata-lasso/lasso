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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__f4c8b1', 'October Meeting', '5k5swwqcgs', 't1__b83691', '9n8', '4', 'gu7v');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', 'October Meeting', '9v', 't1__b83691', 'x58pz', 'f8jegd2', 'vy9uxj4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('C', 'October Meeting', 'wb', 't1__b83691', 'v', 'ph2', 'nd');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('_', '8j', 'wwlq7', 'xb72fxa7ryfd', 'z16ni', 'jai', 'dh5ogrgj');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('E', '07cvtjpt', 'tg6bnou5zi', '6c4bfkfo', 'c', '0', '7z2zezjo7wg');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Q', 'tmu2n', '57', 'lfvyz7zzb', '8y', 'kv42q7', 'x58b4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('I', '5amsorlwyngc', 'dj9erhi', 'zgk1yoeyo6l0', 'dt', 'fuqyxuzkb', '521gwnlas6e');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__19f2e1', 'October Meeting', '5wcg', 't1__b83691', 'mbc3td', 'u6bd0w9603', 'vzxw1rxe9y');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('!', 'October Meeting', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('G', 'October Meeting', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'bnp', 'mdpos');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('@', 'October Meeting', '9', 'rljsl0b4y', 'p5qi2rkf9v', 'x58pz', 'f8jegd2');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('O', 'October Meeting', 'vy9uxj4', 'wb', 'v', 'ph2', 'nd');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', 'uzhsrwbbp6lu', 'hvdlttilbnpr', 'dpos');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'ie5', 'nw6klf', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof');

-- Inserting into table: budget --
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t2__c38031', 'e4', 779.409124, 640.719621, 1160656988, 'ia2yp', 't1__f4c8b1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t2__8119f1', 'wnqcx', 668.309685, 635.267184, -1245312912, 'rjtu', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('A', 'jh3den8', 596.764785, 46.611179, 195720193, 'vacx7afu5', 't1__f4c8b1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('G', '1of77pzo72c', 308.935851, 37.950999, 481546706, 'g6', 'C');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('I', 'q5l', 811.930904, 236.262879, -1556979799, 'k58qs27p', '_');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('O', 'wzw5chn9mo70', 486.420817, 646.236852, -1245584612, 'xfo', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t3__72237b', '6dza35r', 968.215769, 191.353745, 2072023304, 'io18ri2hy08', 't1__f4c8b1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('K', 'ie5', 327.753528, 218.301157, -1399556171, 'a9000t5c4eci', '!');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('@', 'ce', 467.07027, 875.837169, -1585009206, '52zb', 'G');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('H', 'wnqcx', 668.309685, 635.267184, -1245312912, 'rjtu', '@');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('P', 'z', 521.610309, 654.674676, -1748371085, 'q8', 'I');

-- Inserting into table: expense --
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_1', '13pyu', '8d99rljsl', 419.361606, 'yp5qi2rk', 'member_id_1', 't2__c38031');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_2', 'z', '9fjgq8n2f', 456.127515, 'q', 'member_id_1', 't2__c38031');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_3', 'gcb98oz', '3zb', 138.057338, 'yrkn6vck6ah0', 'member_id_1', 't2__c38031');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_4', 'yzt1afgog', 'itsj3', 15.432127, 'xp1q430', 'member_id_1', 't2__c38031');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_5', '0v', 'q8qdjpe1', 140.053935, '2278', 'member_id_1', 'G');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_6', '5', 'sxcmr0o', 698.769833, 'dgj5i', 'member_id_1', 't2__c38031');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_7', '94gth', '2mnajjla3o', 904.028668, 'v8u', 'member_id_1', 'I');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_8', 'aus3', 'u', 337.117577, 'rpd', 'member_id_1', 't2__c38031');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_9', 'szdo2z', 'obb0q0k32o', 57.929422, 'l', 'member_id_1', 'O');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_10', 'boeowii1z5nx', 'h66', 441.511648, 'xlyotow9', 'member_id_1', 't2__c38031');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_11', 'aawg96aqb0tb', 'indz39tajz', 560.916337, '8', 'member_id_1', 'G');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_12', '7qk', '162nh55y3d', 602.631056, 'vu', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('O', 'tp6ewtqxxn', 'jabymzn2mfx7', 971.683344, '33', 'member_id_1', 't3__72237b');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('A', '6sto1cj8sh5k', 'zys7', 846.300006, 'yd1jmgj', 'member_id_1', 't3__72237b');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_15', 'h', 'qta8y3a17', 741.721165, '4ygmay', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_16', 'dpuap96rnt', 'q', 278.413617, '5wli', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('G', 'dn2np490x', 'm', 840.039966, 'qtgel', 'member_id_1', 't3__72237b');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_18', 'qb9i9f2ccu', 'jq1', 256.829372, 'ik1yhb', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_19', 't1pqo', 'iztv', NULL, '6', 'member_id_1', 't2__c38031');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_20', 'iz78aqql', 'd8ftb8', NULL, '9114q', 'member_id_1', 't2__c38031');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_21', '6b', 'jeuuwsj8kj', NULL, '85', 'member_id_1', 't2__c38031');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_22', 'xlvr', 'sur', NULL, '0kaqtnc', 'member_id_1', 't2__c38031');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_23', 'c8s3b7v88k', 'dmdbdh', NULL, '6j47n', 'member_id_1', 't2__c38031');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_24', 'r', '0hsjhanz', NULL, 'dpunmw', 'member_id_1', 't2__c38031');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_25', 'xqrlaw', '014', NULL, '5dqts', 'member_id_1', 't2__c38031');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_26', '97', 'aqz2o20pj6d', NULL, 'dlysu6iphd', 'member_id_1', 't2__c38031');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_27', '4nrq', 'rofqyp5s5b', 22.720462, '02eu', 'member_id_1', 'K');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('@', 'qa1', 'ryytoo3', 1.0, '9hl7', 'member_id_1', 'I');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('!', 'ex1', 'ji7zwau2', 1.0, 'dwyrq13pyu78', 'member_id_1', 'K');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_30', 'f3dqv0gc', '9', 540.154414, 'k3zbily', 'member_id_1', 'H');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('Q', 'n6vck6ah0f', 'jswwlq7xb', 1.0, '72fxa7ryfd', 'member_id_1', 'I');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('D', '16nijjai5dh', 'ogrgjd8y', 1.0, 't1afgog', 'member_id_1', 'I');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.type, SUM(T3.cost) FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget WHERE T1.event_name = 'October Meeting';

/*
Gold Result:
('t1__b83691', 8366.770740000002)
*/

-- Prediction Query
SELECT "expense"."expense_description", SUM("expense"."cost") AS "total_value" FROM "expense" INNER JOIN "budget" ON "expense"."link_to_budget" = "budget"."budget_id" INNER JOIN "event" ON "budget"."link_to_event" = "event"."event_id" WHERE "event"."event_name" = 'October Meeting' AND "expense"."approved" = 'true' GROUP BY "expense"."expense_description";

/*
Prediction Result:
*/