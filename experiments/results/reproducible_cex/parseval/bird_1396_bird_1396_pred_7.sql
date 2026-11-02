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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t2__b435d8', 'Luisa', 'Guidi', 'tti', 'bnp', 'mdpos', 'ie5', -2147483648, 't1__bb10d5');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t2__b8d4a1', 'Luisa', 'Guidi', 'ex1', 'ji7zwau2', 'dwyrq13pyu78', '9', -2147483648, 't1__bb10d5');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('G', 'Luisa', 'Guidi', 'gq8', 'n2f3dqv0gcb9', 'ozk3zbily', 'kn6vc', -2147483648, 't1__bb10d5');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 'h0f8jswwlq', 'xb72fxa7r', 'fdrz16n', 'jja', '5dh', 'ogrgjd8y', -2147483648, 't1__c2ecab');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', 'Luisa', 'Guidi', '1afgogritsj', 'ayxp1q43', '1jh3den', 'c68x8vacx', -2147483648, 't1__bb10d5');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t3__5b9992', 'Luisa', 'Guidi', 'i36c4bf', 'foa', 'cd07z2zezjo7', 'wgxd5ysxcm', -2147483648, 't1__bb10d5');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t3__5c4576', 'nw6klf', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t3__400104', 'rljsl0b4y', 'p5qi2rkf9v', 'x58pz', 'f8jegd2', 'vy9uxj4', 'wb');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t1__bb10d5', 't1__1b66a5', '5k5swwqcgs', '9n8');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t1__c2ecab', 't1__1b66a5', 'ytoo3o9', 'l7');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('A', 't1__1b66a5', 'v', 'ph2');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('O', 'nd', 'wnqcx', '5hncprjtu0d');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('I', 'afu5w1of7', 'pzo72ctdc', 'mfg62');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('G', '5q8qdj', 'e1io', '278507cv');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t2__1d8aa3', 't1__1b66a5', 'ttg6', 'n');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, '4', 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd');

-- Inserting into table: attendance --
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t3__5c4576', 't2__b435d8');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t3__400104', 't2__b435d8');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t3__5c4576', 'A');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t3__5c4576', 't3__5b9992');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t3__400104', 't3__5b9992');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T3.link_to_event), T1.major_name FROM major AS T1 INNER JOIN member AS T2 ON T1.major_id = T2.link_to_major INNER JOIN attendance AS T3 ON T2.member_id = T3.link_to_member WHERE T2.first_name = 'Luisa' AND T2.last_name = 'Guidi';

/*
Gold Result:
(4, 't1__1b66a5')
*/

-- Prediction Query
SELECT (SELECT COUNT(*) FROM attendance WHERE link_to_member = (SELECT member_id FROM member WHERE first_name = 'Luisa' AND last_name = 'Guidi')) AS number_of_events_attended, (SELECT major_name FROM major WHERE major_id = (SELECT link_to_major FROM member WHERE first_name = 'Luisa' AND last_name = 'Guidi')) AS major;

/*
Prediction Result:
(2, 't1__1b66a5')
*/