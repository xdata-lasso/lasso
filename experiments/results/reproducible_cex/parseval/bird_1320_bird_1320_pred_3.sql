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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t2__a1badc', 'Maya', 'Mclean', 'gce376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_2', 'Maya', 'Mclean', 'l0b4y', 'p5qi2rkf9v', 'x58pz', 'f8jegd2', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t2__7c5f93', '9uxj4hw', 'd', 'lph2gn', 'q', 'nqcx5h', 'cprj', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 'Maya', 'Mclean', 'tsj3ayxp1q4', '01jh3den', 'c68x8vacx', 'afu5w1of7', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('G', '72ct', 'c', 'mfg62', '0v', 'q8qdjpe1', 'o22', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('I', 'cmr0oz', 'dgj5i', 'lq5lnpim', 'k58qs27p', 'r94gth2m', 'ajjl', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t3__0260a9', '05a9n0jxf', 'fwsz', 'o', '2zobb0q0k32o', 'w', 'l', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 'Maya', 't3__292dc8', 'b', 'p6luhvdlttil', 'n', 'rmdp', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('B', 'Maya', NULL, '5s5b', 'p', '02eutliqa11r', 'ytoo3o9', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('_', 't3__c48f1e', 'Mclean', 'f9v', 'x58pz', 'f8jegd2', 'vy9uxj4', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('"', 't3__c48f1e', NULL, 'gq8', 'n2f3dqv0gcb9', 'ozk3zbily', 'kn6vc', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('C', NULL, 'Mclean', 'h', 'ogrgjd8y', 't1afgog', 'itsj3', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('F', NULL, 't3__292dc8', '72ct', 'c', 'mfg62', '0v', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('D', NULL, NULL, 'ezjo7wg', 'd5ysxc', 'r0oz', 'dgj5i', -2147483648, 'major_id_1');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__a6820a', 't1__65ceab', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('C', 't1__65ceab', 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr', '13pyu');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', 't1__65ceab', 'u0dz7', 'fjgq8n2f3', 'dqv0gcb98ozk', 'zbilyrkn', '6vck6ah0f8js');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('_', 'q7x', '7', '2fxa7ryfdrz', '16nijjai5dh', 'ogrgjd8y', 't1afgog');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('G', '7cvtjpttg6b', 'ou5z', '36c', 'bfkfoacd', '7z2zezj', '7wgx');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__17c43e', 't1__65ceab', '8uttmu', 'ne578lfv', 'yz7zzbe8yvk', 'v42q7sx58b4p', 'aus3');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('B', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('@', 'siie', 'unw6klfa', '9000t5c4ec', 'gce', '76nium52', 'zbuo4nrqrof');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('`', 'l7', 'klex14ji', '7zwau2dwyr', '13pyu', '8d99rljsl', 'b4yp5qi');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('F', 'wb', 'v', 'ph2', 'nd', 'wnqcx', '5hncprjtu0d');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('"', '6ah', 'f8jswwl', '7xb72', 'xa', '7ryfdrz16n', 'jja');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Q', 'y', 'p1q430', 'jh3den8', 'c68x8vacx7', 'f', '5w1of7');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('#', 'q8qdjpe1', 'o22', '8507cvtjp', 'ttg6bnou5zi3', 'c4bfkfoac', '0');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'bnp', 'mdpos', 'ie5', 'nw6klf', 'a9000t5c4eci');

-- Inserting into table: attendance --
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__a6820a', 't2__a1badc');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__a6820a', 't2__7c5f93');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('_', 't2__a1badc');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__a6820a', 'G');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 't2__a1badc');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__a6820a', 'I');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__17c43e', 't2__a1badc');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('B', '@');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', 'B');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('`', '_');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('F', '"');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('"', 'C');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Q', 'F');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('#', 'D');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_name FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event INNER JOIN member AS T3 ON T2.link_to_member = T3.member_id WHERE T3.first_name = 'Maya' AND T3.last_name = 'Mclean';

/*
Gold Result:
('t1__65ceab',)
('q7x',)
('7cvtjpttg6b',)
('t1__65ceab',)
*/

-- Prediction Query
SELECT DISTINCT e.event_name FROM member AS m INNER JOIN attendance AS a ON m.member_id = a.link_to_member INNER JOIN event AS e ON a.link_to_event = e.event_id WHERE m.first_name = 'Maya' AND m.last_name = 'Mclean';

/*
Prediction Result:
('t1__65ceab',)
('q7x',)
('7cvtjpttg6b',)
*/