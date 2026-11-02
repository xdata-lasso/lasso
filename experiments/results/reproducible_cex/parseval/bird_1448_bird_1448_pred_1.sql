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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__5fced8', 't1__d21dc7', 't1__3e96c7', '5k5swwqcgs', '9n8', '4', 'gu7v');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', 't1__d21dc7', 't1__3e96c7', 'b4yp5qi', 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__90752a', 't1__d21dc7', 't1__3e96c7', 'wb', 'v', 'ph2', 'nd');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('G', 't1__d21dc7', 't1__3e96c7', '6vck6ah0f8js', 'wlq7xb', '72fxa7ryfd', 'z16ni');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('C', 't1__d21dc7', 't1__3e96c7', '8vacx7', 'f', '5w1of7', 'pzo72ctdc');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__8e447b', 't1__d21dc7', 't1__3e96c7', 'k58qs27p', 'r94gth2m', 'ajjl', '3');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('@', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('B', 'gce', '76nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('"', 'p5qi2rkf9v', 'x58pz', 'f8jegd2', 'vy9uxj4', 'wb', 'v');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('#', '79fjgq8', 'n2f3dqv0gcb9', 'ozk3zbily', 'kn6vc', '6ah', 'f8jswwl');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('b', 't1afgog', 'itsj3', 'y', 'p1q430', 'jh3den8', 'c68x8vacx7');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('`', 'mfg62', '0v', 'q8qdjpe1', 'o22', '8507cvtjp', 'ttg6bnou5zi3');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', 'uzhsrwbbp6lu', 'hvdlttilbnpr', 'dpos');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'ie5', 'nw6klf', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof');

-- Inserting into table: budget --
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t2__49c432', 'e4', 779.409124, 640.719621, 1160656988, 'ia2yp', 't1__5fced8');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t2__75d8d2', 'wnqcx', 668.309685, 635.267184, -1245312912, 'rjtu', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('_', 'ogrgjd8y', 763.019095, 308.482994, 1250290042, 'og', 't1__5fced8');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('A', 'tsj', 453.914926, 991.735454, -598313376, 'q4301jh', 't1__90752a');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('G', 'e1io', 443.690199, 518.274259, 2004147439, 'tjpttg', 't1__5fced8');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('I', 'cd07z2zezjo7', 570.824589, 108.948237, -542502665, 'ysxcmr0o', 't1__5fced8');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_7', 'okv8uttmu2', 208.49371, 497.427028, 1908593332, 'vy', 't2__8e447b');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t3__d38f6f', 'pmaus3auvmkr', 641.973572, 49.701386, 1105964624, 'w5chn9m', 't1__5fced8');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_9', '0k32o', 57.929422, 38.169466, 440115543, 'msorlwyngc', 't2__8e447b');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_10', '521gwnlas6e', 668.530896, 841.944569, 1048147204, 'eowi', 't2__8e447b');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('@', 'rwbbp6luhvd', 179.378884, 304.02808, -1364429300, 'nprmdposii', '@');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('D', 'l7', 443.457804, 774.422647, -1390245819, 'x14ji7zwau2d', 'B');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('`', 'ph2', 109.083092, 802.414724, 1968874827, 'nqcx5h', '"');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('B', '7xb72', 814.417862, 987.646344, -961217731, 'dr', '#');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('J', 'f', 313.653498, 489.044661, 645287482, 'f77p', 'b');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('C', 'c4bfkfoac', 60.937725, 413.382111, -406331049, 'ezjo7wg', '`');

-- Inserting into table: expense --
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_1', 'Pizza', '13pyu', 50.01, '8d99rljsl', 'member_id_1', 't2__49c432');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_2', 'Pizza', 'z', 50.01, '9fjgq8n2f', 'member_id_1', 't2__49c432');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_3', 'Pizza', 'dqv0gcb98ozk', 50.01, 'zbilyrkn', 'member_id_1', 't2__49c432');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_4', 'Pizza', 'ai5', 50.01, 'h', 'member_id_1', 't2__49c432');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_5', 'Pizza', 'e', 50.01, '8c68', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_6', 'Pizza', 'mfg62g0v5q8q', 50.01, 'j', 'member_id_1', 't2__49c432');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_7', 'Pizza', 'ou5z', 50.01, '36c', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_8', 'Pizza', 'f', 50.01, 'foa', 'member_id_1', 't2__49c432');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_9', 'Pizza', 'dgj5i', 50.01, 'lq5lnpim', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_10', 'Pizza', 'zzbe8yvkv', 50.01, '42q7sx58b4', 'member_id_1', 't2__49c432');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('O', 'Pizza', '05a9n0jxf', 50.01, 'fwsz', 'member_id_1', 't3__d38f6f');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('A', 'Pizza', '2zob', 50.01, '0', 'member_id_1', 't3__d38f6f');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_13', 'Pizza', 'j', 50.01, '9erhizgk1yoe', 'member_id_1', 't2__49c432');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('_', 'Pizza', 'o6l0hdt6fu', 50.01, 'yxuzk', 'member_id_1', 't3__d38f6f');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_15', 'Pizza', 'z5nxih6', 50.01, '2q2xlyoto', 'member_id_1', 't2__49c432');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_16', 't3__99ac95', 'awg96aqb0tbi', 50.01, 'ndz39tajz9', 'member_id_1', 't2__49c432');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_17', 'Pizza', '8', 50.0, '5wcg', 'member_id_1', 't2__49c432');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_18', 'Pizza', 'bc3t', 100.0, 'u', 'member_id_1', 't2__49c432');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_19', 'Pizza', 'd0w9603vzxw1', 50.01, 'xe9yf', 'member_id_1', 't2__49c432');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_20', 'Pizza', 'qk162nh55', 50.01, '3dohvu0', 'member_id_1', 't2__49c432');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('@', 'Pizza', 'unw6klfa', NULL, '9000t5c4ec', 'member_id_1', '@');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('`', 'Pizza', 'yrq13pyu78d9', NULL, 'rljsl0b4y', 'member_id_1', 'D');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('B', 'Pizza', 'p', NULL, 'jtu0d', 'member_id_1', '`');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('"', 'Pizza', '16nijjai5dh', NULL, 'ogrgjd8y', 'member_id_1', 'B');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('C', 'Pizza', '72ct', NULL, 'c', 'member_id_1', 'J');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('a', 'Pizza', '5', NULL, 'sxcmr0o', 'member_id_1', 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_name, T1.event_date FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget WHERE T3.expense_description = 'Pizza' AND T3.cost > 50 AND T3.cost < 100;

/*
Gold Result:
('t1__d21dc7', 't1__3e96c7')
('t1__d21dc7', 't1__3e96c7')
('t1__d21dc7', 't1__3e96c7')
('t1__d21dc7', 't1__3e96c7')
('t1__d21dc7', 't1__3e96c7')
('t1__d21dc7', 't1__3e96c7')
('t1__d21dc7', 't1__3e96c7')
('t1__d21dc7', 't1__3e96c7')
('t1__d21dc7', 't1__3e96c7')
('t1__d21dc7', 't1__3e96c7')
('t1__d21dc7', 't1__3e96c7')
('t1__d21dc7', 't1__3e96c7')
('t1__d21dc7', 't1__3e96c7')
('t1__d21dc7', 't1__3e96c7')
('t1__d21dc7', 't1__3e96c7')
('t1__d21dc7', 't1__3e96c7')
('t1__d21dc7', 't1__3e96c7')
*/

-- Prediction Query
SELECT T1.event_name, T1.event_date FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget WHERE T3.expense_description = 'Pizza' AND T3.cost BETWEEN 50 AND 100;

/*
Prediction Result:
('t1__d21dc7', 't1__3e96c7')
('t1__d21dc7', 't1__3e96c7')
('t1__d21dc7', 't1__3e96c7')
('t1__d21dc7', 't1__3e96c7')
('t1__d21dc7', 't1__3e96c7')
('t1__d21dc7', 't1__3e96c7')
('t1__d21dc7', 't1__3e96c7')
('t1__d21dc7', 't1__3e96c7')
('t1__d21dc7', 't1__3e96c7')
('t1__d21dc7', 't1__3e96c7')
('t1__d21dc7', 't1__3e96c7')
('t1__d21dc7', 't1__3e96c7')
('t1__d21dc7', 't1__3e96c7')
('t1__d21dc7', 't1__3e96c7')
('t1__d21dc7', 't1__3e96c7')
('t1__d21dc7', 't1__3e96c7')
('t1__d21dc7', 't1__3e96c7')
('t1__d21dc7', 't1__3e96c7')
('t1__d21dc7', 't1__3e96c7')
*/