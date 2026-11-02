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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__42986d', 'bnp', 'mdpos', 'ie5', 'nw6klf', 'a9000t5c4eci', 'gce376nium52', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 'i2rkf', 'vqx58pz0f', '8jegd21vy9ux', 'j4hwbdvlph', 'gndqwnqc', 'x5hncprjtu0', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', '8n2f3', 'dqv0gcb98ozk', 'zbilyrkn', '6vck6ah0f8js', 'wlq7xb', '72fxa7ryfd', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('G', 'dh5ogrgj', '8', 'yzt1afgogrit', 'sj3ayxp1q430', 'jh3den8', 'c68x8vacx7', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('I', '62', '0v', 'q8qdjpe1', 'o22', '8507cvtjp', 'ttg6bnou5zi3', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t2__d244e1', 'okv8uttmu2', 'e578', 'fvy', '7zzbe8y', 'kv42q7', 'x58b4', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t3__270c8f', 'u', '3auvm', 'rpd', 'wzw', 'chn9mo70', 'a9n0jxfo', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('exp_faddb0', 'wwqcg', 'k9n8c', 'pgu7vfe4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_9', 'p', 'jtu0d', '79fjgq8', 'n2f3dqv0gcb9', 'ozk3zbily', 'kn6vc', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_10', 'f8jswwl', '7xb72', 'xa', '7ryfdrz16n', 'jja', '5dh', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_11', '8c68', '8vacx7', 'f', '5w1of7', 'pzo72ctdc', 'mfg62', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_12', 'd5ysxc', 'r0oz', 'dgj5i', 'lq5lnpim', 'k58qs27p', 'r94gth2m', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_13', 'auvmkrpd', 'wzw', 'chn9mo70', 'a9n0jxfo', 'ws', 'do2zobb', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_14', 'uzkb521gwnl', 's', 'elboeowii', 'z5nxih6', '2q2xlyoto', '9oaawg', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_15', '0', 'bindz', '9tajz9td', 'n5wcgumbc', '3tdu6bd0w960', 'vzxw1rxe', -2147483648, 'major_id_1');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t3__7ce17a', 'uo4nrqrofqy', '5s5b', 'p', '02eutliqa11r', 'ytoo3o9', 'l7');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('att_5f0c18', 'gce376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9', 'l7');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', '5k5swwqcgs', '9n8', '4');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti');

-- Inserting into table: budget --
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_1', 'lex', 913.303855, 482.572691, 105869088, 'au2dwy', 't3__7ce17a');

-- Inserting into table: attendance --
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t3__7ce17a', 't1__42986d');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t3__7ce17a', 'A');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t3__7ce17a', 't3__270c8f');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('att_5f0c18', 'exp_faddb0');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('att_5f0c18', 'O');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('att_5f0c18', 'I');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('att_5f0c18', 't2__d244e1');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('att_5f0c18', 'member_id_9');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('att_5f0c18', 'member_id_10');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('att_5f0c18', 'member_id_11');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('att_5f0c18', 'A');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('att_5f0c18', 'G');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('att_5f0c18', 'member_id_12');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('att_5f0c18', 't1__42986d');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('att_5f0c18', 'member_id_13');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('att_5f0c18', 'member_id_14');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('att_5f0c18', 'member_id_15');

-- Inserting into table: expense --
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('A', 'q13py', '2019-01-10', 326.912005, 'true', 't1__42986d', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('C', '9rljsl0b4', '2019-01-10', 884.000446, 'true', 't1__42986d', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('O', 'z16ni', '2019-01-10', 968.276986, 'true', 'O', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('I', 'w1of77pz', '2019-01-10', 224.624401, 'true', 'G', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('_', 'ztdg', '2019-01-10', 145.027285, 'true', 't1__42986d', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_6', 'bnp', 'mdpos', 133.007885, '5u', 'exp_faddb0', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_7', '6klfa9', '00t5c4e', 950.466571, 'i', 'exp_faddb0', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_8', 'x1', 'ji7zwau2', 920.013763, 'dwyrq13pyu78', 'exp_faddb0', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_9', '9rljsl0b4', 'p5qi2rk', 811.601922, '9v', 'exp_faddb0', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_10', 'pz0f8jegd', '1vy9uxj4', 124.573829, 'd', 'exp_faddb0', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_11', 'ph2', 'nd', 893.16532, 'wnqcx', 'exp_faddb0', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_12', 'grgj', '8', 740.059813, 'zt1afgo', 'exp_faddb0', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_13', 'itsj3', 'y', 360.694313, 'q4301jh', 'exp_faddb0', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_14', '5q8qdj', 'e1io', 443.690199, '8507cvtjp', 'exp_faddb0', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_15', 'tg6bnou5zi', '6c4bfkfo', 12.330671, 'cd07z2zezj', 'exp_faddb0', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_16', 'ajjla3okv8u', 'tmu2n', 76.823924, '78lfvyz7zz', 'exp_faddb0', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_17', '8y', 'kv42q7', 282.68858, '58b4pm', 'exp_faddb0', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_18', '0k32o', 'w', 38.169466, '5am', 'exp_faddb0', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_19', 'orlwyngc1dj', '9erhizgk1yoe', 845.392744, 'o6l0hdt6fu', 'exp_faddb0', 'budget_id_1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.link_to_member, T3.link_to_event FROM expense AS T1 INNER JOIN member AS T2 ON T1.link_to_member = T2.member_id INNER JOIN attendance AS T3 ON T2.member_id = T3.link_to_member WHERE DATE(SUBSTRING(T1.expense_date, 1, 10)) BETWEEN '2019-01-10' AND '2019-11-19' AND T1.approved = 'true';

/*
Gold Result:
('t1__42986d', 'att_5f0c18')
('t1__42986d', 't3__7ce17a')
('O', 'att_5f0c18')
('G', 'att_5f0c18')
*/

-- Prediction Query
SELECT T1.first_name, T1.last_name, T2.link_to_event FROM member AS T1 INNER JOIN attendance AS T2 ON T1.member_id = T2.link_to_member INNER JOIN expense AS T3 ON T1.member_id = T3.link_to_member WHERE T3.approved = 'true' AND T3.expense_date BETWEEN '2019-01-10' AND '2019-11-19';

/*
Prediction Result:
('bnp', 'mdpos', 'att_5f0c18')
('bnp', 'mdpos', 't3__7ce17a')
('bnp', 'mdpos', 'att_5f0c18')
('bnp', 'mdpos', 't3__7ce17a')
('8n2f3', 'dqv0gcb98ozk', 'att_5f0c18')
('dh5ogrgj', '8', 'att_5f0c18')
('bnp', 'mdpos', 'att_5f0c18')
('bnp', 'mdpos', 't3__7ce17a')
*/