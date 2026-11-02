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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('C', 't3__203443', 't3__48f842', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 'ex1', 'ji7zwau2', 'dwyrq13pyu78', '9', 'rljsl0b4y', 'p5qi2rkf9v', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', 't3__203443', 't3__48f842', '3d', 'qv0gcb98ozk', 'zbilyrkn', '6vck6ah0f8js', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', '1jh3den', 'c68x8vacx', 'afu5w1of7', 'pzo72ctdc', 'mfg62', '0v', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('?', '5zi36c4bfkfo', 'c', '0', '7z2zezjo7wg', 'd5ysxc', 'r0oz', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('G', 't3__203443', 't3__48f842', 'yz7zzb', '8y', 'kv42q7', 'x58b4', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('I', 't3__203443', 't3__48f842', '521gwnlas6e', 'lboeowii1z5', 'xih6', '2q2xlyoto', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t2__4a86f6', 'n5wcgumbc', '3tdu6bd0w960', 'vzxw1rxe', '9yfk7qk162n', '55', '3dohvu0', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t3__af0d70', '3', 'rmkio18r', 'i2hy08ftp6', 'wt', 'xxnja', 'bymzn2mfx7h3', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('B', 'b', 'p6luhvdlttil', 'n', 'rmdp', 'siie', 'unw6klfa', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('D', 'b', 'p6luhvdlttil', 'n', 'rmdp', 'siie', 'unw6klfa', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_12', NULL, '0t5c4ecigc', 'e376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('`', 'y9uxj4', 'wb', 'v', 'ph2', 'nd', 'wnqcx', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_14', NULL, 'cprj', 'u0dz7', 'fjgq8n2f3', 'dqv0gcb98ozk', 'zbilyrkn', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('a', '1afgogritsj', 'ayxp1q43', '1jh3den', 'c68x8vacx', 'afu5w1of7', 'pzo72ctdc', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_16', NULL, 'g6', 'g0v5q8qd', 'jpe1io22785', '7cvtjpt', 'tg6bnou5zi', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('F', '7p2r94gth2m', 'ajjl', '3', 'okv8uttmu2', 'e578', 'fvy', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_18', NULL, 'be8yvkv', '42q7sx58b4', 'pmaus3auvmkr', 'pdjwzw5chn9', 'o705', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('#', 'gwnlas6', 'elboeowii1', '5nxih66', 'q2xlyoto', '9oaawg', '6aqb0tbin', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_20', NULL, '9tajz9td', 'n5wcgumbc', '3tdu6bd0w960', 'vzxw1rxe', '9yfk7qk162n', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('$', 'knzys7dy', 'yd1jmgjach8', 'qta8y3a17v4y', 'ma', 'q3qdpua', '96rn', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_22', NULL, 'rhm5w', 'ic7', 'dn2np490xdm', 'sqtgelcuqb', 'i9f2ccukj', -2147483648, 'major_id_1');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__9a27ca', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('O', 'v', 'ph2', 'nd', 'wnqcx', '5hncprjtu0d', '79fjgq8');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', 'q7x', '7', '2fxa7ryfdrz', '16nijjai5dh', 'ogrgjd8y', 't1afgog');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('I', 's27p2r94gth2', 'najj', 'a3o', 'v8u', 'tmu2n', '57');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__093376', 'chn9mo70', 'a9n0jxfo', 'ws', 'do2zobb', 'q0k32od', 'cl5ams');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('C', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('@', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('H', '7zwau2dwyr', '13pyu', '8d99rljsl', 'b4yp5qi', 'rkf9vqx5', 'pz0f8jegd');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('`', '7xb72', 'xa', '7ryfdrz16n', 'jja', '5dh', 'ogrgjd8y');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('p', '7wgx', '5', 'sxcmr0o', 'ztdgj5i3lq5l', 'pim5', '58q');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('_', 'q0k32od', 'cl5ams', 'orlwyngc1dj', '9erhizgk1yoe', 'o6l0hdt', 'fuqyxuzkb');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('B', '6dza35r', 'mkio18ri2hy', '08ftp6ewtqxx', 'jaby', 'mzn2mfx7h3', 'p6sto1cj');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', 'rwbbp6luhvd', 'tti', 'bnp');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'mdpos', 'ie5', 'nw6klf', 'a9000t5c4eci', 'gce376nium52');

-- Inserting into table: attendance --
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__9a27ca', 'C');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__9a27ca', 'A');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'O');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'A');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__9a27ca', '@');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__9a27ca', 'O');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__9a27ca', '?');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'G');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__093376', 'O');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__093376', 'A');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__9a27ca', 'G');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__9a27ca', 'I');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__093376', 't2__4a86f6');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('C', 'B');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', 'D');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('H', '`');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('`', 'a');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('p', 'F');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('_', '#');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('B', '$');

-- Inserting into table: income --
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('A', '2019-09-09', 1, 'x58pz', 'f8jegd2', 'C');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('C', '2019-09-09', 1, 'vy9uxj4', 'wb', 'C');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('_', '2019-09-09', 1, 'itsj3', 'y', 'O');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('O', '2019-09-09', 1, 'q8qdjpe1', 'o22', 'A');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('Q', '2019-09-09', 1, '5i3lq5lnpim5', '58q', '@');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('I', '2019-09-09', 1, 'u', '3auvm', 'G');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('G', 't4__e45e12', 1, 'aawg96aqb0tb', 'indz39tajz', 'I');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('@', NULL, 1419861592, '4ecigce376n', 'um5', 'B');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('B', '2019-09-09', 2137741668, 'ytoo3o9hl7', 'klex14ji', 'D');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('H', '2019-09-09', -688098735, '6ah', 'f8jswwl', '`');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('E', '2019-09-09', 1944978593, 'bfkfoacd', '7z2zezj', 'a');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('R', '2019-09-09', 238533676, 'jxfofws', 'do2zobb', 'F');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('D', '2019-09-09', -516345261, 'o', 'vu', '#');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('K', '2019-09-09', 1046248997, 'uik1y', 'hb08hlst1pq', '$');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.first_name, T3.last_name, T4.amount FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event INNER JOIN member AS T3 ON T3.member_id = T2.link_to_member INNER JOIN income AS T4 ON T4.link_to_member = T3.member_id WHERE T4.date_received = '2019-09-09';

/*
Gold Result:
('t3__203443', 't3__48f842', 1)
('ex1', 'ji7zwau2', 1)
('1jh3den', 'c68x8vacx', 1)
('b', 'p6luhvdlttil', 2137741668)
('y9uxj4', 'wb', -688098735)
('1afgogritsj', 'ayxp1q43', 1944978593)
('7p2r94gth2m', 'ajjl', 238533676)
('gwnlas6', 'elboeowii1', -516345261)
('knzys7dy', 'yd1jmgjach8', 1046248997)
*/

-- Prediction Query
SELECT member.first_name, member.last_name, income.amount FROM member INNER JOIN income ON member.member_id = income.link_to_member WHERE income.date_received = '2019-09-09';

/*
Prediction Result:
('t3__203443', 't3__48f842', 1)
('t3__203443', 't3__48f842', 1)
('t3__203443', 't3__48f842', 1)
('ex1', 'ji7zwau2', 1)
('1jh3den', 'c68x8vacx', 1)
('t3__203443', 't3__48f842', 1)
('b', 'p6luhvdlttil', 2137741668)
('y9uxj4', 'wb', -688098735)
('1afgogritsj', 'ayxp1q43', 1944978593)
('7p2r94gth2m', 'ajjl', 238533676)
('gwnlas6', 'elboeowii1', -516345261)
('knzys7dy', 'yd1jmgjach8', 1046248997)
*/