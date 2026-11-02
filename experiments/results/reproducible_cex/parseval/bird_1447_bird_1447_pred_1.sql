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
-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__11b82a', 't1__7e6c43', '5k5swwqcgs', '9n8', '4', 't1__26c20b', 'gu7v');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__f9ae2f', 't1__7e6c43', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 't1__26c20b', 'tti');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('@', 't1__7e6c43', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 't1__26c20b', 'ytoo3o9');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('?', 't1__7e6c43', 'l7', 'klex14ji', '7zwau2dwyr', 't1__26c20b', '13pyu');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', '8d99rljsl', 'b4yp5qi', 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4', 'wb');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_6', 't1__7e6c43', 'n2f3dqv0gcb9', 'ozk3zbily', 'kn6vc', 't1__26c20b', '6ah');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('C', 'f8jswwl', '7xb72', 'xa', '7ryfdrz16n', 'jja', '5dh');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__2bb48c', 't1__7e6c43', 't', 'mfg62g0v5q8q', 'j', 't1__26c20b', 'e1io');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_8', 't1__7e6c43', '278507cv', 'jpttg', 'bnou5zi36', 't1__26c20b', '4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_10', 't1__7e6c43', '5lnpim5k58qs', '7p2r94gt', '2m', 't1__26c20b', 'ajjl');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_11', 't1__7e6c43', 'ne578lfv', 'yz7zzbe8yvk', 'v42q7sx58b4p', 't1__26c20b', 'aus3');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('H', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('`', NULL, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('a', 'p6luhvdlttil', 'n', 'rmdp', 'siie', NULL, 'unw6klfa');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_15', 'O', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 'I', 'ytoo3o9');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_16', 'A', 'l7', 'klex14ji', '7zwau2dwyr', 'A', '13pyu');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_17', 'O', '8d99rljsl', 'b4yp5qi', 'rkf9vqx5', 'G', 'pz0f8jegd');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_18', 'A', '1vy9uxj4', 'wb', 'v', 'A', 'ph2');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_19', 'O', 'nd', 'wnqcx', '5hncprjtu0d', 'Q', '79fjgq8');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_20', 'A', 'n2f3dqv0gcb9', 'ozk3zbily', 'kn6vc', 'A', '6ah');

-- Inserting into table: budget --
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_1', 'bnp', 787.938887, 0.01, 2087640001, 'dposiie5unw', 't1__11b82a');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_2', 'klfa9000t', 827.854302, 0.01, -1964997180, 'gce376nium52', 't1__11b82a');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_3', 'v', 185.427628, 0.01, 1581736075, 'gndqwnqc', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_4', 'x5hncprjtu0', 57.96362, 0.01, -1748371085, 'q8', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_5', 'ogrgjd8y', 763.019095, 0.01, 1250290042, 'og', 'C');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_6', 'itsj3', 15.432127, 0.01, -491938169, '1q43', 'C');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_7', '1jh3den', 544.095565, 0.01, 357330522, '68x8vacx7a', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_8', 'u5', 354.593207, 0.01, -290314193, 'f77pzo72ctd', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('C', 'f', 166.297151, 0.01, -1173368267, 'cd07z2zezjo7', 't2__2bb48c');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('A', 'wgxd5ysxcm', 914.215057, 0.01, 1721638020, '0oztdgj5i3lq', 't2__2bb48c');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('Q', '3', 588.850908, 0.01, 1803796945, '8uttmu', 't2__2bb48c');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('G', 'u', 337.117577, 0.01, 274891948, 'pdjwzw5chn9', 't2__2bb48c');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_13', 'o705', 858.19408, 0.0, 238533676, 'jxfofws', 't1__11b82a');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_14', 'do2zobb', 407.368744, 0.0, -366775518, '2odwcl5a', 't1__11b82a');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_15', 'msorlwyngc', 424.71131, 0.01, 453340472, '9erhizgk1yoe', 't1__11b82a');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_16', 'o6l0hdt', 506.13059, 0.01, -795975227, 'xuzkb52', 't1__11b82a');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_17', 'gwnlas6', 907.723998, 0.01, -2076274980, 'ow', 't1__11b82a');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_18', 'i1z', 493.031806, 0.01, -564679000, '66', 't1__11b82a');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('@', 'rwbbp6luhvd', 179.378884, NULL, -841692980, 'bnp', 'H');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('H', 'hria2ypuzhs', 663.049759, 0.01, 906324270, 'b', '`');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('B', '9000t5c4ec', 128.76421, 0.01, -1683203397, 'e376nium52', 'a');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.event_name, T1.location FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event WHERE T2.remaining > 0;

/*
Gold Result:
('t1__7e6c43', 't1__26c20b')
('8d99rljsl', '1vy9uxj4')
('f8jswwl', 'jja')
(None, 'gu7v')
('p6luhvdlttil', None)
*/

-- Prediction Query
SELECT e.event_name, e.location FROM event AS e JOIN budget AS b ON e.event_id = b.link_to_event WHERE b.remaining > 0;

/*
Prediction Result:
('t1__7e6c43', 't1__26c20b')
('t1__7e6c43', 't1__26c20b')
('8d99rljsl', '1vy9uxj4')
('8d99rljsl', '1vy9uxj4')
('f8jswwl', 'jja')
('f8jswwl', 'jja')
('8d99rljsl', '1vy9uxj4')
('8d99rljsl', '1vy9uxj4')
('t1__7e6c43', 't1__26c20b')
('t1__7e6c43', 't1__26c20b')
('t1__7e6c43', 't1__26c20b')
('t1__7e6c43', 't1__26c20b')
('t1__7e6c43', 't1__26c20b')
('t1__7e6c43', 't1__26c20b')
('t1__7e6c43', 't1__26c20b')
('t1__7e6c43', 't1__26c20b')
(None, 'gu7v')
('p6luhvdlttil', None)
*/