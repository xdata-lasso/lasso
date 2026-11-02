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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__ab331f', 't1__730cda', 't1__49a55a', 'bnp', 'mdpos', 'ie5', 'nw6klf', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__e6945b', 't1__730cda', 't1__49a55a', '00t5c4ecigc', 'e376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__b29f83', 't1__730cda', 't1__49a55a', 'tliqa1', 'ryytoo3', '9hl7', 'klex14ji', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', '!', 'A', 'n6vck6ah0f', 'jswwlq7xb', '72fxa7ryfd', 'z16ni', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', '!', 'A', 'i', 'dh5ogrgj', '8', 'yzt1afgogrit', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_4', '!', 'A', 'ayxp1q43', '1jh3den', 'c68x8vacx', 'afu5w1of7', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('E', '72ct', 'c', 'mfg62', '0v', 'q8qdjpe1', 'o22', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_8', 'P', '1', '0oztdgj5i3lq', '5lnpim5k58qs', '7p2r94gt', '2m', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('C', 'jla', 'okv8uttm', '2ne578', 'fvy', '7zzbe8y', 'kv42q7', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_10', '9', '!', 'hdt6fuq', 'xuzkb52', 'gwnlas6', 'elboeowii1', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('a', 'xih6', '2q2xlyoto', '9oaawg', '6aqb0tbin', 'z', '9tajz9td', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t2__8db7bd', 't1__730cda', 't1__49a55a', '5rmkio18', 'i2hy0', '8ftp6ewtqx', 'njabym', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('D', 't1__50d0ee', 't1__e320d3', 'swwqcgsk', '9n8c4pgu7v', 'e4', 'hria2ypuzhs', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('B', 't1__50d0ee', 't1__e320d3', 'b', 'p6luhvdlttil', 'n', 'rmdp', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_15', 'mem_7e9c57', 'mem_a7e91a', 'ie5', 'nw6klf', 'a9000t5c4eci', 'gce376nium52', -2147483648, 'major_id_1');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', '5k5swwqcgs', '9n8', '4');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti');

-- Inserting into table: income --
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_1', '7zwau2dwyr', -1021749117, 't2__45bb02', '3pyu78d99r', 't1__ab331f');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_2', 'jsl', -346339240, 't2__45bb02', 'yp5qi2rk', 't1__ab331f');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_3', '9v', 556727997, 't2__45bb02', '8pz0f8je', 't1__ab331f');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('C', '9uxj4hwbdvl', 2103044118, 't2__45bb02', 'h2gndqwnqcx5', 't1__ab331f');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('A', 'hncprjtu0dz', -1748371085, 't2__45bb02', 'q8', 't1__ab331f');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_4', 'n2f3dqv0gcb9', 172461907, 't2__45bb02', 'k3zbily', 't1__ab331f');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_7', '8507cvtjp', 0, 't2__45bb02', 'ttg6bnou5zi3', 'E');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_8', 'c4bfkfoac', -1, 't2__45bb02', '0', 'E');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_9', '7z2zezjo7wg', 1248858185, 't2__45bb02', '5', 'E');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_10', 'x58b4', 1, 't2__45bb02', 'pmaus3auvmkr', 'C');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_11', 'pdjwzw5chn9', 0, 't2__45bb02', 'o705', 'C');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_12', 'a9n0jxfofws', 1719800120, 't2__45bb02', 'o', 'C');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_13', '0k32o', 1, 't2__45bb02', 'w', '@');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_14', 'l', 0, 't2__45bb02', '5amsorlwyngc', '@');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_15', 'dj9erhi', 1056589776, 't2__45bb02', 'k1', '@');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_16', 'n5wcgumbc', 1, 't2__45bb02', '3tdu6bd0w960', 'a');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_17', 'vzxw1rxe', 0, 't2__45bb02', '9yfk7qk162n', 'a');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_18', '55', 2105860871, 't2__45bb02', 'dohvu06d', 'a');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('O', 'x7', -1659775598, 't2__45bb02', 'p6sto1cj', 't2__8db7bd');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_19', 'sh5knzys7', 1487347213, 't2__45bb02', 'yd1jmgj', 't2__8db7bd');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('_', '8y3a17v4yg', -2081662466, 't2__45bb02', '3qdpu', 't2__8db7bd');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_21', 'p', -845136979, 't2__45bb02', 'rhm5w', 't2__8db7bd');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('I', 'p490', -592014051, 't2__45bb02', 'sqtg', 't2__8db7bd');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_23', 'lc', -1025517017, 't2__45bb02', 'i9f2ccukj', 't2__8db7bd');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_25', 'yhb08hl', 1040753276, 't2__45bb02', 'pqomizt', 't2__8db7bd');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_26', 'lud8f', NULL, 't2__45bb02', 'tb8r9114qbre', 't1__ab331f');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_27', '6bjeuuwsj8k', NULL, 't2__45bb02', 'h85', 't1__ab331f');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_28', 'pxlvri', NULL, 't2__45bb02', 'surz0kaqtncg', 't1__ab331f');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_29', 'dmdbdh', NULL, 't2__45bb02', '6j47n', 't1__ab331f');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_30', 'ar50hs', NULL, 't2__45bb02', 'han', 't1__ab331f');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_31', 'xdpunmw', NULL, 't2__45bb02', 'wx', 't1__ab331f');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_32', '14r5dqt', NULL, 't2__45bb02', 'mg97a', 't1__ab331f');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_33', 'z2o20', NULL, 't2__45bb02', 'pj6ddlysu6ip', 't1__ab331f');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_34', 'dk', NULL, 't2__45bb02', 'u2gir31vwq5', 't1__ab331f');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_35', 'uoi1pavc', NULL, 't2__45bb02', 'wnyqro', 't1__ab331f');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_36', 'uirlrpouit', NULL, 't2__45bb02', '63xyfvmjwpp', 't1__ab331f');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_37', '6mb3aj0j', NULL, 't2__45bb02', '0h3r13', 't1__ab331f');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_38', 'yhpl2i9', NULL, 't2__45bb02', 'sa', 't1__ab331f');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_39', '8pgc', NULL, 't2__45bb02', 'qwt', 't1__ab331f');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_40', 'r54o6', NULL, 't2__45bb02', 'jektb', 't1__ab331f');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_41', '3rjkwns47j2j', NULL, 't2__45bb02', '8', 't1__ab331f');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_42', 'c', NULL, 't2__45bb02', 'y', 't1__ab331f');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_43', 'vjwq49yr', NULL, 't2__45bb02', 'nxs6dvdxdo2v', 't1__ab331f');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_44', '9fj', NULL, NULL, 'uun7k1', 't1__ab331f');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_45', 'z2my1og', NULL, NULL, 'v1rgeza', 't1__ab331f');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_46', 'xc1clupgly', NULL, NULL, '8oitxeilp', 't1__ab331f');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('P', 'zbuo4nrqrof', 3, 't2__7f406d', 'qyp5s5bbp0', 'D');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('@', 'eutliqa1', 2, 't2__7f406d', 'ryytoo3', 'a');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_49', 'hl72klex1', -74849714, 'inc_9a4a66', '7zw', 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.first_name, T1.last_name, T2.source FROM member AS T1 INNER JOIN income AS T2 ON T1.member_id = T2.link_to_member GROUP BY T1.first_name, T1.last_name, T2.source ORDER BY SUM(T2.amount) DESC, T1.first_name NULLS LAST, T1.last_name NULLS LAST, T2.source NULLS LAST LIMIT 1;

/*
Gold Result:
('xih6', '2q2xlyoto', 't2__45bb02')
*/

-- Prediction Query
SELECT member.first_name, member.last_name, income.source FROM income INNER JOIN member ON income.link_to_member = member.member_id ORDER BY income.amount DESC, income.income_id NULLS LAST, member.member_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('xih6', '2q2xlyoto', 't2__45bb02')
*/