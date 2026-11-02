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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__a23443', 'bnp', 'mdpos', 't1__16c0b0', 'ie5', 'nw6klf', 'a9000t5c4eci', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__195629', 'e376nium52', 'zbuo4nrqrof', 't1__16c0b0', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 'cx5hn', 'p', 't1__16c0b0', 'jtu0d', '79fjgq8', 'n2f3dqv0gcb9', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_3', '3zb', 'lyr', 't1__16c0b0', 'kn6vck6ah0f8', 'sww', 'q7x', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 'a7ryfd', 'z16ni', 'jai', 'dh5ogrgj', '8', 'yzt1afgogrit', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('$', '7pzo72ctd', 't', 't1__16c0b0', 'mfg62g0v5q8q', 'j', 'e1io', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('?', '7cvtjpt', 'tg6bnou5zi', '6c4bfkfo', 'c', '0', '7z2zezjo7wg', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_8', 'pim5', '58q', 't1__16c0b0', 's27p2r94gth2', 'najj', 'a3o', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t2__e7be86', '58b4pmaus3a', 'vmkrpd', 't1__16c0b0', 'wzw', 'chn9mo70', 'a9n0jxfo', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_9', 'zdo2z', 'obb0q0k32o', 't1__16c0b0', 'w', 'l', '5amsorlwyngc', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_11', 'wn', 'as6', 't1__16c0b0', 'elboeowii1', '5nxih66', 'q2xlyoto', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_12', '39tajz9', 'd8n5w', 't1__16c0b0', 'g', 'mbc3td', 'u6bd0w9603', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('B', 'gjac', '8q', 'ta8y3a17v4', 'ygmayq3qdpu', 'p', '6rntdqrhm', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('"', 'jq1', 'uik1y', 'hb08hlst1pq', 'mizt', 'vb6m4iz78aq', 'lud8f', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('C', 'lvrisurz0k', 'q', 'ncgc8', '3b7v8', 'kwdmdbdht', 'j47nxar50', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('D', 'z2o20', 'pj6ddlysu6ip', 'dk', 'u2gir31vwq5', 'oa2sb3u', 'i1pa', -2147483648, 'major_id_1');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_1', 'l7', 'klex14ji', '7zwau2dwyr', '13pyu', '8d99rljsl', 'b4yp5qi');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', '5k5swwqcgs', '9n8', '4');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti');

-- Inserting into table: budget --
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_1', 'rkf9vqx5', 541.393553, 235.518744, 1836127587, 'f8jegd2', 'event_id_1');

-- Inserting into table: expense --
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_1', 'vy9uxj4', '2019-09-10', 20.01, 'wb', 't1__a23443', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_2', 'lph2gn', '2019-09-10', 20.01, 'q', 't1__a23443', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_3', 'sj3ayxp1q430', '2019-09-10', 20.01, 'jh3den8', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_4', '68x8vacx7a', '2019-09-10', 20.01, 'u5', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_5', 'd5ysxc', '2019-09-10', 20.01, 'r0oz', '?', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_6', 'g', '2019-09-10', 20.01, '5i3', '?', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_7', '8uttmu', '2019-09-10', 20.01, 'ne578lfv', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_8', '7zzbe8y', '2019-09-10', 20.01, 'kv42q7', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('_', 'j', '2019-09-10', 20.01, '9erhizgk1yoe', 't2__e7be86', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('A', 'o6l0hdt6fu', '2019-09-10', 20.01, 'yxuzk', 't2__e7be86', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('O', 'oaawg96aq', '2019-09-10', 20.01, '0', 't2__e7be86', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('G', 'xw1rxe9', '2019-09-10', 20.01, 'fk7qk16', 't2__e7be86', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_13', 'dohvu06d', '2019-09-10', 20.0, 'a35rmki', 't1__a23443', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_14', '8ri2hy0', '2019-09-10', 20.0, '8ftp6ewtqx', 't1__a23443', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_15', 'mzn2mfx', '2019-09-10', 20.01, 'h33p6sto1', 't1__a23443', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_16', '8sh', '2019-09-10', 20.01, 'knzys7dy', 't1__a23443', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('@', 'wlic7dn2np', '2019-09-10', 20.01, '90xdmsqt', 'B', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_18', 'lc', '2019-09-10', 20.01, 'qb9i9f', 't1__a23443', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('!', '8', '2019-09-10', 20.01, '9114q', '"', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_20', 'e6bje', '2019-09-10', 20.01, 'uuwsj8kjh8', 't1__a23443', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('`', 'sjhanzxdpu', '2019-09-10', 20.01, 'mwfw', 'C', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_22', 'rlawk', '2019-09-10', 20.01, '14r5dqt', 't1__a23443', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('B', 'v', '2019-09-10', 20.01, 'wnyqrouirlrp', 'D', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_24', 'it63xy', '2019-09-10', 20.01, 'vm', 't1__a23443', 'budget_id_1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.email FROM member AS T1 INNER JOIN expense AS T2 ON T1.member_id = T2.link_to_member WHERE DATE(SUBSTRING(T2.expense_date, 1, 10)) BETWEEN '2019-09-10' AND '2019-11-19' AND T2.cost > 20;

/*
Gold Result:
('t1__16c0b0',)
('jai',)
('6c4bfkfo',)
('ta8y3a17v4',)
('hb08hlst1pq',)
('ncgc8',)
('dk',)
*/

-- Prediction Query
SELECT m.email FROM expense AS e JOIN member AS m ON e.link_to_member = m.member_id WHERE e.expense_date BETWEEN '2019-09-10' AND '2019-11-19' AND e.cost > 20;

/*
Prediction Result:
('t1__16c0b0',)
('t1__16c0b0',)
('jai',)
('jai',)
('6c4bfkfo',)
('6c4bfkfo',)
('jai',)
('jai',)
('t1__16c0b0',)
('t1__16c0b0',)
('t1__16c0b0',)
('t1__16c0b0',)
('t1__16c0b0',)
('t1__16c0b0',)
('ta8y3a17v4',)
('t1__16c0b0',)
('hb08hlst1pq',)
('t1__16c0b0',)
('ncgc8',)
('t1__16c0b0',)
('dk',)
('t1__16c0b0',)
*/