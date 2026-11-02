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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 't3__d15bba', 't3__286c4c', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('C', 'ex1', 'ji7zwau2', 'dwyrq13pyu78', '9', 'rljsl0b4y', 'p5qi2rkf9v', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('_', 't3__d15bba', 't3__286c4c', '3d', 'qv0gcb98ozk', 'zbilyrkn', '6vck6ah0f8js', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', '1jh3den', 'c68x8vacx', 'afu5w1of7', 'pzo72ctdc', 'mfg62', '0v', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('?', 'qdjpe1io2', '78507cvt', 'ptt', '6b', 'ou5z', '36c', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('Q', 't3__d15bba', 't3__286c4c', 'xd', 'ysxcmr0o', 'ztdgj5i3lq5l', 'pim5', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', 't3__d15bba', 't3__286c4c', 'yz7zzb', '8y', 'kv42q7', 'x58b4', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('E', 'xfo', 'ws', 'do2zobb', 'q0k32od', 'cl5ams', 'orlwyngc1dj', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t2__902c5c', 'rxe9yfk', 'qk162nh55', '3dohvu0', 'dza35rmki', '18ri', 'hy08ftp6', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t3__c9711a', 'qxxnj', 'b', 'mzn2mfx', 'h33p6sto1', 'j', 'sh5knzys7', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('I', 't3__d15bba', 't3__286c4c', 'q3qdpua', '96rn', 'dqrhm', 'wlic7dn2', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('`', 'swwqcgsk', '9n8c4pgu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('B', '02eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr', '13pyu', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_14', NULL, 'swwqcgsk', '9n8c4pgu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('D', 'ilbnp', 'mdpos', 'ie5', 'nw6klf', 'a9000t5c4eci', 'gce376nium52', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_16', NULL, '3pyu78d99r', 'jsl', 'b4yp5qi', 'rkf9vqx5', 'pz0f8jegd', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('F', 'y9uxj4', 'wb', 'v', 'ph2', 'nd', 'wnqcx', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_18', NULL, '7', 'yfdrz', '16nijjai5dh', 'ogrgjd8y', 't1afgog', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('G', 'tsj3ayxp1q4', '01jh3den', 'c68x8vacx', 'afu5w1of7', 'pzo72ctdc', 'mfg62', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_20', NULL, '7z2zezj', '7wgx', '5', 'sxcmr0o', 'ztdgj5i3lq5l', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('a', 'm5k', '8qs27p2r', '4gth2mnaj', 'la3', 'okv8uttmu2', 'e578', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_22', NULL, '2zob', '0', '0k32o', 'w', 'l', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('c', 'msorlwyngc', 'dj9erhi', 'zgk1yoeyo6l0', 'dt', 'fuqyxuzkb', '521gwnlas6e', -2147483648, 'major_id_1');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__937b9e', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('O', 'v', 'ph2', 'nd', 'wnqcx', '5hncprjtu0d', '79fjgq8');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', 'q7x', '7', '2fxa7ryfdrz', '16nijjai5dh', 'ogrgjd8y', 't1afgog');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Q', 'qs27p2r94', 'th', '2mnajjla3o', 'v8u', 'tmu2n', '57');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__4721d5', 'zgk1yoeyo6l0', 'dt', 'fuqyxuzkb', '521gwnlas6e', 'lboeowii1z5', 'xih6');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('@', 'w6kl', 'a9', '00t5c4e', 'cigce376nium', '52zbuo4nrq', 'rofqyp5s5b');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('`', '9v', 'x58pz', 'f8jegd2', 'vy9uxj4', 'wb', 'v');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('D', 'p', '02eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('a', 'dqv0gcb9', 'ozk3zbily', 'kn6vc', '6ah', 'f8jswwl', '7xb72');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('!', '278507cv', 'jpttg', 'bnou5zi36', '4', 'f', 'foa');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('B', 'kv42q7', 'x58b4', 'pmaus3auvmkr', 'pdjwzw5chn9', 'o705', 'a9n0jxfofws');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('C', 'q2xlyoto', '9oaawg', '6aqb0tbin', 'z', '9tajz9td', 'n5wcgumbc');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', 'rwbbp6luhvd', 'tti', 'bnp');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'mdpos', 'ie5', 'nw6klf', 'a9000t5c4eci', 'gce376nium52');

-- Inserting into table: attendance --
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__937b9e', 'A');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__937b9e', 'C');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', '_');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'A');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__937b9e', '@');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__937b9e', '?');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__937b9e', 'Q');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'O');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__937b9e', 'O');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__937b9e', 'E');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__937b9e', '_');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__4721d5', 'O');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__4721d5', 'A');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__4721d5', '_');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__4721d5', 't2__902c5c');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__937b9e', 'I');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', '`');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('`', 'B');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('D', 'D');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('a', 'F');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('!', 'G');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('B', 'a');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('C', 'c');

-- Inserting into table: income --
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('C', '2019-09-09', 1, 'x58pz', 'f8jegd2', 'A');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('A', '2019-09-09', 1, 'vy9uxj4', 'wb', 'A');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('G', '2019-09-09', 1, 'itsj3', 'y', '_');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('_', '2019-09-09', 1, 'bfkfoacd', '7z2zezj', 'A');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('O', '2019-09-09', 1, 'u', 'mkrpdj', 'A');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('I', '2019-09-09', 1, 'qb0tbindz39t', 'j', 'O');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('Q', '2019-09-09', NULL, 'jmgjach', 'qta8y3a17', 'O');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('E', '2019-09-09', 1, '90xdmsqt', 'el', 'I');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('@', 't4__3414ec', -1364429300, 'nprmdposii', '5u', '`');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('H', NULL, 176380444, '9rljsl0b4', 'p5qi2rk', 'B');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('B', '2019-09-09', -443340271, 'uo4nrqrofqy', '5s5b', 'D');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('D', '2019-09-09', 722884590, 'hncprjtu0dz', '9fjgq8n2f', 'F');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('!', '2019-09-09', -1744557630, '5q8qdj', 'e1io', 'G');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('N', '2019-09-09', 1908593332, 'vy', '7zzbe8y', 'a');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('K', '2019-09-09', 1468640756, 'boeowii1z5nx', 'h66', 'c');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.first_name, T3.last_name, T4.amount FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event INNER JOIN member AS T3 ON T3.member_id = T2.link_to_member INNER JOIN income AS T4 ON T4.link_to_member = T3.member_id WHERE T4.date_received = '2019-09-09';

/*
Gold Result:
('t3__d15bba', 't3__286c4c', 1)
('t3__d15bba', 't3__286c4c', None)
('ilbnp', 'mdpos', -443340271)
('y9uxj4', 'wb', 722884590)
('tsj3ayxp1q4', '01jh3den', -1744557630)
('m5k', '8qs27p2r', 1908593332)
('msorlwyngc', 'dj9erhi', 1468640756)
*/

-- Prediction Query
SELECT T1.first_name, T1.last_name, T2.amount FROM member AS T1 INNER JOIN income AS T2 ON T1.member_id = T2.link_to_member WHERE STRFTIME('%m/%d/%Y', T2.date_received) = '09/09/2019' AND NOT T2.amount IS NULL;

/*
Prediction Result:
('t3__d15bba', 't3__286c4c', 1)
('t3__d15bba', 't3__286c4c', 1)
('t3__d15bba', 't3__286c4c', 1)
('t3__d15bba', 't3__286c4c', 1)
('t3__d15bba', 't3__286c4c', 1)
('t3__d15bba', 't3__286c4c', 1)
('t3__d15bba', 't3__286c4c', 1)
('ilbnp', 'mdpos', -443340271)
('y9uxj4', 'wb', 722884590)
('tsj3ayxp1q4', '01jh3den', -1744557630)
('m5k', '8qs27p2r', 1908593332)
('msorlwyngc', 'dj9erhi', 1468640756)
*/