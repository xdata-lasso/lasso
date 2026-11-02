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
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t1__a8ddbb', 'rwbbp6luhvd', 179.378884, 304.02808, -1364429300, 'nprmdposii', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t1__69c46e', 'x58pz', 410.133844, 88.474525, -1529584866, 'd2', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('!', 'x', 668.309685, 0.0, 580968159, 'cprj', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('@', '6ah', 418.948509, 0.0, 138842628, 'wwlq7', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('"', 'ctdctmfg62g0', 935.463334, 0.0, 820970595, 'qdjpe1io2', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t2__f6f0b0', '5zi36c', 900.959264, 17.379583, -1173368267, 'cd07z2zezjo7', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('A', '5sw', 357.862717, 792.996259, -1981402255, 'k9n8c', 'event_id_1');

-- Inserting into table: expense --
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('t2__8c43c9', 't2__cfddd0', '8d99rljsl', 419.361606, 'yp5qi2rk', 'member_id_1', 't1__a8ddbb');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('A', 't2__cfddd0', 'y9uxj4', 124.573829, 'd', 'member_id_1', 't1__a8ddbb');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('C', 't2__cfddd0', 'ph2', 109.083092, 'dqwn', 'member_id_1', 't1__a8ddbb');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('#', 't2__cfddd0', 'dz79fjg', 261.415754, 'n2f3dqv0gcb9', 'member_id_1', 't1__69c46e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('$', 't2__dd9265', 'k3zbily', 279.382219, 'n6v', 'member_id_1', 't1__69c46e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('P', 't2__cfddd0', '72fxa7ryfd', 276.61064, '16nijja', 'member_id_1', 't1__69c46e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('q', 't2__dd9265', 'dh5ogrgj', 54.980195, 'yzt1afgog', 'member_id_1', 't1__69c46e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('1', 't2__cfddd0', 'sj3ayxp1q430', 947.945777, 'jh3den8c68', 'member_id_1', 't1__69c46e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('a', 't2__dd9265', 'vacx7afu5', 354.593207, 'of77pzo', 'member_id_1', 't1__69c46e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('!', 't2__cfddd0', '7cvtjpt', 605.666938, '6b', 'member_id_1', 't1__69c46e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('O', 't2__cfddd0', 'xd', 965.506647, 'sxcmr0o', 'member_id_1', 't2__f6f0b0');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('I', 't2__cfddd0', 'j5', 125.223349, 'q5l', 'member_id_1', 't2__f6f0b0');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('G', 't2__cfddd0', '5k58', 251.966916, 's27p2r94gth2', 'member_id_1', 't2__f6f0b0');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('J', 't2__dd9265', 'okv8uttmu2', 208.49371, '78lfvyz7', 'member_id_1', 't1__a8ddbb');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('@', 't2__cfddd0', '8y', 335.639672, 'v42q7sx58b4p', 'member_id_1', 't1__a8ddbb');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('B', 'gu7v', 'e4', 779.409124, 'hria2ypuzhs', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_17', NULL, 'wbbp6luhvdlt', 304.02808, 'bnp', 'member_id_1', 't2__f6f0b0');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.expense_description FROM budget AS T1 INNER JOIN expense AS T2 ON T1.budget_id = T2.link_to_budget ORDER BY T1.remaining, T1.budget_id NULLS LAST, T2.expense_id NULLS LAST LIMIT 1;

/*
Gold Result:
('t2__cfddd0',)
*/

-- Prediction Query
SELECT e.expense_description FROM expense AS e INNER JOIN budget AS b ON e.link_to_budget = b.budget_id WHERE b.budget_id = (SELECT budget_id FROM budget ORDER BY remaining ASC, budget.budget_id NULLS LAST LIMIT 1);

/*
Prediction Result:
*/