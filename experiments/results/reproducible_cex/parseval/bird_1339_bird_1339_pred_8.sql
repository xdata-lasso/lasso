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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__3c5946', 'Elijah', 'Allen', 'bnp', 'mdpos', 'ie5', 'nw6klf', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', 'Elijah', 'Allen', 'yp5qi2rk', '9v', 'x58pz', 'f8jegd2', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', '9uxj4hwbdvl', 'h2gn', 'q', 'nqcx5h', 'cprj', 'u0dz7', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('G', 'Elijah', 'Allen', 'wlq7xb', '72fxa7ryfd', 'z16ni', 'jai', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t2__280e43', 'Elijah', 'Allen', 'xp1q430', 'jh3den8', 'c68x8vacx7', 'f', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 'j9erhizgk1', 'yoeyo6l0hdt6', 'uq', 'xuzkb52', 'gwnlas6', 'elboeowii1', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('B', 'Elijah', 'Allen', 'swwqcgsk', '9n8c4pgu7v', 'e4', 'hria2ypuzhs', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('D', 'Elijah', 'Allen', 'b', 'p6luhvdlttil', 'n', 'rmdp', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('H', 'Elijah', 'Allen', 'swwqcgsk', '9n8c4pgu7v', 'e4', 'hria2ypuzhs', -2147483648, 'major_id_1');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_1', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', '5k5swwqcgs', '9n8', '4');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti');

-- Inserting into table: budget --
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_1', 'l7', 443.457804, 774.422647, -1390245819, 'x14ji7zwau2d', 'event_id_1');

-- Inserting into table: expense --
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_1', 'yrq13p', 'A?_G(09?', 375.832821, '8d99rljsl', 't1__3c5946', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_2', 'fjgq8n2f3', 'A ]G/09?', 687.701166, 'qv0gcb98ozk', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_3', 'lyr', 'A /G009?', 741.809988, 'n6vck6ah0f', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_4', 'h', 'APq_-09?', 488.601669, 'grgj', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_5', '1afgo', 'A OG_09?', 105.078878, 'tsj', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('O', 'w1of77pz', 'A oG_09?', 224.624401, '72ctdctmfg62', 't2__280e43', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('A', 'v5q8qdj', 'A OG_09?', 234.606624, 'io22785', 't2__280e43', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('_', 'tg6bnou5zi', 'A KG109?', 464.719657, '4', 't2__280e43', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_9', '7z2zezj', 'A@oG_09?', NULL, '7wgx', 't1__3c5946', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_10', 'ysxcmr0o', 'A KG_09?', NULL, 'ztdgj5i3lq5l', 't1__3c5946', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_11', '5k58', 'A@A_?09?', NULL, 's27p2', 't1__3c5946', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_12', '4gth2mnaj', 'A@QW/09/', NULL, 'la3', 't1__3c5946', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_13', 'uttmu2ne5', 'A@CW/_%?', NULL, '78lfvyz7zz', 't1__3c5946', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_14', '8y', 'APA_??#?', NULL, 'kv42q7', 't1__3c5946', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_15', '8b4pmaus3au', 'A@C_?09?', NULL, 'mkrpdj', 't1__3c5946', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_16', 'w5chn9m', 'A@q_?09?', NULL, 'o705a9n0jxfo', 't1__3c5946', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_17', 'do2zobb', 'A AG109/', NULL, 'q0k32od', 't1__3c5946', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_18', 'l', 'A@qG/09?', NULL, '5amsorlwyngc', 't1__3c5946', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('@', 'nxih662q', 'AAAAA10A', 446.264042, 'lyotow', '@', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('`', 'ie5', 'A OG_09?', 1.0, 'nw6klf', 't2__280e43', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('!', '9000t5c4ec', 'A OW_09?', 1.0, 'gce', 'D', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('"', 'wbbp6luhvdlt', 'AAAAA10A', 304.02808, 'bnp', 'H', 'budget_id_1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T2.cost) FROM member AS T1 INNER JOIN expense AS T2 ON T1.member_id = T2.link_to_member WHERE T1.last_name = 'Allen' AND T1.first_name = 'Elijah' AND (SUBSTRING(T2.expense_date, 6, 2) = '09' OR SUBSTRING(T2.expense_date, 6, 2) = '10');

/*
Gold Result:
(229.40165471428574,)
*/

-- Prediction Query
SELECT SUM(e.cost) / COUNT(e.expense_id) AS average_cost FROM member AS m JOIN expense AS e ON m.member_id = e.link_to_member WHERE m.member_id = (SELECT member_id FROM member WHERE first_name = 'Elijah' AND last_name = 'Allen') AND (SUBSTRING(e.expense_date, 6, 2) = '09' OR SUBSTRING(e.expense_date, 6, 2) = '10');

/*
Prediction Result:
(41.759202333333334,)
*/