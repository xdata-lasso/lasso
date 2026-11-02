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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__ae5d5a', 'bnp', 'mdpos', 'ie5', 'Vice President', 'nw6klf', 'a9000t5c4eci', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__ae9a51', 'iqa', '1ryytoo', 'o9hl72kl', 'Vice President', 'x1', 'ji7zwau2', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('G', '9uxj4hw', 'd', 'lph2gn', 'Vice President', 'q', 'nqcx5h', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 'rjtu', 'dz79fjg', '8n2f3', 'dqv0gcb98ozk', 'zbilyrkn', '6vck6ah0f8js', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t2__ecea20', 'jh3den8', 'c68x8vacx7', 'f', 'Vice President', '5w1of7', 'pzo72ctdc', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('S', 'swwqcgsk', '9n8c4pgu7v', 'e4', NULL, 'hria2ypuzhs', 'rwbbp6luhvd', -2147483648, 'major_id_1');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', '5k5swwqcgs', '9n8', '4');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti');

-- Inserting into table: income --
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_1', 'gce376nium52', 1, 'zbuo4nrqrof', 'qyp5s5bbp0', 't1__ae5d5a');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('A', 'dwyrq13pyu78', 1, '9', 'rljsl0b4y', 't1__ae5d5a');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('C', 'p5qi2rkf9v', 1, 'x58pz', 'f8jegd2', 't1__ae5d5a');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_4', 'wlq7xb', 1, '72fxa7ryfd', 'z16ni', 'A');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_5', 'i', 1, 'dh5ogrgj', '8', 'A');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_6', '1afgo', 1, 'ri', 'tsj3ayxp1q4', 'A');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('_', 'mfg62', 1, '0v', 'q8qdjpe1', 't2__ecea20');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('Q', '278507cv', 1, 'jpttg', 'bnou5zi36', 't2__ecea20');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('G', 'f', 1, 'foa', 'cd07z2zezjo7', 't2__ecea20');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_10', 'd5ysxc', 1, 'r0oz', 'dgj5i', 't1__ae5d5a');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_11', '5lnpi', NULL, '5k58', 's27p2', 't1__ae5d5a');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('@', 'tti', -1364429300, 'nprmdposii', '5u', 'S');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.amount FROM member AS T1 INNER JOIN income AS T2 ON T1.member_id = T2.link_to_member WHERE T1.position = 'Vice President';

/*
Gold Result:
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(None,)
*/

-- Prediction Query
SELECT SUM(income.amount) AS total_funds_received FROM income INNER JOIN member ON income.link_to_member = member.member_id WHERE member.position = 'Vice President';

/*
Prediction Result:
(7,)
*/