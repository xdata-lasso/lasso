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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__66a7ad', 't1__59dbef', 't1__b18729', 'gce376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 't1__59dbef', 't1__b18729', 'jsl', 'b4yp5qi', 'rkf9vqx5', 'pz0f8jegd', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('C', 't1__59dbef', 't1__b18729', 'y9uxj4', 'wb', 'v', 'ph2', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', 'k', 'ah0f8jsww', 'q7x', '7', '2fxa7ryfdrz', '16nijjai5dh', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t2__da8b4c', 't1__59dbef', 't1__b18729', 'c', '0', '7z2zezjo7wg', 'd5ysxc', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 'a2y', 'uzhs', 'rwbbp6luhvd', 'tti', 'bnp', 'mdpos', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('H', NULL, 'a2y', 'uzhs', 'rwbbp6luhvd', 'tti', 'bnp', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('D', 'uo4nrqrofqy', NULL, '5s5b', 'p', '02eutliqa11r', 'ytoo3o9', -2147483648, 'major_id_1');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__abb429', 'Laugh Out Loud', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_2', 'Laugh Out Loud', 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr', '13pyu');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__6f2e79', 'nd', 'wnqcx', '5hncprjtu0d', '79fjgq8', 'n2f3dqv0gcb9', 'ozk3zbily');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('C', 'Laugh Out Loud', 'ogrgjd8y', 't1afgog', 'itsj3', 'y', 'p1q430');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', '3d', 'n8', 'c68x8vacx7', 'f', '5w1of7', 'pzo72ctdc');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('G', 'Laugh Out Loud', 'g6', 'g0v5q8qd', 'jpe1io22785', '7cvtjpt', 'tg6bnou5zi');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t3__ce13ff', 'q5l', 'pim5', '58q', 's27p2r94gth2', 'najj', 'a3o');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('@', NULL, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('D', 'Laugh Out Loud', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('H', 'Laugh Out Loud', 'mdpos', 'ie5', 'nw6klf', 'a9000t5c4eci', 'gce376nium52');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'bnp', 'mdpos', 'ie5', 'nw6klf', 'a9000t5c4eci');

-- Inserting into table: attendance --
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__abb429', 't1__66a7ad');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__abb429', 'A');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__6f2e79', 'A');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__abb429', 'O');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 't1__66a7ad');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__abb429', 't2__da8b4c');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', '@');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('D', 'H');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('H', 'D');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.first_name, T1.last_name FROM member AS T1 INNER JOIN attendance AS T2 ON T1.member_id = T2.link_to_member INNER JOIN event AS T3 ON T2.link_to_event = T3.event_id WHERE T3.event_name = 'Laugh Out Loud';

/*
Gold Result:
('t1__59dbef', 't1__b18729')
('t1__59dbef', 't1__b18729')
('k', 'ah0f8jsww')
('t1__59dbef', 't1__b18729')
(None, 'a2y')
('uo4nrqrofqy', None)
*/

-- Prediction Query
SELECT DISTINCT member.first_name, member.last_name FROM member INNER JOIN attendance ON member.member_id = attendance.link_to_member INNER JOIN event ON attendance.link_to_event = event.event_id WHERE event.event_name = 'Laugh Out Loud';

/*
Prediction Result:
('t1__59dbef', 't1__b18729')
('k', 'ah0f8jsww')
(None, 'a2y')
('uo4nrqrofqy', None)
*/