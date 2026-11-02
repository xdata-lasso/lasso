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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_1', '02eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr', '13pyu', -2147483648, 'major_id_1');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_1', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', '5u', 'w6kl', 'a9');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, '00t5c4e', 'cigce376nium', '52zbuo4nrq', 'rofqyp5s5b', 'p');

-- Inserting into table: budget --
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t1__a54094', 'rwbbp6luhvd', 179.378884, 304.02808, -1364429300, 'nprmdposii', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('!', 'vqx58pz0f', 707.476301, 541.107536, -1937207087, 'vy9uxj4', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('@', 'd', 328.40866, 989.653112, -1642259219, 'nd', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('%', 'gq8', 915.268032, 207.767266, -1762857309, 'dqv0gcb98ozk', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('B', 'yrk', 615.222139, 203.331848, 32204797, 'k', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('?', '8j', 282.822068, 351.095514, 1255343543, '7', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t2__b01826', '2g0v5q8qd', 632.482455, 234.606624, -288338724, '2278', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('D', '5sw', 357.862717, 792.996259, -1981402255, 'k9n8c', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('A', 'a2y', 797.015047, 241.913711, 1115440883, 'hsrwbbp', 'event_id_1');

-- Inserting into table: expense --
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('t1__ea9a35', 'Water, chips, cookies', '8d99rljsl', 419.361606, 'yp5qi2rk', 'member_id_1', 't1__a54094');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('t1__04e215', 'Water, chips, cookies', 'qcx5', 0.0, 'hncprjtu0dz', 'member_id_1', '@');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('Q', 'Water, chips, cookies', 'r', 680.944245, '16nijjai5dh', 'member_id_1', 't1__a54094');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('A', 'Water, chips, cookies', 'grgj', 54.980195, 'yzt1afgog', 'member_id_1', 't1__a54094');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('O', 'Water, chips, cookies', 'tsj3ayxp1q4', 457.141778, '1jh3den', 'member_id_1', 't1__a54094');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('I', 'Water, chips, cookies', 'afu5w1of7', 517.927187, 'o72ctdc', 'member_id_1', 't1__a54094');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('@', 't1__60efe9', 'gu7v', 86.520366, '4h', 'member_id_1', 'D');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('H', NULL, 'hvdltt', 125.12763, 'n', 'member_id_1', 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.budget_id FROM expense AS T1 INNER JOIN budget AS T2 ON T1.link_to_budget = T2.budget_id WHERE T1.expense_description = 'Water, chips, cookies' ORDER BY T1.cost DESC, T1.expense_id NULLS LAST, T2.budget_id NULLS LAST LIMIT 1;

/*
Gold Result:
('t1__a54094',)
*/

-- Prediction Query
SELECT e.expense_description FROM expense AS e INNER JOIN budget AS b ON e.link_to_budget = b.budget_id WHERE e.expense_description = 'Water, chips, cookies' ORDER BY e.cost DESC, e.expense_id NULLS LAST, b.budget_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Water, chips, cookies',)
*/