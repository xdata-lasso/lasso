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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__d912b7', 't1__366f19', 't1__747eca', 'bnp', 'mdpos', 'ie5', 'nw6klf', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__d649a0', 't1__366f19', 't1__747eca', '00t5c4ecigc', 'e376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__b147ab', 't1__366f19', 't1__747eca', 'tliqa1', 'ryytoo3', '9hl7', 'klex14ji', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 't1__366f19', 't1__747eca', 'y9uxj4', 'wb', 'v', 'ph2', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', '!', '!', 'i', 'yrk', 'n6vck6ah0f', 'jswwlq7xb', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('I', '!', '!', 'a7ryfd', 'z16ni', 'jai', 'dh5ogrgj', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_5', '!', '!', 't1afgog', 'itsj3', 'y', 'p1q430', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_8', '!', '!', '2278', '07cvtjpt', 'tg6bnou5zi', '6c4bfkfo', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_9', '"', '1', 'pim5', '58q', 's27p2r94gth2', 'najj', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('a', '"', '!', '58b4pmaus3a', 'vmkrpd', 'wzw', 'chn9mo70', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_10', '"', '!', 'xfo', 'ws', 'do2zobb', 'q0k32od', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t2__02d265', 't1__366f19', 't1__747eca', 'boeowii1z5nx', 'h66', 'q2xlyoto', '9oaawg', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_13', 'mem_7e9c57', 'mem_a7e91a', 'swwqcgsk', '9n8c4pgu7v', 'e4', 'hria2ypuzhs', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('B', 't1__2b6760', 't1__116f5b', 'b', 'p6luhvdlttil', 'n', 'rmdp', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('C', 't1__2b6760', 't1__116f5b', 'ie5', 'nw6klf', 'a9000t5c4eci', 'gce376nium52', -2147483648, 'major_id_1');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', '5k5swwqcgs', '9n8', '4');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti');

-- Inserting into table: income --
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_1', '7zwau2dwyr', -1021749117, 't2__ef2bd7', '3pyu78d99r', 't1__d912b7');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_2', 'jsl', -346339240, 't2__ef2bd7', 'yp5qi2rk', 't1__d912b7');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_3', '9v', 556727997, 't2__ef2bd7', '8pz0f8je', 't1__d912b7');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('A', 'q', -664193365, 't2__ef2bd7', 'cx5hn', 't1__d912b7');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('C', 'p', -988981234, 't2__ef2bd7', 'u0dz7', 't1__d912b7');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_4', 'fjgq8n2f3', 806170397, 't2__ef2bd7', 'qv0gcb98ozk', 't1__d912b7');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_7', 'jh3den8', 1, 't2__ef2bd7', 'c68x8vacx7', 'A');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_8', 'f', 0, 't2__ef2bd7', '5w1of7', 'A');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_9', 'pzo72ctdc', 1303877941, 't2__ef2bd7', 'mfg62g0v5q8q', 'A');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_10', 'c', 0, 't2__ef2bd7', '0', 'A');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_11', '7z2zezjo7wg', -1, 't2__ef2bd7', 'd5ysxc', 'A');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_12', 'r0oz', -870767087, 't2__ef2bd7', 'j5', 'A');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_13', 'a3o', 0, 't2__ef2bd7', 'v8u', 'A');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_14', 'tmu2n', -1, 't2__ef2bd7', '57', 'A');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_15', 'lfvyz7zzb', 924693315, 't2__ef2bd7', 'kv42q7', 'A');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_16', 'cl5ams', 0, 't2__ef2bd7', 'orlwyngc1dj', 'A');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_17', '9erhizgk1yoe', -1, 't2__ef2bd7', 'o6l0hdt', 'A');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_18', 'fuqyxuzkb', -30041412, 't2__ef2bd7', 'gwnlas6', 'A');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('_', 'bindz', 2085299664, 't2__ef2bd7', 'j', 't2__02d265');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_19', '9td8n5w', -1988582944, 't2__ef2bd7', 'mbc3td', 't2__02d265');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('G', 'vzxw1rxe', -505019168, 't2__ef2bd7', '7qk', 't2__02d265');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_21', '162nh55y3d', 440797047, 't2__ef2bd7', 'vu', 't2__02d265');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('O', 'rmkio18ri2', 1677948887, 't2__ef2bd7', 'y08ftp6ewt', 't2__02d265');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_23', 'xxnja', -2080232972, 't2__ef2bd7', 'mzn2mfx7h3', 't2__02d265');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_25', 'j', 1728926031, 't2__ef2bd7', 'knzys7dy', 't2__02d265');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_26', 'h', NULL, 't2__ef2bd7', 'qta8y3a17', 't1__d912b7');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_27', 'v4ygmayq3qdp', NULL, 't2__ef2bd7', 'uap96rntdqr', 't1__d912b7');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_28', 'm5', NULL, 't2__ef2bd7', 'wlic7dn2np', 't1__d912b7');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_29', 'tgelc', NULL, 't2__ef2bd7', 'qb9i9f', 't1__d912b7');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_30', 'ccukjq1q', NULL, 't2__ef2bd7', 'ik1yhb', 't1__d912b7');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_31', '8hlst1p', NULL, 't2__ef2bd7', 'qomiztvb6m', 't1__d912b7');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_32', 'ud8', NULL, 't2__ef2bd7', 'tb', 't1__d912b7');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_33', 'r9114qbre', NULL, 't2__ef2bd7', '6bjeuuwsj8k', 't1__d912b7');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_34', 'h85', NULL, 't2__ef2bd7', 'pxlvri', 't1__d912b7');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_35', 'q', NULL, 't2__ef2bd7', 'ncgc8', 't1__d912b7');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_36', '3b7v8', NULL, 't2__ef2bd7', 'kwdmdbdht', 't1__d912b7');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_37', 'j47nxar50', NULL, 't2__ef2bd7', 'sj', 't1__d912b7');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_38', 'punmwfwxqrl', NULL, 't2__ef2bd7', 'w', 't1__d912b7');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_39', '014', NULL, 't2__ef2bd7', '5dqts', 't1__d912b7');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_40', 'g97a', NULL, 't2__ef2bd7', 'z2o20', 't1__d912b7');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_41', 'u6iph', NULL, 't2__ef2bd7', 'k', 't1__d912b7');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_42', 'u2gir31vwq5', NULL, 't2__ef2bd7', 'oa2sb3u', 't1__d912b7');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_43', 'i1pa', NULL, 't2__ef2bd7', 'cvwnyq', 't1__d912b7');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_44', 'rpouit63xyf', NULL, NULL, 'mjwpp2', 't1__d912b7');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_45', 'mb3aj0ju0', NULL, NULL, '3r', 't1__d912b7');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_46', '133ir1axyy', NULL, NULL, 'hpl2i9esap', 't1__d912b7');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('!', 'zbuo4nrqrof', 3, 't2__bd041d', 'qyp5s5bbp0', 'C');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('@', 'eutliqa1', 2, 't2__bd041d', 'ryytoo3', 'member_id_10');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_49', 'hl72klex1', -74849714, 'inc_9a4a66', '7zw', 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.first_name, T1.last_name, T2.source FROM member AS T1 INNER JOIN income AS T2 ON T1.member_id = T2.link_to_member GROUP BY T1.first_name, T1.last_name, T2.source ORDER BY SUM(T2.amount) DESC, T1.first_name NULLS LAST, T1.last_name NULLS LAST, T2.source NULLS LAST LIMIT 1;

/*
Gold Result:
('t1__366f19', 't1__747eca', 't2__ef2bd7')
*/

-- Prediction Query
SELECT m.first_name, m.last_name, i.source FROM income AS i INNER JOIN member AS m ON i.link_to_member = m.member_id ORDER BY i.amount DESC, i.income_id NULLS LAST, m.member_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('t1__366f19', 't1__747eca', 't2__ef2bd7')
*/