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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__ab4615', 'bnp', 'mdpos', 'ie5', 'nw6klf', 'a9000t5c4eci', 'gce376nium52', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 'i2rkf', 'vqx58pz0f', '8jegd21vy9ux', 'j4hwbdvlph', 'gndqwnqc', 'x5hncprjtu0', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('G', '8n2f3', 'dqv0gcb98ozk', 'zbilyrkn', '6vck6ah0f8js', 'wlq7xb', '72fxa7ryfd', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('C', 't1afgog', 'itsj3', 'y', 'p1q430', 'jh3den8', 'c68x8vacx7', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('W', 'f77p', 'o72ctdc', 'mfg62', '0v', 'q8qdjpe1', 'o22', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', 'u5zi', '6c4bfkfo', 'c', '0', '7z2zezjo7wg', 'd5ysxc', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t3__d981e7', 'q5l', 'pim5', '58q', 's27p2r94gth2', 'najj', 'a3o', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t2__73c177', 'o705a9n0jxfo', 'ws', 'do2zobb', 'q0k32od', 'cl5ams', 'orlwyngc1dj', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('exp_faddb0', 'luhvdltti', 'bnp', 'mdpos', 'ie5', 'nw6klf', 'a9000t5c4eci', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_10', '2dwyrq13pyu7', 'd99rljsl0', '4', 'p5qi2rk', '9v', 'x58pz', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_11', 'gcb98oz', '3zb', 'lyr', 'kn6vck6ah0f8', 'sww', 'q7x', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_12', '1q43', '1jh3den', 'c68x8vacx', 'afu5w1of7', 'pzo72ctdc', 'mfg62', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_13', 'h2mna', 'jla', 'okv8uttm', '2ne578', 'fvy', '7zzbe8y', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_14', '42q7sx58b4', 'pmaus3auvmkr', 'pdjwzw5chn9', 'o705', 'a9n0jxfofws', 'do2zobb', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_15', 'uzkb521gwnl', 's', 'elboeowii', 'z5nxih6', '2q2xlyoto', '9oaawg', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_16', '0', 'bindz', '9tajz9td', 'n5wcgumbc', '3tdu6bd0w960', 'vzxw1rxe', -2147483648, 'major_id_1');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t3__e162e1', 'uo4nrqrofqy', '5s5b', 'p', '02eutliqa11r', 'ytoo3o9', 'l7');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('att_5f0c18', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', '5k5swwqcgs', '9n8', '4');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti');

-- Inserting into table: budget --
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_1', 'lex', 913.303855, 482.572691, 105869088, 'au2dwy', 't3__e162e1');

-- Inserting into table: attendance --
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t3__e162e1', 't1__ab4615');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t3__e162e1', 'A');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t3__e162e1', 't3__d981e7');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('att_5f0c18', 'W');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('att_5f0c18', 'O');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('att_5f0c18', 'member_id_10');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('att_5f0c18', 't3__d981e7');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('att_5f0c18', 't1__ab4615');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('att_5f0c18', 'member_id_11');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('att_5f0c18', 't2__73c177');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('att_5f0c18', 'member_id_12');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('att_5f0c18', 'C');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('att_5f0c18', 'exp_faddb0');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('att_5f0c18', 'member_id_13');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('att_5f0c18', 'member_id_14');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('att_5f0c18', 'member_id_15');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('att_5f0c18', 'member_id_16');

-- Inserting into table: expense --
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('A', 'q13py', '2019-01-10', 326.912005, 'true', 't1__ab4615', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('C', '9rljsl0b4', '2019-01-10', 884.000446, 'true', 't1__ab4615', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('G', 'z16ni', '2019-01-10', 968.276986, 'true', 'G', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('O', 'f', '2019-01-10', 313.653498, 'true', 'C', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('_', 'tmu2n', '2019-01-10', 76.823924, 'true', 't3__d981e7', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('Q', 'v42q7sx58b4p', '2019-01-10', 199.318647, 'true', 't3__d981e7', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_7', 'gce376nium52', 'zbuo4nrqrof', 586.906897, 'p5s5bbp', 'exp_faddb0', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_8', '2eutliqa11r', 'ytoo3o9', 111.926013, '72klex14ji7z', 'exp_faddb0', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_9', '8jegd21vy9ux', 'j4hwbdvlph', 439.200238, 'dqwn', 'exp_faddb0', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_10', 'x', '5hncprjtu0d', 395.809081, 'fjgq8n2f3', 'exp_faddb0', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_11', '72fxa7ryfd', 'z16ni', 968.276986, 'ai5', 'exp_faddb0', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_12', 'h5ogrgjd8yz', '1afgo', 105.078878, 'tsj', 'exp_faddb0', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_13', 'v5q8qdj', 'e1io', 443.690199, '8507cvtjp', 'exp_faddb0', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_14', 'tg6bnou5zi', '6c4bfkfo', 12.330671, 'cd07z2zezj', 'exp_faddb0', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_15', 'xd', 'ysxcmr0o', 698.769833, 'dgj5i', 'exp_faddb0', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_16', 'q5l', 'pim5', 167.377262, '8qs27p2r', 'exp_faddb0', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_17', '0k32o', 'w', 38.169466, '5am', 'exp_faddb0', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_18', 'orlwyngc1dj', '9erhizgk1yoe', 845.392744, 'o6l0hdt6fu', 'exp_faddb0', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_19', 'k7', 'k162n', 111.965818, '5y3dohvu', 'exp_faddb0', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_20', 'dza35rmki', '18ri', 851.78202, 'y0', 'exp_faddb0', 'budget_id_1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.link_to_member, T3.link_to_event FROM expense AS T1 INNER JOIN member AS T2 ON T1.link_to_member = T2.member_id INNER JOIN attendance AS T3 ON T2.member_id = T3.link_to_member WHERE DATE(SUBSTRING(T1.expense_date, 1, 10)) BETWEEN '2019-01-10' AND '2019-11-19' AND T1.approved = 'true';

/*
Gold Result:
('t1__ab4615', 'att_5f0c18')
('t1__ab4615', 't3__e162e1')
('C', 'att_5f0c18')
('t3__d981e7', 'att_5f0c18')
('t3__d981e7', 't3__e162e1')
*/

-- Prediction Query
SELECT member.member_id, attendance.link_to_event FROM member INNER JOIN expense ON member.member_id = expense.link_to_member INNER JOIN attendance ON member.member_id = attendance.link_to_member WHERE expense.approved = 'true' AND expense.expense_date BETWEEN '2019-01-10' AND '2019-11-19';

/*
Prediction Result:
('t1__ab4615', 'att_5f0c18')
('t1__ab4615', 't3__e162e1')
('t1__ab4615', 'att_5f0c18')
('t1__ab4615', 't3__e162e1')
('C', 'att_5f0c18')
('t3__d981e7', 'att_5f0c18')
('t3__d981e7', 't3__e162e1')
('t3__d981e7', 'att_5f0c18')
('t3__d981e7', 't3__e162e1')
*/