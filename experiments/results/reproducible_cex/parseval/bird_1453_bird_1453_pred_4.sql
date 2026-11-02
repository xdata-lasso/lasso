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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', 't1__acc099', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__1514bd', 't1__acc099', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'bnp', 'mdpos');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('O', 'dqv0gcb98ozk', 'zbilyrkn', '6vck6ah0f8js', 'wlq7xb', '72fxa7ryfd', 'z16ni');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__08db7f', 't1__acc099', '8', 'yzt1afgogrit', 'sj3ayxp1q430', 'jh3den8', 'c68x8vacx7');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('_', '3lq', '5lnpim5k58qs', '7p2r94gt', '2m', 'ajjl', '3');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__9f57e7', 't1__acc099', 'mo705a9n0', 'xfo', 'ws', 'do2zobb', 'q0k32od');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('!', 'dbdh', '6j47n', 'ar50hs', 'han', 'xdpunmw', 'wx');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('@', 'mjwpp2', 'mb3aj0ju0', '3r', '133ir1axyy', 'hpl2i9esap', 'pgckqwtsr');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('B', '7k10', 'z2my1ogyv1r', 'ez', 'x', '1', 'l');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr', '13pyu');

-- Inserting into table: budget --
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t2__5da521', 'Parking', 133.007885, 75.403642, -1209887326, 'klfa9000t', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t2__922e4a', 'Parking', 827.854302, 983.124993, -1964997180, 'gce376nium52', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('A', 'Parking', 854.793228, 983.924121, -47052816, '1of77pzo72c', 't1__08db7f');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('O', 'c', 803.582738, 695.452114, -1284905200, '62', 'O');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('I', 'e', 543.387709, 386.117737, -72442907, '7sx58', '_');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t3__df569f', 'Parking', 722.415629, 230.654784, 1483450542, 'o6l0hdt6fu', 't1__08db7f');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('Q', 'Parking', 853.967947, 590.777158, 1147652228, 'u', 't2__9f57e7');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_8', 'Parking', 276.873433, 969.162867, -641927001, '14r5dqt', 'O');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('@', 'mg97a', 262.663904, 447.480136, -261782899, 'pj6ddlysu6ip', '!');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_10', 'Parking', 563.737346, 483.873235, 17776256, 'ekt', '@');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('B', '1', 840.973378, 451.237024, 946571403, '3r', '@');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_12', 'Parking', 236.600951, 707.803422, 653399300, '8oitxeilp', 't2__9f57e7');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('D', 'e019cy7od0', 457.405588, 461.555144, -1882121644, 'hdsvnhed29lq', 'B');

-- Inserting into table: expense --
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_1', 'v', 'ph2', 109.083092, 'dqwn', 'member_id_1', 't2__5da521');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_2', 'x', '5hncprjtu0d', 395.809081, 'fjgq8n2f3', 'member_id_1', 't2__5da521');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_3', 'ai5', 'h', 488.601669, 'grgj', 'member_id_1', 't2__5da521');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_4', 'v5q8qdj', 'e1io', 443.690199, '8507cvtjp', 'member_id_1', 'O');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_5', 'tg6bnou5zi', '6c4bfkfo', 12.330671, 'cd07z2zezj', 'member_id_1', 't2__5da521');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_6', 'wgxd5ysxc', 'r0oz', 297.258735, 'j5', 'member_id_1', 'O');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_7', 'v8u', 'tmu2n', 76.823924, '78lfvyz7zz', 'member_id_1', 't2__5da521');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_8', 'pmaus3au', 'mkrpdj', 736.632717, 'zw5chn', 'member_id_1', 'I');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_9', 'l', '5amsorlwyngc', 424.71131, 'j9erhizgk1', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('O', 'xuzkb52', 'gwnlas6', 907.723998, 'lb', 'member_id_1', 't3__df569f');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('A', 'ow', 'i1z', 493.031806, 'xih6', 'member_id_1', 't3__df569f');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_12', '2xlyo', 'tow9oaawg96a', 725.010524, '0', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('_', 'i', 'ndz39tajz9', 304.069184, 'n5wcgumbc', 'member_id_1', 't3__df569f');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_14', 'd0w9603vzxw1', 'xe9yf', 958.39315, 'qk162nh55', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('I', 'dohvu06d', 'a35rmki', 229.766946, 'ri2hy08ft', 'member_id_1', 't3__df569f');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_16', 'tqxxnj', 'b', NULL, 'mzn2mfx', 'member_id_1', 'I');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_17', '3p6sto1c', '8sh', NULL, 'knzys7dy', 'member_id_1', 'I');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_18', '1', 'jmgjach8qt', 644.437797, '8y3a17v4yg', 'member_id_1', 't2__5da521');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_19', 'y', '3qdpu', NULL, 'p', 'member_id_1', 'Q');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_20', 'tdqr', 'm5', NULL, 'wlic7dn2np', 'member_id_1', 'I');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_21', '0xdmsqtge', 'cuq', 27.252619, 'i9f2ccukjq1q', 'member_id_1', 't2__5da521');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_22', 'yhb08hl', 't1pqo', NULL, 'iztv', 'member_id_1', 't2__922e4a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_23', 'iz78aqql', 'd8ftb8', NULL, '9114q', 'member_id_1', 't2__5da521');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_24', 'e6bje', 'uuwsj8kjh8', 791.533893, 'wpxlvris', 'member_id_1', 't2__5da521');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_25', 'z0kaq', 'ncgc8', 836.758526, 'b7v88kwd', 'member_id_1', 't2__5da521');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('@', 'k', 'u2gir31vwq5', -1.0, 'oa2sb3u', 'member_id_1', '@');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('C', 'pavcvwn', 'qrouirl', 0.0, 'rpouit63xyf', 'member_id_1', 'O');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('!', 'wns', '47j2ja8dccy3', -1.0, 'vjwq49yrnx', 'member_id_1', 'B');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('B', 'dxdo2v', '7t3gvplj9f', 0.0, 'vuu', 'member_id_1', 'I');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('D', '26u331spxpw3', 'bgwkxgi', 0.0, 'nlj6idmp61', 'member_id_1', 'D');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('"', 'o3ak162ocagj', 'ev', 0.5, 'zxlu49', 'member_id_1', 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_name FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget WHERE T2.category = 'Parking' AND T3.cost < (SELECT AVG(cost) FROM expense);

/*
Gold Result:
('t1__acc099',)
('t1__acc099',)
('t1__acc099',)
('t1__acc099',)
('t1__acc099',)
('t1__acc099',)
('t1__acc099',)
*/

-- Prediction Query
SELECT T1.event_name FROM event AS T1 JOIN budget AS T2 ON T1.event_id = T2.link_to_event JOIN expense AS T3 ON T3.link_to_budget = T2.budget_id WHERE T2.category = 'Parking' AND T3.cost < (SELECT AVG(cost) FROM expense WHERE link_to_budget IN (SELECT budget_id FROM budget WHERE category = 'Parking'));

/*
Prediction Result:
('t1__acc099',)
('t1__acc099',)
('t1__acc099',)
('t1__acc099',)
('t1__acc099',)
('t1__acc099',)
('t1__acc099',)
('t1__acc099',)
('t1__acc099',)
*/