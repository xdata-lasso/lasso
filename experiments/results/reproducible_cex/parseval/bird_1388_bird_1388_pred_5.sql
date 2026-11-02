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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__72bf86', 't1__87b1dc', 't1__644ad8', 'bnp', 'mdpos', 'ie5', 'nw6klf', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__3c6075', 't1__87b1dc', 't1__644ad8', '00t5c4ecigc', 'e376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__4a4390', 't1__87b1dc', 't1__644ad8', 'tliqa1', 'ryytoo3', '9hl7', 'klex14ji', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', '!', 't1__644ad8', 'n6vck6ah0f', 'jswwlq7xb', '72fxa7ryfd', 'z16ni', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_4', '!', 't1__644ad8', 'dh5ogrgj', '8', 'yzt1afgogrit', 'sj3ayxp1q430', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_6', '!', 't1__644ad8', '2278', '07cvtjpt', 'tg6bnou5zi', '6c4bfkfo', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_7', '!', 't1__644ad8', 'pim5', '58q', 's27p2r94gth2', 'najj', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_8', 'K', 't1__644ad8', 'aus3', 'u', 'mkrpdj', 'wzw5chn9mo70', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_9', 'C', 't1__644ad8', 'iz', 'k1', 'yoeyo6l0hdt6', 'uq', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t2__ece7ae', 't1__87b1dc', 't1__644ad8', 'bindz', '9tajz9td', 'n5wcgumbc', '3tdu6bd0w960', -2147483648, 'major_id_1');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', '5k5swwqcgs', '9n8', '4');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti');

-- Inserting into table: income --
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_1', '7zwau2dwyr', -1021749117, 't2__ecced2', '3pyu78d99r', 't1__72bf86');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_2', 'jsl', -346339240, 't2__ecced2', 'yp5qi2rk', 't1__72bf86');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_3', '9v', 556727997, 't2__ecced2', '8pz0f8je', 't1__72bf86');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('Q', '9uxj4hwbdvl', 2103044118, 't2__ecced2', 'h2gndqwnqcx5', 't1__72bf86');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('A', 'hncprjtu0dz', -1748371085, 't2__ecced2', 'q8', 't1__72bf86');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_4', 'n2f3dqv0gcb9', 172461907, 't2__ecced2', 'k3zbily', 't1__72bf86');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_7', 'jh3den8', 1, '@', 'c68x8vacx7', 't1__3c6075');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_8', 'f', 0, '@', '5w1of7', 't1__3c6075');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_9', 'pzo72ctdc', 1303877941, '@', 'mfg62g0v5q8q', 't1__3c6075');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_10', 'c', 0, '"', '0', 't1__3c6075');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_11', '7z2zezjo7wg', -1, '"', 'd5ysxc', 't1__3c6075');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_12', 'r0oz', -870767087, '"', 'j5', 't1__3c6075');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_13', 'a3o', 0, ')', 'v8u', 't1__3c6075');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_14', 'tmu2n', -1, ')', '57', 't1__3c6075');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_15', 'lfvyz7zzb', 924693315, ')', 'kv42q7', 't1__3c6075');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_16', 'a9n0jxfo', 1, '0', 'ws', 't1__3c6075');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_17', 'do2zobb', 0, '0', 'q0k32od', 't1__3c6075');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_18', 'cl5ams', 709097796, '0', 'lwyng', 't1__3c6075');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_19', 'xuzkb52', 1, ')', 'gwnlas6', 't1__3c6075');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_20', 'elboeowii1', 0, ')', '5nxih66', 't1__3c6075');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_21', 'q2xlyoto', 1774679448, ')', 'oaawg96aq', 't1__3c6075');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('O', '1rxe9y', -1046720861, 't2__ecced2', '162nh55y3d', 't2__ece7ae');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_22', 'ohvu06dza3', 1595632888, 't2__ecced2', 'mkio18ri2hy', 't2__ece7ae');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('I', 'qxxnj', 917362079, 't2__ecced2', 'mzn2mfx', 't2__ece7ae');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_24', 'h33p6sto1', -1971560508, 't2__ecced2', 'sh5knzys7', 't2__ece7ae');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_26', 'gjac', 973811121, 't2__ecced2', 'ta8y3a17v4', 't2__ece7ae');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_27', 'qdpuap96', 1291298007, 't2__ecced2', 'tdqr', 't2__ece7ae');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_28', '7', 899787662, 't2__ecced2', 'n2np490xdms', 't2__ece7ae');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_29', 'qb9i9f', 1, '$', 'ccukjq1q', 't1__72bf86');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_30', 'ik1yhb', 0, '$', '8hlst1p', 't1__72bf86');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_31', 'qomiztvb6m', -74691962, '$', '78aqqlu', 't1__72bf86');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_32', '4qbre6b', 1, '@', 'jeuuwsj8kj', 't1__72bf86');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_33', '85', 0, '@', 'pxlvri', 't1__72bf86');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_34', 'surz0kaqtncg', 428944759, '@', 's3b7v88kw', 't1__72bf86');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_35', '6j47n', 1, '1', 'ar50hs', 't1__72bf86');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_36', 'han', 0, '1', 'xdpunmw', 't1__72bf86');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_37', 'wx', -1040088060, '1', 'awk', 't1__72bf86');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_38', 'tsmg9', 2, 'O', 'aqz2o20pj', 't1__72bf86');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_39', 'ddlysu6ip', 2, 'O', 'dk', 't1__72bf86');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_40', 'u2gir31vwq5', 3, 'A', 'oa2sb3u', 't1__72bf86');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_41', 'v', 2, 'G', 'wnyqrouirlrp', 't1__72bf86');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_42', 'ouit63xyfvmj', 2, 'G', 'wpp26mb3aj0j', 't1__72bf86');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_43', '0h3r13', 3, 'A', 'ir1axyyh', 't1__72bf86');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_44', 'p', 2, 'G', 'pgckqwtsr', 't1__72bf86');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_45', '54o6qjektb1', 2, 'G', '2', 't1__72bf86');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_46', 'zg3r', 3, 'A', 'jkwns47j2j', 't1__72bf86');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_47', 'vjwq49yrnx', 2, 'G', '6dvdx', 't1__72bf86');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_48', 'o', 2, 'G', 'v7t3gvpl', 't1__72bf86');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_49', '9fj', 3, 'A', 'uun7k1', 't1__72bf86');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_50', 'gyv1', NULL, NULL, 'gezax', 't1__72bf86');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_51', '1', NULL, NULL, 'l', 't1__72bf86');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_52', 'upgly78oit', NULL, NULL, 'xeilpe019cy', 't1__72bf86');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_53', 'hds', NULL, 't2__ecced2', 'nhed29', 't1__72bf86');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_54', 'qv2', NULL, 't2__ecced2', 'u331spxpw', 't1__72bf86');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_55', '0bgwkxgi', NULL, 't2__ecced2', 'nlj6idmp61', 't1__72bf86');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_56', '62ocagj', NULL, 't2__ecced2', 'ev', 't1__72bf86');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_57', 'zxlu49', NULL, 't2__ecced2', 'ubo', 't1__72bf86');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_58', '8c', NULL, 't2__ecced2', 'e', 't1__72bf86');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_59', 'lbwvdpu5v0e', NULL, 't2__ecced2', 'u', 't1__72bf86');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_60', 'y9v2z12983', NULL, 't2__ecced2', '5xoepacxdb2f', 't1__72bf86');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_61', 'c296xiy', NULL, 't2__ecced2', 'et8xjhcf46c', 't1__72bf86');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_62', '1sjv8nv3d', NULL, 't2__ecced2', 'r', 't1__72bf86');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_63', 'kuez', NULL, 't2__ecced2', 'ctehia3cmvb', 't1__72bf86');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_64', '7vpc0xffwo', NULL, 't2__ecced2', '1esks', 't1__72bf86');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_65', 'huij7f8', NULL, 't2__ecced2', 'qhi', 't1__72bf86');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_66', 'u5gm8gxb5qj', NULL, 't2__ecced2', 'saw', 't1__72bf86');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_67', 'p4kwi', NULL, 't2__ecced2', 'hl7j43y7', 't1__72bf86');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_68', '3w4jn', NULL, 't2__ecced2', 'z19xgjja', 't1__72bf86');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_69', 'cgmukfb5if4', NULL, 't2__ecced2', '80terbf', 't1__72bf86');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_70', 'kvee', NULL, 't2__ecced2', 'sltut6lu2', 't1__72bf86');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.first_name, T1.last_name, T2.source FROM member AS T1 INNER JOIN income AS T2 ON T1.member_id = T2.link_to_member GROUP BY T1.first_name, T1.last_name, T2.source ORDER BY SUM(T2.amount) DESC, T1.first_name NULLS LAST, T1.last_name NULLS LAST, T2.source NULLS LAST LIMIT 1;

/*
Gold Result:
('t1__87b1dc', 't1__644ad8', ')')
*/

-- Prediction Query
SELECT member.first_name, member.last_name, income.source FROM income INNER JOIN member ON income.link_to_member = member.member_id WHERE income.amount = (SELECT MAX(amount) FROM income);

/*
Prediction Result:
('t1__87b1dc', 't1__644ad8', 't2__ecced2')
*/