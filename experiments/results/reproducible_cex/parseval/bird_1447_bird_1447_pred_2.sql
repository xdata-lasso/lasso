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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__55bf66', 't1__ac7b7a', '5k5swwqcgs', '9n8', '4', 't1__9d45cd', 'gu7v');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__bbe1b9', 't1__ac7b7a', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 't1__9d45cd', 'tti');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('@', 't1__ac7b7a', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 't1__9d45cd', 'ytoo3o9');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_3', 't1__ac7b7a', 'l7', 'klex14ji', '7zwau2dwyr', 't1__9d45cd', '13pyu');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', '8d99rljsl', 'b4yp5qi', 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4', 'wb');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('?', 't1__ac7b7a', 'n2f3dqv0gcb9', 'ozk3zbily', 'kn6vc', 't1__9d45cd', '6ah');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_7', 't1__ac7b7a', '5dh', 'ogrgjd8y', 't1afgog', 't1__9d45cd', 'itsj3');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__0dcbda', 't1__ac7b7a', 'afu5w1of7', 'pzo72ctdc', 'mfg62', 't1__9d45cd', '0v');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_8', 't1__ac7b7a', 'q8qdjpe1', 'o22', '8507cvtjp', 't1__9d45cd', 'ttg6bnou5zi3');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_10', 't1__ac7b7a', '5i3', 'q5l', 'pim5', 't1__9d45cd', '58q');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_11', 't1__ac7b7a', 'tmu2n', '57', 'lfvyz7zzb', 't1__9d45cd', '8y');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('D', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('H', NULL, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('$', 'p6luhvdlttil', 'n', 'rmdp', 'siie', NULL, 'unw6klfa');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_15', 'I', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 'O', 'ytoo3o9');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_16', 'A', 'l7', 'klex14ji', '7zwau2dwyr', 'A', '13pyu');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_17', 'O', '8d99rljsl', 'b4yp5qi', 'rkf9vqx5', 'G', 'pz0f8jegd');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_18', 'A', '1vy9uxj4', 'wb', 'v', 'A', 'ph2');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_19', 'O', 'nd', 'wnqcx', '5hncprjtu0d', 'O', '79fjgq8');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_20', 'A', 'n2f3dqv0gcb9', 'ozk3zbily', 'kn6vc', 'A', '6ah');

-- Inserting into table: budget --
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_1', 'bnp', 787.938887, 0.01, 2087640001, 'dposiie5unw', 't1__55bf66');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_2', 'klfa9000t', 827.854302, 0.01, -1964997180, 'gce376nium52', 't1__55bf66');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_3', 'v', 185.427628, 0.01, 1581736075, 'gndqwnqc', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_4', 'x5hncprjtu0', 57.96362, 0.01, -1748371085, 'q8', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_5', 'f8jswwl', 260.513699, 0.01, 1255343543, '7', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_6', '2fxa7ryfdrz', 753.351134, 0.01, 61479715, 'jja', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_7', 'y', 360.694313, 0.01, 1972233925, '4301j', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_8', '3d', 881.248682, 0.01, -1826414375, 'c68x8vacx', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('O', 'c4bfkfoac', 60.937725, 0.01, -406331049, 'ezjo7wg', 't2__0dcbda');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('A', 'd5ysxc', 187.71278, 0.01, -405743609, 'g', 't2__0dcbda');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('_', 's27p2r94gth2', 193.695314, 0.01, 1162591638, 'ajjla3okv8u', 't2__0dcbda');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('G', 'kv42q7', 282.68858, 0.01, -2060082151, 'pmaus3auvmkr', 't2__0dcbda');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_13', 'pdjwzw5chn9', 191.1711, 0.0, 101754718, 'a9n0jxfo', 't1__55bf66');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_14', 'ws', 900.422166, 0.0, -210159774, 'obb0q0k32o', 't1__55bf66');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_15', 'w', 38.169466, 0.01, 440115543, 'msorlwyngc', 't1__55bf66');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_16', 'dj9erhi', 746.006477, 0.01, -499913447, 'yo', 't1__55bf66');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_17', 'l0hdt6fuq', 801.297876, 0.01, 778835680, 'kb521gw', 't1__55bf66');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_18', 'las6', 907.723998, 0.01, -2076274980, 'ow', 't1__55bf66');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('@', 'rwbbp6luhvd', 179.378884, NULL, -841692980, 'bnp', 'D');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('`', 'hria2ypuzhs', 663.049759, 0.01, 906324270, 'b', 'H');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('B', '9000t5c4ec', 128.76421, 0.01, -1683203397, 'e376nium52', '$');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.event_name, T1.location FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event WHERE T2.remaining > 0;

/*
Gold Result:
('t1__ac7b7a', 't1__9d45cd')
('8d99rljsl', '1vy9uxj4')
(None, 'gu7v')
('p6luhvdlttil', None)
*/

-- Prediction Query
SELECT event.event_name, event.location FROM budget INNER JOIN event ON budget.link_to_event = event.event_id WHERE budget.remaining > 0;

/*
Prediction Result:
('t1__ac7b7a', 't1__9d45cd')
('t1__ac7b7a', 't1__9d45cd')
('8d99rljsl', '1vy9uxj4')
('8d99rljsl', '1vy9uxj4')
('8d99rljsl', '1vy9uxj4')
('8d99rljsl', '1vy9uxj4')
('8d99rljsl', '1vy9uxj4')
('8d99rljsl', '1vy9uxj4')
('t1__ac7b7a', 't1__9d45cd')
('t1__ac7b7a', 't1__9d45cd')
('t1__ac7b7a', 't1__9d45cd')
('t1__ac7b7a', 't1__9d45cd')
('t1__ac7b7a', 't1__9d45cd')
('t1__ac7b7a', 't1__9d45cd')
('t1__ac7b7a', 't1__9d45cd')
('t1__ac7b7a', 't1__9d45cd')
(None, 'gu7v')
('p6luhvdlttil', None)
*/