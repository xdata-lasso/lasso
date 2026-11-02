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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__82cbbf', 'bnp', 'mdpos', 'ie5', 'nw6klf', 'a9000t5c4eci', 'gce376nium52', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__540727', 'p5qi2rk', '9v', 'x58pz', 'f8jegd2', 'vy9uxj4', 'wb', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 'qcx5', 'hncprjtu0dz', '9fjgq8n2f', 'dqv0gcb9', 'ozk3zbily', 'kn6vc', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 'jswwlq7xb', '72fxa7ryfd', 'z16ni', 'jai', 'dh5ogrgj', '8', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('?', 'c', 'x7afu5w1of77', 'zo72', 'ctdctmfg62g0', '5q8qdj', 'e1io', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('I', 'las6', 'elboeowii1', '5nxih66', 'q2xlyoto', '9oaawg', '6aqb0tbin', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t3__49a34e', 'y08ftp6ewt', 'xxnja', 'bymzn2mfx7h3', 'p6sto1cj', 'sh5knzys7', 'y', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t2__9b6f57', '7aqz2o20p', '6dd', 'ysu', 'iphdku2gi', '31vwq', '1oa2sb3u', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_9', 'x14ji7zwau2d', 'yrq13p', 'u78d99r', 'jsl', 'b4yp5qi', 'rkf9vqx5', -2147483648, 'major_id_1');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t3__f2a6b3', 'uo4nrqrofqy', '5s5b', 'p', '02eutliqa11r', 'ytoo3o9', 'l7');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('O', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', 'wbbp6luhvdlt', 'ilbnp', 'mdpos', 'ie5', 'nw6klf', 'a9000t5c4eci');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('G', 'e', '76nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', '5k5swwqcgs', '9n8', '4');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti');

-- Inserting into table: budget --
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_1', 'lex', 913.303855, 482.572691, 105869088, 'au2dwy', 't3__f2a6b3');

-- Inserting into table: attendance --
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t3__f2a6b3', 't1__82cbbf');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t3__f2a6b3', 'A');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t3__f2a6b3', '@');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t3__f2a6b3', 'I');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t3__f2a6b3', 't3__49a34e');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('O', '?');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 't1__540727');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 't1__540727');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'A');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 't2__9b6f57');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_9');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('O', 'member_id_9');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', '@');

-- Inserting into table: expense --
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_1', 'q13py', '78d99r', 50.01, 'jsl', 't1__82cbbf', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_2', 'v', 'ph2', 50.01, 'nd', 't1__540727', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_3', 'yzt1afgogrit', 'sj3ayxp1q430', 50.01, 'jh3den8', '@', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_4', '278507cv', 'jpttg', 50.01, 'bnou5zi36', '?', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_5', 'oa', 'cd07z2zezjo7', 50.01, 'wgxd5ysxcm', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_6', '0oztdgj5i3lq', '5lnpim5k58qs', 50.01, '7p2r94gt', '@', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_7', 'jla', 'okv8uttm', 50.01, '2ne578', '@', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_8', 'vy', '7zzbe8y', 50.01, 'kv42q7', '?', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_9', 'pmaus3auvmkr', 'pdjwzw5chn9', 50.01, 'o705', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_10', '9n0jxfofwsz', 'o', 50.01, '2zobb0q0k32o', '?', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_11', 'amsorlwyng', '1', 50.01, 'j', '@', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_12', 'rhizgk1yoey', 'o6l0hdt6fu', 50.01, 'yxuzk', '@', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_13', '39tajz9', 'd8n5w', 50.01, 'g', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_14', 'bc3t', 'u', 50.01, 'bd0w9603v', '@', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('O', 'e9yfk7', 'k162n', 50.01, '55', 't1__82cbbf', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('A', 'dohvu06d', 'a35rmki', 50.01, '18ri', 't1__82cbbf', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_17', 'jmgjach8qt', 'a8y3a17v4yg', 50.01, 'mayq3qdpua', 't3__49a34e', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_18', '6rntdqrhm', 'wlic7dn2', 50.01, 'p490', 't3__49a34e', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('G', 'gelcu', 'qb9i9f2ccu', 50.01, 'jq1', 't1__82cbbf', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_20', 'hb08hlst1pq', 'mizt', 50.01, 'vb6m4iz78aq', 't3__49a34e', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_21', 'ud8', 'tb', 50.01, 'r9114qbre', 't3__49a34e', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_22', '5wpxlvris', 'urz0kaqtncg', 50.01, 'c8s3b7v88k', 't3__49a34e', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_23', 'm', 'b', 50.01, 'h', 't3__49a34e', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_24', 'r', '0hsjhanz', 50.0, 'dpunmw', 't1__82cbbf', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_25', 'xqrlaw', '014', 50.0, '5dqts', 't1__540727', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_26', 'cvwnyq', 'ouirl', 50.01, 'rpouit63xyf', 't1__82cbbf', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_27', 'jwpp', '6mb3aj0j', 50.01, '0h3r13', 't1__540727', 'budget_id_1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.link_to_event FROM expense AS T1 INNER JOIN member AS T2 ON T1.link_to_member = T2.member_id INNER JOIN attendance AS T3 ON T2.member_id = T3.link_to_member WHERE T1.cost > 50;

/*
Gold Result:
('A',)
('G',)
('O',)
('t3__f2a6b3',)
*/

-- Prediction Query
SELECT T1.link_to_event FROM budget AS T1 INNER JOIN expense AS T2 ON T1.budget_id = T2.link_to_budget WHERE T2.cost > 50;

/*
Prediction Result:
('t3__f2a6b3',)
('t3__f2a6b3',)
('t3__f2a6b3',)
('t3__f2a6b3',)
('t3__f2a6b3',)
('t3__f2a6b3',)
('t3__f2a6b3',)
('t3__f2a6b3',)
('t3__f2a6b3',)
('t3__f2a6b3',)
('t3__f2a6b3',)
('t3__f2a6b3',)
('t3__f2a6b3',)
('t3__f2a6b3',)
('t3__f2a6b3',)
('t3__f2a6b3',)
('t3__f2a6b3',)
('t3__f2a6b3',)
('t3__f2a6b3',)
('t3__f2a6b3',)
('t3__f2a6b3',)
('t3__f2a6b3',)
('t3__f2a6b3',)
('t3__f2a6b3',)
('t3__f2a6b3',)
*/