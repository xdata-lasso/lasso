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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t3__478d0b', 't3__644354', 't3__75495e', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 'ex1', 'ji7zwau2', 'dwyrq13pyu78', '9', 'rljsl0b4y', 'p5qi2rkf9v', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 'fgogritsj3ay', 'p1q430', 'jh3den8', 'c68x8vacx7', 'f', '5w1of7', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('?', 'xd', 'ysxcmr0o', 'ztdgj5i3lq5l', 'pim5', '58q', 's27p2r94gth2', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('I', 't3__644354', 't3__75495e', 'aus3', 'u', 'mkrpdj', 'wzw5chn9mo70', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t4__0e9ec4', 't3__644354', 't3__75495e', 'xfo', 'ws', 'do2zobb', 'q0k32od', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('E', 't3__644354', 't3__75495e', 'lwyng', '1', 'j', '9erhizgk1yoe', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('G', 't3__644354', 't3__75495e', 'uzkb521gwnl', 's', 'elboeowii', 'z5nxih6', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t2__1cbe23', 'awg96aqb0tbi', 'ndz39tajz9', 'd8n5w', 'g', 'mbc3td', 'u6bd0w9603', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('B', 'swwqcgsk', '9n8c4pgu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('C', '02eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr', '13pyu', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('D', 'swwqcgsk', '9n8c4pgu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_13', NULL, 'nprmdposii', '5u', 'w6kl', 'a9', '00t5c4e', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('F', 'au2dwyrq13', 'yu78', '9', 'rljsl0b4y', 'p5qi2rkf9v', 'x58pz', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_15', NULL, '8jegd21vy9ux', 'j4hwbdvlph', 'gndqwnqc', 'x5hncprjtu0', 'z', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('H', 'dr', 'z16nijjai5d', 'h5ogrgjd8yz', '1afgo', 'ri', 'tsj3ayxp1q4', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_17', NULL, 'jh3den8', 'c68x8vacx7', 'f', '5w1of7', 'pzo72ctdc', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('$', 'oacd07z2zez', 'o7w', 'xd', 'ysxcmr0o', 'ztdgj5i3lq5l', 'pim5', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_19', NULL, 'qs27p2r94', 'th', '2mnajjla3o', 'v8u', 'tmu2n', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('L', '0k32odwcl5a', 'msorlwyngc', 'dj9erhi', 'zgk1yoeyo6l0', 'dt', 'fuqyxuzkb', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_21', NULL, 'gwnlas6', 'elboeowii1', '5nxih66', 'q2xlyoto', '9oaawg', -2147483648, 'major_id_1');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__6111b1', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', 'v', 'ph2', 'nd', 'wnqcx', '5hncprjtu0d', '79fjgq8');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('@', 'dqv0gcb98ozk', 'zbilyrkn', '6vck6ah0f8js', 'wlq7xb', '72fxa7ryfd', 'z16ni');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__5a0789', 'la3', 'okv8uttmu2', 'e578', 'fvy', '7zzbe8y', 'kv42q7');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('C', 'w6kl', 'a9', '00t5c4e', 'cigce376nium', '52zbuo4nrq', 'rofqyp5s5b');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('H', '9v', 'x58pz', 'f8jegd2', 'vy9uxj4', 'wb', 'v');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('B', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Q', 'ozk3zbily', 'kn6vc', '6ah', 'f8jswwl', '7xb72', 'xa');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('K', 'e1io', '278507cv', 'jpttg', 'bnou5zi36', '4', 'f');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('J', 'x58b4', 'pmaus3auvmkr', 'pdjwzw5chn9', 'o705', 'a9n0jxfofws', 'do2zobb');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('#', '9td8n5w', 'g', 'mbc3td', 'u6bd0w9603', 'vzxw1rxe9y', 'k7');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', 'rwbbp6luhvd', 'tti', 'bnp');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'mdpos', 'ie5', 'nw6klf', 'a9000t5c4eci', 'gce376nium52');

-- Inserting into table: attendance --
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__6111b1', 't3__478d0b');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__6111b1', 'A');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', 't3__478d0b');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', 'A');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__6111b1', '@');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__6111b1', '?');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__5a0789', 't3__478d0b');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__5a0789', 'A');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__6111b1', 'I');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__6111b1', 't4__0e9ec4');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__6111b1', 'E');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__6111b1', 'G');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__5a0789', 't2__1cbe23');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('C', 'B');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('H', 'C');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('B', 'D');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Q', 'F');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('K', 'H');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('J', '$');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('#', 'L');

-- Inserting into table: income --
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('A', '2019-09-09', 1, 'x58pz', 'f8jegd2', 't3__478d0b');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('C', '2019-09-09', 1, 'vy9uxj4', 'wb', 't3__478d0b');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('O', '2019-09-09', 1, 'jai', 'dh5ogrgj', 't3__478d0b');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('_', '2019-09-09', 1, 'pzo72ctdc', 'mfg62', 'A');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('Q', '2019-09-09', 1, 'q8qdjpe1io22', '8507cvtjp', '@');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('G', '2019-09-09', 1, 'ou5z', '36c', 't3__478d0b');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('I', '2019-09-09', NULL, 'e9yfk7', 'k162n', 't3__478d0b');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('@', 't4__7b8772', -1364429300, 'nprmdposii', '5u', 'B');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('B', NULL, 176380444, '9rljsl0b4', 'p5qi2rk', 'C');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('D', '2019-09-09', 1274489983, 'gce', '76nium52', 'D');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('P', '2019-09-09', -1748371085, 'q8', 'n2f3dqv0gcb9', 'F');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('F', '2019-09-09', 1303877941, 'mfg62g0v5q8q', 'j', 'H');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('L', '2019-09-09', -1817527403, '78lfvyz7zz', 'be8yvkv42q7', '$');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('g', '2019-09-09', 1044710644, 'qb0tbindz39t', 'j', 'L');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.first_name, T3.last_name, T4.amount FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event INNER JOIN member AS T3 ON T3.member_id = T2.link_to_member INNER JOIN income AS T4 ON T4.link_to_member = T3.member_id WHERE T4.date_received = '2019-09-09';

/*
Gold Result:
('t3__644354', 't3__75495e', 1)
('ex1', 'ji7zwau2', 1)
('fgogritsj3ay', 'p1q430', 1)
('t3__644354', 't3__75495e', None)
('swwqcgsk', '9n8c4pgu7v', 1274489983)
('au2dwyrq13', 'yu78', -1748371085)
('dr', 'z16nijjai5d', 1303877941)
('oacd07z2zez', 'o7w', -1817527403)
('0k32odwcl5a', 'msorlwyngc', 1044710644)
*/

-- Prediction Query
SELECT member.first_name, member.last_name, income.amount FROM income INNER JOIN member ON income.link_to_member = member.member_id WHERE income.date_received = '2019-09-09';

/*
Prediction Result:
('t3__644354', 't3__75495e', 1)
('t3__644354', 't3__75495e', 1)
('t3__644354', 't3__75495e', 1)
('ex1', 'ji7zwau2', 1)
('fgogritsj3ay', 'p1q430', 1)
('t3__644354', 't3__75495e', 1)
('t3__644354', 't3__75495e', None)
('swwqcgsk', '9n8c4pgu7v', 1274489983)
('au2dwyrq13', 'yu78', -1748371085)
('dr', 'z16nijjai5d', 1303877941)
('oacd07z2zez', 'o7w', -1817527403)
('0k32odwcl5a', 'msorlwyngc', 1044710644)
*/