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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__9d696c', 't1__ab7bd2', '5k5swwqcgs', '9n8', '4', 't1__555a4d', 'gu7v');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('C', 't1__ab7bd2', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 't1__555a4d', 'tti');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('?', 't1__ab7bd2', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 't1__555a4d', 'ytoo3o9');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', 't1__ab7bd2', 'l7', 'klex14ji', '7zwau2dwyr', 't1__555a4d', '13pyu');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('E', '8d99rljsl', 'b4yp5qi', 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4', 'wb');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('I', 't1__ab7bd2', 'n2f3dqv0gcb9', 'ozk3zbily', 'kn6vc', 't1__555a4d', '6ah');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('@', 'f8jswwl', '7xb72', 'xa', '7ryfdrz16n', 'jja', '5dh');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('O', 't1__ab7bd2', '1jh3den', 'c68x8vacx', 'afu5w1of7', 't1__555a4d', 'pzo72ctdc');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__90c211', 't1__ab7bd2', 'bnou5zi36', '4', 'f', 't1__555a4d', 'foa');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_9', 't1__ab7bd2', 'cd07z2zezjo7', 'wgxd5ysxcm', '0oztd', 't1__555a4d', 'j5');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_11', 't1__ab7bd2', '2mnajjla3o', 'v8u', 'tmu2n', 't1__555a4d', '57');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_12', 't1__ab7bd2', 'x58b4', 'pmaus3auvmkr', 'pdjwzw5chn9', 't1__555a4d', 'o705');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('B', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('J', NULL, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('D', 'p6luhvdlttil', 'n', 'rmdp', 'siie', NULL, 'unw6klfa');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_16', 'O', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', '_', 'ytoo3o9');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_17', 'A', 'l7', 'klex14ji', '7zwau2dwyr', 'A', '13pyu');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_18', 'O', '8d99rljsl', 'b4yp5qi', 'rkf9vqx5', 'O', 'pz0f8jegd');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_19', 'A', '1vy9uxj4', 'wb', 'v', 'A', 'ph2');

-- Inserting into table: budget --
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_1', 'bnp', 787.938887, 0.01, 2087640001, 'dposiie5unw', 't1__9d696c');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_2', 'klfa9000t', 827.854302, 0.01, -1964997180, 'gce376nium52', 't1__9d696c');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_3', 'v', 185.427628, 0.01, 1581736075, 'gndqwnqc', 'E');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_4', 'x5hncprjtu0', 57.96362, 0.01, -1748371085, 'q8', 'E');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_5', 'ogrgjd8y', 763.019095, 0.01, 1250290042, 'og', '@');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_6', 'itsj3', 15.432127, 0.01, -491938169, '1q43', '@');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_7', 'mfg62', 93.813527, 0.01, 1870300798, 'q8qdjpe1', '@');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_8', 'o22', 518.274259, 0.01, 2004147439, 'tjpttg', '@');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('_', '3lq', 913.609637, 0.01, 1816660482, 'npi', 't2__90c211');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('A', '5k58', 251.966916, 0.01, -1125548818, '94gth', 't2__90c211');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('I', 'lfvyz7zzb', 70.267562, 0.01, 924693315, 'kv42q7', 't2__90c211');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('O', 'a9n0jxfofws', 900.422166, 0.01, -210159774, 'obb0q0k32o', 't2__90c211');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_13', 'w', 38.169466, 0.0, 440115543, 'msorlwyngc', 't1__9d696c');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_14', 'dj9erhi', 746.006477, 0.0, -499913447, 'yo', 't1__9d696c');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_15', 'l0hdt6fuq', 801.297876, 0.01, 778835680, 'kb521gw', 't1__9d696c');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_16', 'las6', 907.723998, 0.01, -2076274980, 'ow', 't1__9d696c');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_17', 'i1z', 493.031806, 0.01, -564679000, '66', 't1__9d696c');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_18', 'q2xlyoto', 913.199755, 0.01, 205676091, 'aawg96aqb0tb', 't1__9d696c');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('@', 'rwbbp6luhvd', 179.378884, NULL, -841692980, 'bnp', 'B');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('B', 'hria2ypuzhs', 663.049759, 0.01, 906324270, 'b', 'J');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('C', '9000t5c4ec', 128.76421, 0.01, -1683203397, 'e376nium52', 'D');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.event_name, T1.location FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event WHERE T2.remaining > 0;

/*
Gold Result:
('t1__ab7bd2', 't1__555a4d')
('8d99rljsl', '1vy9uxj4')
('f8jswwl', 'jja')
(None, 'gu7v')
('p6luhvdlttil', None)
*/

-- Prediction Query
SELECT T1.event_name, T1.location FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event WHERE T2.remaining > 0;

/*
Prediction Result:
('t1__ab7bd2', 't1__555a4d')
('t1__ab7bd2', 't1__555a4d')
('8d99rljsl', '1vy9uxj4')
('8d99rljsl', '1vy9uxj4')
('f8jswwl', 'jja')
('f8jswwl', 'jja')
('f8jswwl', 'jja')
('f8jswwl', 'jja')
('t1__ab7bd2', 't1__555a4d')
('t1__ab7bd2', 't1__555a4d')
('t1__ab7bd2', 't1__555a4d')
('t1__ab7bd2', 't1__555a4d')
('t1__ab7bd2', 't1__555a4d')
('t1__ab7bd2', 't1__555a4d')
('t1__ab7bd2', 't1__555a4d')
('t1__ab7bd2', 't1__555a4d')
(None, 'gu7v')
('p6luhvdlttil', None)
*/