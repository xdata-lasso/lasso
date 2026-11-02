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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__800e48', 'October Meeting', '5k5swwqcgs', 't1__142a55', '9n8', '4', 'gu7v');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__b3ab89', 'October Meeting', '9v', 't1__142a55', 'x58pz', 'f8jegd2', 'vy9uxj4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('O', 'October Meeting', 'kn6vck6ah0f8', 't1__142a55', 'sww', 'q7x', '7');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', '2fxa7ryfdrz', '16nijjai5dh', 'ogrgjd8y', 't1afgog', 'itsj3', 'y');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Q', 'October Meeting', 'ttg6bnou5zi3', 't1__142a55', 'c4bfkfoac', '0', '7z2zezjo7wg');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('_', 'October Meeting', '4gth2mnaj', 't1__142a55', 'la3', 'okv8uttmu2', 'e578');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('G', 'October Meeting', 'obb0q0k32o', 't1__142a55', 'w', 'l', '5amsorlwyngc');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__3367a2', 'October Meeting', 'eowi', 't1__142a55', '1z5', 'xih6', '2q2xlyoto');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('W', 'October Meeting', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('I', 'October Meeting', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'bnp', 'mdpos');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('@', NULL, 'u78d99r', 'jsl', 'b4yp5qi', 'rkf9vqx5', 'pz0f8jegd');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('B', 'October Meeting', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', 'uzhsrwbbp6lu', 'hvdlttilbnpr', 'dpos');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'ie5', 'nw6klf', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof');

-- Inserting into table: budget --
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t2__60f11f', 'e4', 779.409124, 640.719621, 1160656988, 'ia2yp', 't1__800e48');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t2__a5f38c', 'wb', 50.647649, 185.427628, 1581736075, 'gndqwnqc', 't1__800e48');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('A', 'f', 313.653498, 489.044661, 645287482, 'f77p', 't1__800e48');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('O', '72ct', 51.002063, 803.582738, -1284905200, '62', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('G', 'u', 771.198983, 453.245856, -790819470, 'krpd', 't1__b3ab89');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('_', '9oaawg', 555.75468, 743.240647, 966412849, '0', 't2__3367a2');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t3__52269e', '3tdu6bd0w960', 460.649748, 672.384779, 2018368241, 'xw1rxe9yfk7', 't1__800e48');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('B', 'ie5', 327.753528, 218.301157, -1399556171, 'a9000t5c4eci', 'W');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('@', 'ce', 467.07027, 875.837169, -1585009206, '52zb', 'I');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('H', '1vy9uxj4', 124.573829, 22.63964, -736979194, 'h2gn', '@');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('C', 'hria2ypuzhs', 663.049759, 711.020062, 1908028688, 'p', 'B');

-- Inserting into table: expense --
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_1', '13pyu', '8d99rljsl', 419.361606, 'yp5qi2rk', 'member_id_1', 't2__60f11f');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_2', '5hncprjtu0d', '79fjgq8', 915.268032, '2f3d', 'member_id_1', 't2__60f11f');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_3', '0gcb98', 'zk3z', 892.659478, 'lyr', 'member_id_1', 't2__60f11f');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_4', '1q43', '1jh3den', 544.095565, 'c68x8vacx7', 'member_id_1', 't2__60f11f');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_5', 'v5q8qdj', 'e1io', 443.690199, '8507cvtjp', 'member_id_1', 'O');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_6', '5', 'sxcmr0o', 698.769833, 'dgj5i', 'member_id_1', 't2__60f11f');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_7', 'q5l', 'pim5', 167.377262, '8qs27p2r', 'member_id_1', 'O');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_8', 'vy', '7zzbe8y', 335.639672, 'v42q7sx58b4p', 'member_id_1', 't2__60f11f');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_9', 'wzw5chn9mo70', 'a9n0jxfo', 82.48091, 'zdo2z', 'member_id_1', 'G');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_10', 'j', '9erhizgk1yoe', 845.392744, 'o6l0hdt6fu', 'member_id_1', 't2__60f11f');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_11', 'xuzkb52', 'gwnlas6', 907.723998, 'lb', 'member_id_1', 'O');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_12', 'i', 'ndz39tajz9', 304.069184, 'n5wcgumbc', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('O', '162', 'h55y', 467.033126, 'ohvu06dza3', 'member_id_1', 't3__52269e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('A', 'rmkio18ri2', 'y0', 949.964729, 'ftp6ewtqx', 'member_id_1', 't3__52269e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_15', 'jaby', 'mzn2mfx7h3', 453.840746, '6sto', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('G', 'j', 'sh5knzys7', 846.300006, 'yd1jmgj', 'member_id_1', 't3__52269e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_17', '8q', 'ta8y3a17v4', 643.031153, 'ma', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('Q', '3qdpu', 'p', 552.684299, 'rntdqrhm5', 'member_id_1', 't3__52269e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_19', 'c7d', 'n2np490xdms', 260.74675, 'el', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_20', '9', 'i9f2ccukjq1q', NULL, 'ik1yhb', 'member_id_1', 't2__60f11f');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_21', 'hlst1pqom', 'ztv', NULL, '6', 'member_id_1', 't2__60f11f');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_22', 'z78', 'q', NULL, 'lud8f', 'member_id_1', 't2__60f11f');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_23', '8', '9114q', NULL, 'r', 'member_id_1', 't2__60f11f');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_24', '6bjeuuwsj8k', 'h85', NULL, 'pxlvri', 'member_id_1', 't2__60f11f');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_25', 'urz0kaqtncg', 'c8s3b7v88k', NULL, 'dmdbdh', 'member_id_1', 't2__60f11f');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_26', 'j47nxar50', 'sj', NULL, 'an', 'member_id_1', 't2__60f11f');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_27', 'dpunmw', 'wx', NULL, 'rlawk', 'member_id_1', 't2__60f11f');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('C', 'nrqrofqy', '5s5b', 1.0, 'p', 'member_id_1', '_');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('!', 'eutliqa11r', 'ytoo3o9', 1.0, 'l7', 'member_id_1', 't3__52269e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_30', 'lex', '4ji7zwa', 313.384575, 'dwyrq13p', 'member_id_1', 'B');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('@', 'wnqcx', '5hncprjtu0d', 395.809081, 'fjgq8n2f3', 'member_id_1', 'H');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('E', 'hvdltt', 'lbn', 240.969194, 'mdpos', 'member_id_1', 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.type, SUM(T3.cost) FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget WHERE T1.event_name = 'October Meeting';

/*
Gold Result:
('t1__142a55', 9767.691602)
*/

-- Prediction Query
SELECT e.expense_description, SUM(e.cost) AS total_value FROM expense AS e INNER JOIN budget AS b ON e.link_to_budget = b.budget_id INNER JOIN event AS evt ON b.link_to_event = evt.event_id WHERE evt.event_name = 'October Meeting' AND e.approved = 'true' GROUP BY e.expense_description;

/*
Prediction Result:
*/