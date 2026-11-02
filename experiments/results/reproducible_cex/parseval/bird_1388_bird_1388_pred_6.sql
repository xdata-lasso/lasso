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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__0a4021', 't1__f2eff5', 't1__c27ea4', 'bnp', 'mdpos', 'ie5', 'nw6klf', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__1bda30', 't1__f2eff5', 't1__c27ea4', '00t5c4ecigc', 'e376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__0b1ba5', 't1__f2eff5', 't1__c27ea4', 'tliqa1', 'ryytoo3', '9hl7', 'klex14ji', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('Q', 't1__f2eff5', 't1__c27ea4', '1vy9uxj4', 'wb', 'v', 'ph2', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 't1__f2eff5', 't1__c27ea4', 'q', 'nqcx5h', 'cprj', 'u0dz7', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('G', 't1__f2eff5', 't1__c27ea4', 'f8jswwl', '7xb72', 'xa', '7ryfdrz16n', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_6', 't1__f2eff5', 't1__c27ea4', '5dh', 'ogrgjd8y', 't1afgog', 'itsj3', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', 't1__f2eff5', 't1__c27ea4', 't', 'mfg62g0v5q8q', 'j', 'e1io', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_8', 't1__f2eff5', 't1__c27ea4', '7cvtjpttg6b', 'ou5z', '36c', 'bfkfoacd', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_10', 't1__f2eff5', 't1__c27ea4', '94gth', '2mnajjla3o', 'v8u', 'tmu2n', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_11', 't1__f2eff5', 't1__c27ea4', 'rpd', 'wzw', 'chn9mo70', 'a9n0jxfo', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_12', 't1__f2eff5', 't1__c27ea4', 'fuqyxuzkb', '521gwnlas6e', 'lboeowii1z5', 'xih6', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t2__b1235a', 't1__f2eff5', 't1__c27ea4', 'd0w9603vzxw1', 'xe9yf', '7qk', '162nh55y3d', -2147483648, 'major_id_1');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', '5k5swwqcgs', '9n8', '4');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti');

-- Inserting into table: income --
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_1', '7zwau2dwyr', -1021749117, 't2__f63fb8', '3pyu78d99r', 't1__0a4021');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_2', 'jsl', -346339240, 't2__f63fb8', 'yp5qi2rk', 't1__0a4021');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_3', '9v', 556727997, 't2__f63fb8', '8pz0f8je', 't1__0a4021');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('A', 'q8', -1255130038, 't2__f63fb8', '3d', 'Q');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('C', 'qv0gcb98ozk', -155284187, 't2__f63fb8', 'i', 'Q');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_4', 'yrk', 32204797, 't2__f63fb8', 'k', 'Q');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_7', 'y', 1, 't2__f63fb8', 'p1q430', 't1__1bda30');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_8', 'jh3den8', 0, 't2__f63fb8', 'c68x8vacx7', 't1__1bda30');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_9', 'f', -47052816, 't2__f63fb8', '1of77pzo72c', 't1__1bda30');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_10', '7z2zezj', 1, 't2__f63fb8', '7wgx', 't1__1bda30');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_11', '5', 0, 't2__f63fb8', 'sxcmr0o', 't1__1bda30');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_12', 'ztdgj5i3lq5l', 1339733032, 't2__f63fb8', 'im5k', 't1__1bda30');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_13', '57', 0, 't2__f63fb8', 'lfvyz7zzb', 't1__1bda30');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_14', '8y', -1, 't2__f63fb8', 'kv42q7', 't1__1bda30');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_15', 'x58b4', -1122409769, 't2__f63fb8', 'u', 't1__1bda30');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_16', 'ws', 1, 't2__f63fb8', 'do2zobb', 't1__1bda30');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_17', 'q0k32od', 0, 't2__f63fb8', 'cl5ams', 't1__1bda30');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_18', 'orlwyngc1dj', 211603887, 't2__f63fb8', 'rhizgk1yoey', 't1__1bda30');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_19', '2q2xlyoto', 0, 't2__f63fb8', '9oaawg', 't1__1bda30');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_20', '6aqb0tbin', -1, 't2__f63fb8', 'z', 't1__1bda30');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_21', '9tajz9td', 152478847, 't2__f63fb8', '5wcgumbc3td', 't1__1bda30');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('O', '6dza35r', 2072023304, 't2__f63fb8', 'io18ri2hy08', 't2__b1235a');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_22', 'tp', 24053253, 't2__f63fb8', 'tqxxnj', 't2__b1235a');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('I', 'mfx7h33p', 63063873, 't2__f63fb8', 'o1cj8', 't2__b1235a');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_24', 'h5knz', 1966809332, 't2__f63fb8', '7dyyd', 't2__b1235a');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_26', 'h', 1122899168, 't2__f63fb8', 'a17v4ygm', 't2__b1235a');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('G', 'uap9', 1291298007, 't2__f63fb8', 'tdqr', 't2__b1235a');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_27', 'm5', -648564084, 't2__f63fb8', 'c7d', 't2__b1235a');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_29', 'dmsqtg', -1872934808, 't2__f63fb8', 'u', 't2__b1235a');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_30', 'cukjq1quik1y', 0, 't2__f63fb8', 'hb08hlst1pq', 't1__0a4021');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_31', 'mizt', -1, 't2__f63fb8', 'vb6m4iz78aq', 't1__0a4021');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_32', 'lud8f', -835782528, 't2__f63fb8', 'r9114qbre', 't1__0a4021');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_33', 'j8kjh', 1, 't2__f63fb8', '5wpxlvris', 't1__0a4021');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_34', 'urz0kaqtncg', 0, 't2__f63fb8', 'c8s3b7v88k', 't1__0a4021');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_35', 'dmdbdh', 313797011, 't2__f63fb8', '7nxar50h', 't1__0a4021');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_36', 'dpunmw', 0, 't2__f63fb8', 'wx', 't1__0a4021');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_37', 'rlawk', -1, 't2__f63fb8', '14r5dqt', 't1__0a4021');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_38', 'mg97a', -1019350771, 't2__f63fb8', 'o20pj6dd', 't1__0a4021');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_39', 'dk', 2, 'W', 'u2gir31vwq5', 't1__0a4021');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_40', 'oa2sb3u', 2, 'W', 'i1pa', 't1__0a4021');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_41', 'cvwnyq', 3, 'A', 'ouirl', 't1__0a4021');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_42', '63xyfvmjwpp', 2, 'M', '6mb3aj0j', 't1__0a4021');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_43', '0h3r13', 2, 'M', 'ir1axyyh', 't1__0a4021');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_44', 'l2i9', 3, '1', 'sa', 't1__0a4021');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_45', 'tsr54o', 2, 'G', 'qjektb1d2', 't1__0a4021');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_46', 'zg3r', 2, 'G', 'jkwns47j2j', 't1__0a4021');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_47', '8', 3, 'A', 'c', 't1__0a4021');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_48', '49yrn', 2, 'G', 'xs6dvdxdo2', 't1__0a4021');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_49', '7t3gvp', 2, 'G', 'j9f', 't1__0a4021');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_50', 'vuu', 3, 'A', '7k10', 't1__0a4021');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_51', '1rgeza', NULL, 't2__f63fb8', 'xc1clupgly', 't1__0a4021');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_52', '8oitxeilp', NULL, 't2__f63fb8', 'e019cy7od0', 't1__0a4021');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_53', '3dlhdsvn', NULL, 't2__f63fb8', 'ed', 't1__0a4021');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_54', '331spxpw30bg', NULL, 't2__f63fb8', 'kxginl', 't1__0a4021');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_55', '6id', NULL, 't2__f63fb8', 'p61l', 't1__0a4021');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_56', 'o3ak162o', NULL, 't2__f63fb8', 'cagjeevxzxlu', 't1__0a4021');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_57', 'cde4uekhl', NULL, 't2__f63fb8', 'lbwvdpu5v0e', 't1__0a4021');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_58', 'u', NULL, 't2__f63fb8', 'y9v2z12983', 't1__0a4021');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_59', '5xoepacxdb2f', NULL, 't2__f63fb8', 'c296xiy', 't1__0a4021');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_60', '46', NULL, 't2__f63fb8', 'f', 't1__0a4021');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_61', 'perxa61sjv', NULL, 't2__f63fb8', 'nv3ddroku', 't1__0a4021');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_62', 'zc', NULL, 't2__f63fb8', 'ehia3', 't1__0a4021');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_63', '0', NULL, NULL, 'ffwor1', 't1__0a4021');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_64', 'sk', NULL, NULL, 'f9q82', 't1__0a4021');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_65', 'g01hu', NULL, NULL, 'j7f', 't1__0a4021');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_66', 'gm8gxb5qjl', NULL, 't2__f63fb8', 'awsp4', 't1__0a4021');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_67', 'wi3', NULL, 't2__f63fb8', 'l7', 't1__0a4021');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_68', 'j43y795ybv83', NULL, 't2__f63fb8', 'r3w', 't1__0a4021');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_69', '9xgjjacgmukf', NULL, 't2__f63fb8', '5', 't1__0a4021');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_70', 'f41', NULL, 't2__f63fb8', '80terbfokvee', 't1__0a4021');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_71', 'sltut6lu2', NULL, 't2__f63fb8', 'cel8mhfcim', 't1__0a4021');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.first_name, T1.last_name, T2.source FROM member AS T1 INNER JOIN income AS T2 ON T1.member_id = T2.link_to_member GROUP BY T1.first_name, T1.last_name, T2.source ORDER BY SUM(T2.amount) DESC, T1.first_name NULLS LAST, T1.last_name NULLS LAST, T2.source NULLS LAST LIMIT 1;

/*
Gold Result:
('t1__f2eff5', 't1__c27ea4', 't2__f63fb8')
*/

-- Prediction Query
SELECT "member"."first_name", "member"."last_name", "income"."source" FROM "member" INNER JOIN "income" ON "member"."member_id" = "income"."link_to_member" WHERE "income"."amount" = (SELECT MAX("amount") FROM "income" WHERE "income"."link_to_member" = "member"."member_id");

/*
Prediction Result:
('t1__f2eff5', 't1__c27ea4', 't2__f63fb8')
('t1__f2eff5', 't1__c27ea4', 't2__f63fb8')
('t1__f2eff5', 't1__c27ea4', 't2__f63fb8')
('t1__f2eff5', 't1__c27ea4', 't2__f63fb8')
*/