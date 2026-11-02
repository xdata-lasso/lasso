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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__92322d', 'October Meeting', '2019-10-08', '5k5swwqcgs', '9n8', '4', 'gu7v');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__730736', 'October Meeting', '2019-10-08', 'yp5qi2rk', '9v', 'x58pz', 'f8jegd2');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', 'October Meeting', '2019-10-08', 'k3zbily', 'kn6vc', '6ah', 'f8jswwl');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('O', '7xb72', 'xa', '7ryfdrz16n', 'jja', '5dh', 'ogrgjd8y');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__9bdfa1', 'October Meeting', '2019-10-08', '7p2r94gth2m', 'ajjl', '3', 'okv8uttmu2');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('@', 'October Meeting', NULL, '5k5swwqcgs', '9n8', '4', 'gu7v');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('B', 'October Meeting', NULL, '5u', 'w6kl', 'a9', '00t5c4e');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('!', 'October Meeting', NULL, 'liqa1', 'ryytoo3', '9hl7', 'klex14ji');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('C', 'October Meeting', NULL, 'x58pz', 'f8jegd2', 'vy9uxj4', 'wb');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('H', 'October Meeting', NULL, 'qv0gcb98ozk', 'zbilyrkn', '6vck6ah0f8js', 'wlq7xb');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('D', 'October Meeting', NULL, 'ri', 'tsj3ayxp1q4', '01jh3den', 'c68x8vacx');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('F', 'October Meeting', NULL, 'ou5z', '36c', 'bfkfoacd', '7z2zezj');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('b', 'October Meeting', NULL, 'ajjl', '3', 'okv8uttmu2', 'e578');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', 'uzhsrwbbp6lu', 'hvdlttilbnpr', 'dpos');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'ie5', 'nw6klf', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof');

-- Inserting into table: budget --
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t2__8fa234', 'e4', 779.409124, 640.719621, 1160656988, 'ia2yp', 't1__92322d');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t2__26d07f', 'vy9uxj4', 124.573829, 22.63964, -736979194, 'h2gn', 't1__92322d');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('O', 'sj3ay', 360.694313, 959.196496, 1792827279, '4301jh3den8', 't1__92322d');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('A', '68x8vacx7a', 983.924121, 313.653498, -47052816, '1of77pzo72c', 't1__92322d');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('_', '07cvtjpt', 605.666938, 107.390057, 1467355421, 'ou5z', 't1__92322d');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('G', 'e578', 944.379011, 86.586744, 697257217, '7zzbe8y', 't2__9bdfa1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t3__d28b04', 'pmaus3au', 337.117577, 160.717227, 274891948, 'pdjwzw5chn9', 't1__92322d');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('@', 'e4', 779.409124, 640.719621, 1160656988, 'ia2yp', '@');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('B', 'cigce376nium', 779.28645, 566.030342, 742285925, 'u', 'B');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('H', '7zwau2dwyr', 262.105498, 591.461096, 2142703426, 'u78d99r', '!');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('D', 'v', 185.427628, 243.480613, 1581736075, 'gndqwnqc', 'C');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('!', '72fxa7ryfd', 276.61064, 399.319982, 564390026, '6nijjai5dh', 'H');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('C', 'afu5w1of7', 517.927187, 398.637058, 1992637800, 'dctmf', 'D');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('L', '7wgx', 50.798088, 486.564401, -915385605, 'm', 'F');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('d', 'fvy', 392.947196, 527.633597, -451030047, 'be8yvkv42q7', 'b');

-- Inserting into table: expense --
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_1', '13pyu', '8d99rljsl', 419.361606, 't3__30dade', 'member_id_1', 't2__8fa234');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('A', 'wnqcx', '5hncprjtu0d', 395.809081, 't3__30dade', 'member_id_1', 't2__8fa234');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('C', 'gq8', 'n2f3dqv0gcb9', 540.154414, 't3__30dade', 'member_id_1', 't2__8fa234');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_4', '1afgo', 'ri', 630.468925, 't3__30dade', 'member_id_1', 't2__8fa234');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_5', 'c', 'mfg62', 93.813527, 't3__30dade', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_6', 'q8qdjpe1', 'o22', 518.274259, 't3__30dade', 'member_id_1', 't2__8fa234');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_7', '6c4bfkfo', 'c', 60.937725, 't3__30dade', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_8', '7z2zezjo7wg', 'd5ysxc', 187.71278, 't3__30dade', 'member_id_1', 't2__8fa234');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_9', '0oztdgj5i3lq', '5lnpim5k58qs', 876.038555, 't3__30dade', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_10', 'v42', '7sx58', 682.232894, 't3__30dade', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('O', 'o705a9n0jxfo', 'ws', 900.422166, 't3__30dade', 'member_id_1', 't3__d28b04');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_12', '2zobb0q0k32o', 'w', 38.169466, 't3__30dade', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('G', '5amsorlwyngc', 'dj9erhi', 746.006477, 't3__30dade', 'member_id_1', 't3__d28b04');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_14', 'yoeyo6l', 'hdt6fuq', 801.297876, 't3__30dade', 'member_id_1', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_15', 'b52', 'gwnlas6', 907.723998, 't3__30dade', 'member_id_1', 't2__8fa234');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_16', 'lboeowii1z5', 'xih6', 946.669761, 't3__30dade', 'member_id_1', 't2__8fa234');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_17', 'xlyotow9', 'aawg', 555.75468, NULL, 'member_id_1', 't2__8fa234');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('@', 'hsrwbbp', 'luhvdltti', 182.319045, 'nprmdposii', 'member_id_1', '@');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('B', 'nrqrofqy', '5s5b', 22.720462, '02eu', 'member_id_1', 'B');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('`', 'sl0', '4', 884.000446, 'p5qi2rkf9v', 'member_id_1', 'H');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('"', '5hncprjtu0d', '79fjgq8', 915.268032, '2f3d', 'member_id_1', 'D');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('b', 'grgj', '8', 740.059813, 'zt1afgo', 'member_id_1', '!');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('D', '2g0v5q8qd', 'jpe1io22785', 993.555996, '7cvtjpttg6b', 'member_id_1', 'C');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('F', '0oztdgj5i3lq', '5lnpim5k58qs', 876.038555, '7p2r94gth2m', 'member_id_1', 'L');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('a', '58b4pm', 'u', 771.198983, 'auvmkrpd', 'member_id_1', 'd');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.approved FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget WHERE T1.event_name = 'October Meeting' AND T1.event_date LIKE '2019-10-08%';

/*
Gold Result:
('t3__30dade',)
('t3__30dade',)
('t3__30dade',)
('t3__30dade',)
('t3__30dade',)
('t3__30dade',)
('t3__30dade',)
('t3__30dade',)
('t3__30dade',)
('t3__30dade',)
('t3__30dade',)
('t3__30dade',)
('t3__30dade',)
('t3__30dade',)
('t3__30dade',)
('t3__30dade',)
(None,)
*/

-- Prediction Query
SELECT CASE WHEN expense.approved = 'true' THEN 'Approved' ELSE 'Not Approved' END AS is_expense_approved FROM event INNER JOIN budget ON event.event_id = budget.link_to_event INNER JOIN expense ON budget.budget_id = expense.link_to_budget WHERE event.event_name = 'October Meeting' AND expense.expense_date = '2019-10-08';

/*
Prediction Result:
*/