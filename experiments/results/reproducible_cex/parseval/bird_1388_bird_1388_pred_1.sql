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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__fa8f24', 't1__aedc70', 't1__a020d0', 'bnp', 'mdpos', 'ie5', 'nw6klf', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__1eca0b', 't1__aedc70', 't1__a020d0', '00t5c4ecigc', 'e376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__bcc240', 't1__aedc70', 't1__a020d0', 'tliqa1', 'ryytoo3', '9hl7', 'klex14ji', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 'A', 'Q', 'n6vck6ah0f', 'jswwlq7xb', '72fxa7ryfd', 'z16ni', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 'A', 'Q', 'i', 'dh5ogrgj', '8', 'yzt1afgogrit', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_4', 'A', 'Q', 'ayxp1q43', '1jh3den', 'c68x8vacx', 'afu5w1of7', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_7', '!', '!', '36c', 'bfkfoacd', '7z2zezj', '7wgx', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('Q', 'sxcmr0o', 'ztdgj5i3lq5l', 'pim5', '58q', 's27p2r94gth2', 'najj', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_9', 'D', 'A', 'aus3', 'u', 'mkrpdj', 'wzw5chn9mo70', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('I', '9n0jxfofwsz', 'o', '2zobb0q0k32o', 'w', 'l', '5amsorlwyngc', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('!', 'A', '!', 'xlyotow9', 'aawg', '6aqb0tbin', 'z', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t2__be0c32', 't1__aedc70', 't1__a020d0', '162nh55y3d', 'ohvu06dza3', 'rmkio18r', 'i2hy08ftp6', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_13', 'mem_7e9c57', 'mem_a7e91a', 'swwqcgsk', '9n8c4pgu7v', 'e4', 'hria2ypuzhs', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('F', 't1__20bba8', 't1__586fc5', 'b', 'p6luhvdlttil', 'n', 'rmdp', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('B', 't1__20bba8', 't1__586fc5', 'ie5', 'nw6klf', 'a9000t5c4eci', 'gce376nium52', -2147483648, 'major_id_1');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', '5k5swwqcgs', '9n8', '4');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti');

-- Inserting into table: income --
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_1', '7zwau2dwyr', -1021749117, 't2__0945f9', '3pyu78d99r', 't1__fa8f24');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_2', 'jsl', -346339240, 't2__0945f9', 'yp5qi2rk', 't1__fa8f24');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_3', '9v', 556727997, 't2__0945f9', '8pz0f8je', 't1__fa8f24');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('A', '9uxj4hwbdvl', 2103044118, 't2__0945f9', 'h2gndqwnqcx5', 't1__fa8f24');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('C', 'hncprjtu0dz', -1748371085, 't2__0945f9', 'q8', 't1__fa8f24');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_4', 'n2f3dqv0gcb9', 172461907, 't2__0945f9', 'k3zbily', 't1__fa8f24');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_7', 'pzo72ctdc', 0, '!', 'mfg62', '@');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_8', '0v', -1, '!', 'q8qdjpe1', '@');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_9', 'o22', 2004147439, '!', 'tjpttg', '@');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_10', 'a3o', 0, '3', 'v8u', 'Q');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_11', 'tmu2n', -1, '3', '57', 'Q');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_12', 'lfvyz7zzb', 924693315, '3', 'kv42q7', 'Q');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_13', 'dj9erhi', 1, '1', 'zgk1yoeyo6l0', 'I');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_14', 'dt', 0, '1', 'fuqyxuzkb', 'I');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_15', '521gwnlas6e', 1468640756, '1', 'boeowii1z5nx', 'I');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_16', 'j', 0, 'A', '9td8n5w', '@');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_17', 'g', -1, 'A', 'mbc3td', '@');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_18', 'u6bd0w9603', -541917667, 'A', 'rxe9yfk', '@');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('_', 'xnjaby', 462225708, 't2__0945f9', 'n2mfx7h', 't2__be0c32');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_19', '3p6sto1c', 170892881, 't2__0945f9', '5k', 't2__be0c32');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('G', 'yd1jmgjach8', 973811121, 't2__0945f9', 'ta8y3a17v4', 't2__be0c32');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_21', 'ygmayq3qdpu', 1595033206, 't2__0945f9', '96rn', 't2__be0c32');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('O', 'wlic7dn2', 1409697108, 't2__0945f9', 'p490xdmsqt', 't2__be0c32');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_23', 'el', -1974774786, 't2__0945f9', 'qb9i9f2ccu', 't2__be0c32');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_25', 'k1y', 775289854, 't2__0945f9', '0', 't2__be0c32');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_26', 'iztv', NULL, 't2__0945f9', '6', 't1__fa8f24');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_27', '4iz7', NULL, 't2__0945f9', 'aqqlud8ft', 't1__fa8f24');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_28', '8', NULL, 't2__0945f9', '9114q', 't1__fa8f24');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_29', 'uuwsj8kjh8', NULL, 't2__0945f9', 'wpxlvris', 't1__fa8f24');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_30', 'urz0kaqtncg', NULL, 't2__0945f9', 'c8s3b7v88k', 't1__fa8f24');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_31', 'dmdbdh', NULL, 't2__0945f9', '6j47n', 't1__fa8f24');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_32', 'sjhanzxdpu', NULL, 't2__0945f9', 'mwfw', 't1__fa8f24');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_33', 'qrlawk', NULL, 't2__0945f9', '14r5dqt', 't1__fa8f24');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_34', 'mg97a', NULL, 't2__0945f9', 'z2o20', 't1__fa8f24');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_35', 'u6iph', NULL, 't2__0945f9', 'k', 't1__fa8f24');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_36', 'u2gir31vwq5', NULL, 't2__0945f9', 'oa2sb3u', 't1__fa8f24');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_37', 'i1pa', NULL, 't2__0945f9', 'cvwnyq', 't1__fa8f24');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_38', 'rpouit63xyf', NULL, NULL, 'mjwpp2', 't1__fa8f24');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_39', 'mb3aj0ju0', NULL, NULL, '3r', 't1__fa8f24');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_40', '133ir1axyy', NULL, NULL, 'hpl2i9esap', 't1__fa8f24');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_41', 'sr54o', NULL, 't2__0945f9', 'qjektb1d2', 't1__fa8f24');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_42', 'zg3r', NULL, 't2__0945f9', 'jkwns47j2j', 't1__fa8f24');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_43', '8', NULL, 't2__0945f9', 'c', 't1__fa8f24');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_44', '49yrn', NULL, 't2__0945f9', 'xs6dvdxdo2', 't1__fa8f24');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_45', '7t3gvp', NULL, 't2__0945f9', 'j9f', 't1__fa8f24');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_46', 'vuu', NULL, 't2__0945f9', '7k10', 't1__fa8f24');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('@', 'zbuo4nrqrof', 3, 't2__43dc82', 'qyp5s5bbp0', 'B');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('B', 'eutliqa1', 2, 't2__43dc82', 'ryytoo3', '!');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_49', 'hl72klex1', -74849714, 'inc_9a4a66', '7zw', 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.first_name, T1.last_name, T2.source FROM member AS T1 INNER JOIN income AS T2 ON T1.member_id = T2.link_to_member GROUP BY T1.first_name, T1.last_name, T2.source ORDER BY SUM(T2.amount) DESC, T1.first_name NULLS LAST, T1.last_name NULLS LAST, T2.source NULLS LAST LIMIT 1;

/*
Gold Result:
('t1__aedc70', 't1__a020d0', 't2__0945f9')
*/

-- Prediction Query
SELECT T2.first_name, T2.last_name, T1.source FROM income AS T1 INNER JOIN member AS T2 ON T1.link_to_member = T2.member_id ORDER BY T1.amount DESC, T1.income_id NULLS LAST, T2.member_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('t1__aedc70', 't1__a020d0', 't2__0945f9')
*/