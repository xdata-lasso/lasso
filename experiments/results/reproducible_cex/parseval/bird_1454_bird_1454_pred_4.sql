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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__7c8c55', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', 'wb', 'v', 'ph2', 'nd', 'wnqcx', '5hncprjtu0d');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('C', '79fjgq8', 'n2f3dqv0gcb9', 'ozk3zbily', 'kn6vc', '6ah', 'f8jswwl');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('G', '72ctdctmfg62', '0v', 'q8qdjpe1', 'o22', '8507cvtjp', 'ttg6bnou5zi3');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('_', 'pim5', '58q', 's27p2r94gth2', 'najj', 'a3o', 'v8u');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__da1e06', 'wzw5chn9mo70', 'a9n0jxfo', 'ws', 'do2zobb', 'q0k32od', 'cl5ams');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('!', '5k5swwqcgs', '9n8', 'Game', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('$', 'ie5', 'nw6klf', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('I', '2eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr', '13pyu');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('@', '5k5swwqcgs', '9n8', 'Game', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('B', 'ie5', 'nw6klf', 'Game', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('"', 'yrq13p', 'u78d99r', 'Game', 'jsl', 'b4yp5qi', 'rkf9vqx5');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('`', '5hncprjtu0d', '79fjgq8', 'Game', 'n2f3dqv0gcb9', 'ozk3zbily', 'kn6vc');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', '5u', 'w6kl', 'a9');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, '00t5c4e', 'cigce376nium', '52zbuo4nrq', 'rofqyp5s5b', 'p');

-- Inserting into table: budget --
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t2__f1a52b', 'rwbbp6luhvd', 179.378884, 304.02808, -1364429300, 'nprmdposii', 't1__7c8c55');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('A', 'dh5ogrgj', 54.980195, 958.424773, -458359144, '1afgogritsj', 't1__7c8c55');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('G', 'y', 360.694313, 959.196496, 1792827279, '4301jh3den8', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t3__71d71a', 'iz', 106.602942, 166.233687, -499913447, 'yo', 't1__7c8c55');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('O', 'aawg', 555.75468, 743.240647, 966412849, '0', 't2__da1e06');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('E', 'hria2ypuzhs', 663.049759, 711.020062, 1908028688, 'p', '!');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('@', '8d99rljsl', 419.361606, 470.165282, 1692174491, 'qi2rkf9v', '$');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('C', 'x58pz0f8je', 755.698226, 778.537349, 910894705, '1vy9uxj4', '_');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('B', 'hria2ypuzhs', 663.049759, 711.020062, 1908028688, 'p', '@');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('F', 'qyp5s5bbp0', 673.065986, 825.231787, -1822992503, 'liqa1', 'B');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('J', 'pz0f8jegd', 452.27611, 434.003102, 233994589, 'j4hwbd', '"');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('b', '6ah', 418.948509, 532.326819, -932772113, 'lq7xb7', '`');

-- Inserting into table: expense --
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_1', '8d99rljsl', 'b4yp5qi', 447.109657, 'f9v', 'member_id_1', 't2__f1a52b');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_2', 'x58pz0f8je', 'd2', 890.091601, 'y9uxj4', 'member_id_1', 't2__f1a52b');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_3', 'xb72fxa7r', 'fdrz16n', 130.468488, 'jai', 'member_id_1', 't2__f1a52b');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_4', '68x8vacx7a', 'u5', 354.593207, 'of77pzo', 'member_id_1', 'G');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_5', 'bfkfoacd', '7z2zezj', 837.309049, 'wgxd5ysxc', 'member_id_1', 't2__f1a52b');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_6', '0oztd', 'j5', 125.223349, 'q5l', 'member_id_1', 'G');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_7', 'tmu2ne578l', 'vy', 392.947196, 'zzbe8yvkv', 'member_id_1', 't2__f1a52b');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_8', 'q7sx58b4', 'pmaus3auvmkr', 641.973572, 'j', 'member_id_1', 'G');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_9', 'lwyng', '1', 48.973066, '9er', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('I', 'hdt6fuq', 'xuzkb52', 435.41097, 'nlas6e', 'member_id_1', 't3__71d71a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('A', 'boeowii1z5nx', 'h66', 441.511648, 'xlyotow9', 'member_id_1', 't3__71d71a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_12', 'i', 'ndz39tajz9', 304.069184, 'n5wcgumbc', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('G', 'tdu6bd0w96', '3vzxw1r', 372.360229, '9y', 'member_id_1', 't3__71d71a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_14', 'qk162nh55', '3dohvu0', 507.185482, 'a35rmki', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('O', '8ri2hy0', '8ftp6ewtqx', 361.5356, 'jaby', 'member_id_1', 't3__71d71a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_16', 'mfx7h33p', '6sto1cj8sh5k', NULL, 'zys7', 'member_id_1', 't2__f1a52b');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_17', 'yd1jmgj', 'c', NULL, '8q', 'member_id_1', 't2__f1a52b');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_18', 'a8y3a17v4yg', 'mayq3qdpua', NULL, '96rn', 'member_id_1', 't2__f1a52b');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_19', 'q', 'hm5wl', NULL, 'c7d', 'member_id_1', 't2__f1a52b');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_20', 'np490xdm', 'sqtgelcuqb', NULL, 'i9f2ccukj', 'member_id_1', 't2__f1a52b');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_21', '1quik1yhb08h', 'st1', NULL, 'qomi', 'member_id_1', 't2__f1a52b');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('@', 'hvdltt', 'lbn', 240.969194, 'mdpos', 'member_id_1', 'E');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_23', 'bdvlph', 'gndqwnqc', 629.317167, '5hncprjtu0d', 'member_id_1', '@');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('M', 'gq8', 'n2f3dqv0gcb9', 1.0, 'ozk3zbily', 'member_id_1', '@');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('P', 'n6vck6ah0f', 'jswwlq7xb', 1.0, '72fxa7ryfd', 'member_id_1', 'O');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('`', 'hvdltt', 'lbn', 240.969194, 'mdpos', 'member_id_1', 'B');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('a', 'yytoo', 'o9hl72kl', 74.250383, 'x14ji7zwau2d', 'member_id_1', 'F');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('!', 'ph2', 'nd', 893.16532, 'wnqcx', 'member_id_1', 'J');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('"', 'xa', '7ryfdrz16n', 130.468488, 'jai', 'member_id_1', 'b');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(CASE WHEN T1.type = 'Game' THEN T3.cost ELSE 0 END) * 100 / SUM(T3.cost) FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget;

/*
Gold Result:
(18.581989898541813,)
*/

-- Prediction Query
SELECT SUM(t1.cost) * 100.0 / COUNT(DISTINCT t2.event_id) AS percentage FROM expense AS t1 INNER JOIN budget AS t3 ON t1.link_to_budget = t3.budget_id INNER JOIN event AS t2 ON t3.link_to_event = t2.event_id WHERE t2.type = 'Meeting';

/*
Prediction Result:
(None,)
*/