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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t3__0f2727', 't4__430f2f', 't4__b451b0', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9', 'l7', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 't4__430f2f', 't4__b451b0', 'hncprjtu0dz', '9fjgq8n2f', 'dqv0gcb9', 'ozk3zbily', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_2', 't4__430f2f', 't4__b451b0', 'n6vck6ah0f', 'jswwlq7xb', '72fxa7ryfd', 'z16ni', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t3__c71371', 'tsj3ayxp1q4', '01jh3den', 'c68x8vacx', 'afu5w1of7', 'pzo72ctdc', 'mfg62', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('G', 'of', 'szdo2z', 'obb0q0k32o', 'w', 'l', '5amsorlwyngc', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t4__716054', 'v1rgeza', 'xc1clupgly', '8oitxeilp', 'e019cy7od0', '3dlhdsvn', 'ed', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 'hvdlttilbnpr', 'dpos', 'ie5', 'nw6klf', 'a9000t5c4eci', 'gce376nium52', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_8', NULL, 'hvdlttilbnpr', 'dpos', 'ie5', 'nw6klf', 'a9000t5c4eci', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('B', 'e376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9', 'l7', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_10', NULL, 'hncprjtu0dz', '9fjgq8n2f', 'dqv0gcb9', 'ozk3zbily', 'kn6vc', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('!', 'h0f8jswwlq', 'xb72fxa7r', 'fdrz16n', 'jja', '5dh', 'ogrgjd8y', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_12', NULL, '7cvtjpt', 'tg6bnou5zi', '6c4bfkfo', 'c', '0', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('C', 'ezjo7wg', 'd5ysxc', 'r0oz', 'dgj5i', 'lq5lnpim', 'k58qs27p', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_14', NULL, 'a9n0jxfo', 'ws', 'do2zobb', 'q0k32od', 'cl5ams', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('D', 'wyn', 'gc1dj9erhi', 'zgk1yoeyo6l0', 'dt', 'fuqyxuzkb', '521gwnlas6e', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_16', NULL, '162nh55y3d', 'ohvu06dza3', 'rmkio18r', 'i2hy08ftp6', 'wt', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('F', 'njabym', 'n2mfx7h', '3p6sto1c', '8sh', 'knzys7dy', 'yd1jmgjach8', -2147483648, 'major_id_1');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__530350', 'Yearly Kickoff', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__c6f86e', 'Yearly Kickoff', 'jsl', 'b4yp5qi', 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', 'Yearly Kickoff', '07cvtjpt', 'tg6bnou5zi', '6c4bfkfo', 'c', '0');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('O', '7z2zezjo7wg', 'd5ysxc', 'r0oz', 'dgj5i', 'lq5lnpim', 'k58qs27p');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('G', 'uzkb52', 'gwnlas6', 'elboeowii1', '5nxih66', 'q2xlyoto', '9oaawg');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('C', '6dza35r', 'mkio18ri2hy', '08ftp6ewtqxx', 'jaby', 'mzn2mfx7h3', 'p6sto1cj');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__a0346d', 'Yearly Kickoff', '8hlst1p', 'qomiztvb6m', 'iz78aqql', 'd8ftb8', '9114q');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('@', NULL, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('B', 'Yearly Kickoff', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('D', 'Yearly Kickoff', 'jsl', 'b4yp5qi', 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('`', 'Yearly Kickoff', 'jh3den8', 'c68x8vacx7', 'f', '5w1of7', 'pzo72ctdc');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('E', 'Yearly Kickoff', 'e578', 'fvy', '7zzbe8y', 'kv42q7', 'x58b4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('J', 'Yearly Kickoff', '9oaawg', '6aqb0tbin', 'z', '9tajz9td', 'n5wcgumbc');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', 'luhvdltti', 'bnp', 'mdpos');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'ie5', 'nw6klf', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof');

-- Inserting into table: budget --
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t2__e8b666', 'hria2ypuzhs', 663.049759, 711.020062, 1908028688, 'p', 't1__530350');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t2__a0b481', 'wb', 50.647649, 185.427628, 1581736075, 'gndqwnqc', 't1__530350');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('A', 'tmu2n', 76.823924, 572.833475, -1402164108, 'yz7zzb', 't1__530350');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('G', 'v42', 258.625847, 783.973422, -2060082151, 'pmaus3auvmkr', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('O', 'ayq3', 833.617436, 578.439563, 1032339628, 'uap9', 'G');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_6', 'r', 70.018028, 508.519106, -1537647691, 'uuwsj8kjh8', 't2__a0346d');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t3__329352', 'gc8s3b7v88k', 354.964361, 916.71268, 1633584225, 'd', 't1__530350');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_8', 'u2g', 828.819416, 131.373165, 1352531282, 'vwq51oa', 't2__a0346d');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_9', 'esap8pgck', 254.908527, 299.4394, 1092207544, 'r54o6qjektb1', 't2__a0346d');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('@', 'hria2ypuzhs', 663.049759, 711.020062, 1908028688, 'p', '@');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('B', 'hria2ypuzhs', 663.049759, 711.020062, 1908028688, 'p', 'B');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('E', 'wb', 50.647649, 185.427628, 1581736075, 'gndqwnqc', 'D');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('H', 'mfg62', 93.813527, 935.463334, 820970595, 'qdjpe1io2', '`');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('C', 'pmaus3auvmkr', 641.973572, 49.701386, 1105964624, 'w5chn9m', 'E');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('D', '3tdu6bd0w960', 460.649748, 672.384779, 2018368241, 'xw1rxe9yfk7', 'J');

-- Inserting into table: expense --
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_1', 'klex14ji', '7zwau2dwyr', 262.105498, '3pyu78d99r', 't3__0f2727', 't2__e8b666');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_2', 'jai', 'dh5ogrgj', 54.980195, 'yzt1afgog', 'A', 't2__e8b666');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_3', '0v', 'q8qdjpe1', 140.053935, '2278', 't3__c71371', 't2__e8b666');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_4', '4gth2mnaj', 'la3', 588.850908, 'kv8u', 't3__0f2727', 't2__e8b666');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_5', 'pdjwzw5chn9', 'o705', 858.19408, '9', 't3__0f2727', 'G');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_6', 'dj9erhi', 'zgk1yoeyo6l0', 124.067083, '6fuqy', 'G', 't2__e8b666');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_7', '0', 'bindz', 466.613431, 'ajz9t', 't3__0f2727', 't2__e8b666');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_8', '5wcgumbc3td', 'u6bd0w9603', 594.051247, 'zxw1rx', 't3__0f2727', 'G');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_9', 'k7', 'k162n', 111.965818, '5y3dohvu', 'G', 't2__e8b666');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_10', 'knzys7dy', 'yd1jmgjach8', 726.733068, 'ta8y3a17v4', 't3__0f2727', 't2__e8b666');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_11', 'rntdqrhm5', 'wlic7dn2np', 480.228838, '0xdmsqtgel', 't3__0f2727', 'O');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_12', 'qb9i9f2ccu', 'jq1', 256.829372, 'ik1yhb', 'G', 't2__e8b666');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_13', 'xlvr', 'sur', 840.394555, '0kaqtnc', 't3__0f2727', 't2__e8b666');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('I', 'j47nxar50', 'sj', 115.267985, 'zxdp', 't3__0f2727', 't3__329352');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('A', 'nmwfwx', 'rlawk', 417.346356, '14r5dqtsmg97', 't3__0f2727', 't3__329352');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('O', '2o20pj6', 'd', 783.349866, 'su6iphd', 't3__0f2727', 't2__e8b666');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_17', '3', 'oi1pav', 781.008765, 'wnyqro', 't3__0f2727', 't2__e8b666');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('G', 'lrpou', 't63', 634.169429, 'yfvmjw', 't3__0f2727', 't3__329352');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('Q', '6mb3aj0j', '0h3r13', 463.478104, 'r1axyyhpl2i', 't3__0f2727', 't2__e8b666');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_20', 'zg3r', 'jkwns47j2j', 13.17027, '8dccy3vjwq4', 't3__0f2727', 't2__e8b666');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_21', 'dxdo2v', '7t3gvplj9f', 146.155144, 'uun7k10z2my1', 't3__0f2727', 't2__e8b666');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_22', '26u331spxpw3', 'bgwkxgi', 594.167398, 'j6i', 't3__0f2727', 't2__e8b666');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_23', '61l2', 'o3ak162ocagj', 816.974484, 'vx', 't3__0f2727', 't2__e8b666');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('@', 'zbuo4nrqrof', 'qyp5s5bbp0', 673.065986, 'eutliqa11r', '@', '@');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('B', 'klex14ji', '7zwau2dwyr', 262.105498, '3pyu78d99r', 'B', 'B');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('C', 't1afgog', 'itsj3', 15.432127, 'xp1q430', '!', 'E');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('D', 'r94gth2m', 'ajjl', 11.892553, 'okv8uttmu2', 'C', 'H');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('$', 'lboeowii1z5', 'xih6', 946.669761, 'q2xlyoto', 'D', 'C');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('%', 'qta8y3a17v4y', 'ma', 383.770043, 'qdpuap96', 'F', 'D');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T4.first_name, T4.last_name FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget INNER JOIN member AS T4 ON T3.link_to_member = T4.member_id WHERE T1.event_name = 'Yearly Kickoff';

/*
Gold Result:
('t4__430f2f', 't4__b451b0')
('t4__430f2f', 't4__b451b0')
('tsj3ayxp1q4', '01jh3den')
('t4__430f2f', 't4__b451b0')
('t4__430f2f', 't4__b451b0')
('of', 'szdo2z')
('t4__430f2f', 't4__b451b0')
('t4__430f2f', 't4__b451b0')
('of', 'szdo2z')
('t4__430f2f', 't4__b451b0')
('of', 'szdo2z')
('t4__430f2f', 't4__b451b0')
('t4__430f2f', 't4__b451b0')
('t4__430f2f', 't4__b451b0')
('t4__430f2f', 't4__b451b0')
('t4__430f2f', 't4__b451b0')
('t4__430f2f', 't4__b451b0')
('t4__430f2f', 't4__b451b0')
('t4__430f2f', 't4__b451b0')
('t4__430f2f', 't4__b451b0')
('t4__430f2f', 't4__b451b0')
('t4__430f2f', 't4__b451b0')
('e376nium52', 'zbuo4nrqrof')
('h0f8jswwlq', 'xb72fxa7r')
('ezjo7wg', 'd5ysxc')
('wyn', 'gc1dj9erhi')
('njabym', 'n2mfx7h')
*/

-- Prediction Query
SELECT DISTINCT m.first_name, m.last_name FROM member AS m INNER JOIN expense AS e ON m.member_id = e.link_to_member INNER JOIN budget AS b ON e.link_to_budget = b.budget_id INNER JOIN event AS ev ON b.link_to_event = ev.event_id WHERE ev.event_name = 'Yearly Kickoff';

/*
Prediction Result:
('t4__430f2f', 't4__b451b0')
('tsj3ayxp1q4', '01jh3den')
('of', 'szdo2z')
('e376nium52', 'zbuo4nrqrof')
('h0f8jswwlq', 'xb72fxa7r')
('ezjo7wg', 'd5ysxc')
('wyn', 'gc1dj9erhi')
('njabym', 'n2mfx7h')
*/