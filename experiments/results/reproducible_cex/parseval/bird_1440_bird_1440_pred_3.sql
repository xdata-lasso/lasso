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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 'bnp', 'mdpos', 't1__ae9a13', 'ie5', 'nw6klf', 'a9000t5c4eci', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('C', 'e376nium52', 'zbuo4nrqrof', 't1__ae9a13', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', 'cx5hn', 'p', 't1__ae9a13', 'jtu0d', '79fjgq8', 'n2f3dqv0gcb9', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('G', 'jja', '5dh', 't1__ae9a13', 'ogrgjd8y', 't1afgog', 'itsj3', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('_', 'f77p', 'o72ctdc', 't1__ae9a13', 'mfg62', '0v', 'q8qdjpe1', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__6dbf44', 'v42q7sx58b4p', 'aus3', 'u', 'mkrpdj', 'wzw5chn9mo70', 'a9n0jxfo', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 'j9erhizgk1', 'yoeyo6l0hdt6', 'uq', 'xuzkb52', 'gwnlas6', 'elboeowii1', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('S', '8', '5wcg', 'mbc3td', 'u6bd0w9603', 'vzxw1rxe9y', 'k7', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('K', '6ewt', 'xxnja', 'bymzn2mfx7h3', 'p6sto1cj', 'sh5knzys7', 'y', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('`', '6rntdqrhm', 'wlic7dn2', 'p490', 'dmsqtg', 'lc', 'qb9i9f', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('B', 'tvb6m4iz78', 'q', 'lud8f', 'tb8r9114qbre', '6bjeuuwsj8k', 'h85', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('H', 'nxar50hsj', 'an', 'xdpunmw', 'wx', 'rlawk', '14r5dqt', -2147483648, 'major_id_1');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_1', 'l7', 'klex14ji', '7zwau2dwyr', '13pyu', '8d99rljsl', 'b4yp5qi');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', '5k5swwqcgs', '9n8', '4');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti');

-- Inserting into table: budget --
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_1', 'rkf9vqx5', 541.393553, 235.518744, 1836127587, 'f8jegd2', 'event_id_1');

-- Inserting into table: expense --
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_1', 'vy9uxj4', '2019-09-10', 20.01, 'wb', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_2', 'lph2gn', '2019-09-10', 20.01, 'q', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_3', 'zbilyrkn', '2019-09-10', 20.01, '6vck6ah0f8js', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_4', 'lq7xb7', '2019-09-10', 20.01, '2fxa7ryfdrz', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_5', '1q43', '2019-09-10', 20.01, '1jh3den', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_6', '68x8vacx7a', '2019-09-10', 20.01, 'u5', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_7', '78507cvt', '2019-09-10', 20.01, 'ptt', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_8', 'bnou5zi36', '2019-09-10', 20.01, '4', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('O', 'c', '2019-09-10', 20.01, '0', '_', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('A', 'zezjo7wg', '2019-09-10', 20.01, 'd5ysxc', '_', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('_', 'dgj5i', '2019-09-10', 20.01, 'lq5lnpim', 'O', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('Q', '7p2r94gth2m', '2019-09-10', 20.01, 'ajjl', '_', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_13', 'tmu2n', '2019-09-10', 20.0, '57', 'O', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_14', 'vy', '2019-09-10', 20.0, '7zzbe8y', 'O', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_15', '2zob', '2019-09-10', 20.01, '0', 'G', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_16', '0k32odwcl5a', '2019-09-10', 20.01, 'msorlwyngc', 'G', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('@', 'xih662q2xly', '2019-09-10', 20.01, 'otow9oaawg', '@', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_18', 'qb0tbindz39t', '2019-09-10', 20.01, 'j', 't1__6dbf44', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('D', '62nh55y3dohv', '2019-09-10', 20.01, '06dza3', 'S', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_20', 'rmkio18ri2', '2019-09-10', 20.01, 'y0', 't1__6dbf44', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('B', 'jmgjach8qt', '2019-09-10', 20.01, 'a8y3a17v4yg', 'K', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_22', 'y', '2019-09-10', 20.01, '3qdpu', 't1__6dbf44', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('"', 'kjq1qu', '2019-09-10', 20.01, 'k1y', '`', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_24', '0', '2019-09-10', 20.01, 'hlst1pqom', 't1__6dbf44', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('C', 'lvrisurz0k', '2019-09-10', 20.01, 'q', 'B', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_26', 'ncgc8s3b7v', '2019-09-10', 20.01, '88kwdmdbdht6', 't1__6dbf44', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('d', '7aqz2o20p', '2019-09-10', 20.01, '6dd', 'H', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_28', 'su6iphd', '2019-09-10', 20.01, 'u2g', 't1__6dbf44', 'budget_id_1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.email FROM member AS T1 INNER JOIN expense AS T2 ON T1.member_id = T2.link_to_member WHERE DATE(SUBSTRING(T2.expense_date, 1, 10)) BETWEEN '2019-09-10' AND '2019-11-19' AND T2.cost > 20;

/*
Gold Result:
('t1__ae9a13',)
('uq',)
('u',)
('mbc3td',)
('bymzn2mfx7h3',)
('p490',)
('lud8f',)
('xdpunmw',)
*/

-- Prediction Query
SELECT "member"."email" FROM "expense" INNER JOIN "member" ON "expense"."link_to_member" = "member"."member_id" WHERE "expense"."expense_date" BETWEEN '2019-09-10' AND '2019-11-19' AND "expense"."cost" > 20;

/*
Prediction Result:
('t1__ae9a13',)
('t1__ae9a13',)
('t1__ae9a13',)
('t1__ae9a13',)
('t1__ae9a13',)
('t1__ae9a13',)
('t1__ae9a13',)
('t1__ae9a13',)
('t1__ae9a13',)
('t1__ae9a13',)
('t1__ae9a13',)
('t1__ae9a13',)
('t1__ae9a13',)
('t1__ae9a13',)
('uq',)
('u',)
('mbc3td',)
('u',)
('bymzn2mfx7h3',)
('u',)
('p490',)
('u',)
('lud8f',)
('u',)
('xdpunmw',)
('u',)
*/