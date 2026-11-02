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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_1', 'gce376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9', 'l7', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_2', 'dqv0gcb98ozk', 'zbilyrkn', '6vck6ah0f8js', 'wlq7xb', '72fxa7ryfd', 'z16ni', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_3', 'bnou5zi36', '4', 'f', 'foa', 'cd07z2zezjo7', 'wgxd5ysxcm', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_4', 'ztdgj5i3lq5l', 'pim5', '58q', 's27p2r94gth2', 'najj', 'a3o', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_5', 'g', 'mbc3td', 'u6bd0w9603', 'vzxw1rxe9y', 'k7', 'k162n', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_6', 'uik1y', 'hb08hlst1pq', 'mizt', 'vb6m4iz78aq', 'lud8f', 'tb8r9114qbre', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_7', 'uu', 'sj8kjh', '5wpxlvris', 'urz0kaqtncg', 'c8s3b7v88k', 'dmdbdh', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_8', 'nxar50hsj', 'an', 'xdpunmw', 'wx', 'rlawk', '14r5dqt', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_9', '7aqz2o20p', '6dd', 'ysu', 'iphdku2gi', '31vwq', '1oa2sb3u', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_10', 'avcvwnyqroui', 'lrpou', 't63', 'xyfvmjwpp26', 'b3aj', '0ju0h3r133ir', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_11', 'hpl2i9e', 'ap8pg', 'k', 'wtsr5', '4o6qjektb1', '2', -2147483648, 'major_id_1');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__03570f', 't1__252c62', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', 't1__252c62', 'klex14ji', '7zwau2dwyr', '13pyu', '8d99rljsl', 'b4yp5qi');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('C', 't1__252c62', 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4', 'wb', 'v');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__a93d97', 't1__252c62', 'ph2', 'nd', 'wnqcx', '5hncprjtu0d', '79fjgq8');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('K', 't1__252c62', 'jai', 'dh5ogrgj', '8', 'yzt1afgogrit', 'sj3ayxp1q430');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('@', 't1__252c62', 'jh3den8', 'c68x8vacx7', 'f', '5w1of7', 'pzo72ctdc');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_5', 't1__252c62', 'mfg62', '0v', 'q8qdjpe1', 'o22', '8507cvtjp');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('G', 't1__252c62', 'v8u', 'tmu2n', '57', 'lfvyz7zzb', '8y');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_8', 't1__252c62', 'kv42q7', 'x58b4', 'pmaus3auvmkr', 'pdjwzw5chn9', 'o705');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('"', 'a9n0jxfofws', 'do2zobb', 'q0k32od', 'cl5ams', 'orlwyngc1dj', '9erhizgk1yoe');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('w', 't1__252c62', 'l0hdt6fuq', 'xuzkb52', 'gwnlas6', 'elboeowii1', '5nxih66');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_11', 't1__252c62', 'q2xlyoto', '9oaawg', '6aqb0tbin', 'z', '9tajz9td');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('+', 't1__252c62', '55y3dohvu06d', 'a35rmki', '18ri', 'hy08ftp6', 'wt');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_13', 't1__252c62', 'xxnja', 'bymzn2mfx7h3', 'p6sto1cj', 'sh5knzys7', 'y');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('a', 'yd1jmgjach8', 'qta8y3a17v4y', 'ma', 'q3qdpua', '96rn', 'dqrhm');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__488c05', 't1__252c62', 'wlic7dn2np', '90xdmsqt', 'el', 'u', 'qb9i9f2ccu');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('B', 't1__de008d', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('D', 't1__de008d', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'bnp', 'mdpos');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Q', NULL, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'bnp', 'mdpos', 'ie5', 'nw6klf', 'a9000t5c4eci');

-- Inserting into table: attendance --
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__03570f', 'member_id_1');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_1');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_2');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_3');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_4');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('"', 'member_id_4');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('"', 'member_id_2');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('"', 'member_id_5');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('"', 'member_id_1');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('a', 'member_id_4');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('a', 'member_id_5');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__488c05', 'member_id_2');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__488c05', 'member_id_6');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__488c05', 'member_id_7');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__488c05', 'member_id_3');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__488c05', 'member_id_5');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__488c05', 'member_id_8');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__488c05', 'member_id_9');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__488c05', 'member_id_4');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__488c05', 'member_id_10');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__03570f', 'member_id_7');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__03570f', 'member_id_11');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('D', 'member_id_3');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', 'member_id_3');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Q', 'member_id_11');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_name FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event GROUP BY T1.event_name ORDER BY COUNT(T2.link_to_event) DESC, T1.event_name NULLS LAST LIMIT 1;

/*
Gold Result:
('t1__252c62',)
*/

-- Prediction Query
SELECT e.event_name FROM event AS e INNER JOIN attendance AS a ON e.event_id = a.link_to_event GROUP BY e.event_id ORDER BY COUNT(a.link_to_member) DESC, e.event_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('t1__252c62',)
*/