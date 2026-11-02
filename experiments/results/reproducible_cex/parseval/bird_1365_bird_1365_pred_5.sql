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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_1', 'l7', 'klex14ji', '7zwau2dwyr', '13pyu', '8d99rljsl', 'b4yp5qi', -2147483648, 'major_id_1');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_1', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', 'unw6klfa', '9000t5c4ec', 'gce');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, '76nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9');

-- Inserting into table: budget --
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t1__b92032', 'rwbbp6luhvd', 179.378884, 304.02808, -1364429300, 'nprmdposii', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t1__8d997f', 'gd', 452.27611, 434.003102, 233994589, 'j4hwbd', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('?', 'x', 668.309685, 635.267184, -1245312912, 'rjtu', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('A', 'z', 521.610309, 654.674676, -1748371085, 'q8', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('G', 'kn6vc', 915.583344, 508.771546, 834709651, 'f8jswwl', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('O', '16nijjai5dh', 488.601669, 781.755052, 1583472758, 'rg', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_7', '1q43', 787.642728, NULL, 1923912467, 'jh3den8c68', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_8', 'vacx7afu5', 354.593207, NULL, -290314193, 'f77pzo72ctd', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t2__c3b4e9', '2278', 494.537964, 409.740447, 2004147439, 'tjpttg', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_10', 'ou5z', 988.279797, NULL, 1691780814, '6c4bfkfo', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_11', 'cd07z2zezjo7', 570.824589, NULL, -542502665, 'ysxcmr0o', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('@', 'najj', 185.260952, 1.0, 1919033056, 'v8u', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('`', 'tmu2ne578l', 86.586744, 1.0, 697257217, '7zzbe8y', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('!', 'krpd', 144.157236, 1.0, -609553675, 'w5chn9mo705a', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('H', 'jxfofws', 900.422166, 1.0, -210159774, 'obb0q0k32o', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('B', 'yo', 514.470353, 1.0, 718167481, 'hdt6fuq', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('I', 'uzkb52', 435.41097, 1.0, -670154354, 'as6', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('F', 'oaawg96aq', 19.988339, 1.0, -850941333, 'indz39tajz', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('P', '8', 206.468438, 1.0, 748154000, 'cgumbc', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('Q', '7qk', 931.189708, 1.0, 643589729, 'h55y', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('X', 'o', 116.944655, 1.0, -732999244, '6dza35r', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('W', 'xnjaby', 607.620308, 1.0, 1528227252, 'fx7h', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('C', 'p6sto1cj', 835.790392, 1.0, 1728926031, 'knzys7dy', 'event_id_1');

-- Inserting into table: expense --
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('O', 't1__076a44', 'rkf9vqx5', 541.393553, 'z0f8', 'member_id_1', 't1__b92032');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('A', 't1__076a44', 'ph2', 109.083092, 'dqwn', 'member_id_1', 't1__8d997f');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_3', 't1__076a44', 'f3dqv0gc', 879.800692, '8ozk3zbil', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_4', 't1__076a44', 'xb72fxa7r', 379.883722, 'r', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_5', 't1__076a44', '8', 740.059813, 'zt1afgo', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_6', 't1__076a44', 'mfg62g0v5q8q', 53.966914, 'pe1', 'member_id_1', 't1__b92032');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_7', NULL, 'g', 145.027285, 'i3lq5lnp', 'member_id_1', 't1__b92032');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_8', 't1__076a44', 'k58qs27p', 452.630377, '94gth', 'member_id_1', 't1__b92032');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('@', 'v42', '7sx58', 682.232894, 'pmaus3au', 'member_id_1', '@');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('H', 'cl5ams', 'orlwyngc1dj', 821.485286, 'erhizgk1y', 'member_id_1', '!');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('B', 'lboeowii1z5', 'xih6', 946.669761, 'q2xlyoto', 'member_id_1', 'B');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('L', 'tdu6bd0w96', '3vzxw1r', 372.360229, '9y', 'member_id_1', 'F');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('I', 'io1', 'ri2hy08ft', 913.556136, '6ewt', 'member_id_1', 'Q');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('D', '1', 'jmgjach8qt', 644.437797, '8y3a17v4yg', 'member_id_1', 'W');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.expense_description FROM budget AS T1 INNER JOIN expense AS T2 ON T1.budget_id = T2.link_to_budget ORDER BY T1.remaining, T1.budget_id NULLS LAST, T2.expense_id NULLS LAST LIMIT 1;

/*
Gold Result:
('cl5ams',)
*/

-- Prediction Query
SELECT T1.expense_description FROM expense AS T1 INNER JOIN budget AS T2 ON T1.link_to_budget = T2.budget_id WHERE T2.remaining = (SELECT MIN(remaining) FROM budget);

/*
Prediction Result:
('v42',)
('cl5ams',)
('lboeowii1z5',)
('tdu6bd0w96',)
('io1',)
('1',)
*/