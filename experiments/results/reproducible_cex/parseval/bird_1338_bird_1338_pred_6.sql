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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_1', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr', -2147483648, 'major_id_1');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__13773e', 'October Meeting', '2019-10-08', '5k5swwqcgs', '9n8', '4', 'gu7v');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__6807c6', 'October Meeting', '2019-10-08', 'yp5qi2rk', '9v', 'x58pz', 'f8jegd2');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('O', 'October Meeting', '2019-10-08', 'k3zbily', 'kn6vc', '6ah', 'f8jswwl');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', '7xb72', 'xa', '7ryfdrz16n', 'jja', '5dh', 'ogrgjd8y');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('E', 'October Meeting', '2019-10-08', '4', 'f', 'foa', 'cd07z2zezjo7');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__114c9b', 'October Meeting', '2019-10-08', '3', 'okv8uttmu2', 'e578', 'fvy');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('@', 'October Meeting', NULL, '5k5swwqcgs', '9n8', '4', 'gu7v');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('B', 'October Meeting', NULL, '5u', 'w6kl', 'a9', '00t5c4e');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('C', 'October Meeting', NULL, 'liqa1', 'ryytoo3', '9hl7', 'klex14ji');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('`', 'October Meeting', NULL, 'x58pz', 'f8jegd2', 'vy9uxj4', 'wb');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('F', 'October Meeting', NULL, 'qv0gcb98ozk', 'zbilyrkn', '6vck6ah0f8js', 'wlq7xb');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('D', 'October Meeting', NULL, 'ri', 'tsj3ayxp1q4', '01jh3den', 'c68x8vacx');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('K', 'October Meeting', NULL, 'ou5z', '36c', 'bfkfoacd', '7z2zezj');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('a', 'October Meeting', NULL, 'ajjl', '3', 'okv8uttmu2', 'e578');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', 'uzhsrwbbp6lu', 'hvdlttilbnpr', 'dpos');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'ie5', 'nw6klf', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof');

-- Inserting into table: budget --
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t2__f9672a', 'e4', 779.409124, 640.719621, 1160656988, 'ia2yp', 't1__13773e');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t2__70f151', 'vy9uxj4', 124.573829, 22.63964, -736979194, 'h2gn', 't1__13773e');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('O', 'sj3ay', 360.694313, 959.196496, 1792827279, '4301jh3den8', 't1__13773e');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('A', '68x8vacx7a', 983.924121, 313.653498, -47052816, '1of77pzo72c', 't1__13773e');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('_', 'dgj5i', 458.880538, 264.110281, -15162884, 'pim5', 't1__13773e');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t3__2fea5e', 'maus', 453.245856, 315.872992, -1278087274, 'rpdjwzw5ch', 't1__13773e');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('G', '5amsorlwyngc', 424.71131, 605.551549, 211603887, 'rhizgk1yoey', 't2__114c9b');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('@', 'e4', 779.409124, 640.719621, 1160656988, 'ia2yp', '@');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('H', 'cigce376nium', 779.28645, 566.030342, 742285925, 'u', 'B');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('B', '7zwau2dwyr', 262.105498, 591.461096, 2142703426, 'u78d99r', 'C');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('C', 'v', 185.427628, 243.480613, 1581736075, 'gndqwnqc', '`');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('b', '72fxa7ryfd', 276.61064, 399.319982, 564390026, '6nijjai5dh', 'F');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('c', 'afu5w1of7', 517.927187, 398.637058, 1992637800, 'dctmf', 'D');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('`', '7wgx', 50.798088, 486.564401, -915385605, 'm', 'K');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('F', 'fvy', 392.947196, 527.633597, -451030047, 'be8yvkv42q7', 'a');

-- Inserting into table: expense --
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_1', '13pyu', '8d99rljsl', 419.361606, 't3__beedeb', 'member_id_1', 't2__f9672a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('A', 'wnqcx', '5hncprjtu0d', 395.809081, 't3__beedeb', 'member_id_1', 't2__f9672a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('C', 'gq8', 'n2f3dqv0gcb9', 540.154414, 't3__beedeb', 'member_id_1', 't2__f9672a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_4', '1afgo', 'ri', 630.468925, 't3__beedeb', 'member_id_1', 't2__f9672a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_5', 'c', 'mfg62', 93.813527, 't3__beedeb', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_6', 'q8qdjpe1', 'o22', 518.274259, 't3__beedeb', 'member_id_1', 't2__f9672a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_7', '7cvtjpt', 'tg6bnou5zi', 464.719657, 't3__beedeb', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_8', 'xd', 'ysxcmr0o', 698.769833, 't3__beedeb', 'member_id_1', 't2__f9672a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_9', '8qs27p2r', '4gth2mnaj', 155.873695, 't3__beedeb', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_10', 'zzbe8yvkv', '42q7sx58b4', 710.005534, 't3__beedeb', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('O', 'mo705a9n0', 'xfo', 82.48091, 't3__beedeb', 'member_id_1', 't3__2fea5e');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_12', 'o', '2zobb0q0k32o', 57.929422, 't3__beedeb', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_13', 'l0hdt6fuq', 'xuzkb52', 435.41097, 't3__beedeb', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_14', 's', 'elboeowii', 437.428969, 't3__beedeb', 'member_id_1', 't2__f9672a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_15', 'xih6', '2q2xlyoto', 913.199755, 't3__beedeb', 'member_id_1', 't2__f9672a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_16', 'aawg96aqb0tb', 'indz39tajz', 560.916337, NULL, 'member_id_1', 't2__f9672a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('@', 'hsrwbbp', 'luhvdltti', 182.319045, 'nprmdposii', 'member_id_1', '@');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('B', 'nrqrofqy', '5s5b', 22.720462, '02eu', 'member_id_1', 'H');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('D', 'sl0', '4', 884.000446, 'p5qi2rkf9v', 'member_id_1', 'B');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('L', '5hncprjtu0d', '79fjgq8', 915.268032, '2f3d', 'member_id_1', 'C');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('J', 'grgj', '8', 740.059813, 'zt1afgo', 'member_id_1', 'b');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('M', '2g0v5q8qd', 'jpe1io22785', 993.555996, '7cvtjpttg6b', 'member_id_1', 'c');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('F', '0oztdgj5i3lq', '5lnpim5k58qs', 876.038555, '7p2r94gth2m', 'member_id_1', '`');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('c', '58b4pm', 'u', 771.198983, 'auvmkrpd', 'member_id_1', 'F');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.approved FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget WHERE T1.event_name = 'October Meeting' AND T1.event_date LIKE '2019-10-08%';

/*
Gold Result:
('t3__beedeb',)
('t3__beedeb',)
('t3__beedeb',)
('t3__beedeb',)
('t3__beedeb',)
('t3__beedeb',)
('t3__beedeb',)
('t3__beedeb',)
('t3__beedeb',)
('t3__beedeb',)
('t3__beedeb',)
('t3__beedeb',)
('t3__beedeb',)
('t3__beedeb',)
('t3__beedeb',)
(None,)
*/

-- Prediction Query
SELECT e.event_name, e.event_date, ex.approved FROM event AS e INNER JOIN budget AS b ON e.event_id = b.link_to_event INNER JOIN expense AS ex ON b.budget_id = ex.link_to_budget WHERE e.event_name = 'October Meeting' AND e.event_date = '2019-10-08';

/*
Prediction Result:
('October Meeting', '2019-10-08', 't3__beedeb')
('October Meeting', '2019-10-08', 't3__beedeb')
('October Meeting', '2019-10-08', 't3__beedeb')
('October Meeting', '2019-10-08', 't3__beedeb')
('October Meeting', '2019-10-08', 't3__beedeb')
('October Meeting', '2019-10-08', 't3__beedeb')
('October Meeting', '2019-10-08', 't3__beedeb')
('October Meeting', '2019-10-08', 't3__beedeb')
('October Meeting', '2019-10-08', 't3__beedeb')
('October Meeting', '2019-10-08', 't3__beedeb')
('October Meeting', '2019-10-08', 't3__beedeb')
('October Meeting', '2019-10-08', 't3__beedeb')
('October Meeting', '2019-10-08', 't3__beedeb')
('October Meeting', '2019-10-08', 't3__beedeb')
('October Meeting', '2019-10-08', 't3__beedeb')
('October Meeting', '2019-10-08', None)
*/