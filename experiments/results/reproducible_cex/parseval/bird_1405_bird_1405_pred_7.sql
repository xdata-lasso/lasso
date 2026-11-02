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
-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__dd2137', 'April Speaker', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__ec434d', 'April Speaker', 'uzhsrwbbp6lu', 'hvdlttilbnpr', 'dpos', 'ie5', 'nw6klf');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('!', 'April Speaker', 'rofqyp5s5b', 'p', '02eutliqa11r', 'ytoo3o9', 'l7');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('a', 'April Speaker', 'klex14ji', '7zwau2dwyr', '13pyu', '8d99rljsl', 'b4yp5qi');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('@', 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4', 'wb', 'v', 'ph2');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('9', 'April Speaker', 'z', '9fjgq8n2f', 'dqv0gcb9', 'ozk3zbily', 'kn6vc');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('U', 'April Speaker', 'xb72fxa7r', 'fdrz16n', 'jja', '5dh', 'ogrgjd8y');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('u', 'April Speaker', 't1afgog', 'itsj3', 'y', 'p1q430', 'jh3den8');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('(', 'April Speaker', 'w1of77pz', '72ct', 'c', 'mfg62', '0v');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('1', 'April Speaker', 'q8qdjpe1', 'o22', '8507cvtjp', 'ttg6bnou5zi3', 'c4bfkfoac');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', 'April Speaker', 'xd', 'ysxcmr0o', 'ztdgj5i3lq5l', 'pim5', '58q');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__37e856', 'April Speaker', 's27p2r94gth2', 'najj', 'a3o', 'v8u', 'tmu2n');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('C', 'April Speaker', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('E', 'April Speaker', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'bnp', 'mdpos');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('B', NULL, '4nrq', 'rofqyp5s5b', 'p', '02eutliqa11r', 'ytoo3o9');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('"', 'April Speaker', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('D', 'April Speaker', 'luhvdltti', 'bnp', 'mdpos', 'ie5', 'nw6klf');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('`', 'April Speaker', 'uo4nrqrofqy', '5s5b', 'p', '02eutliqa11r', 'ytoo3o9');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('$', 'April Speaker', 'yrq13p', 'u78d99r', 'jsl', 'b4yp5qi', 'rkf9vqx5');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('e', 'April Speaker', 'lph2gn', 'q', 'nqcx5h', 'cprj', 'u0dz7');

-- Inserting into table: budget --
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t2__084eb2', 't2__9a71d5', 779.409124, 640.719621, 1160656988, 'ia2yp', 't1__dd2137');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('A', 't2__9a71d5', 741.842896, 587.783596, 1419861592, '4ecigce376n', 't1__dd2137');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('C', 't2__9a71d5', 805.746877, 322.782838, 283598170, 'zbuo4nrq', 't1__dd2137');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('!', 't2__9a71d5', 109.083092, 802.414724, 0, 'q', '@');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('$', 't2__1cac59', 345.35543, 250.856497, 1, 'x5hncprjtu0', '@');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('a', 't2__1cac59', 915.583344, 508.771546, 1, 'h0f8jswwlq', '@');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES (')', 't2__9a71d5', 596.764785, 46.611179, 0, '68x8vacx7afu', '@');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('3', 't2__1cac59', 60.937725, 413.382111, 0, 'z2zezjo7w', '@');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('O', 't2__9a71d5', 76.823924, 572.833475, -1402164108, 'yz7zzb', 't2__37e856');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t2__ef02d2', 't2__1cac59', 70.267562, 715.296942, -705922211, 'v42q7sx58b4p', 't2__37e856');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('G', 't2__9a71d5', 199.318647, 841.241836, 319284352, '3auvm', 't2__37e856');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('_', 't2__9a71d5', 160.717227, 564.003268, 609771851, 'j', 't2__37e856');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('d', 'e5u', 933.422701, 345.718563, 1, 'klfa9000t', '!');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('@', 'c4ecigce', 467.07027, 875.837169, 1, 'nium52zbu', 'E');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('B', 'l7', 443.457804, 774.422647, -1390245819, 'x14ji7zwau2d', 'B');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('J', 'hria2ypuzhs', 663.049759, 711.020062, 1908028688, 'p', '"');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('`', 'a9000t5c4eci', 734.586266, 767.720387, -1833165707, '6nium52zb', 'D');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('D', 'l7', 443.457804, 774.422647, -1390245819, 'x14ji7zwau2d', '`');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('E', 'pz0f8jegd', 452.27611, 434.003102, 233994589, 'j4hwbd', '$');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('b', 'fjgq8n2f3', 687.701166, 656.638403, 513454646, '0gcb98', 'e');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(T2.amount), T2.category FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event WHERE T1.event_name = 'April Speaker' ORDER BY T2.amount, T1.event_id NULLS LAST, T2.budget_id NULLS LAST;

/*
Gold Result:
(1117153033, 't2__9a71d5')
*/

-- Prediction Query
SELECT SUM(b.amount) AS total_budget, b.category FROM budget AS b INNER JOIN event AS e ON b.link_to_event = e.event_id WHERE e.event_name = 'April Speaker' GROUP BY b.category ORDER BY b.amount ASC, total_budget NULLS LAST, b.category NULLS LAST;

/*
Prediction Result:
(-1833165707, 'a9000t5c4eci')
(-1390245819, 'l7')
(-705922211, 't2__1cac59')
(1, 'c4ecigce')
(1, 'e5u')
(233994589, 'pz0f8jegd')
(513454646, 'fjgq8n2f3')
(2391008845, 't2__9a71d5')
(1908028688, 'hria2ypuzhs')
*/