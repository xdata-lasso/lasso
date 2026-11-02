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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', 't1__3692c4', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('C', 't1__3692c4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'bnp', 'mdpos');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('O', 'dqv0gcb98ozk', 'zbilyrkn', '6vck6ah0f8js', 'wlq7xb', '72fxa7ryfd', 'z16ni');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__75667d', 't1__3692c4', '8', 'yzt1afgogrit', 'sj3ayxp1q430', 'jh3den8', 'c68x8vacx7');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('_', 'ttg6bnou5zi3', 'c4bfkfoac', '0', '7z2zezjo7wg', 'd5ysxc', 'r0oz');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__431066', 't1__3692c4', '2zobb0q0k32o', 'w', 'l', '5amsorlwyngc', 'dj9erhi');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('!', '14r5dqt', 'mg97a', 'z2o20', 'pj6ddlysu6ip', 'dk', 'u2gir31vwq5');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('G', 'axyyhpl', 'i9esap8p', 'gckqwtsr54', '6qje', 'ktb1d2nzg3rj', 'wns');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('@', 'txe', 'lpe', '19cy7od', '033dlhdsvnh', 'd2', '9lqv26u331s');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr', '13pyu');

-- Inserting into table: budget --
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t2__b8c683', 'Parking', 133.007885, 75.403642, -1209887326, 'klfa9000t', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t2__119c12', 'Parking', 827.854302, 983.124993, -1964997180, 'gce376nium52', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('A', 'Parking', 854.793228, 983.924121, -47052816, '1of77pzo72c', 't1__75667d');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('_', 'c', 803.582738, 695.452114, -1284905200, '62', 'O');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('?', '7p2r94gth2m', 925.474843, 211.248782, 418247369, 'jla', 't1__75667d');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('G', 'u', 337.117577, 160.717227, 274891948, 'pdjwzw5chn9', 't1__75667d');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_7', 'Parking', 746.006477, 106.602942, -499913447, 'yo', 't2__431066');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t3__5271cc', 'Parking', 668.530896, 841.944569, 1048147204, 'eowi', 't1__75667d');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_9', 'Parking', 853.967947, 590.777158, 1147652228, 'u', 't2__431066');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_10', 'Parking', 505.600334, 349.371383, -1051623642, 'njabym', 't2__431066');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_11', 'Parking', 219.484173, 922.347497, 1907670428, '3', 't1__75667d');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('@', 'oi1pav', 781.008765, 340.48601, 1645850786, 'yqro', '!');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_13', 'Parking', 519.969066, 740.685871, -1522433566, 'a8d', 'G');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('B', 'c', 377.389472, 584.512314, 1560573473, 'jwq49yrnxs', 'G');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_15', 'Parking', 367.690725, 246.280755, -165171643, 'g', 't1__75667d');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('`', 'kxginl', 767.869106, 871.584744, 1673977398, 'dmp61l2o3ak1', '@');

-- Inserting into table: expense --
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_1', 'v', 'ph2', 109.083092, 'dqwn', 'member_id_1', 't2__b8c683');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_2', 'x', '5hncprjtu0d', 395.809081, 'fjgq8n2f3', 'member_id_1', 't2__b8c683');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_3', 'ai5', 'h', 488.601669, 'grgj', 'member_id_1', 't2__b8c683');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_4', 'v5q8qdj', 'e1io', 443.690199, '8507cvtjp', 'member_id_1', '_');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_5', 'g', '5i3', 172.799686, '5lnpim5k58qs', 'member_id_1', 't2__b8c683');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_6', 'okv8uttmu2', 'e578', 944.379011, 'vy', 'member_id_1', '?');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_7', 'zzbe8yvkv', '42q7sx58b4', 710.005534, 'maus', 'member_id_1', 't2__b8c683');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_8', 'o705a9n0jxfo', 'ws', 900.422166, 'o', 'member_id_1', 'G');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_9', 'hdt6fuq', 'xuzkb52', 435.41097, 'nlas6e', 'member_id_1', 't2__b8c683');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('O', 'z5nxih6', '2q2xlyoto', 913.199755, 'oaawg96aq', 'member_id_1', 't3__5271cc');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('A', 'tbindz3', 'tajz9td8n', 655.746331, 'wcgumbc3', 'member_id_1', 't3__5271cc');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_12', 'd0w9603vzxw1', 'xe9yf', 958.39315, 'qk162nh55', 'member_id_1', 't2__b8c683');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('G', 'dohvu06d', 'a35rmki', 229.766946, 'ri2hy08ft', 'member_id_1', 't3__5271cc');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_14', 'n2mfx7h33p', '6sto1cj8sh5k', 207.572242, 'ys7dyyd', 'member_id_1', 't2__b8c683');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_15', 'jach8qta8y3', '1', NULL, 'v4ygmayq3', 'member_id_1', '_');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_16', 'uap9', 'rntdqrhm5', NULL, 'wlic7dn2np', 'member_id_1', '?');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_17', '0xdmsqtge', 'cuq', 27.252619, 'i9f2ccukjq1q', 'member_id_1', 't2__b8c683');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_18', '1yh', '0', NULL, 'hlst1pqom', 'member_id_1', 'G');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_19', 'tvb6m4iz78', 'q', NULL, 'lud8f', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_20', '8', '9114q', 19.495363, '6b', 'member_id_1', 't2__b8c683');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_21', 'uuwsj8kjh8', 'wpxlvris', NULL, 'urz0kaqtncg', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_22', 's3b7v88kw', 'm', NULL, 'b', 'member_id_1', 'budget_id_10');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_23', 't6', 'j47nxar50h', 607.211987, 'han', 'member_id_1', 't2__b8c683');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_24', 'dpunmw', 'wx', 257.835629, 'awk', 'member_id_1', 't2__b8c683');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('E', 'rlr', 'pouit63xyf', 0.0, 'mjwpp2', 'member_id_1', '@');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('@', '3', 'j', 0.5, '0ju0h3r133ir', 'member_id_1', 'budget_id_9');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('B', 'dxdo2v', '7t3gvplj9f', -1.0, 'vuu', 'member_id_1', 'B');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('H', 'k10z2my1o', 'gyv1rgezaxc', 0.0, '1clupgly78o', 'member_id_1', 'budget_id_13');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('`', 'cagj', 'ev', 0.0, 'zxlu49', 'member_id_1', '`');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('M', 'o', '8c', 0.5, 'e', 'member_id_1', 'G');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_name FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget WHERE T2.category = 'Parking' AND T3.cost < (SELECT AVG(cost) FROM expense);

/*
Gold Result:
('t1__3692c4',)
('t1__3692c4',)
('t1__3692c4',)
('t1__3692c4',)
('t1__3692c4',)
('t1__3692c4',)
('t1__3692c4',)
('t1__3692c4',)
('axyyhpl',)
*/

-- Prediction Query
SELECT T1.event_name FROM event AS T1 JOIN budget AS T2 ON T1.event_id = T2.link_to_event WHERE T2.category = 'Parking' AND T2.spent < (SELECT AVG(spent) FROM budget WHERE category = 'Parking');

/*
Prediction Result:
('t1__3692c4',)
('t1__3692c4',)
('t1__3692c4',)
('axyyhpl',)
('t1__3692c4',)
*/