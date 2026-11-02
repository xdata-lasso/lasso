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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__e08285', 't1__45a2db', 't1__47d7ba', 'bnp', 'mdpos', 'ie5', 'nw6klf', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__b62076', 't1__45a2db', 't1__47d7ba', 'foa', 'cd07z2zezjo7', 'wgxd5ysxcm', '0oztd', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 't1__45a2db', 't1__47d7ba', '5i3lq5lnpim5', '58q', 's27p2r94gth2', 'najj', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('_', 'okv8uttm', '2ne578', 'fvy', '7zzbe8y', 'kv42q7', 'x58b4', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('P', '3auvm', 'rpd', 'wzw', 'chn9mo70', 'a9n0jxfo', 'ws', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('H', 'obb0q0k', '2odwcl5a', 'msorlwyngc', 'dj9erhi', 'zgk1yoeyo6l0', 'dt', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 'uzkb52', 'gwnlas6', 'elboeowii1', '5nxih66', 'q2xlyoto', '9oaawg', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t2__6b78ee', 't1__45a2db', 't1__47d7ba', '0', 'bindz', '9tajz9td', 'n5wcgumbc', -2147483648, 'major_id_1');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__9f7ef8', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__9f60f6', 'l7', 'klex14ji', '7zwau2dwyr', '13pyu', '8d99rljsl', 'b4yp5qi');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__8b5c65', 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4', 'wb', 'v', 'ph2');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__b5dd45', 'nd', 'wnqcx', '5hncprjtu0d', '79fjgq8', 'n2f3dqv0gcb9', 'ozk3zbily');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__032bfc', 'kn6vc', '6ah', 'f8jswwl', '7xb72', 'xa', '7ryfdrz16n');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__516872', 'jja', '5dh', 'ogrgjd8y', 't1afgog', 'itsj3', 'y');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__98e664', 'p1q430', 'jh3den8', 'c68x8vacx7', 'f', '5w1of7', 'pzo72ctdc');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__cf5e66', 'mfg62', '0v', 'q8qdjpe1', 'o22', '8507cvtjp', 'ttg6bnou5zi3');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', '5k5swwqcgs', '9n8', '4');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti');

-- Inserting into table: attendance --
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__9f7ef8', 't1__e08285');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__9f60f6', 't1__e08285');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8b5c65', 't1__e08285');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__b5dd45', 't1__e08285');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__032bfc', 't1__e08285');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__516872', 't1__e08285');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98e664', 't1__e08285');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__cf5e66', 't1__e08285');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__9f7ef8', '_');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__9f60f6', '_');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8b5c65', '_');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__b5dd45', '_');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__032bfc', '_');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__516872', '_');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98e664', '_');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__cf5e66', '_');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__9f7ef8', 'P');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__9f60f6', 'P');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8b5c65', 'P');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__b5dd45', 'P');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__032bfc', 'P');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__516872', 'P');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98e664', 'P');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__cf5e66', 'P');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__9f7ef8', 'H');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__9f60f6', 'H');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8b5c65', 'H');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__b5dd45', 'H');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__032bfc', 'H');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__516872', 'H');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98e664', 'H');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__cf5e66', 'H');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__9f7ef8', '@');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__9f60f6', '@');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8b5c65', '@');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__b5dd45', '@');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__032bfc', '@');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__516872', '@');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98e664', '@');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__cf5e66', '@');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__9f7ef8', 't2__6b78ee');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__9f60f6', 't2__6b78ee');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8b5c65', 't2__6b78ee');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__b5dd45', 't2__6b78ee');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__032bfc', 't2__6b78ee');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__516872', 't2__6b78ee');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98e664', 't2__6b78ee');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__cf5e66', 't2__6b78ee');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.first_name, T1.last_name FROM member AS T1 INNER JOIN attendance AS T2 ON T1.member_id = T2.link_to_member GROUP BY T2.link_to_member HAVING COUNT(T2.link_to_event) > 7;

/*
Gold Result:
('uzkb52', 'gwnlas6')
('obb0q0k', '2odwcl5a')
('3auvm', 'rpd')
('okv8uttm', '2ne578')
('t1__45a2db', 't1__47d7ba')
('t1__45a2db', 't1__47d7ba')
*/

-- Prediction Query
SELECT member.first_name, member.last_name FROM member INNER JOIN attendance ON member.member_id = attendance.link_to_member GROUP BY member.first_name, member.last_name HAVING COUNT(attendance.link_to_event) > 7;

/*
Prediction Result:
('3auvm', 'rpd')
('obb0q0k', '2odwcl5a')
('okv8uttm', '2ne578')
('t1__45a2db', 't1__47d7ba')
('uzkb52', 'gwnlas6')
*/