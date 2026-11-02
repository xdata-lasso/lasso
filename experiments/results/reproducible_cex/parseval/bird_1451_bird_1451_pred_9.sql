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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__0bffa8', '13pyu', '8d99rljsl', 'b4yp5qi', 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__6462b3', 'rjtu', 'dz79fjg', '8n2f3', 'dqv0gcb98ozk', 'zbilyrkn', '6vck6ah0f8js', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t2__fbe510', 'mu2ne578lf', 'yz7zzb', '8y', 'kv42q7', 'x58b4', 'pmaus3auvmkr', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 'lud8f', 'tb8r9114qbre', '6bjeuuwsj8k', 'h85', 'pxlvri', 'surz0kaqtncg', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', 'b7v88kwd', 'dbdh', '6j47n', 'ar50hs', 'han', 'xdpunmw', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('D', '02eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr', '13pyu', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 'jsl', 'b4yp5qi', 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4', 'wb', -2147483648, 'major_id_1');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('@', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', 'rwbbp6luhvd', 'tti', 'bnp', 'mdpos', 'ie5', 'nw6klf');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t4__18416f', 'j', 'wzw5chn9mo70', 'a9n0jxfo', 'ws', 'do2zobb', 'q0k32od');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t3__b4a24c', 'cl5ams', 'orlwyngc1dj', '9erhizgk1yoe', 'o6l0hdt', 'fuqyxuzkb', '521gwnlas6e');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('B', '9tajz9td', 'n5wcgumbc', '3tdu6bd0w960', 'vzxw1rxe', '9yfk7qk162n', '55');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('D', '3dohvu0', 'dza35rmki', '18ri', 'hy08ftp6', 'wt', 'xxnja');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('?', 'bymzn2mfx7h3', 'p6sto1cj', 'sh5knzys7', 'y', 'yd1jmgjach8', 'qta8y3a17v4y');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t3__c368da', 'ma', 'q3qdpua', '96rn', 'dqrhm', 'wlic7dn2', 'p490');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('C', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('F', 'rwbbp6luhvd', 'tti', 'bnp', 'mdpos', 'ie5', 'nw6klf');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', 'uo4nrqrofqy', '5s5b', 'p');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, '02eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr');

-- Inserting into table: budget --
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t1__294bf8', 'a9000t5c4eci', 734.586266, 767.720387, -1833165707, '6nium52zb', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t3__9285f7', '7p2r94gt', 796.553419, 577.602934, 1162591638, 'ajjla3okv8u', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('?', 'dmsqtg', 63.923383, 40.211911, 422046500, '9', 'B');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('@', 'i9f2ccukjq1q', 763.851917, 314.524853, -1459013972, 'yhb08hlst1pq', 'D');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('A', 'mizt', 636.138886, 917.521539, -1304516770, 'z78', '?');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('B', '9000t5c4ec', 128.76421, 610.208018, -1683203397, 'e376nium52', '@');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('E', 'u', 225.300904, 760.580899, 781505063, 'rofqyp5s5b', '?');

-- Inserting into table: expense --
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_1', 'lph2gn', 'q', 0.0, 'nqcx5h', 't1__0bffa8', 't1__294bf8');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_2', 'wlq7xb', '72fxa7ryfd', -1.0, 'z16ni', 't1__6462b3', 't1__294bf8');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_3', 'h5ogrgjd8yz', '1afgo', 0.0, 'ri', 't1__0bffa8', 't1__294bf8');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_4', 'tsj3ayxp1q4', '01jh3den', -1.0, 'c68x8vacx', 't1__6462b3', 't1__294bf8');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_5', 'f77p', 'o72ctdc', 0.0, 'mfg62', 't1__0bffa8', 't1__294bf8');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_6', '0v', 'q8qdjpe1', -1.0, 'o22', 't1__6462b3', 't1__294bf8');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_7', 'ttg6', 'n', 0.0, 'u5zi', 't1__0bffa8', 't1__294bf8');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_8', '6c4bfkfo', 'c', -1.0, '0', 't1__6462b3', 't1__294bf8');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_9', '7wgx', '5', 0.5, 'sxcmr0o', 't1__0bffa8', 't1__294bf8');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_10', 'ztdgj5i3lq5l', 'pim5', 0.0, '58q', 't1__6462b3', 't1__294bf8');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_11', 'i1z', 'nxih662q', NULL, 'xlyotow9', 't1__0bffa8', 't1__294bf8');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_12', 'aawg', '6aqb0tbin', NULL, 'z', 't1__6462b3', 't1__294bf8');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('B', 'qrlawk', '14r5dqt', 802.240612, 'g97a', 'A', '?');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('@', 'z2o20', 'pj6ddlysu6ip', 112.467274, 'u2g', 'O', '@');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('A', 'r31', 'wq51oa', 922.347497, 'sb3uoi1pavcv', 'O', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_16', 'wnyqrouirlrp', 'ouit63xyfvmj', 720.842041, 'pp26mb', 't1__0bffa8', 't1__294bf8');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('`', 'ph2', 'nd', 2.0, 'wnqcx', 't1__0bffa8', 't1__294bf8');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('b', 'hncprjtu0dz', '9fjgq8n2f', 3.0, 'dqv0gcb9', 'A', 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.member_id FROM expense AS T1 INNER JOIN member AS T2 ON T1.link_to_member = T2.member_id INNER JOIN budget AS T3 ON T1.link_to_budget = T3.budget_id INNER JOIN event AS T4 ON T3.link_to_event = T4.event_id GROUP BY T2.member_id HAVING COUNT(DISTINCT T4.event_id) > 1 ORDER BY SUM(T1.cost) DESC, T2.member_id NULLS LAST LIMIT 1;

/*
Gold Result:
('O',)
*/

-- Prediction Query
SELECT T1.first_name, T1.last_name FROM member AS T1 INNER JOIN expense AS T2 ON T1.member_id = T2.link_to_member GROUP BY T2.link_to_member HAVING COUNT(T2.expense_id) > 1 ORDER BY SUM(T2.cost) DESC, T1.first_name NULLS LAST, T1.last_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('b7v88kwd', 'dbdh')
*/