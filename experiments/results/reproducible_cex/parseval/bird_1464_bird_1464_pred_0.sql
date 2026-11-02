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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('C', 't3__3982ef', 't3__acb412', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 'ex1', 'ji7zwau2', 'dwyrq13pyu78', '9', 'rljsl0b4y', 'p5qi2rkf9v', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', 't3__3982ef', 't3__acb412', '3d', 'qv0gcb98ozk', 'zbilyrkn', '6vck6ah0f8js', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', '1jh3den', 'c68x8vacx', 'afu5w1of7', 'pzo72ctdc', 'mfg62', '0v', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('?', 'ttg6', 'n', 'u5zi', '6c4bfkfo', 'c', '0', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('G', 't3__3982ef', 't3__acb412', 'ezjo7wg', 'd5ysxc', 'r0oz', 'dgj5i', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('Q', 't3__3982ef', 't3__acb412', '7sx58b4pma', 'us3auvmkrpdj', 'wzw5chn9mo70', 'a9n0jxfo', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('_', 't3__3982ef', 't3__acb412', 'obb0q0k32o', 'w', 'l', '5amsorlwyngc', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t2__f3fff0', 'b52', 'gwnlas6', 'elboeowii1', '5nxih66', 'q2xlyoto', '9oaawg', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t3__6023ed', '0', 'bindz', '9tajz9td', 'n5wcgumbc', '3tdu6bd0w960', 'vzxw1rxe', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('H', 'b', 'p6luhvdlttil', 'n', 'rmdp', 'siie', 'unw6klfa', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('D', 'ex1', 'ji7zwau2', 'dwyrq13pyu78', '9', 'rljsl0b4y', 'p5qi2rkf9v', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('B', 'b', 'p6luhvdlttil', 'n', 'rmdp', 'siie', 'unw6klfa', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_14', NULL, '0t5c4ecigc', 'e376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('F', 'y9uxj4', 'wb', 'v', 'ph2', 'nd', 'wnqcx', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_16', NULL, 'cprj', 'u0dz7', 'fjgq8n2f3', 'dqv0gcb98ozk', 'zbilyrkn', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('$', '1afgogritsj', 'ayxp1q43', '1jh3den', 'c68x8vacx', 'afu5w1of7', 'pzo72ctdc', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_18', NULL, 'g6', 'g0v5q8qd', 'jpe1io22785', '7cvtjpt', 'tg6bnou5zi', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('`', '7p2r94gth2m', 'ajjl', '3', 'okv8uttmu2', 'e578', 'fvy', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_20', NULL, 'be8yvkv', '42q7sx58b4', 'pmaus3auvmkr', 'pdjwzw5chn9', 'o705', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('b', 'gwnlas6', 'elboeowii1', '5nxih66', 'q2xlyoto', '9oaawg', '6aqb0tbin', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_22', NULL, '9tajz9td', 'n5wcgumbc', '3tdu6bd0w960', 'vzxw1rxe', '9yfk7qk162n', -2147483648, 'major_id_1');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__72c333', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('G', 'v', 'ph2', 'nd', 'wnqcx', '5hncprjtu0d', '79fjgq8');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', 'q7x', '7', '2fxa7ryfdrz', '16nijjai5dh', 'ogrgjd8y', 't1afgog');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__20cfb4', '2mnajjla3o', 'v8u', 'tmu2n', '57', 'lfvyz7zzb', '8y');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('O', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('!', 'zbuo4nrq', 'rofqyp5s5b', 'p', '02eutliqa11r', 'ytoo3o9', 'l7');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('@', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('D', '7zwau2dwyr', '13pyu', '8d99rljsl', 'b4yp5qi', 'rkf9vqx5', 'pz0f8jegd');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('B', '7xb72', 'xa', '7ryfdrz16n', 'jja', '5dh', 'ogrgjd8y');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('H', '7wgx', '5', 'sxcmr0o', 'ztdgj5i3lq5l', 'pim5', '58q');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('I', 'q0k32od', 'cl5ams', 'orlwyngc1dj', '9erhizgk1yoe', 'o6l0hdt', 'fuqyxuzkb');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', 'rwbbp6luhvd', 'tti', 'bnp');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'mdpos', 'ie5', 'nw6klf', 'a9000t5c4eci', 'gce376nium52');

-- Inserting into table: attendance --
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__72c333', 'C');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__72c333', 'A');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'O');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'A');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__72c333', '@');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__72c333', '?');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'G');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__20cfb4', 'G');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__20cfb4', 'A');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__72c333', 'Q');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__72c333', 'O');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__20cfb4', '_');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__72c333', 'G');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__72c333', '_');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__20cfb4', 't2__f3fff0');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('O', 'H');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('!', 'D');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', 'B');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('D', 'F');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('B', '$');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('H', '`');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('I', 'b');

-- Inserting into table: income --
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('A', '2019-09-09', 1, 'x58pz', 'f8jegd2', 'C');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('C', '2019-09-09', 1, 'vy9uxj4', 'wb', 'C');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('O', '2019-09-09', 1, 'itsj3', 'y', 'O');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('_', '2019-09-09', 1, 'q8qdjpe1', 'o22', 'O');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('Q', '2019-09-09', 1, '162', 'h55y', 'O');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('G', '2019-09-09', NULL, 'a35rmki', '18ri', 'O');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('@', 't4__df7bad', 1419861592, '4ecigce376n', 'um5', 'H');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('B', NULL, 556727997, '8pz0f8je', 'd2', 'D');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('D', '2019-09-09', 2137741668, 'ytoo3o9hl7', 'klex14ji', 'B');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('H', '2019-09-09', -688098735, '6ah', 'f8jswwl', 'F');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('F', '2019-09-09', 1944978593, 'bfkfoacd', '7z2zezj', '$');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('J', '2019-09-09', 238533676, 'jxfofws', 'do2zobb', '`');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('E', '2019-09-09', -516345261, 'o', 'vu', 'b');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.first_name, T3.last_name, T4.amount FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event INNER JOIN member AS T3 ON T3.member_id = T2.link_to_member INNER JOIN income AS T4 ON T4.link_to_member = T3.member_id WHERE T4.date_received = '2019-09-09';

/*
Gold Result:
('t3__3982ef', 't3__acb412', 1)
('t3__3982ef', 't3__acb412', None)
('b', 'p6luhvdlttil', 2137741668)
('y9uxj4', 'wb', -688098735)
('1afgogritsj', 'ayxp1q43', 1944978593)
('7p2r94gth2m', 'ajjl', 238533676)
('gwnlas6', 'elboeowii1', -516345261)
*/

-- Prediction Query
SELECT T1.first_name, T1.last_name, T2.amount FROM member AS T1 INNER JOIN income AS T2 ON T1.member_id = T2.link_to_member WHERE T2.date_received = '2019-09-09';

/*
Prediction Result:
('t3__3982ef', 't3__acb412', 1)
('t3__3982ef', 't3__acb412', 1)
('t3__3982ef', 't3__acb412', 1)
('t3__3982ef', 't3__acb412', 1)
('t3__3982ef', 't3__acb412', 1)
('t3__3982ef', 't3__acb412', None)
('b', 'p6luhvdlttil', 2137741668)
('y9uxj4', 'wb', -688098735)
('1afgogritsj', 'ayxp1q43', 1944978593)
('7p2r94gth2m', 'ajjl', 238533676)
('gwnlas6', 'elboeowii1', -516345261)
*/