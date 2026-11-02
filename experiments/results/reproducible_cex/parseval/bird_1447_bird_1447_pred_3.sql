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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', 't1__5529fa', '5k5swwqcgs', '9n8', '4', 't1__2a9fa5', 'gu7v');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('C', 't1__5529fa', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 't1__2a9fa5', 'tti');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_3', 't1__5529fa', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 't1__2a9fa5', 'ytoo3o9');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('@', 'l7', 'klex14ji', '7zwau2dwyr', '13pyu', '8d99rljsl', 'b4yp5qi');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_5', 't1__5529fa', 'q', 'nqcx5h', 'cprj', 't1__2a9fa5', 'u0dz7');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_6', 't1__5529fa', '8j', 'wwlq7', 'xb72fxa7ryfd', 't1__2a9fa5', 'z16ni');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('G', 't1__5529fa', '1jh3den', 'c68x8vacx', 'afu5w1of7', 't1__2a9fa5', 'pzo72ctdc');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('O', 't1__5529fa', '7z2zezjo7wg', 'd5ysxc', 'r0oz', 't1__2a9fa5', 'dgj5i');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__82035d', 'tmu2n', '57', 'lfvyz7zzb', '8y', 'kv42q7', 'x58b4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('_', 't1__5529fa', '0', '0k32o', 'w', 't1__2a9fa5', 'l');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('H', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('I', NULL, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('`', 'p6luhvdlttil', 'n', 'rmdp', 'siie', NULL, 'unw6klfa');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_14', 'O', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', '_', 'ytoo3o9');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_15', 'A', 'l7', 'klex14ji', '7zwau2dwyr', 'A', '13pyu');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_16', '_', '8d99rljsl', 'b4yp5qi', 'rkf9vqx5', '_', 'pz0f8jegd');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_17', 'A', '1vy9uxj4', 'wb', 'v', 'A', 'ph2');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_18', 'O', 'nd', 'wnqcx', '5hncprjtu0d', 'G', '79fjgq8');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_19', 'A', 'n2f3dqv0gcb9', 'ozk3zbily', 'kn6vc', 'A', '6ah');

-- Inserting into table: budget --
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_1', 'bnp', 787.938887, 0.01, 2087640001, 'dposiie5unw', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_2', 'klfa9000t', 827.854302, 0.01, -1964997180, 'gce376nium52', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_3', 'rkf9vqx5', 541.393553, 0.01, 1836127587, 'f8jegd2', '@');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_4', 'vy9uxj4', 124.573829, 0.01, -2050247126, 'lph2gn', '@');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_5', 'fjgq8n2f3', 687.701166, 0.01, 513454646, '0gcb98', '@');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_6', 'zk3z', 892.659478, 0.01, -1554531873, 'yrkn6vck6ah0', '@');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_7', 'jai', 906.609226, 0.01, 1360271423, 'ogrgjd8y', '@');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_8', 't1afgog', 279.731401, 0.01, -902895762, 'ayxp1q43', '@');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('O', 'mfg62', 93.813527, 0.01, 1870300798, 'q8qdjpe1', 'G');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('A', 'o22', 518.274259, 0.01, 2004147439, 'tjpttg', 'G');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('Q', 'bnou5zi36', 952.850618, 0.01, 1722106924, 'f', 'G');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('G', 'foa', 707.057079, 0.01, 382831862, '0', 'G');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_13', 'lq5lnpim', 487.138399, 0.0, 1379859112, 'qs27p2r94', 'O');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_14', 'th', 577.602934, 0.0, 1162591638, 'ajjla3okv8u', 'O');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_15', 'pmaus3auvmkr', 641.973572, 0.01, -1934017803, 'wzw5chn9mo70', 'O');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_16', 'a9n0jxfo', 82.48091, 0.01, -441521858, '2zob', 'O');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_17', '5amsorlwyngc', 424.71131, 0.01, 453340472, '9erhizgk1yoe', '_');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_18', 'o6l0hdt', 506.13059, 0.01, -795975227, 'xuzkb52', '_');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('@', 'rwbbp6luhvd', 179.378884, NULL, -841692980, 'bnp', 'H');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('B', 'hria2ypuzhs', 663.049759, 0.01, 906324270, 'b', 'I');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('C', '9000t5c4ec', 128.76421, 0.01, -1683203397, 'e376nium52', '`');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.event_name, T1.location FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event WHERE T2.remaining > 0;

/*
Gold Result:
('t1__5529fa', 't1__2a9fa5')
('l7', '8d99rljsl')
(None, 'gu7v')
('p6luhvdlttil', None)
*/

-- Prediction Query
SELECT e.event_name, e.location FROM budget AS b INNER JOIN event AS e ON b.link_to_event = e.event_id WHERE b.remaining > 0;

/*
Prediction Result:
('t1__5529fa', 't1__2a9fa5')
('t1__5529fa', 't1__2a9fa5')
('l7', '8d99rljsl')
('l7', '8d99rljsl')
('l7', '8d99rljsl')
('l7', '8d99rljsl')
('l7', '8d99rljsl')
('l7', '8d99rljsl')
('t1__5529fa', 't1__2a9fa5')
('t1__5529fa', 't1__2a9fa5')
('t1__5529fa', 't1__2a9fa5')
('t1__5529fa', 't1__2a9fa5')
('t1__5529fa', 't1__2a9fa5')
('t1__5529fa', 't1__2a9fa5')
('t1__5529fa', 't1__2a9fa5')
('t1__5529fa', 't1__2a9fa5')
(None, 'gu7v')
('p6luhvdlttil', None)
*/