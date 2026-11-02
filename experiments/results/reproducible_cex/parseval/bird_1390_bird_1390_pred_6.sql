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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_1', '02eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr', '13pyu', -2147483648, 'major_id_1');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('bud_7b42bc', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', 'dqv0gcb98ozk', 'zbilyrkn', '6vck6ah0f8js', 'wlq7xb', '72fxa7ryfd', 'z16ni');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('G', 'jai', 'dh5ogrgj', '8', 'yzt1afgogrit', 'sj3ayxp1q430', 'jh3den8');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('O', 'okv8uttmu2', 'e578', 'fvy', '7zzbe8y', 'kv42q7', 'x58b4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('eve_7693c8', '8', '5wcg', 'mbc3td', 'u6bd0w9603', 'vzxw1rxe9y', 'k7');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('bud_561b1c', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('`', 'rwbbp6luhvd', 'tti', 'bnp', 'mdpos', 'ie5', 'nw6klf');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('@', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('B', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('"', '52zbuo4nrq', 'rofqyp5s5b', 'p', '02eutliqa11r', 'ytoo3o9', 'l7');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('D', '9v', 'x58pz', 'f8jegd2', 'vy9uxj4', 'wb', 'v');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('#', 'dqv0gcb98ozk', 'zbilyrkn', '6vck6ah0f8js', 'wlq7xb', '72fxa7ryfd', 'z16ni');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('C', 'p1q430', 'jh3den8', 'c68x8vacx7', 'f', '5w1of7', 'pzo72ctdc');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('F', 'f', 'foa', 'cd07z2zezjo7', 'wgxd5ysxcm', '0oztd', 'j5');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', '5u', 'w6kl', 'a9');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, '00t5c4e', 'cigce376nium', '52zbuo4nrq', 'rofqyp5s5b', 'p');

-- Inserting into table: budget --
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('exp_3e45ca', 'rwbbp6luhvd', 179.378884, 304.02808, -1364429300, 'nprmdposii', 'bud_7b42bc');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('A', 'x58pz', 410.133844, 88.474525, -1529584866, 'd2', 'bud_7b42bc');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('O', 'y9uxj4', 124.573829, 22.63964, -736979194, 'h2gn', 'bud_7b42bc');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('_', '72ctdctmfg62', 93.813527, 935.463334, 820970595, 'qdjpe1io2', 'G');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('G', 'ysxcmr0o', 698.769833, 297.258735, -1699185893, '5i3lq5lnpim5', 'bud_7b42bc');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('bud_6073be', '162', 213.271827, 722.776931, 774922170, '3dohvu0', 'G');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('?', 'l7', 443.457804, 774.422647, -1390245819, 'x14ji7zwau2d', 'bud_561b1c');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('@', 'yrq13pyu78d9', 557.003843, 182.777264, -904834265, 'b4yp5qi', 'bud_561b1c');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('`', 'rwbbp6luhvd', 179.378884, 304.02808, -1364429300, 'nprmdposii', 'B');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('a', 'klex14ji', 598.409165, 394.443388, 481163439, '2dwyrq', '"');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('!', 'ph2', 109.083092, 802.414724, 1968874827, 'nqcx5h', 'D');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('"', 'jai', 906.609226, 62.386264, 1360271423, 'ogrgjd8y', '#');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('D', 'mfg62', 93.813527, 935.463334, 820970595, 'qdjpe1io2', 'C');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('B', '3lq', 913.609637, 922.974233, -1212676731, 'm5k', 'F');

-- Inserting into table: expense --
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_1', '8d99rljsl', 'b4yp5qi', 447.109657, 'f9v', 'member_id_1', 'exp_3e45ca');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_2', 'wnqcx', '5hncprjtu0d', 395.809081, 'fjgq8n2f3', 'member_id_1', 'O');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_3', '68x8vacx7a', 'u5', 354.593207, 'of77pzo', 'member_id_1', 'exp_3e45ca');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_4', '8507cvtjp', 'ttg6bnou5zi3', 510.534763, '4', 'member_id_1', '_');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_5', 'kf', 'oacd07z2zez', 147.932394, '7wgx', 'member_id_1', 'exp_3e45ca');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_6', '8qs27p2r', '4gth2mnaj', 155.873695, '3', 'member_id_1', 'G');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_7', 'aus3', 'u', 337.117577, 'rpd', 'member_id_1', 'exp_3e45ca');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('I', 'wzw5chn9mo70', 'a9n0jxfo', 82.48091, 'zdo2z', 'member_id_1', 'exp_3e45ca');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('A', 'b', 'q0k32od', 357.061424, '5am', 'member_id_1', 'exp_3e45ca');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_10', 'orlwyngc1dj', '9erhizgk1yoe', 845.392744, 'o6l0hdt6fu', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('G', 'xuzkb52', 'gwnlas6', 907.723998, 'lb', 'member_id_1', 'exp_3e45ca');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_12', 'wii1', '5nxih66', 441.511648, 'xlyotow9', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_13', 'g96aqb', 'tbindz3', 555.680342, 'ajz9t', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_14', 'a35rmki', '18ri', NULL, 'hy08ftp6', 'member_id_1', 'exp_3e45ca');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_15', 'tqxxnj', 'b', NULL, 'mzn2mfx', 'member_id_1', 'exp_3e45ca');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_16', '3p6sto1c', '8sh', NULL, 'knzys7dy', 'member_id_1', 'exp_3e45ca');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_17', '1', 'jmgjach8qt', NULL, 'a8y3a17v4yg', 'member_id_1', 'exp_3e45ca');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_18', 'y', '3qdpu', NULL, 'p', 'member_id_1', 'exp_3e45ca');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_19', 'tdqr', 'm5', NULL, 'wlic7dn2np', 'member_id_1', 'exp_3e45ca');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('C', 'kf9vq', 'x58pz0f8je', 1.0, 'd2', 'member_id_1', '?');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('E', '9uxj4hw', 'd', 1.0, 'lph2gn', 'member_id_1', '?');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('@', 'unw6klfa', '9000t5c4ec', 128.76421, 'gce376nium', 'member_id_1', '`');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('D', '3pyu78d99r', 'jsl', 419.361606, 'yp5qi2rk', 'member_id_1', 'a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('B', 'p', 'jtu0d', 395.809081, 'fjgq8n2f3', 'member_id_1', '!');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('`', '1afgo', 'ri', 630.468925, 'sj3ay', 'member_id_1', '"');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('b', '8507cvtjp', 'ttg6bnou5zi3', 510.534763, '4', 'member_id_1', 'D');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('F', 'qs27p2r94', 'th', 577.602934, 'najj', 'member_id_1', 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN T1.event_name = 'Yearly Kickoff' THEN T3.cost ELSE 0 END) AS REAL) * 100 / SUM(T3.cost) FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT (SUM("expense"."cost") FILTER(WHERE "event"."event_name" = 'Yearly Kickoff') * 100.0 / SUM("expense"."cost")) AS percentage FROM "expense" INNER JOIN "budget" ON "expense"."link_to_budget" = "budget"."budget_id" INNER JOIN "event" ON "budget"."link_to_event" = "event"."event_id";

/*
Prediction Result:
(None,)
*/