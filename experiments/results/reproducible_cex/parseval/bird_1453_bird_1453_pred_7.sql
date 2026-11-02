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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_1', '8d99rljsl', 'b4yp5qi', 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4', 'wb', -2147483648, 'major_id_1');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__129b81', 't1__d6459d', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__0f0d4f', 't1__d6459d', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'bnp', 'mdpos');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('_', 't1__d6459d', 'dqv0gcb98ozk', 'zbilyrkn', '6vck6ah0f8js', 'wlq7xb', '72fxa7ryfd');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', 'z16ni', 'jai', 'dh5ogrgj', '8', 'yzt1afgogrit', 'sj3ayxp1q430');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('G', 't1__d6459d', 'f', 'foa', 'cd07z2zezjo7', 'wgxd5ysxcm', '0oztd');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('O', 't1__d6459d', 'zzbe8yvkv4', 'q7sx58b4', 'pmaus3auvmkr', 'pdjwzw5chn9', 'o705');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__f71ec6', 't1__d6459d', 'xuzkb52', 'gwnlas6', 'elboeowii1', '5nxih66', 'q2xlyoto');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('@', 'oa2sb3u', 'i1pa', 'cvwnyq', 'ouirl', 'rpouit63xyf', 'mjwpp2');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('?', '6dvdx', 'o', 'v7t3gvpl', '9fj', 'uun7k1', 'z2my1og');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('`', 'g', 'kxginl', '6id', 'p61l', 'o3ak162o', 'cagjeevxzxlu');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr', '13pyu');

-- Inserting into table: budget --
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t2__9e8eb9', 'Parking', 133.007885, 75.403642, -1209887326, 'klfa9000t', 't1__129b81');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t2__04527c', 'Parking', 827.854302, 983.124993, -1964997180, 'gce376nium52', 't1__129b81');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('A', 'Parking', 354.593207, 432.405958, 76996700, 'o72ctdc', 't1__129b81');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('Q', 'mfg62g0v5q8q', 53.966914, 153.511511, -1858644047, 'o22', '_');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('O', 'qs27p2r94', 99.674786, 796.553419, 333302050, 'najj', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('G', 'cl5ams', 665.099697, 270.763563, -605061107, 'gc1d', 't1__129b81');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t3__6434a7', 'Parking', 560.916337, 49.319338, 748154000, 'cgumbc', 't1__129b81');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('I', 'Parking', 885.125365, 507.185482, -438741674, '5rmkio18', 't2__f71ec6');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('@', 'mb3aj0ju0', 124.099574, 455.704717, 493701528, '33ir1axyyh', '@');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_10', 'Parking', 633.816798, 181.951966, 1361810968, 'esap8pgck', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('`', 'v1rgeza', 598.494048, 46.864581, -316078323, 'upg', '?');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_12', 'Parking', 652.131381, 526.310762, 139907579, 'txe', '_');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('B', '49kuboe8cd', 64.74848, 478.523041, 426006253, 'll', '`');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_14', 'Parking', 348.456963, 333.997675, 1201135348, '5v0eduy9v2z', 't1__129b81');

-- Inserting into table: expense --
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_1', 'v', 'ph2', 109.083092, 'dqwn', 'member_id_1', 't2__9e8eb9');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_2', 'x', '5hncprjtu0d', 395.809081, 'fjgq8n2f3', 'member_id_1', 't2__9e8eb9');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_3', 'jh3den8c68', '8vacx7', 854.793228, 'u5', 'member_id_1', 't2__9e8eb9');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_4', '7cvtjpt', 'tg6bnou5zi', 464.719657, '4', 'member_id_1', 'Q');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_5', '5i3', 'q5l', 811.930904, 'im5k', 'member_id_1', 't2__9e8eb9');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_6', '3', 'okv8uttmu2', 208.49371, '78lfvyz7', 'member_id_1', 'O');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_7', '9n0jxfofwsz', 'o', 778.650393, '2zobb0q0k32o', 'member_id_1', 't2__9e8eb9');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_8', '9erhizgk1yoe', 'o6l0hdt', 506.13059, 'uq', 'member_id_1', 'G');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_9', 'oaawg96aq', '0', 301.874779, 'indz39tajz', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('O', 'tdu6bd0w96', '3vzxw1r', 372.360229, '9y', 'member_id_1', 't3__6434a7');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('A', '7qk', '162nh55y3d', 602.631056, 'vu', 'member_id_1', 't3__6434a7');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_12', 'i2hy08ftp6', 'wt', 255.149792, 'njabym', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('_', 'n2mfx7h33p', '6sto1cj8sh5k', 207.572242, 'ys7dyyd', 'member_id_1', 't3__6434a7');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_14', 'gjac', '8q', 565.260711, 'a8y3a17v4yg', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('I', 'y', '3qdpu', 871.372603, '96rn', 'member_id_1', 't3__6434a7');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_16', 'hm5wl', 'c7d', NULL, 'n2np490xdms', 'member_id_1', 't2__9e8eb9');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_17', 'el', 'u', NULL, 'qb9i9f2ccu', 'member_id_1', 'O');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_18', 'q1q', 'ik1yhb', 414.619293, 'ls', 'member_id_1', 't2__9e8eb9');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_19', 'qomi', 'tvb6m4i', NULL, '78aqqlu', 'member_id_1', 'O');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_20', 'tb8r9114qbre', '6bjeuuwsj8k', NULL, 'h85', 'member_id_1', 't2__9e8eb9');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_21', 'xlvr', 'sur', 840.394555, '0kaqtnc', 'member_id_1', 't2__9e8eb9');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_22', 'b7v88kwd', 'dbdh', NULL, '6j47n', 'member_id_1', 't2__9e8eb9');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_23', '50hsj', 'an', NULL, 'xdpunmw', 'member_id_1', 'G');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_24', 'xqrlaw', '014', 274.827655, 'dqtsmg97aqz2', 'member_id_1', 't2__9e8eb9');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_25', '0pj6ddly', 'u6iph', 47.174746, 'u2gir31vwq5', 'member_id_1', 't2__9e8eb9');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('@', 'tsr54o', 'qjektb1d2', -1.0, 'zg3r', 'member_id_1', '@');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('B', 'wns', '47j2ja8dccy3', 0.0, 'vjwq49yrnx', 'member_id_1', 'budget_id_10');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('D', 'pe0', '19cy7od033d', 0.0, 'hds', 'member_id_1', '`');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('C', 'ed', '9lqv26u3', 0.5, '1spxpw30', 'member_id_1', 'G');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('G', '29835xoepa', 'cxdb2f0c296x', 0.0, 'yet', 'member_id_1', 'B');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('i', 'hcf', '6cfperxa', 0.5, '1sjv8nv3d', 'member_id_1', '@');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_name FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget WHERE T2.category = 'Parking' AND T3.cost < (SELECT AVG(cost) FROM expense);

/*
Gold Result:
('t1__d6459d',)
('t1__d6459d',)
('t1__d6459d',)
('t1__d6459d',)
('t1__d6459d',)
('t1__d6459d',)
('z16ni',)
*/

-- Prediction Query
SELECT e.event_name FROM event AS e JOIN budget AS b ON e.event_id = b.link_to_event WHERE b.category = 'Parking' AND b.spent < (SELECT AVG(spent) FROM budget WHERE category = 'Parking');

/*
Prediction Result:
('t1__d6459d',)
('t1__d6459d',)
('t1__d6459d',)
*/