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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__befe3c', 't1__1b7e15', 't1__e83327', 'tti', 'bnp', 'mdpos', 'ie5', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__921e66', 't1__1b7e15', 't1__e83327', 'u', '4nrq', 'rofqyp5s5b', 'p', -2147483648, 'C');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 't1__1b7e15', 't1__e83327', '1q43', '1jh3den', 'c68x8vacx', 'afu5w1of7', -2147483648, '_');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('?', 't1__1b7e15', 't1__e83327', 'o72ctdc', 'mfg62', '0v', 'q8qdjpe1', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', '78507cvt', 'ptt', '6b', 'ou5z', '36c', 'bfkfoacd', -2147483648, 'C');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_6', 't1__1b7e15', 't1__e83327', 'q7sx58b4', 'pmaus3auvmkr', 'pdjwzw5chn9', 'o705', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_7', 't1__1b7e15', 't1__e83327', '0', 'bindz', '9tajz9td', 'n5wcgumbc', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t3__26cb95', 't1__1b7e15', 't1__e83327', '5k', 'zys7', 'y', 'yd1jmgjach8', -2147483648, 'Q');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_8', 't1__1b7e15', 't1__e83327', 'ta8y3a17v4', 'ygmayq3qdpu', 'p', '6rntdqrhm', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_10', 't1__1b7e15', 't1__e83327', '0kaqtnc', 'gc8s3b7v88k', 'dmdbdh', '6j47n', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_11', 't1__1b7e15', 't1__e83327', '7aqz2o20p', '6dd', 'ysu', 'iphdku2gi', -2147483648, 'A');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', 't1__1b7e15', 't1__e83327', 'nzg3rjkw', 'ns47j2ja8dc', 'y', 'vjwq49yr', -2147483648, 'O');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('B', 'u7', 'fe4hri', 'a2ypuzhsrwbb', 'p6luhvdlttil', 'n', 'rmdp', -2147483648, 'B');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_1', '02eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr', '13pyu');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('A', 't2__89f3a3', '5k5swwqcgs', '9n8');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('C', 'nw6klf', 'a9000t5c4eci', 'gce376nium52');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('G', 't2__89f3a3', 'z', '9fjgq8n2f');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('@', 'dqv0gcb98ozk', 'zbilyrkn', '6vck6ah0f8js');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('_', 't2__89f3a3', 'itsj3', 'y');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('O', 't2__89f3a3', 'q5l', 'pim5');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Q', 'o6l0hdt6fu', 'yxuzk', '5');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('I', 't2__89f3a3', '8hlst1p', 'qomiztvb6m');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('t2__e75207', 'p', 'pgckqwtsr', '54o6qjektb1');

INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('B', '5k5swwqcgs', '9n8', '4');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, '4', 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd');

-- Inserting into table: budget --
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('budget_id_1', '8d99rljsl', 419.361606, 470.165282, 1692174491, 'qi2rkf9v', 'event_id_1');

-- Inserting into table: expense --
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_1', 'x58pz', 'f8jegd2', 100.01, 'vy9uxj4', 't1__befe3c', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_2', 'bdvlph', 'gndqwnqc', 100.01, 'x5hncprjtu0', 't1__befe3c', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_3', 'q7x', '7', 100.01, '2fxa7ryfdrz', 't1__befe3c', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_4', '6nijjai5dh', 'ogrgjd8y', 100.01, 't1afgog', 't1__befe3c', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_5', '7z2zezj', '7wgx', 100.01, '5', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_6', 'xcmr0', 'ztdg', 100.01, '5i3', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_7', 's27p2r94gth2', 'najj', 100.01, 'a3o', 't1__befe3c', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_8', '8uttmu', 'ne578lfv', 100.01, 'yz7zzbe8yvk', 't1__befe3c', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_9', '9n0jxfofwsz', 'o', 100.01, '2zobb0q0k32o', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_10', 'cl5ams', 'orlwyngc1dj', 100.01, '9erhizgk1yoe', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_11', 'wn', 'as6', 100.01, 'elboeowii1', 't1__befe3c', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_12', 'nxih662q', 'xlyotow9', 100.01, 'aawg', 't1__befe3c', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_13', 'tdu6bd0w96', '3vzxw1r', 100.01, 'e9yfk7', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_14', '162', 'h55y', 100.01, 'dohvu06d', 'A', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_15', 'rmkio18r', 'i2hy08ftp6', 100.01, 'wt', 't1__befe3c', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_16', 'xnjaby', 'mzn2mfx7h3', 100.01, 'p6sto1cj', 't1__befe3c', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('G', 'wlic7dn2np', '90xdmsqt', 100.01, 'el', 't3__26cb95', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('A', 'qb9i9f', 'ccukjq1q', 100.01, 'ik1yhb', 't3__26cb95', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_19', '78aqqlud8ft', '8', 100.01, '9114q', 't1__befe3c', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_20', 'e6bje', 'uuwsj8kjh8', 100.01, 'wpxlvris', 't1__befe3c', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_21', 'sj', 'an', 100.01, 'xdpunmw', 't1__befe3c', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_22', 'xqrlaw', '014', 100.01, '5dqts', 't1__befe3c', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('I', '31vwq51oa2sb', 'uoi1pavc', 100.01, 'wnyqro', 't3__26cb95', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_24', 'rpouit63xyf', 'mjwpp2', 100.0, 'mb3aj0ju0', 't1__befe3c', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_25', 'r133ir1a', 'yyhpl2', 100.0, '9es', 't1__befe3c', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_26', '6dvdx', 'o', 100.01, 'v7t3gvpl', 'O', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_27', 'fjvuun7k1', 'z2my1og', 100.01, 'v1rgeza', 'O', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_28', 'l', 'upgly78oit', 100.01, 'xeilpe019cy', 'O', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_29', '0', '3dlhdsvn', 100.01, 'ed', 'O', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_30', '26u331', 'spxpw30bgwkx', 100.01, 'in', 't1__befe3c', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_31', '6id', 'p61l', 100.01, 'o3ak162o', 't1__befe3c', 'budget_id_1');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('@', 'siie5unw6k', 'fa9', NULL, '00t5c4e', 'B', 'budget_id_1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.first_name, T1.last_name, T2.major_name FROM member AS T1 INNER JOIN major AS T2 ON T2.major_id = T1.link_to_major INNER JOIN expense AS T3 ON T1.member_id = T3.link_to_member WHERE T3.cost > 100;

/*
Gold Result:
('t1__1b7e15', 't1__e83327', 't2__89f3a3')
('78507cvt', 'ptt', 'nw6klf')
('t1__1b7e15', 't1__e83327', 'o6l0hdt6fu')
*/

-- Prediction Query
SELECT m.first_name, m.last_name, maj.major_name FROM member AS m JOIN expense AS e ON m.member_id = e.link_to_member JOIN major AS maj ON m.link_to_major = maj.major_id WHERE e.cost > 100;

/*
Prediction Result:
('t1__1b7e15', 't1__e83327', 't2__89f3a3')
('t1__1b7e15', 't1__e83327', 't2__89f3a3')
('t1__1b7e15', 't1__e83327', 't2__89f3a3')
('t1__1b7e15', 't1__e83327', 't2__89f3a3')
('78507cvt', 'ptt', 'nw6klf')
('78507cvt', 'ptt', 'nw6klf')
('t1__1b7e15', 't1__e83327', 't2__89f3a3')
('t1__1b7e15', 't1__e83327', 't2__89f3a3')
('78507cvt', 'ptt', 'nw6klf')
('78507cvt', 'ptt', 'nw6klf')
('t1__1b7e15', 't1__e83327', 't2__89f3a3')
('t1__1b7e15', 't1__e83327', 't2__89f3a3')
('78507cvt', 'ptt', 'nw6klf')
('78507cvt', 'ptt', 'nw6klf')
('t1__1b7e15', 't1__e83327', 't2__89f3a3')
('t1__1b7e15', 't1__e83327', 't2__89f3a3')
('t1__1b7e15', 't1__e83327', 'o6l0hdt6fu')
('t1__1b7e15', 't1__e83327', 'o6l0hdt6fu')
('t1__1b7e15', 't1__e83327', 't2__89f3a3')
('t1__1b7e15', 't1__e83327', 't2__89f3a3')
('t1__1b7e15', 't1__e83327', 't2__89f3a3')
('t1__1b7e15', 't1__e83327', 't2__89f3a3')
('t1__1b7e15', 't1__e83327', 'o6l0hdt6fu')
('t1__1b7e15', 't1__e83327', 't2__89f3a3')
('t1__1b7e15', 't1__e83327', 't2__89f3a3')
('t1__1b7e15', 't1__e83327', 't2__89f3a3')
('t1__1b7e15', 't1__e83327', 't2__89f3a3')
('t1__1b7e15', 't1__e83327', 't2__89f3a3')
('t1__1b7e15', 't1__e83327', 't2__89f3a3')
*/