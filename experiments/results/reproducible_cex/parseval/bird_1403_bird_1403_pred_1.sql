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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__e9e779', 't2__83bd58', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_2', 't2__83bd58', 'b', 'p6luhvdlttil', 'n', 'rmdp', 'siie');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__b79933', 'unw6klfa', '9000t5c4ec', 'gce', '76nium52', 'zbuo4nrqrof', 'qyp5s5bbp0');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('@', 't2__83bd58', 'oo3o9hl72kl', 'x1', 'ji7zwau2', 'dwyrq13pyu78', '9');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', 'rljsl0b4y', 'p5qi2rkf9v', 'x58pz', 'f8jegd2', 'vy9uxj4', 'wb');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('?', 'gndqwnqc', 'x5hncprjtu0', 'z', '9fjgq8n2f', 'dqv0gcb9', 'ozk3zbily');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('!', 'ayxp1q43', '1jh3den', 'c68x8vacx', 'afu5w1of7', 'pzo72ctdc', 'mfg62');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__80349c', 'djpe1', 'o22', '8507cvtjp', 'ttg6bnou5zi3', 'c4bfkfoac', '0');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('B', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('C', 'bnp', 'mdpos', 'ie5', 'nw6klf', 'a9000t5c4eci', 'gce376nium52');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('D', 's5bbp02e', 'tliqa1', 'ryytoo3', '9hl7', 'klex14ji', '7zwau2dwyr');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('F', '9rljsl0b4', 'p5qi2rk', '9v', 'x58pz', 'f8jegd2', 'vy9uxj4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('`', 'gndqwnqc', 'x5hncprjtu0', 'z', '9fjgq8n2f', 'dqv0gcb9', 'ozk3zbily');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('E', 'h0f8jswwlq', 'xb72fxa7r', 'fdrz16n', 'jja', '5dh', 'ogrgjd8y');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('%', 'ayxp1q43', '1jh3den', 'c68x8vacx', 'afu5w1of7', 'pzo72ctdc', 'mfg62');

-- Inserting into table: budget --
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t1__97c18c', 'hria2ypuzhs', 663.049759, -0.01, 906324270, 'Closed', 't1__e9e779');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t1__bd913c', '2eutliqa11r', 997.73177, -0.01, -525979501, 'Closed', 't1__b79933');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('$', 'v', 185.427628, 0.0, 1581736075, 'Closed', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('%', 'kn6vc', 915.583344, -0.01, 37673509, 'Closed', '?');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('1', 'h0f8jswwlq', 842.831917, -1.0, -566887085, 'Closed', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('A', '72fxa7ryfd', 276.61064, -0.01, 564390026, 'Closed', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('`', '6nijjai5dh', 488.601669, -1.0, 1583472758, 'Closed', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('p', 'rg', 155.818582, -0.01, 1074760385, 'Closed', '@');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('J', 't1afgog', 279.731401, -1.0, -902895762, 'Closed', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('e', '0v', 492.883123, -0.01, 820970595, 'Closed', '!');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('@', 'rwbbp6luhvd', 179.378884, NULL, -841692980, 'Closed', 'B');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('a', 'zbuo4nrqrof', 586.906897, -0.01, -472966518, 't1__5b0fa7', 'C');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('!', '13pyu', 520.715697, 0.0, 176380444, 't1__5b0fa7', 'D');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('"', 'wb', 50.647649, NULL, 1581736075, 't1__5b0fa7', 'F');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('D', 'kn6vc', 915.583344, -0.01, 37673509, NULL, '`');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('b', 't1afgog', 279.731401, 0.0, -902895762, NULL, 'E');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('B', '0v', 492.883123, NULL, 820970595, NULL, '%');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.event_name FROM budget AS T1 INNER JOIN event AS T2 ON T2.event_id = T1.link_to_event WHERE T1.event_status = 'Closed' AND T1.remaining < 0 ORDER BY T1.remaining, T1.budget_id NULLS LAST, T2.event_id NULLS LAST LIMIT 1;

/*
Gold Result:
('rljsl0b4y',)
*/

-- Prediction Query
SELECT event_name FROM event JOIN budget ON event.event_id = budget.link_to_event WHERE status = 'Closed' AND remaining < 0 ORDER BY remaining ASC, event.event_id NULLS LAST, budget.budget_id NULLS LAST LIMIT 1;

/*
Prediction Result:
*/