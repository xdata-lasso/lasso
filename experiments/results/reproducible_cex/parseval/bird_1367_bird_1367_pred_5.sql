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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_1', 'tti', 'bnp', 'mdpos', 'ie5', 'nw6klf', 'a9000t5c4eci', -2147483648, 'mem_822156');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_2', 'ytoo3o9hl7', 'klex14ji', '7zwau2dwyr', '13pyu', '8d99rljsl', 'b4yp5qi', -2147483648, 'I');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_3', 'bdvlph', 'gndqwnqc', 'x5hncprjtu0', 'z', '9fjgq8n2f', 'dqv0gcb9', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', 'k3zbily', 'kn6vc', '6ah', 'f8jswwl', '7xb72', 'xa', -2147483648, 'mem_822156');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 'fdrz16n', 'jja', '5dh', 'ogrgjd8y', 't1afgog', 'itsj3', -2147483648, 'mem_822156');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('G', '1q43', '1jh3den', 'c68x8vacx', 'afu5w1of7', 'pzo72ctdc', 'mfg62', -2147483648, 'mem_822156');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('_', '5q8qdj', 'e1io', '278507cv', 'jpttg', 'bnou5zi36', '4', -2147483648, 'mem_822156');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_8', 'd5ysxc', 'r0oz', 'dgj5i', 'lq5lnpim', 'k58qs27p', 'r94gth2m', -2147483648, 'mem_822156');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_9', 'ajjla3okv8u', 'tmu2n', '57', 'lfvyz7zzb', '8y', 'kv42q7', -2147483648, 'mem_822156');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', '4h', 'ia2yp', 'uzhsrwbbp6lu', 'hvdlttilbnpr', 'dpos', 'ie5', -2147483648, 'G');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('C', '6klfa9', '00t5c4e', 'cigce376nium', '52zbuo4nrq', 'rofqyp5s5b', 'p', -2147483648, 'major_id_2');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('H', 'ia2yp', 'uzhsrwbbp6lu', 'hvdlttilbnpr', 'dpos', 'ie5', 'nw6klf', -2147483648, 'D');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('D', 'ytoo3o9hl7', 'klex14ji', '7zwau2dwyr', '13pyu', '8d99rljsl', 'b4yp5qi', -2147483648, 'E');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('B', 'h2gn', 'q', 'nqcx5h', 'cprj', 'u0dz7', 'fjgq8n2f3', -2147483648, '!');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('`', 'z16nijjai5d', 'h5ogrgjd8yz', '1afgo', 'ri', 'tsj3ayxp1q4', '01jh3den', -2147483648, '`');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('a', 'q8qdjpe1io22', '8507cvtjp', 'ttg6bnou5zi3', 'c4bfkfoac', '0', '7z2zezjo7wg', -2147483648, 'a');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('''', '94gth', '2mnajjla3o', 'v8u', 'tmu2n', '57', 'lfvyz7zzb', -2147483648, 'H');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('mem_822156', '5k5swwqcgs', '9n8', 'maj_fa9b9c');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('I', 'gce376nium52', 'zbuo4nrqrof', 'maj_fa9b9c');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_2', 'qyp5s5bbp0', '2eutliqa11r', 'maj_fa9b9c');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('A', 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('maj_67b42b', 'kf', 'oacd07z2zez', 'o7w');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('G', '5k5swwqcgs', '9n8', 'maj_c895dc');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('@', '4', 'gu7v', 'maj_c895dc');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('D', '5k5swwqcgs', '9n8', '4');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_9', 'gu7v', 'e4', NULL);

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('E', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_11', 'qyp5s5bbp0', '2eutliqa11r', NULL);

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('!', 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_13', 'wb', 'v', NULL);

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('`', 'dqv0gcb98ozk', 'zbilyrkn', '6vck6ah0f8js');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_15', 'wlq7xb', '72fxa7ryfd', NULL);

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('a', 'c68x8vacx', 'afu5w1of7', 'pzo72ctdc');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_17', 'mfg62', '0v', NULL);

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('H', 'd5ysxc', 'r0oz', 'dgj5i');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_19', 'lq5lnpim', 'k58qs27p', NULL);

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, '4', 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.college FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id GROUP BY T2.major_id ORDER BY COUNT(T2.college) DESC, T2.college NULLS LAST LIMIT 1;

/*
Gold Result:
('maj_fa9b9c',)
*/

-- Prediction Query
SELECT major.college FROM member INNER JOIN major ON member.link_to_major = major.major_id GROUP BY major.college ORDER BY COUNT(*) DESC, major.college NULLS LAST LIMIT 1;

/*
Prediction Result:
('maj_fa9b9c',)
*/