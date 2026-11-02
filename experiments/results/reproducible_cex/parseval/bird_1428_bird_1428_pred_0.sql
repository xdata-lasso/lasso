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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_1', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'Member', 'bnp', 'mdpos', 1, 't1__9f70ec');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_2', 'l7', 'klex14ji', '7zwau2dwyr', 'Member', '13pyu', '8d99rljsl', 2, 't1__9f70ec');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_3', 'wnqcx', '5hncprjtu0d', '79fjgq8', 'Member', 'n2f3dqv0gcb9', 'ozk3zbily', 3, 't1__6a304c');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_4', '7ryfdrz16n', 'jja', '5dh', 'Member', 'ogrgjd8y', 't1afgog', 1, 'G');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_5', 'itsj3', 'y', 'p1q430', 'Member', 'jh3den8', 'c68x8vacx7', 2, 't1__9f70ec');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_6', 'f', '5w1of7', 'pzo72ctdc', 'Member', 'mfg62', '0v', 1, 'G');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_7', 'q8qdjpe1', 'o22', '8507cvtjp', 'Member', 'ttg6bnou5zi3', 'c4bfkfoac', 2, 't1__9f70ec');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_8', 'r0oz', 'dgj5i', 'lq5lnpim', 'Member', 'k58qs27p', 'r94gth2m', 1, 'I');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_9', 'ajjl', '3', 'okv8uttmu2', 'Member', 'e578', 'fvy', 2, 't1__9f70ec');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('G', '7zzbe8y', 'kv42q7', 'x58b4', 'Member', 'pmaus3auvmkr', 'pdjwzw5chn9', 1, 't1__9f70ec');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 'o705', 'a9n0jxfofws', 'do2zobb', 'Member', 'q0k32od', 'cl5ams', 1, 't1__9f70ec');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('Q', 'orlwyngc1dj', '9erhizgk1yoe', 'o6l0hdt', 'Member', 'fuqyxuzkb', '521gwnlas6e', 1, 't1__9f70ec');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('I', 'lboeowii1z5', 'xih6', '2q2xlyoto', 'Member', '9oaawg', '6aqb0tbin', 1, 't1__9f70ec');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', 'z', '9tajz9td', 'n5wcgumbc', 'Member', '3tdu6bd0w960', 'vzxw1rxe', 1, 't1__9f70ec');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_15', '9yfk7qk162n', '55', '3dohvu0', 'Member', 'dza35rmki', '18ri', 1, 't1__9f70ec');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_16', 'hy08ftp6', 'wt', 'xxnja', 't1__ad27e9', 'bymzn2mfx7h3', 'p6sto1cj', 1, 't1__9f70ec');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_17', 'qta8y3a17v4y', 'ma', 'q3qdpua', 'Member', '96rn', 'dqrhm', 1, 't1__9f70ec');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_18', 'wlic7dn2', 'p490', 'dmsqtg', 'Member', 'lc', 'qb9i9f', 1, 't1__9f70ec');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 'tti', 'bnp', 'mdpos', NULL, 'ie5', 'nw6klf', 4, '@');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('`', 'klex14ji', '7zwau2dwyr', '13pyu', 't1__ad27e9', '8d99rljsl', 'b4yp5qi', 5, 'B');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('a', 'wnqcx', '5hncprjtu0d', '79fjgq8', NULL, 'n2f3dqv0gcb9', 'ozk3zbily', 6, '`');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('B', '5dh', 'ogrgjd8y', 't1afgog', 'Member', 'itsj3', 'y', 7, 'C');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('b', '0v', 'q8qdjpe1', 'o22', 't1__ad27e9', '8507cvtjp', 'ttg6bnou5zi3', 8, 'F');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('C', 'k58qs27p', 'r94gth2m', 'ajjl', NULL, '3', 'okv8uttmu2', 9, '"');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('D', 'nw6klf', 'a9000t5c4eci', 'gce376nium52', 'Member', 'zbuo4nrqrof', 'qyp5s5bbp0', 10, '#');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t1__9f70ec', '5k5swwqcgs', 'Electrical and Computer Engineering Department', '9n8');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_2', 'ie5', 'Electrical and Computer Engineering Department', 'nw6klf');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t1__6a304c', 'b4yp5qi', 'rkf9vqx5', 'pz0f8jegd');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('A', 'kn6vc', 'Electrical and Computer Engineering Department', '6ah');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('G', 'f8jswwl', '7xb72', 'xa');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('I', '0', '7z2zezjo7wg', 'd5ysxc');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t2__cf4fcc', 'sh5knzys7', 'y', 'yd1jmgjach8');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('@', '5k5swwqcgs', 'Electrical and Computer Engineering Department', '9n8');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('B', 'a9000t5c4eci', 't2__28e914', 'gce376nium52');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('`', 'rkf9vqx5', 't2__28e914', 'pz0f8jegd');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('C', 'kn6vc', NULL, '6ah');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('F', 'p1q430', NULL, 'jh3den8');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('"', 'c4bfkfoac', NULL, '0');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('#', 'mdpos', 'Electrical and Computer Engineering Department', 'ie5');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1, '4', 't3__dccac1', 'gu7v', 't3__758f42', 'e4');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (2, 'a9000t5c4eci', 't3__dccac1', 'gce376nium52', 't3__758f42', 'zbuo4nrqrof');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483647, 'qyp5s5bbp0', 't3__dccac1', '2eutliqa11r', 't3__758f42', 'ytoo3o9');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (3, '1vy9uxj4', 'wb', 'v', 'ph2', 'nd');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (4, '4', 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (5, 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9', 'l7');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (6, '1vy9uxj4', 'wb', 'v', 'ph2', 'nd');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (7, 'f8jswwl', '7xb72', 'xa', '7ryfdrz16n', 'jja');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (8, 'c68x8vacx7', 'f', '5w1of7', 'pzo72ctdc', 'mfg62');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (9, '7z2zezjo7wg', 'd5ysxc', 'r0oz', 'dgj5i', 'lq5lnpim');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483638, '5k5swwqcgs', NULL, '9n8', '4', 'gu7v');

INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (10, 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'bnp');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT city, state FROM member AS T1 INNER JOIN major AS T2 ON T2.major_id = T1.link_to_major INNER JOIN zip_code AS T3 ON T3.zip_code = T1.zip WHERE department = 'Electrical and Computer Engineering Department' AND position = 'Member';

/*
Gold Result:
('t3__dccac1', 't3__758f42')
('t3__dccac1', 't3__758f42')
('t3__dccac1', 't3__758f42')
('t3__dccac1', 't3__758f42')
('t3__dccac1', 't3__758f42')
('t3__dccac1', 't3__758f42')
('t3__dccac1', 't3__758f42')
('t3__dccac1', 't3__758f42')
('t3__dccac1', 't3__758f42')
('t3__dccac1', 't3__758f42')
('t3__dccac1', 't3__758f42')
('t3__dccac1', 't3__758f42')
('t3__dccac1', 't3__758f42')
('hria2ypuzhs', 'tti')
*/

-- Prediction Query
SELECT T3.city, T3.state FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id INNER JOIN zip_code AS T3 ON T1.zip = T3.zip_code WHERE T2.department = 'Electrical and Computer Engineering' AND T1.position = 'Member';

/*
Prediction Result:
*/