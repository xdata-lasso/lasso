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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__e1a91a', 'bnp', 'mdpos', 'ie5', 't2__c43669', 'nw6klf', 'a9000t5c4eci', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', '8pz0f8je', 'd2', 'vy9uxj4', 't2__c43669', 'wb', 'v', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('C', 'gndqwnqc', 'x5hncprjtu0', 'z', '9fjgq8n2f', 'dqv0gcb9', 'ozk3zbily', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('G', 'rg', 'd8y', 't1afgog', 'itsj3', 'y', 'p1q430', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('I', 'o72ctdc', 'mfg62', '0v', 'q8qdjpe1', 'o22', '8507cvtjp', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t2__fdcf60', 'msorlwyngc', 'dj9erhi', 'zgk1yoeyo6l0', 'dt', 'fuqyxuzkb', '521gwnlas6e', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('!', 'swwqcgsk', '9n8c4pgu7v', 'e4', 't2__c43669', 'hria2ypuzhs', 'rwbbp6luhvd', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 'ilbnp', 'mdpos', 'ie5', 't2__22bb80', 'nw6klf', 'a9000t5c4eci', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('B', 'oo3o9', 'l7', 'klex14ji', 'Member', '7zwau2dwyr', '13pyu', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('J', '8pz0f8je', 'd2', 'vy9uxj4', NULL, 'wb', 'v', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('c', 'swwqcgsk', '9n8c4pgu7v', 'e4', 't2__22bb80', 'hria2ypuzhs', 'rwbbp6luhvd', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('D', 'klfa9000t', 'c4ecigce', '76nium52', 't2__22bb80', 'zbuo4nrqrof', 'qyp5s5bbp0', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('F', '2dwyrq', '3pyu78d', '9rljsl0b4', 't2__22bb80', 'p5qi2rk', '9v', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('E', 'd', 'lph2gn', 'q', 't2__22bb80', 'nqcx5h', 'cprj', -2147483648, 'major_id_1');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_1', 'gce376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9', 'l7');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', '5k5swwqcgs', '9n8', '4');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti');

-- Inserting into table: budget --
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_1', 'klex14ji', 598.409165, 394.443388, 481163439, '2dwyrq', 'event_id_1');

-- Inserting into table: expense --
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_1', '3pyu78d', '9rljsl0b4', 884.000446, 'p5qi2rkf9v', 't1__e1a91a', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_2', 'kn6vc', '6ah', 418.948509, 'jswwlq7xb', 'C', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_3', '7', 'yfdrz', 753.351134, '6nijjai', 'C', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_4', 'jh3den8', 'c68x8vacx7', 854.793228, 'u5', 'G', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_5', 'ttg6bnou5zi3', 'c4bfkfoac', 60.937725, '7z2zezj', 'I', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('G', 'd5ysxc', 'r0oz', 297.258735, 'j5', 't1__e1a91a', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('A', 'lq5lnpim', 'k58qs27p', 452.630377, '94gth', 't1__e1a91a', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('O', 'ajjla3okv8u', 'tmu2n', 76.823924, '78lfvyz7zz', 't1__e1a91a', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('I', '7sx58', 'b4pmaus3auv', 202.422113, 'rpdjwzw5ch', 't1__e1a91a', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_10', 'a9n0jxfo', 'ws', NULL, 'do2zobb', 't1__e1a91a', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_11', '0k32o', 'w', NULL, 'l', 't1__e1a91a', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_12', 'ii1z5n', 'xih662q2xly', NULL, 'otow9oaawg', 't1__e1a91a', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_13', 'qb0tbindz39t', 'j', NULL, '9td8n5w', 't1__e1a91a', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_14', 'bc3t', 'u', NULL, 'bd0w9603v', 't1__e1a91a', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_15', 'xw1rxe9yfk7', 'k162n', NULL, '55', 't1__e1a91a', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('!', 'e', '76nium52', 1.0, 'zbuo4nrqrof', '@', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('a', '5s5b', 'p', 1.0, '02eutliqa11r', '!', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('@', '9rljsl0b4', 'p5qi2rk', 811.601922, '9v', 'B', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('B', 'h2gn', 'q', 345.35543, 'cx5hn', 'J', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('`', 'tilbn', 'rmdp', 227.766936, 'iie5u', 'c', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('"', 'eutliqa11r', 'ytoo3o9', 111.926013, '72klex14ji7z', 'D', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('K', 'x58pz0f8je', 'd2', 890.091601, 'y9uxj4', 'F', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('C', '0dz79f', 'gq8', 915.268032, '2f3d', 'E', 'budget_id_1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T1.cost) FROM expense AS T1 INNER JOIN member AS T2 ON T1.link_to_member = T2.member_id WHERE T2.position <> 'Member';

/*
Gold Result:
(409.88125153333334,)
*/

-- Prediction Query
SELECT CAST(SUM(T1.cost) AS REAL) / COUNT(T1.link_to_member) FROM expense AS T1 INNER JOIN member AS T2 ON T1.link_to_member = T2.member_id WHERE T2.position <> 'Member';

/*
Prediction Result:
(292.7723225238095,)
*/