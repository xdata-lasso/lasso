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
-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, '5k5swwqcgs', 'zip_329924', 'Orange County', 'Virginia', '9n8');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483647, '4', NULL, 'zip_fe12fa', 'Virginia', 'gu7v');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483646, 'e4', NULL, 'zip_85033d', 'Virginia', 'hria2ypuzhs');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483645, 'rwbbp6luhvd', NULL, 'Orange County', 'zip_7ae48d', 'tti');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483644, 'bnp', NULL, 'Orange County', 'zip_32b8ac', 'mdpos');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483643, 'ie5', NULL, 'Orange County', 'Virginia', 'nw6klf');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483642, 'a9000t5c4eci', NULL, 'Orange County', 'Virginia', 'gce376nium52');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483641, 'zbuo4nrqrof', NULL, 'Orange County', 'Virginia', 'qyp5s5bbp0');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483640, '2eutliqa11r', NULL, 'Orange County', 'Virginia', 'ytoo3o9');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (2, 'l7', 'zip_329924', 'Orange County', 'Virginia', 'klex14ji');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (3, '7zwau2dwyr', 'zip_329924', 'Orange County', 'Virginia', '13pyu');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (4, '8d99rljsl', 'b4yp5qi', 'Orange County', NULL, 'rkf9vqx5');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (5, 'pz0f8jegd', '1vy9uxj4', 'zip_b67f8c', 'zip_e440a3', 'wb');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (6, 'v', 'ph2', 'zip_b67f8c', NULL, 'nd');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (7, 'wnqcx', '5hncprjtu0d', NULL, 'Virginia', '79fjgq8');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (8, 'n2f3dqv0gcb9', 'ozk3zbily', NULL, 'zip_e440a3', 'kn6vc');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (9, '6ah', 'f8jswwl', NULL, NULL, '7xb72');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (10, 'xa', '7ryfdrz16n', 'Orange County', 'Virginia', 'jja');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (11, '5dh', 'ogrgjd8y', 'Orange County', 'Virginia', 't1afgog');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (12, 'itsj3', 'y', 'Orange County', 'Virginia', 'p1q430');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(city) FROM zip_code WHERE county = 'Orange County' AND state = 'Virginia';

/*
Gold Result:
(6,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT city) FROM zip_code WHERE county = 'Orange County' AND state = 'Virginia';

/*
Prediction Result:
(4,)
*/