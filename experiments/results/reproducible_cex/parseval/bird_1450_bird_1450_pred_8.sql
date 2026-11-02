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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__72ebe3', 'rwbbp6luhvd', 'tti', 'bnp', 'mdpos', 'ie5', 'nw6klf', 2, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 'lex', '4ji7zwa', '2dwyrq', '3pyu78d', '9rljsl0b4', 'p5qi2rk', 2, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 'x58pz0f8je', 'd2', 'vy9uxj4', 'wb', 'v', 'ph2', 3, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('a', 'tsj', 'ayxp1q43', '1jh3den', 'c68x8vacx', 'afu5w1of7', 'pzo72ctdc', 2, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t2__82fecc', 'l', '5amsorlwyngc', 'dj9erhi', 'zgk1yoeyo6l0', 'dt', 'fuqyxuzkb', 3, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('C', 'ia2yp', 'uzhsrwbbp6lu', 'hvdlttilbnpr', 'dpos', 'ie5', 'nw6klf', 4, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('B', 'dpos', 'ie5', 'nw6klf', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof', 5, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('D', 'bdvlph', 'gndqwnqc', 'x5hncprjtu0', 'z', '9fjgq8n2f', 'dqv0gcb9', 6, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('J', 'xp1q430', 'jh3den8', 'c68x8vacx7', 'f', '5w1of7', 'pzo72ctdc', 7, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('F', 'q5l', 'pim5', '58q', 's27p2r94gth2', 'najj', 'a3o', 8, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('G', '0k32o', 'w', 'l', '5amsorlwyngc', 'dj9erhi', 'zgk1yoeyo6l0', 9, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('`', 'vzxw1rxe9y', 'k7', 'k162n', '55', '3dohvu0', 'dza35rmki', 10, 'major_id_1');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', 'gu7v', 'e4', 'hria2ypuzhs');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (2, '5k5swwqcgs', 't3__4fa312', 't3__a770bf', '9n8', '4');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (3, '9000t5c4ec', 'gce', '76nium52', 'zbuo4nrqrof', 'qyp5s5bbp0');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1, 'gwnlas6', 'elboeowii1', '5nxih66', 'q2xlyoto', '9oaawg');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (4, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (5, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483643, 'hria2ypuzhs', NULL, 'rwbbp6luhvd', 'tti', 'bnp');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (6, 'l7', 'klex14ji', '7zwau2dwyr', '13pyu', '8d99rljsl');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483641, 'b4yp5qi', NULL, 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (7, 'f8jswwl', '7xb72', 'xa', '7ryfdrz16n', 'jja');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483639, '5dh', NULL, 'ogrgjd8y', 't1afgog', 'itsj3');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (8, 'o22', '8507cvtjp', 'ttg6bnou5zi3', 'c4bfkfoac', '0');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483637, '7z2zezjo7wg', NULL, 'd5ysxc', 'r0oz', 'dgj5i');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (9, 'lfvyz7zzb', '8y', 'kv42q7', 'x58b4', 'pmaus3auvmkr');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483635, 'pdjwzw5chn9', NULL, 'o705', 'a9n0jxfofws', 'do2zobb');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (10, 'lboeowii1z5', 'xih6', '2q2xlyoto', '9oaawg', '6aqb0tbin');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483633, 'z', NULL, '9tajz9td', 'n5wcgumbc', '3tdu6bd0w960');

-- Inserting into table: income --
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_1', '2eutliqa11r', 41, 'ytoo3o9', 'l7', 't1__72ebe3');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_2', 'nd', 41, 'wnqcx', '5hncprjtu0d', 'A');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_3', 'gq8', 41, 'n2f3dqv0gcb9', 'ozk3zbily', 't1__72ebe3');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_4', 'n6vck6ah0f', 41, 'jswwlq7xb', '72fxa7ryfd', 'A');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_5', '16nijjai5dh', 41, 'ogrgjd8y', 't1afgog', 't1__72ebe3');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_6', 'mfg62g0v5q8q', 41, 'j', 'e1io', 'A');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_7', '8507cvtjp', 41, 'ttg6bnou5zi3', 'c4bfkfoac', 't1__72ebe3');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('G', '7z2zezjo7wg', 41, 'd5ysxc', 'r0oz', 't1__72ebe3');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('A', 'dgj5i', 41, 'lq5lnpim', 'k58qs27p', 't1__72ebe3');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_10', '4gth2mnaj', 41, 'la3', 'okv8uttmu2', 't1__72ebe3');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('O', '78lfvyz7', 41, 'zzbe8yvkv4', 'q7sx58b4', 't1__72ebe3');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_12', 'u', 41, '3auvm', 'rpd', 't1__72ebe3');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_13', 'chn9mo70', 41, 'a9n0jxfo', 'ws', 't1__72ebe3');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_14', '2zob', 40, '0', '0k32o', 't1__72ebe3');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_15', '0', 41, 'bindz', '9tajz9td', 't1__72ebe3');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_16', 'cgumbc', 41, '3tdu6bd0w960', 'vzxw1rxe', 't1__72ebe3');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('@', 'a9000t5c4eci', NULL, 'gce376nium52', 'zbuo4nrqrof', 'C');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('B', 'qyp5s5bbp0', 41, '2eutliqa11r', 'ytoo3o9', 'B');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('H', 'ozk3zbily', 41, 'kn6vc', '6ah', 'D');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('F', 'mfg62', 41, '0v', 'q8qdjpe1', 'J');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('C', 'v8u', 41, 'tmu2n', '57', 'F');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('b', 'dt', 41, 'fuqyxuzkb', '521gwnlas6e', 'G');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('"', '18ri', 41, 'hy08ftp6', 'wt', '`');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.city, T3.county FROM income AS T1 INNER JOIN member AS T2 ON T1.link_to_member = T2.member_id INNER JOIN zip_code AS T3 ON T3.zip_code = T2.zip WHERE T1.amount > 40;

/*
Gold Result:
('t3__4fa312', 't3__a770bf')
('gce', '76nium52')
('9n8', '4')
('klex14ji', '7zwau2dwyr')
('7xb72', 'xa')
('8507cvtjp', 'ttg6bnou5zi3')
('8y', 'kv42q7')
('xih6', '2q2xlyoto')
*/

-- Prediction Query
SELECT T3.city, T3.state FROM income AS T1 INNER JOIN member AS T2 ON T1.link_to_member = T2.member_id INNER JOIN zip_code AS T3 ON T2.zip = T3.zip_code WHERE T1.amount > 40;

/*
Prediction Result:
('t3__4fa312', '9n8')
('gce', 'zbuo4nrqrof')
('t3__4fa312', '9n8')
('gce', 'zbuo4nrqrof')
('t3__4fa312', '9n8')
('gce', 'zbuo4nrqrof')
('t3__4fa312', '9n8')
('t3__4fa312', '9n8')
('t3__4fa312', '9n8')
('t3__4fa312', '9n8')
('t3__4fa312', '9n8')
('t3__4fa312', '9n8')
('t3__4fa312', '9n8')
('t3__4fa312', '9n8')
('t3__4fa312', '9n8')
('9n8', 'gu7v')
('klex14ji', '13pyu')
('7xb72', '7ryfdrz16n')
('8507cvtjp', 'c4bfkfoac')
('8y', 'x58b4')
('xih6', '9oaawg')
*/