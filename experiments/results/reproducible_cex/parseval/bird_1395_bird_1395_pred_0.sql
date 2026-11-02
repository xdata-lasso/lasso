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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t2__8a5f28', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t2__1953a0', '7', 'yfdrz', '16nijjai5dh', 'ogrgjd8y', 't1afgog', 'itsj3', -2147483648, 'major_id_1');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__ba1b91', 'Community Theater', '2019-01-01', '5k5swwqcgs', '9n8', '4', 'gu7v');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('C', 'Community Theater', '2019-01-01', 'l7', 'klex14ji', '7zwau2dwyr', '13pyu');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', '8d99rljsl', 'b4yp5qi', 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4', 'wb');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('O', 'Community Theater', '2019-01-01', 'v', 'ph2', 'nd', 'wnqcx');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('G', 'Community Theater', '2019-01-01', '5hncprjtu0d', '79fjgq8', 'n2f3dqv0gcb9', 'ozk3zbily');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__62cbca', 'Community Theater', '2019-01-01', 'kn6vc', '6ah', 'f8jswwl', '7xb72');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('P', 'Community Theater', 'AS1O_', '5k5swwqcgs', '9n8', '4', 'gu7v');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('B', 'Community Theater', NULL, '4h', 'ia2yp', 'uzhsrwbbp6lu', 'hvdlttilbnpr');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('@', 't1__7d3211', '2019-01-01', 'dposiie5unw', 'klfa9000t', 'c4ecigce', '76nium52');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('D', 't1__7d3211', NULL, 'u', '4nrq', 'rofqyp5s5b', 'p');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('"', NULL, '2019-01-01', '2eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('#', NULL, 'A;3H''', 'au2dwy', 'q13py', '78d99r', 'jsl');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('F', NULL, NULL, '4', 'p5qi2rk', '9v', 'x58pz');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'tti', 'bnp', 'mdpos', 'ie5', 'nw6klf');

-- Inserting into table: attendance --
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__ba1b91', 't2__8a5f28');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 't2__8a5f28');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__62cbca', 't2__8a5f28');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__62cbca', 't2__1953a0');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('P', 't2__8a5f28');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('B', 't2__8a5f28');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', 't2__1953a0');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('D', 't2__1953a0');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('"', 't2__1953a0');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('#', 't2__1953a0');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('F', 't2__1953a0');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T2.link_to_member) FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event WHERE T1.event_name = 'Community Theater' AND SUBSTRING(T1.event_date, 1, 4) = '2019';

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT link_to_member) FROM attendance AS T1 INNER JOIN event AS T2 ON T1.link_to_event = T2.event_id WHERE T2.event_name = 'Community Theater' AND STRFTIME('%Y', T2.event_date) = '2019';

/*
Prediction Result:
(2,)
*/