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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__894844', 't1__f021b3', 't1__d152f2', 'tti', 'bnp', 'mdpos', 'ie5', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 't1__f021b3', 't1__d152f2', 'u', '4nrq', 'rofqyp5s5b', 'p', -2147483648, 'C');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 't1__f021b3', 't1__d152f2', 'xp1q430', 'jh3den8', 'c68x8vacx7', 'f', -2147483648, '_');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_3', 't1__f021b3', 't1__d152f2', 'w1of77pz', '72ct', 'c', 'mfg62', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('I', 't1__f021b3', 't1__d152f2', 'ajjl', '3', 'okv8uttmu2', 'e578', -2147483648, 'O');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('?', 't1__f021b3', 't1__d152f2', '5amsorlwyngc', 'dj9erhi', 'zgk1yoeyo6l0', 'dt', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('_', 't1__f021b3', 't1__d152f2', '06dza3', 'rmkio18r', 'i2hy08ftp6', 'wt', -2147483648, 'O');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('G', 't1__f021b3', 't1__d152f2', 'tvb6m4iz78', 'q', 'lud8f', 'tb8r9114qbre', -2147483648, 'O');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('B', 'u7', 'fe4hri', 'a2ypuzhsrwbb', 'p6luhvdlttil', 'n', 'rmdp', -2147483648, 'B');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('H', NULL, 'u7', 'fe4hri', 'a2ypuzhsrwbb', 'p6luhvdlttil', 'n', -2147483648, 'D');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_1', '02eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr', '13pyu');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('A', 't2__09b126', '5k5swwqcgs', '9n8');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('C', 'nw6klf', 'a9000t5c4eci', 'gce376nium52');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('@', 'z', '9fjgq8n2f', 'dqv0gcb9');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('?', 'k3zbily', 'kn6vc', '6ah');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('_', 't2__09b126', 't1afgog', 'itsj3');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('O', 't2__09b126', '58q', 's27p2r94gth2');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t1__db7a78', 't2__09b126', '9oaawg', '6aqb0tbin');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t2__8822da', 'h', '6j47n', 'ar50hs');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('G', NULL, 'han', 'xdpunmw');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('B', '5k5swwqcgs', '9n8', '4');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('D', '5k5swwqcgs', '9n8', '4');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, '4', 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd');

-- Inserting into table: budget --
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_1', '8d99rljsl', 419.361606, 470.165282, 1692174491, 'qi2rkf9v', 'event_id_1');

-- Inserting into table: expense --
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_1', 'x58pz', 'f8jegd2', 100.01, 'vy9uxj4', 't1__894844', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_2', 'bdvlph', 'gndqwnqc', 100.01, 'x5hncprjtu0', 't1__894844', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_3', 'jswwlq7xb', '72fxa7ryfd', 100.01, 'z16ni', 't1__894844', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_4', 'ai5', 'h', 100.01, 'ogrgjd8y', 't1__894844', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_5', 'v5q8qdj', 'e1io', 100.01, '278507cv', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_6', 'ptt', '6b', 100.01, 'ou5z', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_7', 'bfkfoacd', '7z2zezj', 100.01, '7wgx', 't1__894844', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_8', 'ysxcmr0o', 'ztdgj5i3lq5l', 100.01, 'pim5', 't1__894844', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_9', 'yz7zzb', '8y', 100.01, 'kv42q7', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_10', '58b4pm', 'u', 100.01, '3auvm', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_11', 'j', 'wzw5chn9mo70', 100.01, 'a9n0jxfo', 't1__894844', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_12', 'szdo2z', 'obb0q0k32o', 100.01, 'w', 't1__894844', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_13', 'qyxuzk', '5', 100.01, '1gwnlas6', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_14', 'lboeowii1z5', 'xih6', 100.01, '2q2xlyoto', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_15', 'tajz9td8n', '5wcgumbc3td', 100.01, 'u6bd0w9603', 't1__894844', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_16', 'xw1rxe9', 'fk7qk16', 100.01, '2nh55y3doh', 't1__894844', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('O', 'njabym', 'n2mfx7h', 100.01, '3p6sto1c', '_', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('A', 'sh5knzys7', 'y', 100.01, 'yd1jmgjach8', '_', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_19', '8y3a17v4yg', 'mayq3qdpua', 100.01, '96rn', 't1__894844', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_20', 'q', 'hm5wl', 100.01, 'c7d', 't1__894844', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_21', 'm', 'sqtgelcuqb', 100.01, 'i9f2ccukj', 't1__894844', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_22', '1quik1yhb08h', 'st1', 100.01, 'qomi', 't1__894844', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_23', 'j8kjh', '5wpxlvris', 100.0, 'urz0kaqtncg', 't1__894844', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_24', 's3b7v88kw', 'm', 100.0, 'b', 't1__894844', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_25', 'rlawk', '14r5dqt', 100.01, 'mg97a', 't1__894844', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_26', '2o20pj6', 'd', 100.01, 'ysu', 't1__894844', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_27', 'k', 'u2gir31vwq5', 100.01, 'oa2sb3u', 't1__894844', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_28', '1pa', 'cvwnyq', 100.01, 'ouirl', 't1__894844', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_29', 'it63xy', 'vm', 100.01, 'wpp', 't1__894844', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_30', 'mb3aj0ju0', '3r', 100.01, '133ir1axyy', 't1__894844', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('@', 'siie5unw6k', 'fa9', NULL, '00t5c4e', 'B', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('B', 'mdpos', 'ie5', 100.01, 'nw6klf', 'H', 'budget_id_1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.first_name, T1.last_name, T2.major_name FROM member AS T1 INNER JOIN major AS T2 ON T2.major_id = T1.link_to_major INNER JOIN expense AS T3 ON T1.member_id = T3.link_to_member WHERE T3.cost > 100;

/*
Gold Result:
('t1__f021b3', 't1__d152f2', 't2__09b126')
('t1__f021b3', 't1__d152f2', 'nw6klf')
(None, 'u7', '5k5swwqcgs')
*/

-- Prediction Query
SELECT T2.first_name, T2.last_name, T4.major_name FROM expense AS T1 INNER JOIN member AS T2 ON T1.link_to_member = T2.member_id INNER JOIN major AS T4 ON T2.link_to_major = T4.major_id WHERE T1.cost > 100;

/*
Prediction Result:
('t1__f021b3', 't1__d152f2', 't2__09b126')
('t1__f021b3', 't1__d152f2', 't2__09b126')
('t1__f021b3', 't1__d152f2', 't2__09b126')
('t1__f021b3', 't1__d152f2', 't2__09b126')
('t1__f021b3', 't1__d152f2', 'nw6klf')
('t1__f021b3', 't1__d152f2', 'nw6klf')
('t1__f021b3', 't1__d152f2', 't2__09b126')
('t1__f021b3', 't1__d152f2', 't2__09b126')
('t1__f021b3', 't1__d152f2', 'nw6klf')
('t1__f021b3', 't1__d152f2', 'nw6klf')
('t1__f021b3', 't1__d152f2', 't2__09b126')
('t1__f021b3', 't1__d152f2', 't2__09b126')
('t1__f021b3', 't1__d152f2', 'nw6klf')
('t1__f021b3', 't1__d152f2', 'nw6klf')
('t1__f021b3', 't1__d152f2', 't2__09b126')
('t1__f021b3', 't1__d152f2', 't2__09b126')
('t1__f021b3', 't1__d152f2', 't2__09b126')
('t1__f021b3', 't1__d152f2', 't2__09b126')
('t1__f021b3', 't1__d152f2', 't2__09b126')
('t1__f021b3', 't1__d152f2', 't2__09b126')
('t1__f021b3', 't1__d152f2', 't2__09b126')
('t1__f021b3', 't1__d152f2', 't2__09b126')
('t1__f021b3', 't1__d152f2', 't2__09b126')
('t1__f021b3', 't1__d152f2', 't2__09b126')
('t1__f021b3', 't1__d152f2', 't2__09b126')
('t1__f021b3', 't1__d152f2', 't2__09b126')
('t1__f021b3', 't1__d152f2', 't2__09b126')
('t1__f021b3', 't1__d152f2', 't2__09b126')
(None, 'u7', '5k5swwqcgs')
*/