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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__592233', 't1__61668e', 't1__350223', 'bnp', 'mdpos', 'ie5', 'nw6klf', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 't1__61668e', 't1__350223', 'f', 'foa', 'cd07z2zezjo7', 'wgxd5ysxcm', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__b8ebb9', 't1__61668e', 't1__350223', 'ztdg', '5i3', 'q5l', 'pim5', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', '7p2r94gt', '2m', 'ajjl', '3', 'okv8uttmu2', 'e578', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('#', '7zzbe8y', 'kv42q7', 'x58b4', 'pmaus3auvmkr', 'pdjwzw5chn9', 'o705', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('T', 'fofwsz', 'o', '2zobb0q0k32o', 'w', 'l', '5amsorlwyngc', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('Q', 'rhizgk1yoey', 'o6l0hdt6fu', 'yxuzk', '5', '1gwnlas6', 'elboeowii1', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t2__0bbb59', 't1__61668e', 't1__350223', 'xih6', '2q2xlyoto', '9oaawg', '6aqb0tbin', -2147483648, 'major_id_1');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__a38659', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__f2a964', 'l7', 'klex14ji', '7zwau2dwyr', '13pyu', '8d99rljsl', 'b4yp5qi');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__bcf32d', 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4', 'wb', 'v', 'ph2');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__049ebc', 'nd', 'wnqcx', '5hncprjtu0d', '79fjgq8', 'n2f3dqv0gcb9', 'ozk3zbily');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__448132', 'kn6vc', '6ah', 'f8jswwl', '7xb72', 'xa', '7ryfdrz16n');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__600990', 'jja', '5dh', 'ogrgjd8y', 't1afgog', 'itsj3', 'y');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__b429ea', 'p1q430', 'jh3den8', 'c68x8vacx7', 'f', '5w1of7', 'pzo72ctdc');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__17e9b3', 'mfg62', '0v', 'q8qdjpe1', 'o22', '8507cvtjp', 'ttg6bnou5zi3');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', '5k5swwqcgs', '9n8', '4');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti');

-- Inserting into table: attendance --
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__a38659', 't1__592233');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__f2a964', 't1__592233');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__bcf32d', 't1__592233');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__049ebc', 't1__592233');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__448132', 't1__592233');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__600990', 't1__592233');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__b429ea', 't1__592233');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__17e9b3', 't1__592233');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__a38659', 'A');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__f2a964', 'A');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__bcf32d', 'A');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__049ebc', 'A');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__448132', 'A');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__600990', 'A');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__b429ea', 'A');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__17e9b3', 'A');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__a38659', 'O');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__f2a964', 'O');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__bcf32d', 'O');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__049ebc', 'O');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__448132', 'O');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__600990', 'O');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__b429ea', 'O');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__17e9b3', 'O');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__a38659', '#');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__f2a964', '#');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__bcf32d', '#');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__049ebc', '#');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__448132', '#');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__600990', '#');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__b429ea', '#');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__17e9b3', '#');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__a38659', 'T');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__f2a964', 'T');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__bcf32d', 'T');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__049ebc', 'T');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__448132', 'T');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__600990', 'T');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__b429ea', 'T');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__17e9b3', 'T');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__a38659', 'Q');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__f2a964', 'Q');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__bcf32d', 'Q');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__049ebc', 'Q');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__448132', 'Q');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__600990', 'Q');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__b429ea', 'Q');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__17e9b3', 'Q');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__a38659', 't2__0bbb59');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__f2a964', 't2__0bbb59');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__bcf32d', 't2__0bbb59');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__049ebc', 't2__0bbb59');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__448132', 't2__0bbb59');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__600990', 't2__0bbb59');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__b429ea', 't2__0bbb59');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__17e9b3', 't2__0bbb59');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.first_name, T1.last_name FROM member AS T1 INNER JOIN attendance AS T2 ON T1.member_id = T2.link_to_member GROUP BY T2.link_to_member HAVING COUNT(T2.link_to_event) > 7;

/*
Gold Result:
('7zzbe8y', 'kv42q7')
('t1__61668e', 't1__350223')
('7p2r94gt', '2m')
('rhizgk1yoey', 'o6l0hdt6fu')
('fofwsz', 'o')
('t1__61668e', 't1__350223')
('t1__61668e', 't1__350223')
*/

-- Prediction Query
SELECT T1.first_name, T1.last_name FROM member AS T1 INNER JOIN attendance AS T2 ON T1.member_id = T2.link_to_member GROUP BY T1.first_name, T1.last_name HAVING COUNT(T2.link_to_event) > 7;

/*
Prediction Result:
('7p2r94gt', '2m')
('7zzbe8y', 'kv42q7')
('fofwsz', 'o')
('rhizgk1yoey', 'o6l0hdt6fu')
('t1__61668e', 't1__350223')
*/