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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__6702b8', 'Maya', 'Mclean', 'l7', 'klex14ji', '7zwau2dwyr', '13pyu', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__8949b7', 'Maya', 'Mclean', '1afgogritsj', 'ayxp1q43', '1jh3den', 'c68x8vacx', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', 'Maya', 'Mclean', 'ysxcmr0o', 'ztdgj5i3lq5l', 'pim5', '58q', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', '7p2r94gth2m', 'ajjl', '3', 'okv8uttmu2', 'e578', 'fvy', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('G', 'Maya', 'Mclean', 'gwnlas6', 'elboeowii1', '5nxih66', 'q2xlyoto', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t2__3d2749', 'Maya', 'Mclean', 'sqtg', 'lc', 'qb9i9f', 'ccukjq1q', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('_', 'Maya', 'Mclean', 'swwqcgsk', '9n8c4pgu7v', 'e4', 'hria2ypuzhs', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 'Maya', 't1__b474f2', '6klfa9', '00t5c4e', 'cigce376nium', '52zbuo4nrq', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('D', 'Maya', NULL, 'au2dwyrq13', 'yu78', '9', 'rljsl0b4y', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('B', 't1__aad966', 'Mclean', 'h2gndqwnqcx5', 'hncprjtu0dz', '9fjgq8n2f', 'dqv0gcb9', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('C', 't1__aad966', NULL, 'dr', 'z16nijjai5d', 'h5ogrgjd8yz', '1afgo', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('F', NULL, 'Mclean', 'g6', 'g0v5q8qd', 'jpe1io22785', '7cvtjpt', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('E', NULL, 't1__b474f2', '0oztdgj5i3lq', '5lnpim5k58qs', '7p2r94gt', '2m', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('H', NULL, NULL, 'v42q7sx58b4p', 'aus3', 'u', 'mkrpdj', -2147483648, 'major_id_1');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_1', 'eve_1518ae', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__c9becf', 't3__724809', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'bnp', 'mdpos');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_3', 'eve_1518ae', '8d99rljsl', 'b4yp5qi', 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', 'eve_1518ae', 'd', 'lph2gn', 'q', 'nqcx5h', 'cprj');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('C', 'eve_1518ae', 'u0dz7', 'fjgq8n2f3', 'dqv0gcb98ozk', 'zbilyrkn', '6vck6ah0f8js');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_4', 't3__78eac2', 'wlq7xb', '72fxa7ryfd', 'z16ni', 'jai', 'dh5ogrgj');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__5382ab', 'afu5w1of7', 'pzo72ctdc', 'mfg62', '0v', 'q8qdjpe1', 'o22');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_8', 'eve_1518ae', '8507cvtjp', 'ttg6bnou5zi3', 'c4bfkfoac', '0', '7z2zezjo7wg');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_9', 'eve_1518ae', '7zzbe8y', 'kv42q7', 'x58b4', 'pmaus3auvmkr', 'pdjwzw5chn9');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('G', '05a9n0jxf', 'fwsz', 'o', '2zobb0q0k32o', 'w', 'l');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_11', 'eve_1518ae', '5amsorlwyngc', 'dj9erhi', 'zgk1yoeyo6l0', 'dt', 'fuqyxuzkb');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_12', 'eve_1518ae', '9oaawg', '6aqb0tbin', 'z', '9tajz9td', 'n5wcgumbc');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_13', 'eve_1518ae', 'u', 'bd0w9603v', 'xw1rxe9', 'fk7qk16', '2nh55y3doh');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_14', 'eve_1518ae', '6dza35r', 'mkio18ri2hy', '08ftp6ewtqxx', 'jaby', 'mzn2mfx7h3');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('E', '6sto1cj8sh5k', 'zys7', 'y', 'yd1jmgjach8', 'qta8y3a17v4y', 'ma');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_16', 'eve_1518ae', 'q3qdpua', '96rn', 'dqrhm', 'wlic7dn2', 'p490');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_17', 'eve_1518ae', 'ik1yhb', '8hlst1p', 'qomiztvb6m', 'iz78aqql', 'd8ftb8');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_18', 'eve_1518ae', '4qbre6b', 'jeuuwsj8kj', '85', 'pxlvri', 'surz0kaqtncg');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_19', 'eve_1518ae', 'b7v88kwd', 'dbdh', '6j47n', 'ar50hs', 'han');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_20', 'eve_1518ae', 'p', 'nmwfwx', 'rlawk', '14r5dqt', 'mg97a');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_21', 'eve_1518ae', 'o20pj6dd', 'ysu', 'iphdku2gi', '31vwq', '1oa2sb3u');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_22', 'eve_1518ae', 'pavcvwn', 'qrouirl', 'rpouit63xyf', 'mjwpp2', 'mb3aj0ju0');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_23', 'eve_1518ae', '133ir', 'axyyhpl', 'i9esap8p', 'gckqwtsr54', '6qje');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t3__3de82e', '1', '2', 'zg3r', 'jkwns47j2j', '8', 'c');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_25', NULL, 'y', 'vjwq49yr', 'nxs6dvdxdo2v', '7t3gvplj9f', 'vuu');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_26', 'eve_1518ae', '0z2my1o', 'gyv1rgezaxc', '1clupgly78o', 'txe', 'lpe');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('@', 'Women''s Soccer', 'rwbbp6luhvd', 'tti', 'bnp', 'mdpos', 'ie5');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('B', 'rofqyp5s5b', 'p', '02eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('D', 'p5qi2rkf9v', 'x58pz', 'f8jegd2', 'vy9uxj4', 'wb', 'v');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('F', 'ozk3zbily', 'kn6vc', '6ah', 'f8jswwl', '7xb72', 'xa');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('H', 'ri', 'tsj3ayxp1q4', '01jh3den', 'c68x8vacx', 'afu5w1of7', 'pzo72ctdc');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('$', 'tg6bnou5zi', '6c4bfkfo', 'c', '0', '7z2zezjo7wg', 'd5ysxc');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('L', 'ajjl', '3', 'okv8uttmu2', 'e578', 'fvy', '7zzbe8y');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('(', 'wzw5chn9mo70', 'a9n0jxfo', 'ws', 'do2zobb', 'q0k32od', 'cl5ams');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', 'ie5', 'nw6klf', 'a9000t5c4eci');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'gce376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9');

-- Inserting into table: attendance --
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c9becf', 't1__6702b8');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__5382ab', 't1__6702b8');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c9becf', 'A');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 't1__6702b8');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('E', 't1__6702b8');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c9becf', 't2__3d2749');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', '_');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('B', '@');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('D', 'D');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('F', 'B');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('H', 'C');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('$', 'F');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('L', 'E');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('(', 'H');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CASE WHEN T3.event_name = 'Women''s Soccer' THEN 'YES' END AS result FROM member AS T1 INNER JOIN attendance AS T2 ON T1.member_id = T2.link_to_member INNER JOIN event AS T3 ON T2.link_to_event = T3.event_id WHERE T1.first_name = 'Maya' AND T1.last_name = 'Mclean';

/*
Gold Result:
(None,)
(None,)
(None,)
(None,)
(None,)
('YES',)
*/

-- Prediction Query
SELECT COUNT(*) > 0 FROM "member" AS M INNER JOIN "attendance" AS A ON M."member_id" = A."link_to_member" INNER JOIN "event" AS E ON A."link_to_event" = E."event_id" WHERE M."first_name" = 'Maya' AND M."last_name" = 'Mclean' AND E."event_name" = 'Women''s Soccer';

/*
Prediction Result:
(1,)
*/