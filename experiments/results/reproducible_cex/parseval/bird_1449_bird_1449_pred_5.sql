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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', 't1__155a33', 't1__571588', 'tti', 'bnp', 'mdpos', 'ie5', -2147483648, 't1__95fde5');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 't1__155a33', 't1__571588', 'u', '4nrq', 'rofqyp5s5b', 'p', -2147483648, 't1__6e79dd');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('G', 't1__155a33', 't1__571588', 'ah0f8jsww', 'q7x', '7', '2fxa7ryfdrz', -2147483648, '@');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('Q', 't1__155a33', 't1__571588', 'c4bfkfoac', '0', '7z2zezjo7wg', 'd5ysxc', -2147483648, '@');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 'u7', 'fe4hri', 'a2ypuzhsrwbb', 'p6luhvdlttil', 'n', 'rmdp', -2147483648, 'H');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('H', NULL, 'u7', 'fe4hri', 'a2ypuzhsrwbb', 'p6luhvdlttil', 'n', -2147483648, 'E');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('D', 'p5s5bbp', NULL, '02eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', -2147483648, 'B');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('B', 'bdvlph', 'gndqwnqc', 'x5hncprjtu0', 'z', '9fjgq8n2f', 'dqv0gcb9', -2147483648, 'C');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_1', '02eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr', '13pyu');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t1__95fde5', 't2__4e144e', '5k5swwqcgs', '9n8');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t1__6e79dd', 'nw6klf', 'a9000t5c4eci', 'gce376nium52');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('A', 't2__4e144e', 'z', '9fjgq8n2f');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('@', 'dqv0gcb9', 'ozk3zbily', 'kn6vc');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('?', '16nijjai5dh', 'ogrgjd8y', 't1afgog');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t2__657a98', 'mizt', 'vb6m4iz78aq', 'lud8f');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('H', '5k5swwqcgs', '9n8', '4');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('E', '5k5swwqcgs', '9n8', '4');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('B', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_10', NULL, 'jsl', 'b4yp5qi');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('C', 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, '4', 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd');

-- Inserting into table: budget --
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_1', '8d99rljsl', 419.361606, 470.165282, 1692174491, 'qi2rkf9v', 'event_id_1');

-- Inserting into table: expense --
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_1', 'x58pz', 'f8jegd2', 100.01, 'vy9uxj4', 'O', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_2', 'bdvlph', 'gndqwnqc', 100.01, 'x5hncprjtu0', 'O', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_3', 'tsj3ayxp1q4', '01jh3den', 100.01, 'c68x8vacx', 'G', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_4', 'u5', '1of77p', 100.01, 'o72ctdc', 'G', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_5', '62', '0v', 100.01, 'q8qdjpe1', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_6', '2278', '07cvtjpt', 100.01, 'tg6bnou5zi', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_7', '0oztdgj5i3lq', '5lnpim5k58qs', 100.01, '7p2r94gt', 'Q', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_8', '2mnajjla3o', 'v8u', 100.01, 'tmu2n', 'Q', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_9', 'vy', '7zzbe8y', 100.01, 'kv42q7', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_10', '58b4pm', 'u', 100.01, '3auvm', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_11', 'j', 'wzw5chn9mo70', 100.01, 'a9n0jxfo', 'O', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_12', 'szdo2z', 'obb0q0k32o', 100.01, 'w', 'O', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_13', 'amsorlwyng', '1', 100.01, 'j', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_14', 'rhizgk1yoey', 'o6l0hdt6fu', 100.01, 'yxuzk', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_15', 'gwnlas6', 'elboeowii1', 100.01, '5nxih66', 'Q', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_16', '2xlyo', 'tow9oaawg96a', 100.01, 'qb0tbindz39t', 'Q', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('O', 'td8n5wcgu', 'bc3t', 100.01, 'u', 'O', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('A', 'd0w9603vzxw1', 'xe9yf', 100.01, '7qk', 'O', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_19', '55', '3dohvu0', 100.01, 'dza35rmki', 'G', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_20', '8ri2hy0', '8ftp6ewtqx', 100.01, 'njabym', 'G', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('G', 'fx7h', '3p6sto1c', 100.01, '8sh', 'Q', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_22', 'ys7dyyd1jmg', 'jach8qta8y3', 100.01, '1', 'G', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_23', 'ygmayq3q', 'dpuap96rnt', 100.01, 'q', 'G', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_24', '7', 'dn2np490xdm', 100.0, 'sqtgelcuqb', 'O', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_25', 'f2ccukjq1', 'uik1y', 100.0, 'hb08hlst1pq', 'O', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_26', '9114qbre6bj', 'uu', 100.01, 'sj8kjh', 'O', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_27', 'pxlvri', 'surz0kaqtncg', 100.01, 'c8s3b7v88k', 'O', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_28', 'b', 'h', 100.01, '6j47n', 'O', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_29', 'r', '0hsjhanz', 100.01, 'dpunmw', 'O', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_30', 'rlawk', '14r5dqt', 100.01, 'mg97a', 'O', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_31', '2o20pj6', 'd', 100.01, 'ysu', 'O', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('@', 'siie5unw6k', 'fa9', NULL, '00t5c4e', '@', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('D', 'mdpos', 'ie5', 100.01, 'nw6klf', 'H', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('B', 'au2dwy', 'q13py', 100.01, '78d99r', 'D', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('C', 'k3zbily', 'kn6vc', 100.01, '6ah', 'B', 'budget_id_1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.first_name, T1.last_name, T2.major_name FROM member AS T1 INNER JOIN major AS T2 ON T2.major_id = T1.link_to_major INNER JOIN expense AS T3 ON T1.member_id = T3.link_to_member WHERE T3.cost > 100;

/*
Gold Result:
('t1__155a33', 't1__571588', 't2__4e144e')
('t1__155a33', 't1__571588', 'dqv0gcb9')
('t1__155a33', 't1__571588', 'nw6klf')
(None, 'u7', '5k5swwqcgs')
('p5s5bbp', None, 'a9000t5c4eci')
('bdvlph', 'gndqwnqc', 'rkf9vqx5')
*/

-- Prediction Query
SELECT member.first_name, member.last_name, major.major_name FROM expense INNER JOIN member ON expense.link_to_member = member.member_id INNER JOIN major ON member.link_to_major = major.major_id WHERE expense.cost > 100;

/*
Prediction Result:
('t1__155a33', 't1__571588', 't2__4e144e')
('t1__155a33', 't1__571588', 't2__4e144e')
('t1__155a33', 't1__571588', 'dqv0gcb9')
('t1__155a33', 't1__571588', 'dqv0gcb9')
('t1__155a33', 't1__571588', 'nw6klf')
('t1__155a33', 't1__571588', 'nw6klf')
('t1__155a33', 't1__571588', 'dqv0gcb9')
('t1__155a33', 't1__571588', 'dqv0gcb9')
('t1__155a33', 't1__571588', 'nw6klf')
('t1__155a33', 't1__571588', 'nw6klf')
('t1__155a33', 't1__571588', 't2__4e144e')
('t1__155a33', 't1__571588', 't2__4e144e')
('t1__155a33', 't1__571588', 'nw6klf')
('t1__155a33', 't1__571588', 'nw6klf')
('t1__155a33', 't1__571588', 'dqv0gcb9')
('t1__155a33', 't1__571588', 'dqv0gcb9')
('t1__155a33', 't1__571588', 't2__4e144e')
('t1__155a33', 't1__571588', 't2__4e144e')
('t1__155a33', 't1__571588', 'dqv0gcb9')
('t1__155a33', 't1__571588', 'dqv0gcb9')
('t1__155a33', 't1__571588', 'dqv0gcb9')
('t1__155a33', 't1__571588', 'dqv0gcb9')
('t1__155a33', 't1__571588', 'dqv0gcb9')
('t1__155a33', 't1__571588', 't2__4e144e')
('t1__155a33', 't1__571588', 't2__4e144e')
('t1__155a33', 't1__571588', 't2__4e144e')
('t1__155a33', 't1__571588', 't2__4e144e')
('t1__155a33', 't1__571588', 't2__4e144e')
('t1__155a33', 't1__571588', 't2__4e144e')
(None, 'u7', '5k5swwqcgs')
('p5s5bbp', None, 'a9000t5c4eci')
('bdvlph', 'gndqwnqc', 'rkf9vqx5')
*/