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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('G', 'mem_c6b21d', 'mem_ffcf5c', 'bnp', 'mdpos', 'ie5', 'nw6klf', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 'mem_c6b21d', 'mem_ffcf5c', '00t5c4ecigc', 'e376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', 'mem_c6b21d', 'mem_ffcf5c', 'au2dwyrq13', 'yu78', '9', 'rljsl0b4y', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4', 'wb', 'v', 'ph2', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('_', 'mem_c6b21d', 'mem_ffcf5c', 'f3dqv0gc', '9', 'ozk3zbily', 'kn6vc', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('I', 'mem_c6b21d', 'mem_ffcf5c', 'ri', 'tsj3ayxp1q4', '01jh3den', 'c68x8vacx', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('D', 'swwqcgsk', '9n8c4pgu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('`', 'klfa9000t', 'c4ecigce', '76nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('H', NULL, 'swwqcgsk', '9n8c4pgu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('L', '5u', NULL, 'w6kl', 'a9', '00t5c4e', 'cigce376nium', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('B', '02eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr', '13pyu', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('a', 'dqwn', 'cx5hn', 'p', 'jtu0d', '79fjgq8', 'n2f3dqv0gcb9', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('?', 'a7ryfd', 'z16ni', 'jai', 'dh5ogrgj', '8', 'yzt1afgogrit', -2147483648, 'major_id_1');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', '5k5swwqcgs', '9n8', '4');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti');

-- Inserting into table: income --
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('O', '2019-09-09', 1, '2eutliqa11r', 'ytoo3o9', 'G');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('A', '2019-09-09', 1, 'l7', 'klex14ji', 'G');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('C', '2019-09-09', 1, 'nd', 'wnqcx', '@');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('G', '2019-09-09', 1, 'rjtu', 'dz79fjg', 'A');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('Q', '2019-09-09', 1, 'h0f8jswwlq', 'xb72fxa7r', '@');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('_', '2019-09-09', 1, 'z16nijjai5d', 'h5ogrgjd8yz', 'O');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('@', 'inc_d88ce0', -1364429300, 'nprmdposii', '5u', 'D');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('B', NULL, 2137741668, 'ytoo3o9hl7', 'klex14ji', '`');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('D', '2019-09-09', -1377057208, 'ilbnp', 'mdpos', 'H');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('F', '2019-09-09', 283598170, 'zbuo4nrq', 'rofqyp5s5b', 'L');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('E', '2019-09-09', 176380444, '9rljsl0b4', 'p5qi2rk', 'B');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_12', 'vqx58pz0f', NULL, '8jegd21vy9ux', 'j4hwbdvlph', 'A');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('?', '2019-09-09', 172461907, 'k3zbily', 'kn6vc', 'a');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_14', 'ah0f8jsww', NULL, 'q7x', '7', 'O');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('"', '2019-09-09', 678047687, '3ay', 'p1q430', '?');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_16', 'jh3den8c68', NULL, '8vacx7', 'f', 'D');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.first_name, T3.last_name, T4.amount FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event INNER JOIN member AS T3 ON T3.member_id = T2.link_to_member INNER JOIN income AS T4 ON T4.link_to_member = T3.member_id WHERE T4.date_received = '2019-09-09';

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT member.first_name, member.last_name, income.amount FROM member INNER JOIN income ON member.member_id = income.link_to_member WHERE income.date_received = '2019-09-09';

/*
Prediction Result:
('mem_c6b21d', 'mem_ffcf5c', 1)
('rkf9vqx5', 'pz0f8jegd', 1)
(None, 'swwqcgsk', -1377057208)
('5u', None, 283598170)
('02eutliqa11r', 'ytoo3o9', 176380444)
('dqwn', 'cx5hn', 172461907)
('a7ryfd', 'z16ni', 678047687)
*/