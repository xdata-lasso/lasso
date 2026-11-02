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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__4ffa2a', 't3__ef6f1e', 't3__a3f5c8', '02eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 't3__ef6f1e', 't3__a3f5c8', '1vy9uxj4', 'wb', 'v', 'ph2', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_2', 't3__ef6f1e', 't3__a3f5c8', 'q', 'nqcx5h', 'cprj', 'u0dz7', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('C', 'i', 'yrk', 'n6vck6ah0f', 'jswwlq7xb', '72fxa7ryfd', 'z16ni', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__89af3b', 'u5zi', '6c4bfkfo', 'c', '0', '7z2zezjo7wg', 'd5ysxc', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 't3__ef6f1e', 't3__a3f5c8', 'ztdgj5i3lq5l', 'pim5', '58q', 's27p2r94gth2', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t3__ecd855', 'b', 'mzn2mfx', 'h33p6sto1', 'j', 'sh5knzys7', 'y', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_8', NULL, 'swwqcgsk', '9n8c4pgu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('B', 'ilbnp', 'mdpos', 'ie5', 'nw6klf', 'a9000t5c4eci', 'gce376nium52', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_10', NULL, 'ex1', 'ji7zwau2', 'dwyrq13pyu78', '9', 'rljsl0b4y', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('`', 'i2rkf', 'vqx58pz0f', '8jegd21vy9ux', 'j4hwbdvlph', 'gndqwnqc', 'x5hncprjtu0', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_12', NULL, 'xa', '7ryfdrz16n', 'jja', '5dh', 'ogrgjd8y', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('"', '1afgogritsj', 'ayxp1q43', '1jh3den', 'c68x8vacx', 'afu5w1of7', 'pzo72ctdc', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_14', NULL, 'foa', 'cd07z2zezjo7', 'wgxd5ysxcm', '0oztd', 'j5', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('F', 'q5l', 'pim5', '58q', 's27p2r94gth2', 'najj', 'a3o', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_16', NULL, 'vmkrpd', 'wzw', 'chn9mo70', 'a9n0jxfo', 'ws', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('b', '2zob', '0', '0k32o', 'w', 'l', '5amsorlwyngc', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_18', NULL, 'eowi', '1z5', 'xih6', '2q2xlyoto', '9oaawg', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('a', '0', 'bindz', '9tajz9td', 'n5wcgumbc', '3tdu6bd0w960', 'vzxw1rxe', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_20', NULL, 'tqxxnj', 'b', 'mzn2mfx', 'h33p6sto1', 'j', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('0', 'knzys7dy', 'yd1jmgjach8', 'qta8y3a17v4y', 'ma', 'q3qdpua', '96rn', -2147483648, 'major_id_1');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_1', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', '5u', 'w6kl', 'a9');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, '00t5c4e', 'cigce376nium', '52zbuo4nrq', 'rofqyp5s5b', 'p');

-- Inserting into table: budget --
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t1__5e3a15', 'rwbbp6luhvd', 179.378884, 304.02808, -1364429300, 'nprmdposii', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_2', 'p5qi2rk', 811.601922, 92.834164, -705985602, 'x58pz0f8je', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t1__ac78cd', 'gq8', 915.268032, 207.767266, -1762857309, 'dqv0gcb98ozk', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('@', 'tsj', 0.5, 453.914926, 2111987706, 'p1q430', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('A', '8c68', 369.474112, 979.894465, -683007527, 'x', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('Q', 'jpe1io22785', 993.555996, 848.763933, -1962347906, 'jpttg', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('H', '8y', 335.639672, 743.007715, 318331233, 'q7sx58b4', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('c', 'sorlwyngc1', 48.973066, 146.101675, 681061317, 'iz', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t2__53e2d0', '18ri', 851.78202, 890.677915, 389700824, '08ftp6ewtqxx', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('P', 'u', 225.300904, 760.580899, 781505063, 'rofqyp5s5b', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('D', '79fjgq8', 915.268032, 207.767266, -1762857309, 'dqv0gcb98ozk', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('B', 'mfg62g0v5q8q', 53.966914, 153.511511, -1858644047, 'o22', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('b', '8uttmu', 774.197346, 446.676539, -1817527403, '78lfvyz7zz', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('I', 'j', 821.485286, 549.267866, -413043724, 'k1yoeyo6l0h', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('`', 'k7', 256.291309, 931.189708, 643589729, 'h55y', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('E', 'q', 278.413617, 191.514384, -648564084, 'c7d', 'event_id_1');

-- Inserting into table: expense --
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('t1__98b270', '7zwau2dwyr', '13pyu', 520.715697, 'd99rljsl0', 't1__4ffa2a', 't1__5e3a15');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('t1__a8f3a1', 'jai', 'dh5ogrgj', 54.980195, 'yzt1afgog', 'C', 't1__ac78cd');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('@', 'afu5w1of7', 'pzo72ctdc', 803.582738, 'mfg62g0v5q8q', 't1__4ffa2a', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('E', 'ajjla3okv8u', 'tmu2n', 76.823924, '78lfvyz7zz', 'A', 't1__5e3a15');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('A', 'u', 'mkrpdj', 736.632717, 'zw5chn', 't1__4ffa2a', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('F', 'jxfofws', 'do2zobb', 407.368744, '0k32odwcl5a', 'A', 't1__5e3a15');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('0', 'o6l0hdt', 'fuqyxuzkb', 904.57762, '521gwnlas6e', 't1__4ffa2a', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('Q', 'i1z', 'nxih662q', 446.264042, 'lyotow', 'A', 't1__5e3a15');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('O', 'g96aqb', 'tbindz3', 555.680342, 'ajz9t', 't1__4ffa2a', 't1__5e3a15');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('_', '3', 'tdu6bd0w96', 411.582585, 'vzxw1rxe9y', 't1__4ffa2a', 't1__5e3a15');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('G', '162', 'h55y', 467.033126, 'ohvu06dza3', 't1__4ffa2a', 't1__5e3a15');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('B', 'p', '02eutliqa11r', 997.73177, 'ytoo3o9hl7', 'B', 'P');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('C', 'zbilyrkn', '6vck6ah0f8js', 346.706184, 'q7x', '`', 'D');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('D', '8507cvtjp', 'ttg6bnou5zi3', 510.534763, '4', '"', 'B');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('!', 'be8yvkv42q7', 'x58b4', 710.005534, 'maus', 'F', 'b');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('"', 't', 'fuqyxuzkb', 904.57762, '521gwnlas6e', 'b', 'I');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('`', 'dohvu06d', 'a35rmki', 229.766946, 'ri2hy08ft', 'a', '`');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('b', 'n2np490xdms', 'tgelc', 321.654734, 'b9i9f', '0', 'E');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.first_name, T3.last_name FROM expense AS T1 INNER JOIN budget AS T2 ON T1.link_to_budget = T2.budget_id INNER JOIN member AS T3 ON T1.link_to_member = T3.member_id ORDER BY T2.spent DESC, T1.expense_id NULLS LAST, T2.budget_id NULLS LAST, T3.member_id NULLS LAST LIMIT 5;

/*
Gold Result:
('i2rkf', 'vqx58pz0f')
('i', 'yrk')
('2zob', '0')
('q5l', 'pim5')
('t3__ef6f1e', 't3__a3f5c8')
*/

-- Prediction Query
SELECT T1.first_name, T1.last_name FROM member AS T1 INNER JOIN expense AS T2 ON T1.member_id = T2.link_to_member GROUP BY T1.first_name, T1.last_name ORDER BY SUM(T2.cost) DESC, T1.first_name NULLS LAST, T1.last_name NULLS LAST LIMIT 5;

/*
Prediction Result:
('t3__ef6f1e', 't3__a3f5c8')
('ilbnp', 'mdpos')
('2zob', '0')
('q5l', 'pim5')
('1afgogritsj', 'ayxp1q43')
*/