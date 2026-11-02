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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_1', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr', -2147483648, 'major_id_1');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__501f19', 'October Meeting', '2019-10-08', '5k5swwqcgs', '9n8', '4', 'gu7v');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__777fc4', 'October Meeting', '2019-10-08', 'yp5qi2rk', '9v', 'x58pz', 'f8jegd2');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', 'October Meeting', '2019-10-08', 'k3zbily', 'kn6vc', '6ah', 'f8jswwl');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('O', '7xb72', 'xa', '7ryfdrz16n', 'jja', '5dh', 'ogrgjd8y');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('C', '5q8qdj', 'e1io', '278507cv', 'jpttg', 'bnou5zi36', '4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__4bce0f', 'October Meeting', '2019-10-08', '78lfvyz7zz', 'be8yvkv42q7', 'x58b4', 'pmaus3auvmkr');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('@', 'October Meeting', NULL, '5k5swwqcgs', '9n8', '4', 'gu7v');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('B', 'October Meeting', NULL, '5u', 'w6kl', 'a9', '00t5c4e');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('J', 'October Meeting', NULL, 'liqa1', 'ryytoo3', '9hl7', 'klex14ji');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('`', 'October Meeting', NULL, 'x58pz', 'f8jegd2', 'vy9uxj4', 'wb');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('K', 'October Meeting', NULL, 'qv0gcb98ozk', 'zbilyrkn', '6vck6ah0f8js', 'wlq7xb');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('a', 'October Meeting', NULL, 'ri', 'tsj3ayxp1q4', '01jh3den', 'c68x8vacx');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('D', 'October Meeting', NULL, 'ou5z', '36c', 'bfkfoacd', '7z2zezj');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', 'uzhsrwbbp6lu', 'hvdlttilbnpr', 'dpos');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'ie5', 'nw6klf', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof');

-- Inserting into table: budget --
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t2__8850b8', 'e4', 779.409124, 640.719621, 1160656988, 'ia2yp', 't1__501f19');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t2__fbd625', 'vy9uxj4', 124.573829, 22.63964, -736979194, 'h2gn', 't1__501f19');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('_', 'sj3ay', 360.694313, 959.196496, 1792827279, '4301jh3den8', 't1__501f19');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('A', '68x8vacx7a', 983.924121, 313.653498, -47052816, '1of77pzo72c', 't1__501f19');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('O', '7wgx', 50.798088, 486.564401, -915385605, 'm', 't1__501f19');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_6', 'pdjwzw5chn9', 191.1711, 225.279122, 101754718, 'a9n0jxfo', 't2__4bce0f');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t3__a3c290', 'l', 708.448101, 988.402461, 364043263, 'sorlwyngc1', 't1__501f19');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_8', 'yxuzk', 20.547158, 959.258771, 450555855, '1gwnlas6', 't2__4bce0f');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_9', 'tbindz3', 555.680342, 302.335933, -2140923099, '9td8n5w', 't2__4bce0f');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('?', 'e4', 779.409124, 640.719621, 1160656988, 'ia2yp', '@');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('@', 'cigce376nium', 779.28645, 566.030342, 742285925, 'u', 'B');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('H', '7zwau2dwyr', 262.105498, 591.461096, 2142703426, 'u78d99r', 'J');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('D', 'v', 185.427628, 243.480613, 1581736075, 'gndqwnqc', '`');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('B', '72fxa7ryfd', 276.61064, 399.319982, 564390026, '6nijjai5dh', 'K');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('I', 'afu5w1of7', 517.927187, 398.637058, 1992637800, 'dctmf', 'a');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('`', '7wgx', 50.798088, 486.564401, -915385605, 'm', 'D');

-- Inserting into table: expense --
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_1', '13pyu', '8d99rljsl', 419.361606, 't3__6eace8', 'member_id_1', 't2__8850b8');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('A', 'wnqcx', '5hncprjtu0d', 395.809081, 't3__6eace8', 'member_id_1', 't2__8850b8');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('C', 'gq8', 'n2f3dqv0gcb9', 540.154414, 't3__6eace8', 'member_id_1', 't2__8850b8');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_4', '1afgo', 'ri', 630.468925, 't3__6eace8', 'member_id_1', 't2__8850b8');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_5', 'c', 'mfg62', 93.813527, 't3__6eace8', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_6', 'kf', 'oacd07z2zez', 147.932394, 't3__6eace8', 'member_id_1', 't2__8850b8');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_7', '0oztdgj5i3lq', '5lnpim5k58qs', 876.038555, 't3__6eace8', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_8', 'r94gth2m', 'ajjl', 11.892553, 't3__6eace8', 'member_id_1', 't2__8850b8');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_9', 'v8u', 'tmu2n', 76.823924, 't3__6eace8', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_10', 'szdo2z', 'obb0q0k32o', 57.929422, 't3__6eace8', 'member_id_1', 't2__8850b8');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('_', 'j9erhizgk1', 'yoeyo6l0hdt6', 834.163912, 't3__6eace8', 'member_id_1', 't3__a3c290');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_12', 'lboeowii1z5', 'xih6', 946.669761, 't3__6eace8', 'member_id_1', 't2__8850b8');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('O', '2xlyo', 'tow9oaawg96a', 725.010524, 't3__6eace8', 'member_id_1', 't3__a3c290');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_14', 'um', 'c', 714.781282, 't3__6eace8', 'member_id_1', 't2__8850b8');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_15', 'u6bd0w9603', 'vzxw1rxe9y', 85.140124, 't3__6eace8', 'member_id_1', 't2__8850b8');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_16', 'qk162nh55', '3dohvu0', 507.185482, 't3__6eace8', 'member_id_1', 't2__8850b8');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_17', '5rmkio18', 'i2hy0', 949.964729, NULL, 'member_id_1', 't2__8850b8');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('@', 'hsrwbbp', 'luhvdltti', 182.319045, 'nprmdposii', 'member_id_1', '?');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('B', 'nrqrofqy', '5s5b', 22.720462, '02eu', 'member_id_1', '@');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('F', 'sl0', '4', 884.000446, 'p5qi2rkf9v', 'member_id_1', 'H');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('`', '5hncprjtu0d', '79fjgq8', 915.268032, '2f3d', 'member_id_1', 'D');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('a', 'grgj', '8', 740.059813, 'zt1afgo', 'member_id_1', 'B');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('!', '2g0v5q8qd', 'jpe1io22785', 993.555996, '7cvtjpttg6b', 'member_id_1', 'I');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('"', '0oztdgj5i3lq', '5lnpim5k58qs', 876.038555, '7p2r94gth2m', 'member_id_1', '`');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.approved FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget WHERE T1.event_name = 'October Meeting' AND T1.event_date LIKE '2019-10-08%';

/*
Gold Result:
('t3__6eace8',)
('t3__6eace8',)
('t3__6eace8',)
('t3__6eace8',)
('t3__6eace8',)
('t3__6eace8',)
('t3__6eace8',)
('t3__6eace8',)
('t3__6eace8',)
('t3__6eace8',)
('t3__6eace8',)
('t3__6eace8',)
('t3__6eace8',)
('t3__6eace8',)
('t3__6eace8',)
('t3__6eace8',)
(None,)
*/

-- Prediction Query
SELECT T1.expense_id, T1.expense_description, T1.approved FROM expense AS T1 INNER JOIN budget AS T2 ON T1.link_to_budget = T2.budget_id INNER JOIN event AS T3 ON T2.link_to_event = T3.event_id WHERE T3.event_name LIKE '%October Meeting%' AND T3.event_date LIKE '%2019-10-08%';

/*
Prediction Result:
('expense_id_1', '13pyu', 't3__6eace8')
('A', 'wnqcx', 't3__6eace8')
('C', 'gq8', 't3__6eace8')
('expense_id_4', '1afgo', 't3__6eace8')
('expense_id_5', 'c', 't3__6eace8')
('expense_id_6', 'kf', 't3__6eace8')
('expense_id_7', '0oztdgj5i3lq', 't3__6eace8')
('expense_id_8', 'r94gth2m', 't3__6eace8')
('expense_id_9', 'v8u', 't3__6eace8')
('expense_i_10', 'szdo2z', 't3__6eace8')
('_', 'j9erhizgk1', 't3__6eace8')
('expense_i_12', 'lboeowii1z5', 't3__6eace8')
('O', '2xlyo', 't3__6eace8')
('expense_i_14', 'um', 't3__6eace8')
('expense_i_15', 'u6bd0w9603', 't3__6eace8')
('expense_i_16', 'qk162nh55', 't3__6eace8')
('expense_i_17', '5rmkio18', None)
*/