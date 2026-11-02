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
-- Inserting into table: member --
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t2__02c1cf', 'Luisa', 'Guidi', 'tti', 'bnp', 'mdpos', 'ie5', -2147483648, 't1__9ce6f7');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t2__bfbf2e', 'Luisa', 'Guidi', '3pyu78d99r', 'jsl', 'b4yp5qi', 'rkf9vqx5', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 'Luisa', 'Guidi', 'gq8', 'n2f3dqv0gcb9', 'ozk3zbily', 'kn6vc', -2147483648, 't1__9ce6f7');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('_', 'h0f8jswwlq', 'xb72fxa7r', 'fdrz16n', 'jja', '5dh', 'ogrgjd8y', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', 'fgogritsj3ay', 'p1q430', 'jh3den8', 'c68x8vacx7', 'f', '5w1of7', -2147483648, 'O');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('G', 'Luisa', 'Guidi', 'bfkfoacd', '7z2zezj', '7wgx', '5', -2147483648, 't2__1ed08c');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t3__137f07', 'Luisa', 'Guidi', 'cmr0oz', 'dgj5i', 'lq5lnpim', 'k58qs27p', -2147483648, 't1__9ce6f7');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t3__cea767', 'nw6klf', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t3__27b1db', 'pz0f8jegd', '1vy9uxj4', 'wb', 'v', 'ph2', 'nd');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t1__9ce6f7', 't1__3aa483', '5k5swwqcgs', '9n8');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('A', 't1__3aa483', 'ytoo3o9', 'l7');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('C', 't1__3aa483', 'klex14ji', '7zwau2dwyr');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('O', 't1__3aa483', 'wnqcx', '5hncprjtu0d');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('E', 't1__3aa483', 'pzo72ctdc', 'mfg62');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('G', 't1__3aa483', '5q8qdj', 'e1io');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t2__1ed08c', 't1__3aa483', '8507cvtjp', 'ttg6bnou5zi3');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, '4', 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd');

-- Inserting into table: attendance --
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t3__cea767', 't2__02c1cf');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t3__27b1db', 't2__02c1cf');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t3__cea767', '_');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t3__cea767', 'O');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t3__cea767', 'A');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t3__cea767', 't3__137f07');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t3__27b1db', 't3__137f07');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T3.link_to_event), T1.major_name FROM major AS T1 INNER JOIN member AS T2 ON T1.major_id = T2.link_to_major INNER JOIN attendance AS T3 ON T2.member_id = T3.link_to_member WHERE T2.first_name = 'Luisa' AND T2.last_name = 'Guidi';

/*
Gold Result:
(5, 't1__3aa483')
*/

-- Prediction Query
SELECT COUNT(DISTINCT "attendance"."link_to_event") AS "number_of_events", "major"."major_name" FROM "member" INNER JOIN "attendance" ON "member"."member_id" = "attendance"."link_to_member" INNER JOIN "major" ON "member"."link_to_major" = "major"."major_id" WHERE "member"."first_name" = 'Luisa' AND "member"."last_name" = 'Guidi';

/*
Prediction Result:
(2, 't1__3aa483')
*/