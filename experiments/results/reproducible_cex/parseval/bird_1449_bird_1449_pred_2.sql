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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('C', 't1__af568d', 't1__e5fdab', 'tti', 'bnp', 'mdpos', 'ie5', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 't1__af568d', 't1__e5fdab', 'u', '4nrq', 'rofqyp5s5b', 'p', -2147483648, 'C');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', 't1__af568d', 't1__e5fdab', 'dqv0gcb98ozk', 'zbilyrkn', '6vck6ah0f8js', 'wlq7xb', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('_', 't1__af568d', 't1__e5fdab', '1q43', '1jh3den', 'c68x8vacx', 'afu5w1of7', -2147483648, 'O');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 'ctdctmfg62g0', '5q8qdj', 'e1io', '278507cv', 'jpttg', 'bnou5zi36', -2147483648, 'C');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('E', 't1__af568d', 't1__e5fdab', '0oztd', 'j5', '3lq', '5lnpim5k58qs', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('G', 't1__af568d', 't1__e5fdab', 'vy', '7zzbe8y', 'kv42q7', 'x58b4', -2147483648, 'O');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('I', 't1__af568d', 't1__e5fdab', '3p6sto1c', '8sh', 'knzys7dy', 'yd1jmgjach8', -2147483648, 'O');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('Q', 't1__af568d', 't1__e5fdab', '0xdmsqtge', 'cuq', '9', 'i9f2ccukjq1q', -2147483648, 'O');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('B', 'u7', 'fe4hri', 'a2ypuzhsrwbb', 'p6luhvdlttil', 'n', 'rmdp', -2147483648, 'B');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('F', NULL, 'u7', 'fe4hri', 'a2ypuzhsrwbb', 'p6luhvdlttil', 'n', -2147483648, '!');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_1', '02eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr', '13pyu');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('A', 't2__40340d', '5k5swwqcgs', '9n8');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('C', 'nw6klf', 'a9000t5c4eci', 'gce376nium52');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('@', 't2__40340d', 'z', '9fjgq8n2f');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('O', 't2__40340d', 'itsj3', 'y');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('?', 'o', '2zobb0q0k32o', 'w');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('G', 't2__40340d', 'lboeowii1z5', 'xih6');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t2__e83115', 'xdpunmw', 'wx', 'rlawk');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('I', 't2__40340d', 'wpp', '6mb3aj0j');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('B', '5k5swwqcgs', '9n8', '4');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('!', '5k5swwqcgs', '9n8', '4');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, '4', 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd');

-- Inserting into table: budget --
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_1', '8d99rljsl', 419.361606, 470.165282, 1692174491, 'qi2rkf9v', 'event_id_1');

-- Inserting into table: expense --
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_1', 'x58pz', 'f8jegd2', 100.01, 'vy9uxj4', 'C', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_2', 'bdvlph', 'gndqwnqc', 100.01, 'x5hncprjtu0', 'C', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_3', 'a7ryfd', 'z16ni', 100.01, 'jai', 'O', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_4', 'h', 'ogrgjd8y', 100.01, 't1afgog', 'O', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_5', '4', 'f', 100.01, 'foa', '@', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_6', '0', '7z2zezjo7wg', 100.01, 'd5ysxc', '@', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_7', 'r94gth2m', 'ajjl', 100.01, '3', 'E', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_8', 'v8u', 'tmu2n', 100.01, '57', 'E', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_9', 'u', '3auvm', 100.01, 'rpd', '@', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_10', 'wzw5chn9mo70', 'a9n0jxfo', 100.01, 'ws', '@', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_11', '5amsorlwyngc', 'dj9erhi', 100.01, 'zgk1yoeyo6l0', '_', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_12', 't', 'fuqyxuzkb', 100.01, '521gwnlas6e', '_', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_13', 'lyotow', 'oaawg96aq', 100.01, '0', '@', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_14', 'i', 'ndz39tajz9', 100.01, 'd8n5w', '@', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_15', 'bc3t', 'u', 100.01, 'bd0w9603v', 'E', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_16', 'xw1rxe9yfk7', 'k162n', 100.01, '55', 'E', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('O', 'ohvu06dza3', 'rmkio18r', 100.01, 'i2hy08ftp6', 'O', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('A', 'tqxxnj', 'b', 100.01, 'mzn2mfx', 'O', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_19', 'a8y3a17v4yg', 'mayq3qdpua', 100.01, '96rn', 'I', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_20', 'q', 'hm5wl', 100.01, 'c7d', 'I', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_21', '1yh', '0', 100.01, 'hlst1pqom', 'Q', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_22', 'tvb6m4i', '78aqqlu', 100.01, '8', 'Q', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('_', 'r9114qbre', '6bjeuuwsj8k', 100.01, 'h85', 'G', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_24', 'vrisurz0ka', 'qtncgc8s3b7', 100.0, 'v88kwdmdbd', 'Q', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_25', '6j47n', 'ar50hs', 100.0, 'han', 'Q', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_26', '5dqts', 'g97a', 100.01, 'z2o20', 'O', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_27', '6dd', 'ysu', 100.01, 'iphdku2gi', 'O', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_28', 'wq51oa', 'sb3uoi1p', 100.01, 'avcvwnyqroui', 'O', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_29', 'rpo', 'it63xy', 100.01, 'vm', 'O', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_30', 'r133ir1a', 'yyhpl2', 100.01, '9es', 'O', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_31', '8pgc', 'qwt', 100.01, 'r54o6', 'O', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('@', 'siie5unw6k', 'fa9', NULL, '00t5c4e', 'B', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('B', 'mdpos', 'ie5', 100.01, 'nw6klf', 'F', 'budget_id_1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.first_name, T1.last_name, T2.major_name FROM member AS T1 INNER JOIN major AS T2 ON T2.major_id = T1.link_to_major INNER JOIN expense AS T3 ON T1.member_id = T3.link_to_member WHERE T3.cost > 100;

/*
Gold Result:
('t1__af568d', 't1__e5fdab', 't2__40340d')
('ctdctmfg62g0', '5q8qdj', 'nw6klf')
(None, 'u7', '5k5swwqcgs')
*/

-- Prediction Query
SELECT T1.first_name, T1.last_name, T3.major_name FROM member AS T1 INNER JOIN expense AS T2 ON T1.member_id = T2.link_to_member INNER JOIN major AS T3 ON T1.link_to_major = T3.major_id WHERE T2.cost > 100;

/*
Prediction Result:
('t1__af568d', 't1__e5fdab', 't2__40340d')
('t1__af568d', 't1__e5fdab', 't2__40340d')
('t1__af568d', 't1__e5fdab', 't2__40340d')
('t1__af568d', 't1__e5fdab', 't2__40340d')
('ctdctmfg62g0', '5q8qdj', 'nw6klf')
('ctdctmfg62g0', '5q8qdj', 'nw6klf')
('t1__af568d', 't1__e5fdab', 't2__40340d')
('t1__af568d', 't1__e5fdab', 't2__40340d')
('ctdctmfg62g0', '5q8qdj', 'nw6klf')
('ctdctmfg62g0', '5q8qdj', 'nw6klf')
('t1__af568d', 't1__e5fdab', 't2__40340d')
('t1__af568d', 't1__e5fdab', 't2__40340d')
('ctdctmfg62g0', '5q8qdj', 'nw6klf')
('ctdctmfg62g0', '5q8qdj', 'nw6klf')
('t1__af568d', 't1__e5fdab', 't2__40340d')
('t1__af568d', 't1__e5fdab', 't2__40340d')
('t1__af568d', 't1__e5fdab', 't2__40340d')
('t1__af568d', 't1__e5fdab', 't2__40340d')
('t1__af568d', 't1__e5fdab', 't2__40340d')
('t1__af568d', 't1__e5fdab', 't2__40340d')
('t1__af568d', 't1__e5fdab', 't2__40340d')
('t1__af568d', 't1__e5fdab', 't2__40340d')
('t1__af568d', 't1__e5fdab', 't2__40340d')
('t1__af568d', 't1__e5fdab', 't2__40340d')
('t1__af568d', 't1__e5fdab', 't2__40340d')
('t1__af568d', 't1__e5fdab', 't2__40340d')
('t1__af568d', 't1__e5fdab', 't2__40340d')
('t1__af568d', 't1__e5fdab', 't2__40340d')
('t1__af568d', 't1__e5fdab', 't2__40340d')
(None, 'u7', '5k5swwqcgs')
*/