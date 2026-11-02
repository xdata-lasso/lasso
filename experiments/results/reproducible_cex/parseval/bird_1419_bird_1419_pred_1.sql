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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__2d815e', '5k5swwqcgs', '2020-03-24T12:00:00', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__778655', 'uzhsrwbbp6lu', '2020-03-24T12:00:00', 'hvdlttilbnpr', 'dpos', 'ie5', 'nw6klf');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', 'rofqyp5s5b', '2020-03-24T12:00:00', 'p', '02eutliqa11r', 'ytoo3o9', 'l7');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('_', 'klex14ji', '7zwau2dwyr', '13pyu', '8d99rljsl', 'b4yp5qi', 'rkf9vqx5');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('G', 'vy9uxj4', 'wb', 'v', 'ph2', 'nd', 'wnqcx');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__3157bc', 'n2f3dqv0gcb9', '2020-03-24T12:00:00', 'ozk3zbily', 'kn6vc', '6ah', 'f8jswwl');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('@', '5k5swwqcgs', NULL, '9n8', '4', 'gu7v', 'e4');

-- Inserting into table: budget --
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_1', 't2__490a35', 779.409124, 640.719621, 1160656988, 'ia2yp', 't1__2d815e');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('A', 't2__490a35', 741.842896, 587.783596, 1419861592, '4ecigce376n', 't1__2d815e');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('C', 't2__490a35', 805.746877, 322.782838, 283598170, 'zbuo4nrq', 't1__2d815e');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_4', 't2__490a35', 541.393553, 235.518744, 1836127587, 'f8jegd2', '_');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_5', 't2__490a35', 668.309685, 635.267184, -1245312912, 'rjtu', 'G');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_6', 't2__490a35', 415.830002, 395.809081, 401805964, 'gq8', 'G');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('O', 't2__490a35', 260.513699, 969.559316, 1255343543, '7', 't2__3157bc');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('I', 't2__490a35', 949.322482, 640.201736, 1350414441, 'a7ryfd', 't2__3157bc');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_9', 't2__490a35', 276.61064, 399.319982, 564390026, '6nijjai5dh', 't1__2d815e');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_10', NULL, 488.601669, 781.755052, 1583472758, 'rg', 't1__2d815e');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('@', 'hria2ypuzhs', 663.049759, 711.020062, 1908028688, 'p', '@');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.category FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event WHERE T1.event_date = '2020-03-24T12:00:00';

/*
Gold Result:
('t2__490a35',)
('t2__490a35',)
('t2__490a35',)
('t2__490a35',)
('t2__490a35',)
('t2__490a35',)
(None,)
*/

-- Prediction Query
SELECT type FROM event WHERE event_date = '2020-03-24T12:00:00';

/*
Prediction Result:
('9n8',)
('hvdlttilbnpr',)
('p',)
('ozk3zbily',)
*/