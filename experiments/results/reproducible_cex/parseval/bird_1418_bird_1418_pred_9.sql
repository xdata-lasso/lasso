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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__de9584', '5k5swwqcgs', '9n8', '4', 'gu7v', 'MU 215', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__c06db4', 'uzhsrwbbp6lu', 'hvdlttilbnpr', 'dpos', 'ie5', 'MU 215', 'nw6klf');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('O', 'rofqyp5s5b', 'p', '02eutliqa11r', 'ytoo3o9', 'MU 215', 'l7');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', 'klex14ji', '7zwau2dwyr', '13pyu', '8d99rljsl', 'b4yp5qi', 'rkf9vqx5');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('I', 'vy9uxj4', 'wb', 'v', 'ph2', 'MU 215', 'nd');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__981a53', 'dz79fjg', '8n2f3', 'dqv0gcb98ozk', 'zbilyrkn', 'MU 215', '6vck6ah0f8js');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('@', '5k5swwqcgs', '9n8', '4', 'gu7v', NULL, 'e4');

-- Inserting into table: budget --
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_1', 't2__c1544e', 779.409124, 640.719621, 1160656988, 'ia2yp', 't1__de9584');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('A', 't2__c1544e', 741.842896, 587.783596, 1419861592, '4ecigce376n', 't1__de9584');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('C', 't2__c1544e', 805.746877, 322.782838, 283598170, 'zbuo4nrq', 't1__de9584');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_4', 't2__c1544e', 541.393553, 235.518744, 1836127587, 'f8jegd2', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_5', 't2__c1544e', 893.16532, 254.83756, -1245682094, 'x', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_6', 't2__c1544e', 668.309685, 635.267184, -1245312912, 'rjtu', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('G', 't2__c1544e', 346.706184, 176.824244, -566887085, '72fxa7ryfd', 't2__981a53');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('I', 't2__c1544e', 276.61064, 399.319982, 564390026, '6nijjai5dh', 't2__981a53');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('O', 't2__c1544e', 488.601669, 781.755052, 1583472758, 'rg', 't2__981a53');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_10', 't2__c1544e', 155.818582, 917.457483, 1074760385, 't1afgog', 't1__de9584');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_11', NULL, 279.731401, 630.468925, -902895762, 'ayxp1q43', 't1__de9584');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('@', 'hria2ypuzhs', 663.049759, 711.020062, 1908028688, 'p', '@');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.category FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event WHERE T1.location = 'MU 215';

/*
Gold Result:
('t2__c1544e',)
('t2__c1544e',)
('t2__c1544e',)
('t2__c1544e',)
('t2__c1544e',)
('t2__c1544e',)
('t2__c1544e',)
(None,)
*/

-- Prediction Query
SELECT DISTINCT T1.category FROM budget AS T1 INNER JOIN event AS T2 ON T2.event_id = T1.link_to_event WHERE T2.location = 'MU 215';

/*
Prediction Result:
('t2__c1544e',)
(None,)
*/