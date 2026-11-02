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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_1', 'tti', 'bnp', 'mdpos', 'ie5', 'nw6klf', 'a9000t5c4eci', -2147483648, 't1__7e9a51');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_2', 'ytoo3o9hl7', 'klex14ji', '7zwau2dwyr', '13pyu', '8d99rljsl', 'b4yp5qi', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_3', 'bdvlph', 'gndqwnqc', 'x5hncprjtu0', 'z', '9fjgq8n2f', 'dqv0gcb9', -2147483648, 'C');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_4', 'k3zbily', 'kn6vc', '6ah', 'f8jswwl', '7xb72', 'xa', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_5', 'dh5ogrgj', '8', 'yzt1afgogrit', 'sj3ayxp1q430', 'jh3den8', 'c68x8vacx7', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_6', 'u5', '1of77p', 'o72ctdc', 'mfg62', '0v', 'q8qdjpe1', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_7', '2278', '07cvtjpt', 'tg6bnou5zi', '6c4bfkfo', 'c', '0', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('Q', 'zezjo7wg', 'd5ysxc', 'r0oz', 'dgj5i', 'lq5lnpim', 'k58qs27p', -2147483648, 't1__7e9a51');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', '94gth', '2mnajjla3o', 'v8u', 'tmu2n', '57', 'lfvyz7zzb', -2147483648, 't1__7e9a51');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('I', 'yvkv42q7s', '58b4pm', 'u', '3auvm', 'rpd', 'wzw', -2147483648, 't1__7e9a51');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('_', 'n9', 'o705', 'a9n0jxfofws', 'do2zobb', 'q0k32od', 'cl5ams', -2147483648, 't1__7e9a51');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('G', 'wyn', 'gc1dj9erhi', 'zgk1yoeyo6l0', 'dt', 'fuqyxuzkb', '521gwnlas6e', -2147483648, 't1__7e9a51');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_13', 'oaawg96aq', '0', 'bindz', '9tajz9td', 'n5wcgumbc', '3tdu6bd0w960', -2147483648, 't1__7e9a51');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 'pgu7vfe4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'bnp', 'mdpos', -2147483648, 't1__7e9a51');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('P', '5u', 'w6kl', 'a9', '00t5c4e', 'cigce376nium', '52zbuo4nrq', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('B', 'ia2yp', 'uzhsrwbbp6lu', 'hvdlttilbnpr', 'dpos', 'ie5', 'nw6klf', -2147483648, 'J');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('C', 'ytoo3o9hl7', 'klex14ji', '7zwau2dwyr', '13pyu', '8d99rljsl', 'b4yp5qi', -2147483648, 'D');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('#', 'h2gn', 'q', 'nqcx5h', 'cprj', 'u0dz7', 'fjgq8n2f3', -2147483648, '`');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('b', 'z16nijjai5d', 'h5ogrgjd8yz', '1afgo', 'ri', 'tsj3ayxp1q4', '01jh3den', -2147483648, 'a');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('D', 'q8qdjpe1io22', '8507cvtjp', 'ttg6bnou5zi3', 'c4bfkfoac', '0', '7z2zezjo7wg', -2147483648, '!');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('H', '94gth', '2mnajjla3o', 'v8u', 'tmu2n', '57', 'lfvyz7zzb', -2147483648, 'K');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t1__7e9a51', '5k5swwqcgs', '9n8', 't2__b90836');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('A', 'gce376nium52', 'zbuo4nrqrof', 't2__b90836');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_2', 'qyp5s5bbp0', '2eutliqa11r', 't2__b90836');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('C', 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('@', '7ryfdrz16n', 'jja', '4');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t2__63c636', 'boeowii1z5nx', 'h66', 'q2xlyoto');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('B', '5k5swwqcgs', '9n8', 't2__b90836');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_8', '5k5swwqcgs', '9n8', NULL);

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('J', '4', 'gu7v', 'e4');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_10', 'a9000t5c4eci', 'gce376nium52', NULL);

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('D', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_12', 'rkf9vqx5', 'pz0f8jegd', NULL);

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('`', '1vy9uxj4', 'wb', 'v');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_14', 'dqv0gcb98ozk', 'zbilyrkn', NULL);

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('a', '6vck6ah0f8js', 'wlq7xb', '72fxa7ryfd');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_16', 'c68x8vacx', 'afu5w1of7', NULL);

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('!', 'pzo72ctdc', 'mfg62', '0v');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_18', 'd5ysxc', 'r0oz', NULL);

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('K', 'dgj5i', 'lq5lnpim', 'k58qs27p');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, '4', 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.college FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id GROUP BY T2.major_id ORDER BY COUNT(T2.college) DESC, T2.college NULLS LAST LIMIT 1;

/*
Gold Result:
('t2__b90836',)
*/

-- Prediction Query
SELECT major.college FROM member JOIN major ON member.link_to_major = major.major_id GROUP BY major.college ORDER BY COUNT(member.member_id) DESC, major.college NULLS LAST LIMIT 1;

/*
Prediction Result:
('t2__b90836',)
*/