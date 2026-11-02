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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_1', '8d99rljsl', 'b4yp5qi', 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4', 'wb', -2147483648, 'major_id_1');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', 't1__23c1a3', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('C', 't1__23c1a3', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'bnp', 'mdpos');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('O', 'dqv0gcb98ozk', 'zbilyrkn', '6vck6ah0f8js', 'wlq7xb', '72fxa7ryfd', 'z16ni');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__1b8bc0', 't1__23c1a3', '8', 'yzt1afgogrit', 'sj3ayxp1q430', 'jh3den8', 'c68x8vacx7');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('G', 'ttg6bnou5zi3', 'c4bfkfoac', '0', '7z2zezjo7wg', 'd5ysxc', 'r0oz');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__bc6346', 't1__23c1a3', 'do2zobb', 'q0k32od', 'cl5ams', 'orlwyngc1dj', '9erhizgk1yoe');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('@', '6j47n', 'ar50hs', 'han', 'xdpunmw', 'wx', 'rlawk');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('`', '6mb3aj0j', '0h3r13', 'ir1axyyh', 'l2i9', 'sa', '8pgc');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('P', '9fj', 'uun7k1', 'z2my1og', 'v1rgeza', 'xc1clupgly', '8oitxeilp');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('0', 'ubo', '8c', 'e', 'uekhllbw', 'dpu5v0', 'du');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr', '13pyu');

-- Inserting into table: budget --
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t2__9da6fa', 'Parking', 133.007885, 75.403642, -1209887326, 'klfa9000t', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t2__47b62d', 'Parking', 827.854302, 983.124993, -1964997180, 'gce376nium52', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('G', 'Parking', 854.793228, 983.924121, -47052816, '1of77pzo72c', 't1__1b8bc0');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('A', 'c', 803.582738, 695.452114, -1284905200, '62', 'O');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('O', 'Parking', 876.038555, 628.658254, 1055237066, 'r94gth2m', 't1__1b8bc0');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t3__c2f2d2', 'Parking', 668.530896, 841.944569, 1048147204, 'eowi', 't1__1b8bc0');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('@', '14r5dqt', 802.240612, 187.899799, -2098439423, '2o20pj6', '@');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_8', 'Parking', 562.744101, 949.111842, 1216978423, 'su6iphd', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('`', 'qwt', 992.371408, 288.95229, 1339281953, '4o6qjektb1', '`');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_10', 'Parking', 451.237024, 720.390829, -1517965246, 'ns47j2', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('B', 'e019cy7od0', 457.405588, 461.555144, -1882121644, 'hdsvnhed29lq', 'P');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_12', 'Parking', 726.542267, 954.744224, 1032462616, '331spxpw30bg', 't2__bc6346');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('D', 'y9v2z12983', 728.526405, 935.403582, -1147311649, 'acxd', '0');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_14', 'Parking', 448.700958, 419.701122, -537413388, 'et8xjhc', 'A');

-- Inserting into table: expense --
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_1', 'v', 'ph2', 109.083092, 'dqwn', 'member_id_1', 't2__9da6fa');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_2', 'x', '5hncprjtu0d', 395.809081, 'fjgq8n2f3', 'member_id_1', 't2__9da6fa');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_3', 'ai5', 'h', 488.601669, 'grgj', 'member_id_1', 't2__9da6fa');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_4', 'v5q8qdj', 'e1io', 443.690199, '8507cvtjp', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_5', 'g', '5i3', 172.799686, '5lnpim5k58qs', 'member_id_1', 't2__9da6fa');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_6', 'ajjla3okv8u', 'tmu2n', 76.823924, '78lfvyz7zz', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_7', '8y', 'kv42q7', 282.68858, '58b4pm', 'member_id_1', 't2__9da6fa');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_8', 'us3auvmkrpdj', 'wzw5chn9mo70', 486.420817, 'a9n0jxfofws', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_9', 'o6l0hdt6fu', 'yxuzk', 20.547158, '521gwnlas6e', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('G', 'z5nxih6', '2q2xlyoto', 913.199755, 'oaawg96aq', 'member_id_1', 't3__c2f2d2');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('A', 'tbindz3', 'tajz9td8n', 655.746331, 'wcgumbc3', 'member_id_1', 't3__c2f2d2');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_12', 'u', 'bd0w9603v', 843.866361, 'xw1rxe9', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('O', 'k7', 'k162n', 111.965818, '5y3dohvu', 'member_id_1', 't3__c2f2d2');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_14', 'a35rmki', '18ri', 851.78202, 'y0', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_15', 'tqxxnj', 'b', NULL, 'mzn2mfx', 'member_id_1', 't2__47b62d');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_16', '3p6sto1c', '8sh', NULL, 'knzys7dy', 'member_id_1', 'O');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_17', '1', 'jmgjach8qt', 644.437797, '8y3a17v4yg', 'member_id_1', 't2__9da6fa');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_18', 'y', '3qdpu', NULL, 'p', 'member_id_1', 'O');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_19', 'tdqr', 'm5', NULL, 'wlic7dn2np', 'member_id_1', 'O');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_20', '0xdmsqtge', 'cuq', 27.252619, 'i9f2ccukjq1q', 'member_id_1', 't2__9da6fa');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_21', 'yhb08hlst1pq', 'mizt', NULL, 'vb6m4iz78aq', 'member_id_1', 't2__47b62d');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_22', 'd8ftb8', '9114q', NULL, 'r', 'member_id_1', 'G');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_23', '6bjeuuwsj8k', 'h85', 358.01048, 'lvrisu', 'member_id_1', 't2__9da6fa');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_24', '0kaqtnc', 'gc8s3b7v88k', 354.964361, 'dbdh', 'member_id_1', 't2__9da6fa');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('@', 'u2gir31vwq5', 'oa2sb3u', 0.0, 'i1pa', 'member_id_1', '@');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('H', 'wnyqro', 'uirlrpouit', 0.5, '63xyfvmjwpp', 'member_id_1', 't3__c2f2d2');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('!', '8', 'c', 0.0, 'y', 'member_id_1', '`');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('B', 'jwq49yrnxs', '6dvdxdo2v7', 0.5, '3gvpl', 'member_id_1', 'budget_id_8');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('C', 'xgi', 'nlj6idmp61', 0.0, '2o3', 'member_id_1', 'B');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('P', '62ocagj', 'ev', 0.5, 'zxlu49', 'member_id_1', 't2__9da6fa');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('"', '6cfperxa', '1sjv8nv3d', -1.0, 'r', 'member_id_1', 'D');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('D', 'ezcteh', 'a3c', 0.0, 'mvb7vpc0xffw', 'member_id_1', 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_name FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget WHERE T2.category = 'Parking' AND T3.cost < (SELECT AVG(cost) FROM expense);

/*
Gold Result:
('t1__23c1a3',)
('t1__23c1a3',)
('t1__23c1a3',)
('t1__23c1a3',)
('t1__23c1a3',)
('t1__23c1a3',)
('t1__23c1a3',)
*/

-- Prediction Query
SELECT T1.event_name FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget WHERE T2.category = 'Parking' GROUP BY T1.event_id HAVING SUM(T3.cost) < (SELECT AVG(T3.cost) FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget WHERE T2.category = 'Parking');

/*
Prediction Result:
*/