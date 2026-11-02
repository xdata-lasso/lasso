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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t2__33b993', 'gce376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 'Medium', 'ytoo3o9', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('G', 'ph2', 'nd', 'wnqcx', '5hncprjtu0d', 'Medium', '79fjgq8', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', '3d', 'qv0gcb98ozk', 'zbilyrkn', '6vck6ah0f8js', 'wlq7xb', '72fxa7ryfd', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', 'ctdctmfg62g0', '5q8qdj', 'e1io', '278507cv', 'Medium', 'jpttg', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t3__1c5aca', 'yz7zzb', '8y', 'kv42q7', 'x58b4', 'pmaus3auvmkr', 'pdjwzw5chn9', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('?', 'a2y', 'uzhs', 'rwbbp6luhvd', 'tti', NULL, 'bnp', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('I', 'uo4nrqrofqy', '5s5b', 'p', '02eutliqa11r', 't3__f390cc', 'ytoo3o9', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 'yp5qi2rk', '9v', 'x58pz', 'f8jegd2', NULL, 'vy9uxj4', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('!', 'cprj', 'u0dz7', 'fjgq8n2f3', 'dqv0gcb98ozk', 'Medium', 'zbilyrkn', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('_', 'h5ogrgjd8yz', '1afgo', 'ri', 'tsj3ayxp1q4', 't3__f390cc', '01jh3den', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('`', 'qdjpe1io2', '78507cvt', 'ptt', '6b', NULL, 'ou5z', -2147483648, 'major_id_1');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__536338', 'Women''s Soccer', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('C', 'Women''s Soccer', 'l7', 'klex14ji', '7zwau2dwyr', '13pyu', '8d99rljsl');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', 'yp5qi2rk', '9v', 'x58pz', 'f8jegd2', 'vy9uxj4', 'wb');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('G', 'Women''s Soccer', 'z16ni', 'jai', 'dh5ogrgj', '8', 'yzt1afgogrit');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('_', 'Women''s Soccer', 'xp1q430', 'jh3den8', 'c68x8vacx7', 'f', '5w1of7');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('O', 'Women''s Soccer', 'bnou5zi36', '4', 'f', 'foa', 'cd07z2zezjo7');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__6622e4', 'Women''s Soccer', 'ysxcmr0o', 'ztdgj5i3lq5l', 'pim5', '58q', 's27p2r94gth2');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('K', 'Women''s Soccer', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('@', 't1__3663c2', 'mdpos', 'ie5', 'nw6klf', 'a9000t5c4eci', 'gce376nium52');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('D', 't1__3663c2', 'l7', 'klex14ji', '7zwau2dwyr', '13pyu', '8d99rljsl');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('B', NULL, 'wb', 'v', 'ph2', 'nd', 'wnqcx');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('`', NULL, '6vck6ah0f8js', 'wlq7xb', '72fxa7ryfd', 'z16ni', 'jai');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('a', NULL, 'c68x8vacx', 'afu5w1of7', 'pzo72ctdc', 'mfg62', '0v');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'bnp', 'mdpos', 'ie5', 'nw6klf', 'a9000t5c4eci');

-- Inserting into table: attendance --
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__536338', 't2__33b993');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 't2__33b993');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__536338', 'A');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__6622e4', 't2__33b993');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('K', '?');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', 'I');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('D', '@');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('B', '!');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('`', '_');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('a', '`');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.event_id) FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event INNER JOIN member AS T3 ON T2.link_to_member = T3.member_id WHERE T1.event_name = 'Women''s Soccer' AND T3.t_shirt_size = 'Medium';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT member.member_id) FROM member INNER JOIN attendance ON member.member_id = attendance.link_to_member INNER JOIN event ON attendance.link_to_event = event.event_id WHERE event.event_name = 'Women''s Soccer' AND member.t_shirt_size = 'Medium';

/*
Prediction Result:
(1,)
*/