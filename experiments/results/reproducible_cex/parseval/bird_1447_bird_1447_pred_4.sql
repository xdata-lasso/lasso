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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', 't1__53d8e5', '5k5swwqcgs', '9n8', '4', 't1__960fee', 'gu7v');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('C', 't1__53d8e5', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 't1__960fee', 'tti');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('@', 't1__53d8e5', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 't1__960fee', 'ytoo3o9');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_3', 't1__53d8e5', 'l7', 'klex14ji', '7zwau2dwyr', 't1__960fee', '13pyu');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('?', 't1__53d8e5', 'vy9uxj4', 'wb', 'v', 't1__960fee', 'ph2');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_6', 't1__53d8e5', 'n2f3dqv0gcb9', 'ozk3zbily', 'kn6vc', 't1__960fee', '6ah');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('I', 't1__53d8e5', '5dh', 'ogrgjd8y', 't1afgog', 't1__960fee', 'itsj3');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('O', 't1__53d8e5', 'afu5w1of7', 'pzo72ctdc', 'mfg62', 't1__960fee', '0v');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('G', 't1__53d8e5', 'q8qdjpe1', 'o22', '8507cvtjp', 't1__960fee', 'ttg6bnou5zi3');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('_', 't1__53d8e5', '2mnajjla3o', 'v8u', 'tmu2n', 't1__960fee', '57');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('`', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('B', NULL, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('E', 'p6luhvdlttil', 'n', 'rmdp', 'siie', NULL, 'unw6klfa');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_14', 'C', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 'O', 'ytoo3o9');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_15', 'A', 'l7', 'klex14ji', '7zwau2dwyr', 'A', '13pyu');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_16', 'O', '8d99rljsl', 'b4yp5qi', 'rkf9vqx5', 'G', 'pz0f8jegd');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_17', 'A', '1vy9uxj4', 'wb', 'v', 'A', 'ph2');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_18', 'I', 'nd', 'wnqcx', '5hncprjtu0d', 'I', '79fjgq8');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_19', 'A', 'n2f3dqv0gcb9', 'ozk3zbily', 'kn6vc', 'A', '6ah');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_20', 'O', 'f8jswwl', '7xb72', 'xa', 'O', '7ryfdrz16n');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_21', 'A', 'jja', '5dh', 'ogrgjd8y', 'A', 't1afgog');

-- Inserting into table: budget --
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_1', 'bnp', 787.938887, 0.01, 2087640001, 'dposiie5unw', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_2', 'klfa9000t', 827.854302, 0.01, -1964997180, 'gce376nium52', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_3', '8d99rljsl', 419.361606, 0.01, 1692174491, 'qi2rkf9v', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_4', 'x58pz', 410.133844, 0.01, -1529584866, 'd2', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_5', 'nd', 893.16532, 0.01, -1052964641, 'qcx5', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_6', 'hncprjtu0dz', 521.610309, 0.01, -1748371085, 'q8', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_7', 'f8jswwl', 260.513699, 0.01, 1255343543, '7', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_8', '2fxa7ryfdrz', 753.351134, 0.01, 61479715, 'jja', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('O', 'y', 360.694313, 0.01, 1972233925, '4301j', 'I');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('A', '3d', 881.248682, 0.01, -1826414375, 'c68x8vacx', 'I');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_11', 'c4bfkfoac', 60.937725, 0.0, -406331049, 'ezjo7wg', 'O');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_12', 'd5ysxc', 187.71278, 0.0, -405743609, 'g', 'O');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_13', '5i3', 172.799686, 0.01, 1816660482, 'npi', 'O');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_14', '5k58', 251.966916, 0.01, -1125548818, '94gth', 'O');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_15', 'lfvyz7zzb', 70.267562, 0.01, 924693315, 'kv42q7', '_');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_16', 'x58b4', 710.005534, 0.01, -1122409769, 'u', '_');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('@', 'rwbbp6luhvd', 179.378884, NULL, -841692980, 'bnp', '`');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('B', 'hria2ypuzhs', 663.049759, 0.01, 906324270, 'b', 'B');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('D', '9000t5c4ec', 128.76421, 0.01, -1683203397, 'e376nium52', 'E');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.event_name, T1.location FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event WHERE T2.remaining > 0;

/*
Gold Result:
('t1__53d8e5', 't1__960fee')
(None, 'gu7v')
('p6luhvdlttil', None)
*/

-- Prediction Query
SELECT "event"."event_name", "event"."location" FROM "event" INNER JOIN "budget" ON "event"."event_id" = "budget"."link_to_event" WHERE "budget"."remaining" > 0;

/*
Prediction Result:
('t1__53d8e5', 't1__960fee')
('t1__53d8e5', 't1__960fee')
('t1__53d8e5', 't1__960fee')
('t1__53d8e5', 't1__960fee')
('t1__53d8e5', 't1__960fee')
('t1__53d8e5', 't1__960fee')
('t1__53d8e5', 't1__960fee')
('t1__53d8e5', 't1__960fee')
('t1__53d8e5', 't1__960fee')
('t1__53d8e5', 't1__960fee')
('t1__53d8e5', 't1__960fee')
('t1__53d8e5', 't1__960fee')
('t1__53d8e5', 't1__960fee')
('t1__53d8e5', 't1__960fee')
(None, 'gu7v')
('p6luhvdlttil', None)
*/