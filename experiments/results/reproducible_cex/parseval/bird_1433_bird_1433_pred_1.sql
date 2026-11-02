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
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (2, 'PO Box', '5k5swwqcgs', 'zip_efe731', '9n8', '4');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (3, 'PO Box', 'gu7v', 'zip_efe731', 'e4', 'hria2ypuzhs');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (4, 'rwbbp6luhvd', 'tti', NULL, 'bnp', 'mdpos');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (5, 'PO Box', 'ie5', NULL, 'nw6klf', 'a9000t5c4eci');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (6, 'PO Box', 'gce376nium52', NULL, 'zbuo4nrqrof', 'qyp5s5bbp0');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (7, 'PO Box', '2eutliqa11r', NULL, 'ytoo3o9', 'l7');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (8, 'PO Box', 'klex14ji', NULL, '7zwau2dwyr', '13pyu');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (9, 'PO Box', '8d99rljsl', NULL, 'b4yp5qi', 'rkf9vqx5');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (10, 'PO Box', 'pz0f8jegd', NULL, '1vy9uxj4', 'wb');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (11, 'PO Box', 'v', NULL, 'ph2', 'nd');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (12, 'PO Box', 'wnqcx', NULL, '5hncprjtu0d', '79fjgq8');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (13, 'PO Box', 'n2f3dqv0gcb9', NULL, 'ozk3zbily', 'kn6vc');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT county FROM zip_code WHERE type = 'PO Box' AND NOT county IS NULL;

/*
Gold Result:
('zip_efe731',)
*/

-- Prediction Query
SELECT DISTINCT city FROM zip_code WHERE type = 'PO Box';

/*
Prediction Result:
('5k5swwqcgs',)
('gu7v',)
('ie5',)
('gce376nium52',)
('2eutliqa11r',)
('klex14ji',)
('8d99rljsl',)
('pz0f8jegd',)
('v',)
('wnqcx',)
('n2f3dqv0gcb9',)
*/