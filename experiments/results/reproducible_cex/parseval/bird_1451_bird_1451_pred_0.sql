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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__a7b350', '13pyu', '8d99rljsl', 'b4yp5qi', 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('%', 'rjtu', 'dz79fjg', '8n2f3', 'dqv0gcb98ozk', 'zbilyrkn', '6vck6ah0f8js', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('d', '3ay', 'p1q430', 'jh3den8', 'c68x8vacx7', 'f', '5w1of7', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 'g', '5i3', 'q5l', 'pim5', '58q', 's27p2r94gth2', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('a', 'v42q7sx58b4p', 'aus3', 'u', 'mkrpdj', 'wzw5chn9mo70', 'a9n0jxfo', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('E', 'awg96aqb0tbi', 'ndz39tajz9', 'd8n5w', 'g', 'mbc3td', 'u6bd0w9603', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t2__0571ba', '5y3dohvu06d', 'a35rmki', '18ri', 'hy08ftp6', 'wt', 'xxnja', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__4ece89', 'pqomizt', 'vb6m4iz78aq', 'lud8f', 'tb8r9114qbre', '6bjeuuwsj8k', 'h85', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('C', 'lj9f', 'vuu', '7k10', 'z2my1ogyv1r', 'ez', 'x', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('M', 'l', 'upgly78oit', 'xeilpe019cy', 'od033dlhd', 'vnhed', '9lqv26u3', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('D', 'fqyp5s5bbp0', '2eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', '3pyu78d99r', 'jsl', 'b4yp5qi', 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4', -2147483648, 'major_id_1');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('@', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', 'rwbbp6luhvd', 'tti', 'bnp', 'mdpos', 'ie5', 'nw6klf');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('H', 'q8qdjpe1', 'o22', '8507cvtjp', 'ttg6bnou5zi3', 'c4bfkfoac', '0');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('D', 'cl5ams', 'orlwyngc1dj', '9erhizgk1yoe', 'o6l0hdt', 'fuqyxuzkb', '521gwnlas6e');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t4__1f7b91', 'cj8sh5k', 'zys7', 'y', 'yd1jmgjach8', 'qta8y3a17v4y', 'ma');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t3__779e86', 'q3qdpua', '96rn', 'dqrhm', 'wlic7dn2', 'p490', 'dmsqtg');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t3__eaef50', 'dmdbdh', '6j47n', 'ar50hs', 'han', 'xdpunmw', 'wx');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('B', 'rlawk', '14r5dqt', 'mg97a', 'z2o20', 'pj6ddlysu6ip', 'dk');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('!', 'u2gir31vwq5', 'oa2sb3u', 'i1pa', 'cvwnyq', 'ouirl', 'rpouit63xyf');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('C', 'mjwpp2', 'mb3aj0ju0', '3r', '133ir1axyy', 'hpl2i9esap', 'pgckqwtsr');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('G', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('F', 'rwbbp6luhvd', 'tti', 'bnp', 'mdpos', 'ie5', 'nw6klf');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', 'uo4nrqrofqy', '5s5b', 'p');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, '02eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr');

-- Inserting into table: budget --
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t1__a5ac0a', 'a9000t5c4eci', 734.586266, 767.720387, -1833165707, '6nium52zb', 'A');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t3__63d2d7', 'mzn2mfx', 522.859968, 789.571919, -156175571, '6sto', '@');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('?', '54o6qjektb1', 840.973378, 451.237024, 946571403, '3r', 'B');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('@', 'jkwns47j2j', 13.17027, 649.440889, -1881008758, 'y', '!');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('A', 'vjwq49yr', 736.293094, 606.851472, -583955995, '6dvdxdo2v7', 'C');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('B', '9', 877.276439, 627.258639, 947159877, '5c4ec', 'F');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('!', 'gce376nium52', 816.814398, 396.776796, 757448742, '4nrq', 'H');

-- Inserting into table: expense --
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_1', 'lph2gn', 'q', 0.0, 'nqcx5h', 't1__a7b350', 't1__a5ac0a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_2', 'wlq7xb', '72fxa7ryfd', -1.0, 'z16ni', '%', 't1__a5ac0a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_3', 'h5ogrgjd8yz', '1afgo', 0.5, 'ri', 't1__a7b350', 't1__a5ac0a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_4', 'pzo72ctdc', 'mfg62', 0.0, '0v', 'd', 't1__a5ac0a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_5', '7wgx', '5', 0.5, 'sxcmr0o', 't1__a7b350', 't1__a5ac0a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_6', 'najj', 'a3o', 0.0, 'v8u', 'A', 't1__a5ac0a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_7', '57', 'lfvyz7zzb', 0.5, '8y', 't1__a7b350', 't1__a5ac0a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_8', 'ws', 'do2zobb', 0.0, 'q0k32od', 'a', 't1__a5ac0a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_9', 'i1z', 'nxih662q', 0.5, 'xlyotow9', 't1__a7b350', 't1__a5ac0a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_10', 'vzxw1rxe9y', 'k7', 0.0, 'k162n', 'E', 't1__a5ac0a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_11', 'i9f2ccukj', '1quik', NULL, 'yhb08hl', 't1__a7b350', 't1__a5ac0a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_12', 'pxlvri', 'surz0kaqtncg', NULL, 'c8s3b7v88k', 't1__4ece89', 't1__a5ac0a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('@', '1spxpw30', 'g', 358.454959, 'xginlj6idm', 'C', '?');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('A', '61l2', 'o3ak162ocagj', 816.974484, 'vx', 'M', '@');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('C', 'xlu49ku', 'o', 66.494394, 'cde4uekhllbw', 'M', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_16', 'dpu5v0', 'du', 594.359145, '9v2z129', 't1__a7b350', 't1__a5ac0a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('B', 'd', 'lph2gn', 2.0, 'q', 't1__a7b350', 't1__a5ac0a');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('D', 'cx5hn', 'p', 3.0, 'jtu0d', 'A', '?');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.member_id FROM expense AS T1 INNER JOIN member AS T2 ON T1.link_to_member = T2.member_id INNER JOIN budget AS T3 ON T1.link_to_budget = T3.budget_id INNER JOIN event AS T4 ON T3.link_to_event = T4.event_id GROUP BY T2.member_id HAVING COUNT(DISTINCT T4.event_id) > 1 ORDER BY SUM(T1.cost) DESC, T2.member_id NULLS LAST LIMIT 1;

/*
Gold Result:
('M',)
*/

-- Prediction Query
SELECT T1.first_name, T1.last_name FROM member AS T1 INNER JOIN (SELECT T2.link_to_member, SUM(T2.cost) AS total_cost FROM expense AS T2 INNER JOIN budget AS T3 ON T2.link_to_budget = T3.budget_id GROUP BY T2.link_to_member HAVING COUNT(DISTINCT T3.link_to_event) > 1) AS T4 ON T1.member_id = T4.link_to_member ORDER BY T4.total_cost DESC, T1.member_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('l', 'upgly78oit')
*/