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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__bee785', 't1__3add15', 't1__eecc1b', 'tti', 'bnp', 'mdpos', 'ie5', -2147483648, 'C');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('C', 't1__3add15', 't1__eecc1b', 'u', '4nrq', 'rofqyp5s5b', 'p', -2147483648, 't1__2807e8');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 't1__3add15', 't1__eecc1b', 'xa', '7ryfdrz16n', 'jja', '5dh', -2147483648, '?');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 't1__3add15', 't1__eecc1b', 'w1of77pz', '72ct', 'c', 'mfg62', -2147483648, 'O');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_4', 't1__3add15', 't1__eecc1b', 'v5q8qdj', 'e1io', '278507cv', 'jpttg', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('?', 't1__3add15', 't1__eecc1b', '8uttmu', 'ne578lfv', 'yz7zzbe8yvk', 'v42q7sx58b4p', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_7', 't1__3add15', 't1__eecc1b', 'yxuzk', '5', '1gwnlas6', 'elboeowii1', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', 't1__3add15', 't1__eecc1b', 'y0', '8ftp6ewtqx', 'njabym', 'n2mfx7h', -2147483648, 'O');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('_', 't1__3add15', 't1__eecc1b', 'cuq', '9', 'i9f2ccukjq1q', 'ik1yhb', -2147483648, '_');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('B', 'u7', 'fe4hri', 'a2ypuzhsrwbb', 'p6luhvdlttil', 'n', 'rmdp', -2147483648, '`');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_1', '02eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr', '13pyu');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('C', 't2__f8f3a8', '5k5swwqcgs', '9n8');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t1__2807e8', 'nw6klf', 'a9000t5c4eci', 'gce376nium52');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('@', 't2__f8f3a8', 'z', '9fjgq8n2f');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('A', 'dqv0gcb9', 'ozk3zbily', 'kn6vc');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('?', 'ah0f8jsww', 'q7x', '7');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('O', 't2__f8f3a8', 'c68x8vacx7', 'f');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Q', 't2__f8f3a8', '9erhizgk1yoe', 'o6l0hdt');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t1__031a91', 't2__f8f3a8', 'g', 'mbc3td');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('_', 't2__f8f3a8', 'p490', 'dmsqtg');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('G', 't2__f8f3a8', 'surz0kaqtncg', 'c8s3b7v88k');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t2__7f2175', '14r5dqt', 'mg97a', 'z2o20');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('`', '5k5swwqcgs', '9n8', '4');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, '4', 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd');

-- Inserting into table: budget --
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_1', '8d99rljsl', 419.361606, 470.165282, 1692174491, 'qi2rkf9v', 'event_id_1');

-- Inserting into table: expense --
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_1', 'x58pz', 'f8jegd2', 100.01, 'vy9uxj4', 't1__bee785', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_2', 'bdvlph', 'gndqwnqc', 100.01, 'x5hncprjtu0', 't1__bee785', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_3', 'grgj', '8', 100.01, 'yzt1afgogrit', 't1__bee785', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_4', '3ay', 'p1q430', 100.01, 'jh3den8', 't1__bee785', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_5', 'ou5z', '36c', 100.01, 'bfkfoacd', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_6', '7z2zezjo7wg', 'd5ysxc', 100.01, 'r0oz', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_7', '5i3', 'q5l', 100.01, 'pim5', 't1__bee785', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_8', '8qs27p2r', '4gth2mnaj', 100.01, 'la3', 't1__bee785', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_9', 'u', '3auvm', 100.01, 'rpd', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_10', 'wzw5chn9mo70', 'a9n0jxfo', 100.01, 'ws', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_11', '2zobb0q0k32o', 'w', 100.01, 'l', 't1__bee785', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_12', 'amsorlwyng', '1', 100.01, 'j', 't1__bee785', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_13', 'nxih662q', 'xlyotow9', 100.01, 'aawg', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_14', 'qb0tbindz39t', 'j', 100.01, '9td8n5w', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_15', 'w9603vz', 'xw1rxe9yfk7', 100.01, 'k162n', 't1__bee785', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_16', '55y3dohvu06d', 'a35rmki', 100.01, '18ri', 't1__bee785', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('O', '6sto', 'cj8sh5k', 100.01, 'zys7', 'O', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('A', 'yd1jmgj', 'c', 100.01, '8q', 'O', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_19', 'a17v4ygm', 'y', 100.01, '3qdpu', 't1__bee785', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_20', '96rn', 'dqrhm', 100.01, 'wlic7dn2', 't1__bee785', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('G', 'st1', 'qomi', 100.01, 'tvb6m4i', '_', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_22', 'ud8', 'tb', 100.01, 'r9114qbre', 't1__bee785', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_23', 'jeuuwsj8kj', '85', 100.01, 'pxlvri', 't1__bee785', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_24', '6j47n', 'ar50hs', 100.0, 'han', 't1__bee785', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_25', 'dpunmw', 'wx', 100.0, 'rlawk', 't1__bee785', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_26', 'dlysu6iphd', 'u2g', 100.01, 'r31', 't1__bee785', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_27', 'q51oa2', 'sb3uoi1pavcv', 100.01, 'wnyqrouirlrp', 't1__bee785', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_28', '63xyf', 'mjwpp2', 100.01, 'mb3aj0ju0', 't1__bee785', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_29', 'r133ir1a', 'yyhpl2', 100.01, '9es', 't1__bee785', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_30', 'gckqwtsr54', '6qje', 100.01, 'ktb1d2nzg3rj', 't1__bee785', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_31', 'ns47j2', 'a8d', 100.01, 'c', 't1__bee785', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('@', 'siie5unw6k', 'fa9', NULL, '00t5c4e', 'B', 'budget_id_1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.first_name, T1.last_name, T2.major_name FROM member AS T1 INNER JOIN major AS T2 ON T2.major_id = T1.link_to_major INNER JOIN expense AS T3 ON T1.member_id = T3.link_to_member WHERE T3.cost > 100;

/*
Gold Result:
('t1__3add15', 't1__eecc1b', 't2__f8f3a8')
('t1__3add15', 't1__eecc1b', 'ah0f8jsww')
*/

-- Prediction Query
SELECT T1.first_name, T1.last_name, T2.major_name FROM member AS T1 JOIN expense AS T3 ON T1.member_id = T3.link_to_member JOIN major AS T2 ON T1.link_to_major = T2.major_id WHERE T3.cost > 100;

/*
Prediction Result:
('t1__3add15', 't1__eecc1b', 't2__f8f3a8')
('t1__3add15', 't1__eecc1b', 't2__f8f3a8')
('t1__3add15', 't1__eecc1b', 't2__f8f3a8')
('t1__3add15', 't1__eecc1b', 't2__f8f3a8')
('t1__3add15', 't1__eecc1b', 'ah0f8jsww')
('t1__3add15', 't1__eecc1b', 'ah0f8jsww')
('t1__3add15', 't1__eecc1b', 't2__f8f3a8')
('t1__3add15', 't1__eecc1b', 't2__f8f3a8')
('t1__3add15', 't1__eecc1b', 'ah0f8jsww')
('t1__3add15', 't1__eecc1b', 'ah0f8jsww')
('t1__3add15', 't1__eecc1b', 't2__f8f3a8')
('t1__3add15', 't1__eecc1b', 't2__f8f3a8')
('t1__3add15', 't1__eecc1b', 'ah0f8jsww')
('t1__3add15', 't1__eecc1b', 'ah0f8jsww')
('t1__3add15', 't1__eecc1b', 't2__f8f3a8')
('t1__3add15', 't1__eecc1b', 't2__f8f3a8')
('t1__3add15', 't1__eecc1b', 't2__f8f3a8')
('t1__3add15', 't1__eecc1b', 't2__f8f3a8')
('t1__3add15', 't1__eecc1b', 't2__f8f3a8')
('t1__3add15', 't1__eecc1b', 't2__f8f3a8')
('t1__3add15', 't1__eecc1b', 't2__f8f3a8')
('t1__3add15', 't1__eecc1b', 't2__f8f3a8')
('t1__3add15', 't1__eecc1b', 't2__f8f3a8')
('t1__3add15', 't1__eecc1b', 't2__f8f3a8')
('t1__3add15', 't1__eecc1b', 't2__f8f3a8')
('t1__3add15', 't1__eecc1b', 't2__f8f3a8')
('t1__3add15', 't1__eecc1b', 't2__f8f3a8')
('t1__3add15', 't1__eecc1b', 't2__f8f3a8')
('t1__3add15', 't1__eecc1b', 't2__f8f3a8')
*/