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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__d56f28', 'October Meeting', '5k5swwqcgs', 't1__4b41d0', '9n8', '4', 'gu7v');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('C', 'October Meeting', '9v', 't1__4b41d0', 'x58pz', 'f8jegd2', 'vy9uxj4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', 'October Meeting', 'kn6vck6ah0f8', 't1__4b41d0', 'sww', 'q7x', '7');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('O', '2fxa7ryfdrz', '16nijjai5dh', 'ogrgjd8y', 't1afgog', 'itsj3', 'y');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('G', 'ttg6bnou5zi3', 'c4bfkfoac', '0', '7z2zezjo7wg', 'd5ysxc', 'r0oz');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('I', '7zzbe8y', 'kv42q7', 'x58b4', 'pmaus3auvmkr', 'pdjwzw5chn9', 'o705');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__f9ca82', 'October Meeting', '2q2xlyoto', 't1__4b41d0', '9oaawg', '6aqb0tbin', 'z');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('?', 'October Meeting', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('@', 'October Meeting', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'bnp', 'mdpos');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('B', NULL, 'u78d99r', 'jsl', 'b4yp5qi', 'rkf9vqx5', 'pz0f8jegd');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', 'uzhsrwbbp6lu', 'hvdlttilbnpr', 'dpos');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'ie5', 'nw6klf', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof');

-- Inserting into table: budget --
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t2__3d90d9', 'e4', 779.409124, 640.719621, 1160656988, 'ia2yp', 't1__d56f28');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t2__9babb6', 'wb', 50.647649, 185.427628, 1581736075, 'gndqwnqc', 't1__d56f28');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('A', 'f', 313.653498, 489.044661, 645287482, 'f77p', 't1__d56f28');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('O', '72ct', 51.002063, 803.582738, -1284905200, '62', 'O');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('G', '7p2r94gth2m', 925.474843, 211.248782, 418247369, 'jla', 'O');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('Q', 'cl5ams', 665.099697, 270.763563, -605061107, 'gc1d', 't1__d56f28');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_7', '9tajz9td', 535.501742, 655.746331, -625404808, 'um', 't2__f9ca82');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t3__2c147b', 'k7', 256.291309, 931.189708, 643589729, 'h55y', 't1__d56f28');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_9', 'mzn2mfx7h3', 453.840746, 909.594191, -891525031, '1cj8', 't2__f9ca82');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_10', 'qdpuap96', 800.653743, 961.532162, 2013152515, 'q', 't2__f9ca82');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_11', 'hlst1pqom', 139.623194, 403.002922, 2141720493, 'vb6m4iz78aq', 't2__f9ca82');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('@', 'ie5', 327.753528, 218.301157, -1399556171, 'a9000t5c4eci', '@');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('a', 'e', 467.07027, 875.837169, -1585009206, '52zb', 'C');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('B', '1vy9uxj4', 124.573829, 22.63964, -736979194, 'h2gn', 'B');

-- Inserting into table: expense --
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_1', '13pyu', '8d99rljsl', 419.361606, 'yp5qi2rk', 'member_id_1', 't2__3d90d9');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_2', '5hncprjtu0d', '79fjgq8', 915.268032, '2f3d', 'member_id_1', 't2__3d90d9');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_3', '0gcb98', 'zk3z', 892.659478, 'lyr', 'member_id_1', 't2__3d90d9');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_4', '1q43', '1jh3den', 544.095565, 'c68x8vacx7', 'member_id_1', 't2__3d90d9');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_5', 'v5q8qdj', 'e1io', 443.690199, '8507cvtjp', 'member_id_1', 'O');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_6', 'g', '5i3', 172.799686, '5lnpim5k58qs', 'member_id_1', 't2__3d90d9');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_7', 'okv8uttmu2', 'e578', 944.379011, 'vy', 'member_id_1', 'G');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_8', '9n0jxfofwsz', 'o', 778.650393, '2zobb0q0k32o', 'member_id_1', 't2__3d90d9');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_9', '9erhizgk1yoe', 'o6l0hdt', 506.13059, 'uq', 'member_id_1', 'Q');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_10', 'uzkb52', 'gwnlas6', 907.723998, 'lb', 'member_id_1', 't2__3d90d9');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_11', 'ow', 'i1z', 493.031806, 'xih6', 'member_id_1', 'O');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_12', '3', 'tdu6bd0w96', 411.582585, 'vzxw1rxe9y', 'member_id_1', 't2__3d90d9');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('O', 'o', 'vu', 885.125365, 'dza35rmki', 'member_id_1', 't3__2c147b');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('A', '8ri2hy0', '8ftp6ewtqx', 361.5356, 'jaby', 'member_id_1', 't3__2c147b');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_15', '5k', 'zys7', 846.300006, 'yd1jmgj', 'member_id_1', 't2__3d90d9');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('G', 'h', 'qta8y3a17', 741.721165, '4ygmay', 'member_id_1', 't3__2c147b');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_17', 'm5', 'wlic7dn2np', 480.228838, '0xdmsqtgel', 'member_id_1', 't2__3d90d9');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('I', 'qb9i9f', 'ccukjq1q', 763.851917, 'ik1yhb', 'member_id_1', 't3__2c147b');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_19', 'ud8', 'tb', 544.766726, '9114qbre6bj', 'member_id_1', 't2__3d90d9');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_20', 'sj8kjh', '5wpxlvris', NULL, 'urz0kaqtncg', 'member_id_1', 't2__3d90d9');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_21', 's3b7v88kw', 'm', NULL, 'b', 'member_id_1', 't2__3d90d9');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_22', '6j47n', 'ar50hs', NULL, 'han', 'member_id_1', 't2__3d90d9');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_23', 'dpunmw', 'wx', NULL, 'rlawk', 'member_id_1', 't2__3d90d9');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_24', '14r5dqtsmg97', 'aqz2o20pj6d', NULL, 'dlysu6iphd', 'member_id_1', 't2__3d90d9');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_25', 'u2gir31vwq5', 'oa2sb3u', NULL, 'i1pa', 'member_id_1', 't2__3d90d9');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_26', 'v', 'wnyqrouirlrp', NULL, 'ouit63xyfvmj', 'member_id_1', 't2__3d90d9');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_27', 'p26m', '3', NULL, 'j', 'member_id_1', 't2__3d90d9');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('@', '4nrq', 'rofqyp5s5b', 1.0, 'p', 'member_id_1', 'budget_id_11');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('a', '2eutliqa11r', 'ytoo3o9', 1.0, 'l7', 'member_id_1', '@');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_30', 'lex', '4ji7zwa', 313.384575, 'dwyrq13p', 'member_id_1', '@');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('B', 'wnqcx', '5hncprjtu0d', 395.809081, 'fjgq8n2f3', 'member_id_1', 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.type, SUM(T3.cost) FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget WHERE T1.event_name = 'October Meeting';

/*
Gold Result:
('t1__4b41d0', 10487.186125000002)
*/

-- Prediction Query
SELECT T3.event_name, SUM(T2.cost) FROM budget AS T1 INNER JOIN expense AS T2 ON T1.budget_id = T2.link_to_budget INNER JOIN event AS T3 ON T1.link_to_event = T3.event_id WHERE T3.event_name = 'October Meeting' AND T2.approved = 'true';

/*
Prediction Result:
(None, None)
*/