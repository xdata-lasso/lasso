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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__c87fc2', 'rwbbp6luhvd', 'tti', 'bnp', 'mdpos', 'ie5', 'nw6klf', 2, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 'lex', '4ji7zwa', '2dwyrq', '3pyu78d', '9rljsl0b4', 'p5qi2rk', 2, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 'x58pz0f8je', 'd2', 'vy9uxj4', 'wb', 'v', 'ph2', 3, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t2__588678', '58b4pmaus3a', 'vmkrpd', 'wzw', 'chn9mo70', 'a9n0jxfo', 'ws', 3, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('?', 'ia2yp', 'uzhsrwbbp6lu', 'hvdlttilbnpr', 'dpos', 'ie5', 'nw6klf', 5, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('G', 'dpos', 'ie5', 'nw6klf', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof', 6, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('C', 'bdvlph', 'gndqwnqc', 'x5hncprjtu0', 'z', '9fjgq8n2f', 'dqv0gcb9', 7, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('P', 'xp1q430', 'jh3den8', 'c68x8vacx7', 'f', '5w1of7', 'pzo72ctdc', 8, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('B', 'q5l', 'pim5', '58q', 's27p2r94gth2', 'najj', 'a3o', 9, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('R', '0k32o', 'w', 'l', '5amsorlwyngc', 'dj9erhi', 'zgk1yoeyo6l0', 10, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('#', 'vzxw1rxe9y', 'k7', 'k162n', '55', '3dohvu0', 'dza35rmki', 11, 'major_id_1');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', 'gu7v', 'e4', 'hria2ypuzhs');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (2, '5k5swwqcgs', 't3__aae625', 't3__0bdd95', '9n8', '4');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (3, '9000t5c4ec', 'gce', '76nium52', 'zbuo4nrqrof', 'qyp5s5bbp0');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (4, '9fjgq8n2f', 'dqv0gcb9', 'ozk3zbily', 'kn6vc', '6ah');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1, 'do2zobb', 'q0k32od', 'cl5ams', 'orlwyngc1dj', '9erhizgk1yoe');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (5, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483643, '5k5swwqcgs', NULL, '9n8', '4', 'gu7v');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (6, 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'bnp');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483641, 'l7', NULL, 'klex14ji', '7zwau2dwyr', '13pyu');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (7, '8d99rljsl', 'b4yp5qi', 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483639, 'f8jswwl', NULL, '7xb72', 'xa', '7ryfdrz16n');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (8, 'jja', '5dh', 'ogrgjd8y', 't1afgog', 'itsj3');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483637, 'o22', NULL, '8507cvtjp', 'ttg6bnou5zi3', 'c4bfkfoac');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (9, '0', '7z2zezjo7wg', 'd5ysxc', 'r0oz', 'dgj5i');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483635, 'lfvyz7zzb', NULL, '8y', 'kv42q7', 'x58b4');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (10, 'pmaus3auvmkr', 'pdjwzw5chn9', 'o705', 'a9n0jxfofws', 'do2zobb');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483633, 'lboeowii1z5', NULL, 'xih6', '2q2xlyoto', '9oaawg');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (11, '6aqb0tbin', 'z', '9tajz9td', 'n5wcgumbc', '3tdu6bd0w960');

-- Inserting into table: income --
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_1', '2eutliqa11r', 41, 'ytoo3o9', 'l7', 't1__c87fc2');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_2', 'nd', 41, 'wnqcx', '5hncprjtu0d', 'A');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_3', '8j', 41, 'wwlq7', 'xb72fxa7ryfd', 't1__c87fc2');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_4', '16nijjai5dh', 41, 'ogrgjd8y', 't1afgog', 'A');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_5', 'tsj3ayxp1q4', 41, '01jh3den', 'c68x8vacx', 't1__c87fc2');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_6', '5w1of7', 41, 'pzo72ctdc', 'mfg62', 'A');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_7', '5q8qdj', 41, 'e1io', '278507cv', 't1__c87fc2');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('G', 'ttg6', 41, 'n', 'u5zi', 't1__c87fc2');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('A', '6c4bfkfo', 41, 'c', '0', 't1__c87fc2');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_10', 'ezjo7wg', 41, 'd5ysxc', 'r0oz', 't1__c87fc2');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_11', '5i3lq5lnpim5', 41, '58q', 's27p2r94gth2', 't1__c87fc2');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_12', 'la3', 41, 'okv8uttmu2', 'e578', 't1__c87fc2');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_13', 'yz7zzb', 40, '8y', 'kv42q7', 't1__c87fc2');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_14', 'l0hdt6fuq', 41, 'xuzkb52', 'gwnlas6', 't1__c87fc2');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_15', 'boeowii1z5nx', 41, 'h66', 'q2xlyoto', 't1__c87fc2');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('@', 'a9000t5c4eci', NULL, 'gce376nium52', 'zbuo4nrqrof', '?');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('D', 'qyp5s5bbp0', 41, '2eutliqa11r', 'ytoo3o9', 'G');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('`', 'ozk3zbily', 41, 'kn6vc', '6ah', 'C');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('B', 'mfg62', 41, '0v', 'q8qdjpe1', 'P');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('C', 'v8u', 41, 'tmu2n', '57', 'B');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('R', 'dt', 41, 'fuqyxuzkb', '521gwnlas6e', 'R');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('#', '18ri', 41, 'hy08ftp6', 'wt', '#');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.city, T3.county FROM income AS T1 INNER JOIN member AS T2 ON T1.link_to_member = T2.member_id INNER JOIN zip_code AS T3 ON T3.zip_code = T2.zip WHERE T1.amount > 40;

/*
Gold Result:
('t3__aae625', 't3__0bdd95')
('gce', '76nium52')
('hria2ypuzhs', 'rwbbp6luhvd')
('b4yp5qi', 'rkf9vqx5')
('5dh', 'ogrgjd8y')
('7z2zezjo7wg', 'd5ysxc')
('pdjwzw5chn9', 'o705')
('z', '9tajz9td')
*/

-- Prediction Query
SELECT T1.city, T1.county FROM zip_code AS T1 INNER JOIN member AS T2 ON T1.zip_code = T2.zip INNER JOIN income AS T3 ON T2.member_id = T3.link_to_member GROUP BY T1.city, T1.county HAVING COUNT(DISTINCT T2.member_id) > 40;

/*
Prediction Result:
*/