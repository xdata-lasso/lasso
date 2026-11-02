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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__b9295b', 'bnp', 'mdpos', 'ie5', 'nw6klf', 'a9000t5c4eci', 'gce376nium52', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__b338a9', 'p5qi2rk', '9v', 'x58pz', 'f8jegd2', 'vy9uxj4', 'wb', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 'qcx5', 'hncprjtu0dz', '9fjgq8n2f', 'dqv0gcb9', 'ozk3zbily', 'kn6vc', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 'jswwlq7xb', '72fxa7ryfd', 'z16ni', 'jai', 'dh5ogrgj', '8', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('?', 'c', 'x7afu5w1of77', 'zo72', 'ctdctmfg62g0', '5q8qdj', 'e1io', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t3__e738cf', 'o', 'vu', '6dza35r', 'mkio18ri2hy', '08ftp6ewtqxx', 'jaby', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t2__91b8c9', '7nxar50h', 'sjhanzxdpu', 'mwfw', 'qrlawk', '14r5dqt', 'mg97a', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_8', 'tliqa1', 'ryytoo3', '9hl7', 'klex14ji', '7zwau2dwyr', '13pyu', -2147483648, 'major_id_1');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t3__4ad7f2', 'uo4nrqrofqy', '5s5b', 'p', '02eutliqa11r', 'ytoo3o9', 'l7');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('G', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', 'wbbp6', 'uhv', 'l', 'tilbn', 'rmdp', 'siie');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('O', '6klfa9', '00t5c4e', 'cigce376nium', '52zbuo4nrq', 'rofqyp5s5b', 'p');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', '5k5swwqcgs', '9n8', '4');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti');

-- Inserting into table: budget --
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_1', 'lex', 913.303855, 482.572691, 105869088, 'au2dwy', 't3__4ad7f2');

-- Inserting into table: attendance --
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t3__4ad7f2', 't1__b9295b');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t3__4ad7f2', 'A');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t3__4ad7f2', '@');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t3__4ad7f2', 't3__e738cf');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 't3__e738cf');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', '@');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'A');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 't1__b338a9');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('O', 't3__e738cf');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_8');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 't1__b9295b');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', '?');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('O', 'A');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'A');

-- Inserting into table: expense --
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_1', 'q13py', '78d99r', 50.01, 'jsl', 't1__b9295b', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_2', 'v', 'ph2', 50.01, 'nd', 't1__b338a9', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_3', 'yzt1afgogrit', 'sj3ayxp1q430', 50.01, 'jh3den8', '@', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_4', '278507cv', 'jpttg', 50.01, 'bnou5zi36', '?', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_5', 'oa', 'cd07z2zezjo7', 50.01, 'wgxd5ysxcm', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_6', '0oztdgj5i3lq', '5lnpim5k58qs', 50.01, '7p2r94gt', '@', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_7', 'jla', 'okv8uttm', 50.01, '2ne578', '@', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_8', 'vy', '7zzbe8y', 50.01, 'kv42q7', '?', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_9', 'pmaus3auvmkr', 'pdjwzw5chn9', 50.01, 'o705', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_10', '9n0jxfofwsz', 'o', 50.01, '2zobb0q0k32o', '@', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_11', 'amsorlwyng', '1', 50.01, 'j', '@', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_12', 'rhizgk1yoey', 'o6l0hdt6fu', 50.01, 'yxuzk', '?', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_13', 'nlas6e', 'lboeowii1z5', 50.01, 'xih6', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_14', '2xlyo', 'tow9oaawg96a', 50.01, 'qb0tbindz39t', '@', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('I', 'n5wcgumbc', '3tdu6bd0w960', 50.01, 'vzxw1rxe', 't1__b9295b', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('A', 'k7', 'k162n', 50.01, '55', 't1__b9295b', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_17', 'mfx7h33p', '6sto1cj8sh5k', 50.01, 'zys7', 't3__e738cf', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_18', 'yd1jmgj', 'c', 50.01, '8q', 't3__e738cf', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('O', '7v4ygma', 'q3qdpua', 50.01, '96rn', 't1__b9295b', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_20', 'wlic7dn2', 'p490', 50.01, 'dmsqtg', 't3__e738cf', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_21', 'cuq', '9', 50.01, 'i9f2ccukjq1q', 't3__e738cf', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_22', 't1pqomiztvb6', '4iz7', 50.01, 'aqqlud8ft', 't3__e738cf', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_23', 'r9114qbre', '6bjeuuwsj8k', 50.01, 'h85', 't3__e738cf', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_24', 'isurz', 'kaqtncg', 50.0, 'c8s3b7v88k', 't1__b9295b', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_25', 'm', 'b', 50.0, 'h', 't1__b338a9', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_26', 'pj6ddly', 'u6iph', 50.01, 'k', 't1__b9295b', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_27', '2gir31vwq5', 'oa2sb3u', 50.01, 'i1pa', 't1__b338a9', 'budget_id_1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.link_to_event FROM expense AS T1 INNER JOIN member AS T2 ON T1.link_to_member = T2.member_id INNER JOIN attendance AS T3 ON T2.member_id = T3.link_to_member WHERE T1.cost > 50;

/*
Gold Result:
('A',)
('G',)
('O',)
('t3__4ad7f2',)
*/

-- Prediction Query
SELECT T1.link_to_event FROM attendance AS T1 INNER JOIN member AS T2 ON T1.link_to_member = T2.member_id INNER JOIN expense AS T3 ON T3.link_to_member = T2.member_id WHERE T3.cost > 50;

/*
Prediction Result:
('G',)
('t3__4ad7f2',)
('A',)
('A',)
('t3__4ad7f2',)
('A',)
('A',)
('G',)
('O',)
('t3__4ad7f2',)
('A',)
('t3__4ad7f2',)
('A',)
('t3__4ad7f2',)
('A',)
('A',)
('G',)
('O',)
('t3__4ad7f2',)
('A',)
('t3__4ad7f2',)
('A',)
('t3__4ad7f2',)
('A',)
('A',)
('G',)
('O',)
('t3__4ad7f2',)
('A',)
('t3__4ad7f2',)
('G',)
('t3__4ad7f2',)
('G',)
('t3__4ad7f2',)
('G',)
('O',)
('t3__4ad7f2',)
('G',)
('O',)
('t3__4ad7f2',)
('G',)
('t3__4ad7f2',)
('G',)
('O',)
('t3__4ad7f2',)
('G',)
('O',)
('t3__4ad7f2',)
('G',)
('O',)
('t3__4ad7f2',)
('G',)
('O',)
('t3__4ad7f2',)
('G',)
('t3__4ad7f2',)
('A',)
*/