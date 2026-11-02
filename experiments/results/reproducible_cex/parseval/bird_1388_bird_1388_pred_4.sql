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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__9c02ff', 't1__786330', 't1__5d3d51', 'bnp', 'mdpos', 'ie5', 'nw6klf', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__c4f0b1', 't1__786330', 't1__5d3d51', '00t5c4ecigc', 'e376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__95efd1', 't1__786330', 't1__5d3d51', 'tliqa1', 'ryytoo3', '9hl7', 'klex14ji', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 't1__786330', 't1__5d3d51', '1vy9uxj4', 'wb', 'v', 'ph2', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('C', 't1__786330', 't1__5d3d51', 'q', 'nqcx5h', 'cprj', 'u0dz7', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('_', 't1__786330', '\', 'f8jswwl', '7xb72', 'xa', '7ryfdrz16n', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_6', 't1__786330', '\', '5dh', 'ogrgjd8y', 't1afgog', 'itsj3', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', 't1__786330', '!', 't', 'mfg62g0v5q8q', 'j', 'e1io', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_8', 't1__786330', '!', '7cvtjpttg6b', 'ou5z', '36c', 'bfkfoacd', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_10', 't1__786330', '0', '94gth', '2mnajjla3o', 'v8u', 'tmu2n', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_11', 't1__786330', '(', 'rpd', 'wzw', 'chn9mo70', 'a9n0jxfo', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_12', 't1__786330', 'L', 'fuqyxuzkb', '521gwnlas6e', 'lboeowii1z5', 'xih6', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t2__c6cbea', 't1__786330', 't1__5d3d51', 'd0w9603vzxw1', 'xe9yf', '7qk', '162nh55y3d', -2147483648, 'major_id_1');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', '5k5swwqcgs', '9n8', '4');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti');

-- Inserting into table: income --
INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_1', '7zwau2dwyr', -1021749117, 't2__661ca8', '3pyu78d99r', 't1__9c02ff');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_2', 'jsl', -346339240, 't2__661ca8', 'yp5qi2rk', 't1__9c02ff');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_3', '9v', 556727997, 't2__661ca8', '8pz0f8je', 't1__9c02ff');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('Q', 'q8', -1255130038, 't2__661ca8', '3d', 'A');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('A', 'qv0gcb98ozk', -155284187, 't2__661ca8', 'i', 'A');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_4', 'yrk', 32204797, 't2__661ca8', 'k', 'A');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_7', 'y', 1, 't2__661ca8', 'p1q430', 't1__c4f0b1');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_8', 'jh3den8', 0, 't2__661ca8', 'c68x8vacx7', 't1__c4f0b1');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_9', 'f', -47052816, 't2__661ca8', '1of77pzo72c', 't1__c4f0b1');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_10', '7z2zezj', 0, 't2__661ca8', '7wgx', 't1__c4f0b1');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_11', '5', -1, 't2__661ca8', 'sxcmr0o', 't1__c4f0b1');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_12', 'ztdgj5i3lq5l', 1339733032, 't2__661ca8', 'im5k', 't1__c4f0b1');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_13', '57', 1, 't2__661ca8', 'lfvyz7zzb', 't1__c4f0b1');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_14', '8y', 0, 't2__661ca8', 'kv42q7', 't1__c4f0b1');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_15', 'x58b4', -1122409769, 't2__661ca8', 'u', 't1__c4f0b1');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_16', 'ws', 1, 't2__661ca8', 'do2zobb', 't1__c4f0b1');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_17', 'q0k32od', 0, 't2__661ca8', 'cl5ams', 't1__c4f0b1');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_18', 'orlwyngc1dj', 211603887, 't2__661ca8', 'rhizgk1yoey', 't1__c4f0b1');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_19', '2q2xlyoto', 0, 't2__661ca8', '9oaawg', 't1__c4f0b1');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_20', '6aqb0tbin', -1, 't2__661ca8', 'z', 't1__c4f0b1');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_21', '9tajz9td', 152478847, 't2__661ca8', '5wcgumbc3td', 't1__c4f0b1');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('_', '6dza35r', 2072023304, 't2__661ca8', 'io18ri2hy08', 't2__c6cbea');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_22', 'tp', 24053253, 't2__661ca8', 'tqxxnj', 't2__c6cbea');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_24', 'mfx7h33p', 63063873, 't2__661ca8', 'o1cj8', 't2__c6cbea');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('O', 'ys7dyyd1jmg', 729543907, 't2__661ca8', 'c', 't2__c6cbea');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_25', '8q', 280292620, 't2__661ca8', 'a8y3a17v4yg', 't2__c6cbea');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_27', 'dpuap96rnt', 1139012231, 't2__661ca8', 'hm5wl', 't2__c6cbea');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('G', 'p490xdmsqt', -1685482179, 't2__661ca8', 'cuq', 't2__c6cbea');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_28', '9', -1750715330, 't2__661ca8', 'ccukjq1qui', 't2__c6cbea');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_30', 'hlst1pqom', 0, 't2__661ca8', 'ztv', 't1__9c02ff');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_31', '6', -1, 't2__661ca8', '4iz7', 't1__9c02ff');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_32', 'aqqlud8ft', 1183069552, 't2__661ca8', '4qbre6b', 't1__9c02ff');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_33', '8kj', 1, 't2__661ca8', '85', 't1__9c02ff');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_34', 'pxlvri', 0, 't2__661ca8', 'surz0kaqtncg', 't1__9c02ff');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_35', 'c8s3b7v88k', -622923312, 't2__661ca8', 'dbdh', 't1__9c02ff');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_36', '50hsj', 0, 't2__661ca8', 'an', 't1__9c02ff');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_37', 'xdpunmw', -1, 't2__661ca8', 'wx', 't1__9c02ff');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_38', 'rlawk', 558684943, 't2__661ca8', 'r5dqtsmg', 't1__9c02ff');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_39', 'pj6ddly', 2, 'G', 'u6iph', 't1__9c02ff');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_40', 'k', 2, 'G', 'u2gir31vwq5', 't1__9c02ff');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_41', 'oa2sb3u', 3, 'A', 'i1pa', 't1__9c02ff');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_42', 'rouir', 2, 'I', 'rpo', 't1__9c02ff');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_43', 'it63xy', 2, 'I', 'vm', 't1__9c02ff');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_44', 'wpp', 3, 'A', '6mb3aj0j', 't1__9c02ff');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_45', '33ir1axyyh', 2, 'M', 'l2i9', 't1__9c02ff');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_46', 'sa', 2, 'M', '8pgc', 't1__9c02ff');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_47', 'qwt', 3, 'A', 'r54o6', 't1__9c02ff');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_48', '1d2nzg3rjk', 2, 'O', 'ns47j2', 't1__9c02ff');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_49', 'a8d', 2, 'O', 'c', 't1__9c02ff');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_50', '3vjwq49', 3, 'A', 'yrnxs6dvdx', 't1__9c02ff');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_51', 'lj9f', NULL, 't2__661ca8', 'vuu', 't1__9c02ff');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_52', '7k10', NULL, 't2__661ca8', 'z2my1ogyv1r', 't1__9c02ff');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_53', 'ez', NULL, 't2__661ca8', 'x', 't1__9c02ff');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_54', 'ly', NULL, 't2__661ca8', '8oitxeilp', 't1__9c02ff');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_55', 'e019cy7od0', NULL, 't2__661ca8', '3dlhdsvn', 't1__9c02ff');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_56', 'ed', NULL, 't2__661ca8', '9lqv26u3', 't1__9c02ff');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_57', '30bgwk', NULL, 't2__661ca8', 'xginlj6idm', 't1__9c02ff');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_58', '61l2', NULL, 't2__661ca8', 'o3ak162ocagj', 't1__9c02ff');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_59', 'ev', NULL, 't2__661ca8', 'zxlu49', 't1__9c02ff');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_60', 'e', NULL, 't2__661ca8', 'uekhllbw', 't1__9c02ff');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_61', 'dpu5v0', NULL, 't2__661ca8', 'du', 't1__9c02ff');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_62', 'y9v2z12983', NULL, 't2__661ca8', '5xoepacxdb2f', 't1__9c02ff');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_63', 'et8xjhcf46c', NULL, 't2__661ca8', 'pe', 't1__9c02ff');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_64', 'rxa61sjv8nv', NULL, 't2__661ca8', 'ddrokuez', 't1__9c02ff');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_65', 'ctehia3cmvb', NULL, 't2__661ca8', '7vpc0xffwo', 't1__9c02ff');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_66', '9q', NULL, 't2__661ca8', '2qg01huij', 't1__9c02ff');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_67', '7f8kqhiu5g', NULL, 't2__661ca8', '8gxb', 't1__9c02ff');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_68', 'qjlsawsp', NULL, 't2__661ca8', 'kwi3hl7j', 't1__9c02ff');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_69', '83kr3w', NULL, NULL, 'jn2z19xg', 't1__9c02ff');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_70', 'jac', NULL, NULL, 'gmukfb5if4', 't1__9c02ff');

INSERT INTO "income" ("income_id", "date_received", "amount", "source", "notes", "link_to_member") VALUES ('income_id_71', '80terbf', NULL, NULL, 'kvee', 't1__9c02ff');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.first_name, T1.last_name, T2.source FROM member AS T1 INNER JOIN income AS T2 ON T1.member_id = T2.link_to_member GROUP BY T1.first_name, T1.last_name, T2.source ORDER BY SUM(T2.amount) DESC, T1.first_name NULLS LAST, T1.last_name NULLS LAST, T2.source NULLS LAST LIMIT 1;

/*
Gold Result:
('t1__786330', 't1__5d3d51', 't2__661ca8')
*/

-- Prediction Query
SELECT m.first_name, m.last_name, i.source FROM member AS m JOIN income AS i ON m.member_id = i.link_to_member WHERE m.member_id IN (SELECT member_id FROM (SELECT link_to_member, SUM(amount) AS total_income, RANK() OVER (ORDER BY SUM(amount) DESC) AS income_rank FROM income GROUP BY link_to_member) WHERE income_rank = 1);

/*
Prediction Result:
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 'G')
('t1__786330', 't1__5d3d51', 'G')
('t1__786330', 't1__5d3d51', 'A')
('t1__786330', 't1__5d3d51', 'I')
('t1__786330', 't1__5d3d51', 'I')
('t1__786330', 't1__5d3d51', 'A')
('t1__786330', 't1__5d3d51', 'M')
('t1__786330', 't1__5d3d51', 'M')
('t1__786330', 't1__5d3d51', 'A')
('t1__786330', 't1__5d3d51', 'O')
('t1__786330', 't1__5d3d51', 'O')
('t1__786330', 't1__5d3d51', 'A')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', 't2__661ca8')
('t1__786330', 't1__5d3d51', None)
('t1__786330', 't1__5d3d51', None)
('t1__786330', 't1__5d3d51', None)
*/