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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t2__6f5d14', 'gce376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9', 'l7', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t2__f8fce8', 'dr', 'z16nijjai5d', 'h5ogrgjd8yz', '1afgo', 'ri', 'tsj3ayxp1q4', -2147483648, 'major_id_1');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__aaaa51', 'Women''s Soccer', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', 'Women''s Soccer', 'klex14ji', '7zwau2dwyr', '13pyu', '8d99rljsl', 'b4yp5qi');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('C', 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4', 'wb', 'v', 'ph2');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('O', 'nd', 'wnqcx', '5hncprjtu0d', '79fjgq8', 'n2f3dqv0gcb9', 'ozk3zbily');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__d1cfe3', 'Women''s Soccer', 'kn6vc', '6ah', 'f8jswwl', '7xb72', 'xa');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('E', NULL, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('@', 'Women''s Soccer', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('B', 'Women''s Soccer', 'ia2yp', 'uzhsrwbbp6lu', 'hvdlttilbnpr', 'dpos', 'ie5');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('P', 'Women''s Soccer', 'w6kl', 'a9', '00t5c4e', 'cigce376nium', '52zbuo4nrq');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('G', 'Women''s Soccer', 'fqyp', 's5bbp02e', 'tliqa1', 'ryytoo3', '9hl7');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('b', 'Women''s Soccer', 'lex', '4ji7zwa', '2dwyrq', '3pyu78d', '9rljsl0b4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('c', 'Women''s Soccer', 'p5qi2rkf9v', 'x58pz', 'f8jegd2', 'vy9uxj4', 'wb');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'bnp', 'mdpos', 'ie5', 'nw6klf', 'a9000t5c4eci');

-- Inserting into table: attendance --
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__aaaa51', 't2__6f5d14');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('C', 't2__6f5d14');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('O', 't2__6f5d14');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__d1cfe3', 't2__6f5d14');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__d1cfe3', 't2__f8fce8');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('E', 't2__6f5d14');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', 't2__6f5d14');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('B', 't2__f8fce8');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('P', 't2__f8fce8');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 't2__f8fce8');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('b', 't2__f8fce8');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('c', 't2__6f5d14');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T2.link_to_member) FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event WHERE T1.event_name = 'Women''s Soccer';

/*
Gold Result:
(9,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT attendance.link_to_member) FROM attendance JOIN event ON attendance.link_to_event = event.event_id WHERE event.event_name = 'Women''s Soccer';

/*
Prediction Result:
(2,)
*/