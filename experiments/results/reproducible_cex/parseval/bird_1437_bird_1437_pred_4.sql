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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__95cbc4', 'bnp', 'mdpos', 'ie5', 'nw6klf', 'a9000t5c4eci', 'gce376nium52', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 'i2rkf', 'vqx58pz0f', '8jegd21vy9ux', 'j4hwbdvlph', 'gndqwnqc', 'x5hncprjtu0', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', '8n2f3', 'dqv0gcb98ozk', 'zbilyrkn', '6vck6ah0f8js', 'wlq7xb', '72fxa7ryfd', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('G', 'dh5ogrgj', '8', 'yzt1afgogrit', 'sj3ayxp1q430', 'jh3den8', 'c68x8vacx7', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('I', 'g6', 'g0v5q8qd', 'jpe1io22785', '7cvtjpt', 'tg6bnou5zi', '6c4bfkfo', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('E', 'xcmr0', 'ztdg', '5i3', 'q5l', 'pim5', '58q', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', '2m', 'ajjl', '3', 'okv8uttmu2', 'e578', 'fvy', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('C', '58b4pmaus3a', 'vmkrpd', 'wzw', 'chn9mo70', 'a9n0jxfo', 'ws', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t2__a25da1', 'yo', 'l0hdt6fuq', 'xuzkb52', 'gwnlas6', 'elboeowii1', '5nxih66', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t3__261d2e', 'xlyotow9', 'aawg', '6aqb0tbin', 'z', '9tajz9td', 'n5wcgumbc', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('exp_faddb0', 'wwqcg', 'k9n8c', 'pgu7vfe4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_12', 'z16ni', 'jai', 'dh5ogrgj', '8', 'yzt1afgogrit', 'sj3ayxp1q430', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_13', 'den8c68x', 'vacx7afu5', '1of77p', 'o72ctdc', 'mfg62', '0v', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_14', 'ztdg', '5i3', 'q5l', 'pim5', '58q', 's27p2r94gth2', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_15', '7sx58', 'b4pmaus3auv', 'krpd', 'wzw', 'chn9mo70', 'a9n0jxfo', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_16', 'k1', 'yoeyo6l0hdt6', 'uq', 'xuzkb52', 'gwnlas6', 'elboeowii1', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_17', 'xih662q2xly', 'otow9oaawg', '6aqb0tbin', 'z', '9tajz9td', 'n5wcgumbc', -2147483648, 'major_id_1');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t3__199d22', 'uo4nrqrofqy', '5s5b', 'p', '02eutliqa11r', 'ytoo3o9', 'l7');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('att_5f0c18', 'gce376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9', 'l7');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', '5k5swwqcgs', '9n8', '4');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti');

-- Inserting into table: budget --
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_1', 'lex', 913.303855, 482.572691, 105869088, 'au2dwy', 't3__199d22');

-- Inserting into table: attendance --
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t3__199d22', 't1__95cbc4');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t3__199d22', '@');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t3__199d22', 't3__261d2e');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('att_5f0c18', 'C');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('att_5f0c18', 'A');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('att_5f0c18', 'I');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('att_5f0c18', 't3__261d2e');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('att_5f0c18', 'O');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('att_5f0c18', 't2__a25da1');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('att_5f0c18', 'member_id_12');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('att_5f0c18', 'member_id_13');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('att_5f0c18', 'G');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('att_5f0c18', 'member_id_14');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('att_5f0c18', 'member_id_15');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('att_5f0c18', '@');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('att_5f0c18', 'member_id_16');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('att_5f0c18', 'member_id_17');

-- Inserting into table: expense --
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('A', 'q13py', '2019-01-10', 326.912005, 'true', 't1__95cbc4', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('C', '9rljsl0b4', '2019-01-10', 884.000446, 'true', 't1__95cbc4', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('O', 'z16ni', '2019-01-10', 968.276986, 'true', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('G', '1of77pzo72c', '2019-01-10', 308.935851, 'true', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('_', 'zezjo7wg', '2019-01-10', 790.772456, 'true', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_6', 'bnp', 'mdpos', 133.007885, '5u', 'exp_faddb0', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_7', '6klfa9', '00t5c4e', 950.466571, 'i', 'exp_faddb0', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_8', 'x1', 'ji7zwau2', 920.013763, 'dwyrq13pyu78', 'exp_faddb0', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_9', '9rljsl0b4', 'p5qi2rk', 811.601922, '9v', 'exp_faddb0', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_10', '8pz0f8je', 'd2', 890.091601, 'y9uxj4', 'exp_faddb0', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_11', 'bdvlph', 'gndqwnqc', 629.317167, '5hncprjtu0d', 'exp_faddb0', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_12', 'gq8', 'n2f3dqv0gcb9', 540.154414, 'k3zbily', 'exp_faddb0', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_13', 'kn6vck6ah0f8', 'sww', 176.824244, 'xb72fxa7r', 'exp_faddb0', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_14', 'q8qdjpe1io22', '8507cvtjp', 789.724834, 'ttg6bnou5zi3', 'exp_faddb0', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_15', 'bfkfoacd', '7z2zezj', 837.309049, 'wgxd5ysxc', 'exp_faddb0', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_16', 'ajjl', '3', 588.850908, 'kv8u', 'exp_faddb0', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_17', 'tmu2ne578l', 'vy', 392.947196, 'zzbe8yvkv', 'exp_faddb0', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_18', 'zdo2z', 'obb0q0k32o', 57.929422, 'l', 'exp_faddb0', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_19', 'amsorlwyng', '1', 48.973066, '9er', 'exp_faddb0', 'budget_id_1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.link_to_member, T3.link_to_event FROM expense AS T1 INNER JOIN member AS T2 ON T1.link_to_member = T2.member_id INNER JOIN attendance AS T3 ON T2.member_id = T3.link_to_member WHERE DATE(SUBSTRING(T1.expense_date, 1, 10)) BETWEEN '2019-01-10' AND '2019-11-19' AND T1.approved = 'true';

/*
Gold Result:
('t1__95cbc4', 't3__199d22')
('A', 'att_5f0c18')
*/

-- Prediction Query
SELECT T2.first_name, T2.last_name, T3.link_to_event FROM expense AS T1 JOIN attendance AS T3 ON T1.link_to_member = T3.link_to_member JOIN member AS T2 ON T3.link_to_member = T2.member_id WHERE T1.approved = 'true' AND T1.expense_date BETWEEN '2019-01-10' AND '2019-11-19';

/*
Prediction Result:
('bnp', 'mdpos', 't3__199d22')
('bnp', 'mdpos', 't3__199d22')
('8n2f3', 'dqv0gcb98ozk', 'att_5f0c18')
('8n2f3', 'dqv0gcb98ozk', 'att_5f0c18')
('8n2f3', 'dqv0gcb98ozk', 'att_5f0c18')
*/