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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', 'eve_558fe8', '2019-03-15', 'Game', '5k5swwqcgs', '9n8', 'Closed');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('C', 'eve_558fe8', '2019-03-15', 'Game', '4', 'gu7v', 'Closed');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('O', 'eve_558fe8', '2019-03-15', 'eve_b2e2ec', 'e4', 'hria2ypuzhs', 'Closed');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('G', 'eve_558fe8', '2019-03-15', 'Game', 'rwbbp6luhvd', 'tti', 'eve_452425');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_5', 'bnp', '2019-03-15', 'Game', 'mdpos', 'ie5', 'Closed');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('@', 'nw6klf', '2019-03-15', 'Game', 'a9000t5c4eci', 'gce376nium52', 'Closed');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_7', 'zbuo4nrqrof', '2019-03-15', 'Game', 'qyp5s5bbp0', '2eutliqa11r', 'Closed');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('W', 'ytoo3o9', '2019-03-15', 'Game', 'l7', 'klex14ji', 'Closed');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_9', '7zwau2dwyr', '2019-03-15', 'Game', '13pyu', '8d99rljsl', 'Closed');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('D', 'b4yp5qi', '2019-03-15', 'Game', 'rkf9vqx5', 'pz0f8jegd', 'Closed');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_11', '1vy9uxj4', '2019-03-15', 'Game', 'wb', 'v', 'Closed');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('!', 'ph2', '2019-03-15', 'Game', 'nd', 'wnqcx', 'Closed');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_13', '5hncprjtu0d', '2019-03-15', 'Game', '79fjgq8', 'n2f3dqv0gcb9', 'Closed');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('F', 'ozk3zbily', '2019-03-15', 'Game', 'kn6vc', '6ah', 'Closed');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_15', 'f8jswwl', '2019-03-15', 'Game', '7xb72', 'xa', 'Closed');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('B', '7ryfdrz16n', '2019-03-15', 'Game', 'jja', '5dh', 'Closed');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_17', 'ogrgjd8y', '2019-03-15', 'Game', 't1afgog', 'itsj3', 'Closed');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('H', 'y', '2019-03-15', 'Game', 'p1q430', 'jh3den8', 'Closed');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_19', 'c68x8vacx7', '2019-03-15', 'Game', 'f', '5w1of7', 'Closed');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('P', 'pzo72ctdc', '2019-03-15', 'Game', 'mfg62', '0v', 'Closed');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_21', 'q8qdjpe1', '2019-03-15', 'Game', 'o22', '8507cvtjp', 'Closed');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('"', 'ttg6bnou5zi3', '2019-03-15', 'Game', 'c4bfkfoac', '0', 'Closed');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_23', '7z2zezjo7wg', '2019-03-15', 'Game', 'd5ysxc', 'r0oz', 'Closed');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('E', 'dgj5i', '2019-03-15', 'Game', 'lq5lnpim', 'k58qs27p', 'Closed');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT event_name FROM event WHERE type = 'Game' AND DATE(SUBSTRING(event_date, 1, 10)) BETWEEN '2019-03-15' AND '2020-03-20' AND status = 'Closed';

/*
Gold Result:
('eve_558fe8',)
('bnp',)
('nw6klf',)
('zbuo4nrqrof',)
('ytoo3o9',)
('7zwau2dwyr',)
('b4yp5qi',)
('1vy9uxj4',)
('ph2',)
('5hncprjtu0d',)
('ozk3zbily',)
('f8jswwl',)
('7ryfdrz16n',)
('ogrgjd8y',)
('y',)
('c68x8vacx7',)
('pzo72ctdc',)
('q8qdjpe1',)
('ttg6bnou5zi3',)
('7z2zezjo7wg',)
('dgj5i',)
*/

-- Prediction Query
SELECT event_name FROM event WHERE type = 'Game' AND status = 'Closed' AND SUBSTRING(event_date, 1, 10) BETWEEN '2019-03-15' AND '2020-03-20';

/*
Prediction Result:
('eve_558fe8',)
('eve_558fe8',)
('bnp',)
('nw6klf',)
('zbuo4nrqrof',)
('ytoo3o9',)
('7zwau2dwyr',)
('b4yp5qi',)
('1vy9uxj4',)
('ph2',)
('5hncprjtu0d',)
('ozk3zbily',)
('f8jswwl',)
('7ryfdrz16n',)
('ogrgjd8y',)
('y',)
('c68x8vacx7',)
('pzo72ctdc',)
('q8qdjpe1',)
('ttg6bnou5zi3',)
('7z2zezjo7wg',)
('dgj5i',)
*/