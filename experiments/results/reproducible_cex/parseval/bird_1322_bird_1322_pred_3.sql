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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_1', 'b4yp5qi', 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4', 'wb', 'v', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_2', 'gndqwnqc', 'x5hncprjtu0', 'z', '9fjgq8n2f', 'dqv0gcb9', 'ozk3zbily', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_3', '6vck6ah0f8js', 'wlq7xb', '72fxa7ryfd', 'z16ni', 'jai', 'dh5ogrgj', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_4', '1afgo', 'ri', 'tsj3ayxp1q4', '01jh3den', 'c68x8vacx', 'afu5w1of7', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_5', '72ctdctmfg62', '0v', 'q8qdjpe1', 'o22', '8507cvtjp', 'ttg6bnou5zi3', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_6', 'f', 'foa', 'cd07z2zezjo7', 'wgxd5ysxcm', '0oztd', 'j5', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_7', '5lnpi', '5k58', 's27p2', '94gth', '2mnajjla3o', 'v8u', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_8', '2ne578', 'fvy', '7zzbe8y', 'kv42q7', 'x58b4', 'pmaus3auvmkr', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_9', 'wzw5chn9mo70', 'a9n0jxfo', 'ws', 'do2zobb', 'q0k32od', 'cl5ams', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_10', 'yngc1d', 'j9erhizgk1', 'yoeyo6l0hdt6', 'uq', 'xuzkb52', 'gwnlas6', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_11', 'boeowii1z5nx', 'h66', 'q2xlyoto', '9oaawg', '6aqb0tbin', 'z', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_12', 'jaby', 'mzn2mfx7h3', 'p6sto1cj', 'sh5knzys7', 'y', 'yd1jmgjach8', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_13', 'a8y3a17v4yg', 'mayq3qdpua', '96rn', 'dqrhm', 'wlic7dn2', 'p490', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_14', 'sqtgelcuqb', 'i9f2ccukj', '1quik', 'yhb08hl', 't1pqo', 'iztv', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_15', 'lud8f', 'tb8r9114qbre', '6bjeuuwsj8k', 'h85', 'pxlvri', 'surz0kaqtncg', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_16', '7', 'v88kwdmdbd', 't6', 'j47nxar50h', 'sjhanzxdpu', 'mwfw', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_17', 'awk', '14r5dqt', 'mg97a', 'z2o20', 'pj6ddlysu6ip', 'dk', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_18', '31vwq', '1oa2sb3u', 'i1pa', 'cvwnyq', 'ouirl', 'rpouit63xyf', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_19', 'wpp26mb3aj0j', '0h3r13', 'ir1axyyh', 'l2i9', 'sa', '8pgc', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_20', 'sr54o', 'qjektb1d2', 'zg3r', 'jkwns47j2j', '8', 'c', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_21', 'vjwq49yrnx', '6dvdx', 'o', 'v7t3gvpl', '9fj', 'uun7k1', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_22', 'y1og', 'v1rgeza', 'xc1clupgly', '8oitxeilp', 'e019cy7od0', '3dlhdsvn', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_23', 'vdpu5v', 'eduy9v2', '129835x', 'epac', 'db2f0c', '96xiyet8', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_24', '6cfperxa', '1sjv8nv3d', 'r', 'kuez', 'ctehia3cmvb', '7vpc0xffwo', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_25', '80terbfokvee', 'sltut6lu2', 'cel8mhfcim', 'n5enii0fmbgz', 'oqxs27xh', '88y1k253s', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_26', 'ehn1mdaqqh', 'yyzsnp64hm', 'nw4m', 'rrwbjk0', 'p', '6g', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_27', '7', 'jjplwtlzh42n', 'j5yrji5', 'qkna', '38gfxswb2d0', 'mxwdb7o', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_28', '5qo1k4c6gwn', 'kd4kc3iikaxz', '90nhs', '9gob', '6', 'rn5u', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_29', 'bnaayvh', 'vyx8scr0fs3', 'qn0b5m2rlxcr', 'fx03rz', 'z8', 'lqme2wb1', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_30', 'n66e0i', 'olt0', '0zi90o50q', '33g865zm6', 'p', 'ewew092p40', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_31', 'il21xs', 'd', '6q5ziqoauy0', '3lwh994f', 'qc1m9gr8xj', 'qbloxd4sj5il', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_32', 'd6dvygwakmwg', '73fy3d', 'dip', 'txfbl10qx6j', 'd4fc75m4s', 'ajdu26xu', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_33', 'vkviql', 'n0rlpsaxe', 'in', 'bciv', 'ojsmeqv3', '3uxdo', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_34', 'zmjrssb', '72', '404qpp3303a1', 'gqut', '184dwojdl', 'lz', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_35', '0', 'q', '1c8', 'w', 'adbp07', '0ugk2hjzx', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_36', 'cg9', '4', 'kj', 'og8dw16f5tqh', 'd5m', 'b', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_37', 'dlb6i42', 'tew5c29d', 't1havc', 'c4zpw867', 'fve0jf4i', 't99kvnbh', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_38', '3tfn', 'dtw89qy6sru4', 'uf', 'of8', 'f6bp', 'qgjradfhj', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_39', 'k53p8e5ol', 'f0yf1ur8kzi', '0g50j597fz', 'qcue', '41faxc', 'je448u5', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_40', 'p', '3cehye3oylc', 'if0', 'ly46upleoh', 'm3q0pq97', '534', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_41', '11y', 'pzc7x', 'v4pmp', 'jve', '2', 'rn6j7', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_42', 'kwegrf6snl45', 'jw5pbgwojn', 'hh6va3tdx5hn', '5b733o58z', 'g', 'xt0twou', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_43', '4h5', '4', '1q', '9w43ial8s8', 'sp4j9fod', 't9kcq2iae6', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_44', '167', '6lk8qazkjy', 'fxsove98b8', '0235v8ik', '3qu7', 'cxswgr124', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_45', 'hklzy93zu', '8yb4qpog5sm', 'h', 't', 'nj8y6whwhl', '5i', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_46', 'j', '8ry9', 'hw6', 'v7j', '52k1qzqt', 'uw42p20g', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_47', 'l3bjksu', 'e6hvzbo', 'dlz6', 'sijufc2', 'fghixb', 'gxislq', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_48', 'u2fkzbwx', '3q5br37qobv', 'j', '26kpxc567p', 'vp0h2flntlco', 'qtl1u', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_49', 'vf3ya6l431gf', 'g6', '6gifj', 'vxt41', 'jf1qj3s', '4d', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_50', 'l6rurl72', '8ippx', '6', '59q4tkf5j4c', '2y', '485ys1gz7p3h', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_51', 'ytzip2', 'a6d2hqs4zc1', '2282rnfvk', 'mfoqp', 'ucnn53i', '8owqwx0hv', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_52', 'h59i', 'nipn6d', 'okt16', 'qb', 'jae9ps4do', 'e0b6', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_53', 'kuizi', '2308npqdb', 'wew42zl4ptf8', 'l0lw90', '2klya', 'cw1g', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_54', 'd3zdayv5u', 'or', 'ccwraq', 'eddnko', '7dq70691', '7', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_55', 'i0k8thqz3rs', '4x3yyxg3u', 'ge', 'rz', 'w0qgiqh4ao3k', '9v09407sw', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_56', '49kf5l6r', 'nd3rhbnmbp9', 'v5122bvxj', 'uw84', 'm31', 'fs4n', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_57', '2u85', 'r', '971kpjnn', 's', 'y75w5', 'nagrj6o317ka', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_58', 'sqiuj9f94', 'ycwnr8dq', '5gbzjmeuvjv', 'cr9l03f515y', '8am0qjut2f31', '6fr11luvk4', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_59', 'g3', 'zchdq8o', 'xze42', 'wen', '4ilc', 'kspw6gvo', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_60', 'zmrsv641', '6b', 'ugt8ygq', 'fzr1', 'v7z6i', 'r1w', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_61', 'zbb', '27z', 'uuwyewb', 'hg8', '1ev3gqe', 'nehcnt2v', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_62', 'axg0gtxot6', 'p1lrhq', 'xyube', 'yhmlrnycz8d5', 'kabtcpo', '1ke8euy0kcx', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_63', 'kfphyyxnm0', 'm', '8usy', 'c1vk27ki', 'uvof5ndg', '80z', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_64', 'z82twy4', 'o1sqirlhj1', 'xi', 'o9km29vphx5v', '7jo', 'y', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_65', 'vh4', 'my4gp', '0kr5bk0d0gkg', 'qavutce54k', 'dvf12j4ljl', 'hxdpnhebny', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_66', 'pyee2', 't2ugy7q', 'kj2d', 'sjla91nq7dx', 'g9rta6', 'wanil7azq6', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_67', 'cu84vxo5sddf', 'a2n0l', 'czduqt', 'ig197ge', 'rru', 'lwblhtkbto', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_68', 'wnzpkc', 'w0q9', 'z43yul6g25', 'lkk', 'gq', 'kx1wfn', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_69', '1864a9g9nw1', 'bb6teckai', 'h8mp', 'f5tulso', 'k6vhgc3b0v2', '3muo9o5cw', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_70', '6gwfuy2v', 'ctr95', 'snhqc1jc1j3d', 'll8k', '6qohr35i', 'ptxmlhv1xt', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_71', 'w', 'wwkmxvvfta', 'q65qvero7mf', '86mok', 'pt50qbwhb', 'szz', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_72', 'd0cunhg', 'mgvzmqiwb', 'o', '90a5nxzf', 'as9e', 'zdfe0r841i6v', -2147483648, 'major_id_1');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__8a6031', '5k5swwqcgs', '9n8', 'Meeting', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__db457f', 'hria2ypuzhs', 'rwbbp6luhvd', 'Meeting', 'tti', 'bnp', 'mdpos');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__413d6a', 'ie5', 'nw6klf', 'Meeting', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', '9tajz9td', 'n5wcgumbc', 'Meeting', '3tdu6bd0w960', 'vzxw1rxe', '9yfk7qk162n');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('@', '55', '3dohvu0', 'Meeting', 'dza35rmki', '18ri', 'hy08ftp6');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('C', 'ed', '9lqv26u3', 'Meeting', '1spxpw30', 'g', 'kxginl');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('O', '6id', 'p61l', 'o3ak162o', 'cagjeevxzxlu', '49kuboe8cd', '4u');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Q', 'sk', 'f9q82', 'Meeting', 'g01hu', 'j7f', '8kqhiu5gm8');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('G', 'xb', 'qjlsawsp', 'kwi3hl7j', '3y795ybv', '3kr3w4jn2', '19xgjja');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__8c1fc8', 'j90tefx3u5u', '709qf9lx8', 'Meeting', 'qzabivuumwu', 'alj0jwk6h', '2o');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'l7', 'klex14ji', '7zwau2dwyr', '13pyu', '8d99rljsl');

-- Inserting into table: attendance --
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__8a6031', 'member_id_1');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__8a6031', 'member_id_2');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__8a6031', 'member_id_3');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__8a6031', 'member_id_4');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__8a6031', 'member_id_5');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__8a6031', 'member_id_6');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__8a6031', 'member_id_7');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__8a6031', 'member_id_8');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__8a6031', 'member_id_9');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__8a6031', 'member_id_10');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__8a6031', 'member_id_11');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', 'member_id_2');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', 'member_id_6');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', 'member_id_5');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', 'member_id_12');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', 'member_id_13');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', 'member_id_14');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', 'member_id_1');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', 'member_id_9');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', 'member_id_4');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', 'member_id_8');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', 'member_id_3');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', 'member_id_7');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', 'member_id_15');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', 'member_id_10');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', 'member_id_16');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', 'member_id_17');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', 'member_id_11');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', 'member_id_18');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', 'member_id_19');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', 'member_id_20');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', 'member_id_21');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', 'member_id_22');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('O', 'member_id_3');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('O', 'member_id_19');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('O', 'member_id_20');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('O', 'member_id_6');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('O', 'member_id_4');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('O', 'member_id_23');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('O', 'member_id_12');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('O', 'member_id_5');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('O', 'member_id_24');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('O', 'member_id_9');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('O', 'member_id_14');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_22');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_2');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_20');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_4');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_7');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_11');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_6');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_3');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_1');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_16');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_5');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('O', 'member_id_25');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('O', 'member_id_1');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('O', 'member_id_16');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('O', 'member_id_18');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('O', 'member_id_26');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('O', 'member_id_27');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('O', 'member_id_28');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('O', 'member_id_29');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('O', 'member_id_30');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('O', 'member_id_31');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('O', 'member_id_32');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_5');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_30');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_32');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_27');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_6');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_26');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_18');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_22');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_28');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_12');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_33');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_24');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_1');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_34');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_16');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_4');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_25');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_35');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_36');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_13');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_11');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_37');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_38');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_39');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_40');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_10');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_41');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_42');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_43');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_44');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_45');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_46');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_23');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_20');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_47');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_29');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_9');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_19');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_48');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_15');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_49');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_50');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_51');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_52');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_53');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_14');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_54');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_55');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_56');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_57');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_58');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_59');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_60');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_8');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_61');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__8a6031', 'member_id_31');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__8a6031', 'member_id_48');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__8a6031', 'member_id_52');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__8a6031', 'member_id_46');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__8a6031', 'member_id_62');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__8a6031', 'member_id_12');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__8a6031', 'member_id_35');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__8a6031', 'member_id_63');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__8a6031', 'member_id_61');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__8a6031', 'member_id_44');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__8a6031', 'member_id_17');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_64');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__8c1fc8', 'member_id_65');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__8a6031', 'member_id_66');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__8a6031', 'member_id_13');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__8a6031', 'member_id_67');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__8a6031', 'member_id_14');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__8a6031', 'member_id_29');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__8a6031', 'member_id_24');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__8a6031', 'member_id_68');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__8a6031', 'member_id_69');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__8a6031', 'member_id_70');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__8a6031', 'member_id_71');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__8a6031', 'member_id_72');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__8a6031', 'member_id_27');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.event_id) FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event WHERE T1.type = 'Meeting' GROUP BY T1.type HAVING COUNT(T2.link_to_event) > 10;

/*
Gold Result:
(113,)
*/

-- Prediction Query
SELECT COUNT(T1.event_id) FROM event AS T1 JOIN attendance AS T2 ON T1.event_id = T2.link_to_event GROUP BY T2.link_to_event HAVING COUNT(T2.link_to_member) > 10 AND T1.type = 'Meeting';

/*
Prediction Result:
(22,)
(34,)
(57,)
*/