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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t3__2b051d', 't4__5a7700', 't4__62dcf5', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9', 'l7', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 't4__5a7700', 't4__62dcf5', 'hncprjtu0dz', '9fjgq8n2f', 'dqv0gcb9', 'ozk3zbily', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_2', 't4__5a7700', 't4__62dcf5', 'n6vck6ah0f', 'jswwlq7xb', '72fxa7ryfd', 'z16ni', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t3__020441', 'tsj3ayxp1q4', '01jh3den', 'c68x8vacx', 'afu5w1of7', 'pzo72ctdc', 'mfg62', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', 'of', 'szdo2z', 'obb0q0k32o', 'w', 'l', '5amsorlwyngc', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('G', 'wlic7dn2np', '90xdmsqt', 'el', 'u', 'qb9i9f2ccu', 'jq1', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t4__3d28cc', 'xs6dvdxdo2', '7t3gvp', 'j9f', 'vuu', '7k10', 'z2my1ogyv1r', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 'hvdlttilbnpr', 'dpos', 'ie5', 'nw6klf', 'a9000t5c4eci', 'gce376nium52', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('`', '8pz0f8je', 'd2', 'vy9uxj4', 'wb', 'v', 'ph2', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('B', 'hvdlttilbnpr', 'dpos', 'ie5', 'nw6klf', 'a9000t5c4eci', 'gce376nium52', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_11', NULL, 'uo4nrqrofqy', '5s5b', 'p', '02eutliqa11r', 'ytoo3o9', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('a', 'h2gn', 'q', 'nqcx5h', 'cprj', 'u0dz7', 'fjgq8n2f3', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_13', NULL, '0gcb98', 'zk3z', 'i', 'yrk', 'n6vck6ah0f', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('"', 'c68x8vacx', 'afu5w1of7', 'pzo72ctdc', 'mfg62', '0v', 'q8qdjpe1', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_15', NULL, '278507cv', 'jpttg', 'bnou5zi36', '4', 'f', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('!', 'mu2ne578lf', 'yz7zzb', '8y', 'kv42q7', 'x58b4', 'pmaus3auvmkr', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_17', NULL, 'wzw', 'chn9mo70', 'a9n0jxfo', 'ws', 'do2zobb', -2147483648, 'major_id_1');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__a6374e', 'Yearly Kickoff', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__ca188f', 'Yearly Kickoff', 'jsl', 'b4yp5qi', 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', 'Yearly Kickoff', '07cvtjpt', 'tg6bnou5zi', '6c4bfkfo', 'c', '0');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('_', '7z2zezjo7wg', 'd5ysxc', 'r0oz', 'dgj5i', 'lq5lnpim', 'k58qs27p');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('I', 'uzkb52', 'gwnlas6', 'elboeowii1', '5nxih66', 'q2xlyoto', '9oaawg');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('O', 'rmkio18r', 'i2hy08ftp6', 'wt', 'xxnja', 'bymzn2mfx7h3', 'p6sto1cj');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__31c6c4', 'Yearly Kickoff', '6', '4iz7', 'aqqlud8ft', '8', '9114q');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('@', 't1__e2412a', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('B', NULL, 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr', '13pyu');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('`', 'Yearly Kickoff', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('b', 'Yearly Kickoff', 'q13py', '78d99r', 'jsl', 'b4yp5qi', 'rkf9vqx5');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('a', 'Yearly Kickoff', '5dh', 'ogrgjd8y', 't1afgog', 'itsj3', 'y');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('!', 'Yearly Kickoff', 'ysxcmr0o', 'ztdgj5i3lq5l', 'pim5', '58q', 's27p2r94gth2');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', 'luhvdltti', 'bnp', 'mdpos');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'ie5', 'nw6klf', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof');

-- Inserting into table: budget --
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t2__9ebf86', 'hria2ypuzhs', 663.049759, 711.020062, 1908028688, 'p', 't1__a6374e');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t2__a2c329', 'wb', 50.647649, 185.427628, 1581736075, 'gndqwnqc', 't1__a6374e');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('G', 'tmu2n', 76.823924, 572.833475, -1402164108, 'yz7zzb', 't1__a6374e');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('A', 'v42', 258.625847, 783.973422, -2060082151, 'pmaus3auvmkr', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('O', '8', 206.468438, 674.193177, 1148916014, 'g', 't1__a6374e');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_6', 'r', 70.018028, 508.519106, -1537647691, 'uuwsj8kjh8', 't2__31c6c4');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t3__bb7003', 'gc8s3b7v88k', 354.964361, 916.71268, 1633584225, 'd', 't1__a6374e');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_8', 'u2g', 828.819416, 131.373165, 1352531282, 'vwq51oa', 't2__31c6c4');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_9', 'rpouit63xyf', 824.672918, 189.105795, -614741184, '26mb', 't2__31c6c4');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('@', 'hria2ypuzhs', 663.049759, 711.020062, 1908028688, 'p', '@');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('B', '8d99rljsl', 419.361606, 470.165282, 1692174491, 'qi2rkf9v', 'B');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('C', 'hria2ypuzhs', 663.049759, 711.020062, 1908028688, 'p', '`');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('`', 'pz0f8jegd', 452.27611, 434.003102, 233994589, 'j4hwbd', 'b');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('"', 'p1q430', 947.945777, 571.595144, 518609210, '3d', 'a');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('a', 'najj', 185.260952, 462.366429, 1919033056, 'v8u', '!');

-- Inserting into table: expense --
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_1', 'klex14ji', '7zwau2dwyr', 262.105498, '3pyu78d99r', 't3__2b051d', 't2__9ebf86');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_2', 'jai', 'dh5ogrgj', 54.980195, 'yzt1afgog', 'A', 't2__9ebf86');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_3', '0v', 'q8qdjpe1', 140.053935, '2278', 't3__020441', 't2__9ebf86');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_4', '4gth2mnaj', 'la3', 588.850908, 'kv8u', 't3__2b051d', 't2__9ebf86');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_5', 'pdjwzw5chn9', 'o705', 858.19408, '9', 't3__2b051d', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_6', 'dj9erhi', 'zgk1yoeyo6l0', 124.067083, '6fuqy', 'O', 't2__9ebf86');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_7', '0', 'bindz', 466.613431, 'ajz9t', 't3__2b051d', 't2__9ebf86');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_8', 'c', '3tdu6bd0w960', 460.649748, 'vzxw1rxe9yf', 't3__2b051d', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_9', '162', 'h55y', 467.033126, 'ohvu06dza3', 'O', 't2__9ebf86');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_10', 'knzys7dy', 'yd1jmgjach8', 726.733068, 'ta8y3a17v4', 't3__2b051d', 't2__9ebf86');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_11', 'mayq3qdpua', '96rn', 968.723597, 'q', 't3__2b051d', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_12', 'uik1y', 'hb08hlst1pq', 961.035335, 'iztv', 'G', 't2__9ebf86');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_13', 'xlvr', 'sur', 840.394555, '0kaqtnc', 't3__2b051d', 't2__9ebf86');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('O', 'j47nxar50', 'sj', 115.267985, 'zxdp', 't3__2b051d', 't3__bb7003');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('A', 'nmwfwx', 'rlawk', 417.346356, '14r5dqtsmg97', 't3__2b051d', 't3__bb7003');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('_', '2o20pj6', 'd', 783.349866, 'su6iphd', 't3__2b051d', 't2__9ebf86');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_17', '3', 'oi1pav', 781.008765, 'wnyqro', 't3__2b051d', 't2__9ebf86');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_18', '0ju', '0h3r133ir1ax', 387.054953, 'hpl2i9esap', 't3__2b051d', 't2__9ebf86');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('Q', 'k', 'wtsr5', 563.737346, 'o6qjektb', 't3__2b051d', 't3__bb7003');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_20', 'zg3rjkwns47j', 'ja8dccy3', 584.512314, 'jwq49y', 't3__2b051d', 't2__9ebf86');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_21', '1', 'l', 575.65588, 'gly7', 't3__2b051d', 't2__9ebf86');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_22', 'xeilp', 'e019cy7od0', 457.405588, 'dlhdsvnh', 't3__2b051d', 't2__9ebf86');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('@', 'zbuo4nrqrof', 'qyp5s5bbp0', 673.065986, 'eutliqa11r', '@', '@');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('B', 'nd', 'wnqcx', 668.309685, 'hncprjtu0dz', '`', 'B');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('"', 'l7', 'klex14ji', 598.409165, 'wau2dwy', 'B', 'C');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('D', 'jswwlq7xb', '72fxa7ryfd', 276.61064, '16nijja', 'a', '`');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('`', 'foa', 'cd07z2zezjo7', 570.824589, 'xd', '"', '"');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('E', 'q0k32od', 'cl5ams', 665.099697, 'lwyng', '!', 'a');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T4.first_name, T4.last_name FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget INNER JOIN member AS T4 ON T3.link_to_member = T4.member_id WHERE T1.event_name = 'Yearly Kickoff';

/*
Gold Result:
('t4__5a7700', 't4__62dcf5')
('t4__5a7700', 't4__62dcf5')
('tsj3ayxp1q4', '01jh3den')
('t4__5a7700', 't4__62dcf5')
('t4__5a7700', 't4__62dcf5')
('of', 'szdo2z')
('t4__5a7700', 't4__62dcf5')
('t4__5a7700', 't4__62dcf5')
('of', 'szdo2z')
('t4__5a7700', 't4__62dcf5')
('t4__5a7700', 't4__62dcf5')
('wlic7dn2np', '90xdmsqt')
('t4__5a7700', 't4__62dcf5')
('t4__5a7700', 't4__62dcf5')
('t4__5a7700', 't4__62dcf5')
('t4__5a7700', 't4__62dcf5')
('t4__5a7700', 't4__62dcf5')
('t4__5a7700', 't4__62dcf5')
('t4__5a7700', 't4__62dcf5')
('t4__5a7700', 't4__62dcf5')
('t4__5a7700', 't4__62dcf5')
('t4__5a7700', 't4__62dcf5')
('hvdlttilbnpr', 'dpos')
('h2gn', 'q')
('c68x8vacx', 'afu5w1of7')
('mu2ne578lf', 'yz7zzb')
*/

-- Prediction Query
SELECT m.first_name, m.last_name FROM event AS e INNER JOIN budget AS b ON e.event_id = b.link_to_event INNER JOIN attendance AS a ON b.link_to_event = a.link_to_event INNER JOIN member AS m ON a.link_to_member = m.member_id WHERE e.event_name = 'Yearly Kickoff';

/*
Prediction Result:
*/