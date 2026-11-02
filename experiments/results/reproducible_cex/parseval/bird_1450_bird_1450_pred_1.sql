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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__f9f81a', 'rwbbp6luhvd', 'tti', 'bnp', 'mdpos', 'ie5', 'nw6klf', 2, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 'lex', '4ji7zwa', '2dwyrq', '3pyu78d', '9rljsl0b4', 'p5qi2rk', 2, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 'x58pz0f8je', 'd2', 'vy9uxj4', 'wb', 'v', 'ph2', 3, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('G', 'kf', 'oacd07z2zez', 'o7w', 'xd', 'ysxcmr0o', 'ztdgj5i3lq5l', 2, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('_', 'vy', '7zzbe8y', 'kv42q7', 'x58b4', 'pmaus3auvmkr', 'pdjwzw5chn9', 2, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', 'k1', 'yoeyo6l0hdt6', 'uq', 'xuzkb52', 'gwnlas6', 'elboeowii1', 2, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t2__43d569', 'cgumbc', '3tdu6bd0w960', 'vzxw1rxe', '9yfk7qk162n', '55', '3dohvu0', 3, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('D', 'ia2yp', 'uzhsrwbbp6lu', 'hvdlttilbnpr', 'dpos', 'ie5', 'nw6klf', 4, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('H', 'dpos', 'ie5', 'nw6klf', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof', 5, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('F', 'bdvlph', 'gndqwnqc', 'x5hncprjtu0', 'z', '9fjgq8n2f', 'dqv0gcb9', 6, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('B', 'xp1q430', 'jh3den8', 'c68x8vacx7', 'f', '5w1of7', 'pzo72ctdc', 7, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('R', 'q5l', 'pim5', '58q', 's27p2r94gth2', 'najj', 'a3o', 8, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('!', '0k32o', 'w', 'l', '5amsorlwyngc', 'dj9erhi', 'zgk1yoeyo6l0', 9, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('C', 'vzxw1rxe9y', 'k7', 'k162n', '55', '3dohvu0', 'dza35rmki', 10, 'major_id_1');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', 'gu7v', 'e4', 'hria2ypuzhs');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (2, '5k5swwqcgs', 't3__3b194e', 't3__d1aeee', '9n8', '4');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (3, '9000t5c4ec', 'gce', '76nium52', 'zbuo4nrqrof', 'qyp5s5bbp0');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1, 'dza35rmki', '18ri', 'hy08ftp6', 'wt', 'xxnja');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (4, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483644, '5k5swwqcgs', NULL, '9n8', '4', 'gu7v');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (5, 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'bnp');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483642, 'l7', NULL, 'klex14ji', '7zwau2dwyr', '13pyu');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (6, '8d99rljsl', 'b4yp5qi', 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483640, 'f8jswwl', NULL, '7xb72', 'xa', '7ryfdrz16n');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (7, 'jja', '5dh', 'ogrgjd8y', 't1afgog', 'itsj3');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483638, 'o22', NULL, '8507cvtjp', 'ttg6bnou5zi3', 'c4bfkfoac');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (8, '0', '7z2zezjo7wg', 'd5ysxc', 'r0oz', 'dgj5i');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483636, 'lfvyz7zzb', NULL, '8y', 'kv42q7', 'x58b4');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (9, 'pmaus3auvmkr', 'pdjwzw5chn9', 'o705', 'a9n0jxfofws', 'do2zobb');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483634, 'lboeowii1z5', NULL, 'xih6', '2q2xlyoto', '9oaawg');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (10, '6aqb0tbin', 'z', '9tajz9td', 'n5wcgumbc', '3tdu6bd0w960');

-- Inserting into table: income --
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_1', '2eutliqa11r', 41, 'ytoo3o9', 'l7', 't1__f9f81a');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_2', 'nd', 41, 'wnqcx', '5hncprjtu0d', 'A');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_3', 'gq8', 41, 'n2f3dqv0gcb9', 'ozk3zbily', 't1__f9f81a');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_4', 'n6vck6ah0f', 41, 'jswwlq7xb', '72fxa7ryfd', 'A');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_5', '16nijjai5dh', 41, 'ogrgjd8y', 't1afgog', 't1__f9f81a');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_6', 'tsj3ayxp1q4', 41, '01jh3den', 'c68x8vacx', 'A');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_7', '5w1of7', 41, 'pzo72ctdc', 'mfg62', 't1__f9f81a');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('O', '5q8qdj', 41, 'e1io', '278507cv', 't1__f9f81a');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('A', 'jpttg', 41, 'bnou5zi36', '4', 't1__f9f81a');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_10', 'im5k', 41, '8qs27p2r', '4gth2mnaj', 'A');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('I', '3', 41, 'okv8uttmu2', 'e578', 't1__f9f81a');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_12', 'o705a9n0jxfo', 41, 'ws', 'do2zobb', 'A');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('C', '0k32odwcl5a', 41, 'msorlwyngc', 'dj9erhi', 't1__f9f81a');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_14', 'nxih662q', 41, 'xlyotow9', 'aawg', 'A');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_15', '0', 40, 'bindz', '9tajz9td', 't1__f9f81a');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_16', 'mzn2mfx7h3', 41, 'p6sto1cj', 'sh5knzys7', 't1__f9f81a');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_17', 'yd1jmgjach8', 41, 'qta8y3a17v4y', 'ma', 't1__f9f81a');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('@', 'a9000t5c4eci', NULL, 'gce376nium52', 'zbuo4nrqrof', 'D');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('H', 'qyp5s5bbp0', 41, '2eutliqa11r', 'ytoo3o9', 'H');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('B', 'ozk3zbily', 41, 'kn6vc', '6ah', 'F');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('"', 'mfg62', 41, '0v', 'q8qdjpe1', 'B');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('`', 'v8u', 41, 'tmu2n', '57', 'R');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('D', 'dt', 41, 'fuqyxuzkb', '521gwnlas6e', '!');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('$', '18ri', 41, 'hy08ftp6', 'wt', 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.city, T3.county FROM income AS T1 INNER JOIN member AS T2 ON T1.link_to_member = T2.member_id INNER JOIN zip_code AS T3 ON T3.zip_code = T2.zip WHERE T1.amount > 40;

/*
Gold Result:
('t3__3b194e', 't3__d1aeee')
('gce', '76nium52')
('hria2ypuzhs', 'rwbbp6luhvd')
('b4yp5qi', 'rkf9vqx5')
('5dh', 'ogrgjd8y')
('7z2zezjo7wg', 'd5ysxc')
('pdjwzw5chn9', 'o705')
('z', '9tajz9td')
*/

-- Prediction Query
SELECT z.city, z.county FROM event AS e JOIN budget AS b ON e.event_id = b.link_to_event JOIN income AS i ON b.link_to_event = e.event_id JOIN member AS m ON i.link_to_member = m.member_id JOIN zip_code AS z ON m.zip = z.zip_code GROUP BY e.event_id HAVING COUNT(i.income_id) > 40;

/*
Prediction Result:
*/