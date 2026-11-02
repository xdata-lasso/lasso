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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t3__0ee240', 't4__d957e4', 't4__e1085c', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9', 'l7', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 't4__d957e4', 't4__e1085c', 'hncprjtu0dz', '9fjgq8n2f', 'dqv0gcb9', 'ozk3zbily', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_2', 't4__d957e4', 't4__e1085c', 'n6vck6ah0f', 'jswwlq7xb', '72fxa7ryfd', 'z16ni', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('C', 'tsj3ayxp1q4', '01jh3den', 'c68x8vacx', 'afu5w1of7', 'pzo72ctdc', 'mfg62', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('G', 't4__d957e4', 't4__e1085c', 'xfo', 'ws', 'do2zobb', 'q0k32od', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t4__5c10e4', 'k', 'wtsr5', '4o6qjektb1', '2', 'zg3r', 'jkwns47j2j', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 'hvdlttilbnpr', 'dpos', 'ie5', 'nw6klf', 'a9000t5c4eci', 'gce376nium52', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('B', '8pz0f8je', 'd2', 'vy9uxj4', 'wb', 'v', 'ph2', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('D', 'hvdlttilbnpr', 'dpos', 'ie5', 'nw6klf', 'a9000t5c4eci', 'gce376nium52', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_10', NULL, 'uo4nrqrofqy', '5s5b', 'p', '02eutliqa11r', 'ytoo3o9', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('b', 'h2gn', 'q', 'nqcx5h', 'cprj', 'u0dz7', 'fjgq8n2f3', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_12', NULL, '0gcb98', 'zk3z', 'i', 'yrk', 'n6vck6ah0f', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('`', 'c68x8vacx', 'afu5w1of7', 'pzo72ctdc', 'mfg62', '0v', 'q8qdjpe1', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_14', NULL, '278507cv', 'jpttg', 'bnou5zi36', '4', 'f', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('"', 'mu2ne578lf', 'yz7zzb', '8y', 'kv42q7', 'x58b4', 'pmaus3auvmkr', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_16', NULL, 'wzw', 'chn9mo70', 'a9n0jxfo', 'ws', 'do2zobb', -2147483648, 'major_id_1');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__4cccf0', 'Yearly Kickoff', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__ff425a', 'Yearly Kickoff', 'jsl', 'b4yp5qi', 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('_', 'Yearly Kickoff', '07cvtjpt', 'tg6bnou5zi', '6c4bfkfo', 'c', '0');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', '7z2zezjo7wg', 'd5ysxc', 'r0oz', 'dgj5i', 'lq5lnpim', 'k58qs27p');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('O', 'Yearly Kickoff', 'eyo6', 'l0hdt6fuqyx', 'uzkb521gwnl', 's', 'elboeowii');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('G', 'Yearly Kickoff', '3dohvu0', 'dza35rmki', '18ri', 'hy08ftp6', 'wt');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__307368', 'Yearly Kickoff', 'dqrhm', 'wlic7dn2', 'p490', 'dmsqtg', 'lc');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('@', 't1__a4a1f9', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('C', NULL, 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr', '13pyu');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('B', 'Yearly Kickoff', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('F', 'Yearly Kickoff', 'q13py', '78d99r', 'jsl', 'b4yp5qi', 'rkf9vqx5');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('b', 'Yearly Kickoff', '5dh', 'ogrgjd8y', 't1afgog', 'itsj3', 'y');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('!', 'Yearly Kickoff', 'ysxcmr0o', 'ztdgj5i3lq5l', 'pim5', '58q', 's27p2r94gth2');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', 'luhvdltti', 'bnp', 'mdpos');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'ie5', 'nw6klf', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof');

-- Inserting into table: budget --
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t2__99f025', 'hria2ypuzhs', 663.049759, 711.020062, 1908028688, 'p', 't1__4cccf0');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t2__f0a7b6', 'wb', 50.647649, 185.427628, 1581736075, 'gndqwnqc', 't1__4cccf0');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('A', 'tmu2n', 76.823924, 572.833475, -1402164108, 'yz7zzb', 't1__4cccf0');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('G', 'v42', 258.625847, 783.973422, -2060082151, 'pmaus3auvmkr', '_');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_5', 'qb9i9f', 446.993541, 41.090755, -788896327, 'q1q', 't2__307368');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t3__706986', 'qomi', 915.602165, 591.192357, -696672546, 'm4iz78aqq', 't1__4cccf0');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_7', '6j47n', 370.459832, 766.476432, -343920305, 'sjhanzxdpu', 't2__307368');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_8', '2gir31vwq5', 981.395878, 430.247286, -2014514218, 'oi1pav', 't2__307368');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('!', 'hria2ypuzhs', 663.049759, 711.020062, 1908028688, 'p', '@');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('@', '8d99rljsl', 419.361606, 470.165282, 1692174491, 'qi2rkf9v', 'C');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('`', 'hria2ypuzhs', 663.049759, 711.020062, 1908028688, 'p', 'B');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('B', 'pz0f8jegd', 452.27611, 434.003102, 233994589, 'j4hwbd', 'F');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('C', 'p1q430', 947.945777, 571.595144, 518609210, '3d', 'b');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('D', 'najj', 185.260952, 462.366429, 1919033056, 'v8u', '!');

-- Inserting into table: expense --
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_1', 'klex14ji', '7zwau2dwyr', 262.105498, '3pyu78d99r', 't3__0ee240', 't2__99f025');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_2', 'jai', 'dh5ogrgj', 54.980195, 'yzt1afgog', 'A', 't2__99f025');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_3', '0v', 'q8qdjpe1', 140.053935, '2278', 'C', 't2__99f025');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_4', '4gth2mnaj', 'la3', 588.850908, 'kv8u', 't3__0ee240', 't2__99f025');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_5', 'pdjwzw5chn9', 'o705', 858.19408, '9', 't3__0ee240', 'G');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_6', 'cl5ams', 'orlwyngc1dj', 821.485286, 'erhizgk1y', 'A', 't2__99f025');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_7', 'nxih662q', 'xlyotow9', 232.87238, 'aawg96aqb0t', 't3__0ee240', 't2__99f025');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_8', 'ndz39tajz9', 'd8n5w', 36.996954, 'mbc3td', 't3__0ee240', 'G');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_9', 'd0w9603vzxw1', 'xe9yf', 958.39315, 'qk162nh55', 'A', 't2__99f025');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_10', 'njabym', 'n2mfx7h', 463.637542, '6sto', 't3__0ee240', 't2__99f025');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_11', '8sh', 'knzys7dy', 670.297308, 'd1jmgja', 't3__0ee240', 'G');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_12', 'qta8y3a17', 'v4ygmayq3qdp', 846.183059, 'ap96rn', 'A', 't2__99f025');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_13', '1yh', '0', 538.678811, 'st1', 't3__0ee240', 't2__99f025');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('O', '8', 'tb', 544.766726, '9114qbre6bj', 't3__0ee240', 't3__706986');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('A', 'uu', 'sj8kjh', 537.801391, 'wpxlvris', 't3__0ee240', 't3__706986');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('G', '0kaqtnc', 'gc8s3b7v88k', 354.964361, 'dbdh', 't3__0ee240', 't2__99f025');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_17', 'fwxqrl', 'w', 164.859551, '14r5dqtsmg97', 't3__0ee240', 't2__99f025');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('I', '2o20pj6', 'd', 783.349866, 'su6iphd', 't3__0ee240', 't3__706986');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_19', 'wnyqrouirlrp', 'ouit63xyfvmj', 720.842041, 'pp26mb', 't3__0ee240', 't2__99f025');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_20', '0h3r133ir1ax', 'yhpl2i9', 72.185429, 'p', 't3__0ee240', 't2__99f025');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_21', 'vjwq49yr', 'nxs6dvdxdo2v', 848.951769, '7t3gvplj9f', 't3__0ee240', 't2__99f025');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_22', 'uun7k10z2my1', 'gyv1', 274.879203, 'za', 't3__0ee240', 't2__99f025');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('@', 'zbuo4nrqrof', 'qyp5s5bbp0', 673.065986, 'eutliqa11r', '@', '!');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('B', 'nd', 'wnqcx', 668.309685, 'hncprjtu0dz', 'B', '@');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('F', 'l7', 'klex14ji', 598.409165, 'wau2dwy', 'D', '`');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('"', 'jswwlq7xb', '72fxa7ryfd', 276.61064, '16nijja', 'b', 'B');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('b', 'foa', 'cd07z2zezjo7', 570.824589, 'xd', '`', 'C');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('D', 'q0k32od', 'cl5ams', 665.099697, 'lwyng', '"', 'D');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T4.first_name, T4.last_name FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget INNER JOIN member AS T4 ON T3.link_to_member = T4.member_id WHERE T1.event_name = 'Yearly Kickoff';

/*
Gold Result:
('t4__d957e4', 't4__e1085c')
('t4__d957e4', 't4__e1085c')
('tsj3ayxp1q4', '01jh3den')
('t4__d957e4', 't4__e1085c')
('t4__d957e4', 't4__e1085c')
('t4__d957e4', 't4__e1085c')
('t4__d957e4', 't4__e1085c')
('t4__d957e4', 't4__e1085c')
('t4__d957e4', 't4__e1085c')
('t4__d957e4', 't4__e1085c')
('t4__d957e4', 't4__e1085c')
('t4__d957e4', 't4__e1085c')
('t4__d957e4', 't4__e1085c')
('t4__d957e4', 't4__e1085c')
('t4__d957e4', 't4__e1085c')
('t4__d957e4', 't4__e1085c')
('t4__d957e4', 't4__e1085c')
('t4__d957e4', 't4__e1085c')
('t4__d957e4', 't4__e1085c')
('t4__d957e4', 't4__e1085c')
('t4__d957e4', 't4__e1085c')
('t4__d957e4', 't4__e1085c')
('hvdlttilbnpr', 'dpos')
('h2gn', 'q')
('c68x8vacx', 'afu5w1of7')
('mu2ne578lf', 'yz7zzb')
*/

-- Prediction Query
SELECT DISTINCT T4.first_name, T4.last_name FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget INNER JOIN member AS T4 ON T3.link_to_member = T4.member_id WHERE T1.event_name = 'Yearly Kickoff';

/*
Prediction Result:
('t4__d957e4', 't4__e1085c')
('tsj3ayxp1q4', '01jh3den')
('hvdlttilbnpr', 'dpos')
('h2gn', 'q')
('c68x8vacx', 'afu5w1of7')
('mu2ne578lf', 'yz7zzb')
*/