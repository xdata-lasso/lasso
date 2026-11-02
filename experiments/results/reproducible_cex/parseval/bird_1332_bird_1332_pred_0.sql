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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__16cf6e', 'September Meeting', 'A?_A?09A', '5k5swwqcgs', '9n8', '4', 'gu7v');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__ed4fa4', 'September Meeting', 'A??!G09S', 'rwbbp6luhvd', 'tti', 'bnp', 'mdpos');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('O', 'September Meeting', 'A7WIH09Y', 'um5', 'zbuo4nrq', 'rofqyp5s5b', 'p');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', '02eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr', '13pyu');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__c2e2d4', 'September Meeting', 'A7WiH09%', 'd2', 'vy9uxj4', 'wb', 'v');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Q', 'September Meeting', 'A@oG_?i?', '5k5swwqcgs', '9n8', '4', 'gu7v');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('P', 'September Meeting', 'A@KW_?a?', '5k5swwqcgs', '9n8', '4', 'gu7v');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('G', 'September Meeting', '!AAAA09A', '5k5swwqcgs', '9n8', '4', 'gu7v');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('@', 'September Meeting', 'A@OG_?a?', 'uzhsrwbbp6lu', 'hvdlttilbnpr', 'dpos', 'ie5');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('B', 't1__e4e2c3', 'AAAAA09A', '5k5swwqcgs', '9n8', '4', 'gu7v');

-- Inserting into table: budget --
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_1', 'Food', 1.0, 86.520366, -1865039888, 'hria2ypuzhs', 't1__16cf6e');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('G', 'Food', 1.0, 133.007885, -1823627488, 'nw6klf', 't1__16cf6e');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('A', 'Food', 1.0, 741.842896, 1419861592, '4ecigce376n', 't1__16cf6e');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_4', 'Food', 1.0, 520.715697, 176380444, '9rljsl0b4', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_5', 'Food', 1.0, 884.000446, -1116181514, 'i2rkf', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_6', 'Food', 1.0, 551.785129, 556727997, '8pz0f8je', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('O', 'Food', 1.0, 185.427628, 1581736075, 'gndqwnqc', 't2__c2e2d4');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_8', 'Food', 1.0, 629.317167, 722884590, 'hncprjtu0dz', 't1__16cf6e');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_9', 't2__0ad2dc', 1.0, 521.610309, -1748371085, 'q8', 't1__16cf6e');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_10', 'Food', 1.0, 915.268032, -1255130038, '3d', 't1__16cf6e');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_11', 'Food', NULL, 656.638403, 513454646, '0gcb98', 't1__16cf6e');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('@', 'Food', 86.520366, 65.761562, 1160656988, 'ia2yp', 'Q');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('B', 't2__31a2eb', 86.520366, 65.761562, 1160656988, 'ia2yp', 'P');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('`', NULL, 86.520366, 65.761562, 1160656988, 'ia2yp', 'G');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('H', NULL, 327.753528, 218.301157, -1399556171, 'a9000t5c4eci', '@');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('F', 'Food', 86.520366, 65.761562, 1160656988, 'ia2yp', 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.spent FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event WHERE T1.event_name = 'September Meeting' AND T2.category = 'Food' AND SUBSTRING(T1.event_date, 6, 2) = '09';

/*
Gold Result:
(1.0,)
(1.0,)
(1.0,)
(1.0,)
(1.0,)
(1.0,)
(None,)
*/

-- Prediction Query
SELECT T2.spent FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event WHERE T1.event_name = 'September Meeting' AND T2.category = 'Food';

/*
Prediction Result:
(1.0,)
(1.0,)
(1.0,)
(1.0,)
(1.0,)
(1.0,)
(None,)
(86.520366,)
*/