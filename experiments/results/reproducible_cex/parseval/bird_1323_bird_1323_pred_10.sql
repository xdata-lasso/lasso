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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_1', 'gce376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9', 'l7', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_2', 'x1', 'ji7zwau2', 'dwyrq13pyu78', '9', 'rljsl0b4y', 'p5qi2rkf9v', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_3', 'pz0f8jegd', '1vy9uxj4', 'wb', 'v', 'ph2', 'nd', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_4', 'cx5hn', 'p', 'jtu0d', '79fjgq8', 'n2f3dqv0gcb9', 'ozk3zbily', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_5', '6vck6ah0f8js', 'wlq7xb', '72fxa7ryfd', 'z16ni', 'jai', 'dh5ogrgj', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_6', '1afgo', 'ri', 'tsj3ayxp1q4', '01jh3den', 'c68x8vacx', 'afu5w1of7', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_7', '72ct', 'c', 'mfg62', '0v', 'q8qdjpe1', 'o22', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_8', '7cvtjpttg6b', 'ou5z', '36c', 'bfkfoacd', '7z2zezj', '7wgx', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_9', 'xcmr0', 'ztdg', '5i3', 'q5l', 'pim5', '58q', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_10', 'r94gth2m', 'ajjl', '3', 'okv8uttmu2', 'e578', 'fvy', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_11', 'be8yvkv42q7', 'x58b4', 'pmaus3auvmkr', 'pdjwzw5chn9', 'o705', 'a9n0jxfofws', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_12', '2zobb0q0k32o', 'w', 'l', '5amsorlwyngc', 'dj9erhi', 'zgk1yoeyo6l0', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_13', 'fuqyxuzkb', '521gwnlas6e', 'lboeowii1z5', 'xih6', '2q2xlyoto', '9oaawg', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_14', '0', 'bindz', '9tajz9td', 'n5wcgumbc', '3tdu6bd0w960', 'vzxw1rxe', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_15', '7qk', '162nh55y3d', 'ohvu06dza3', 'rmkio18r', 'i2hy08ftp6', 'wt', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_16', 'jaby', 'mzn2mfx7h3', 'p6sto1cj', 'sh5knzys7', 'y', 'yd1jmgjach8', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_17', '8y3a17v4yg', 'mayq3qdpua', '96rn', 'dqrhm', 'wlic7dn2', 'p490', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_18', 'sqtgelcuqb', 'i9f2ccukj', '1quik', 'yhb08hl', 't1pqo', 'iztv', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_19', 'z78', 'q', 'lud8f', 'tb8r9114qbre', '6bjeuuwsj8k', 'h85', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_20', 'lvrisurz0k', 'q', 'ncgc8', '3b7v8', 'kwdmdbdht', 'j47nxar50', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_21', 'an', 'xdpunmw', 'wx', 'rlawk', '14r5dqt', 'mg97a', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_22', 'u0h', 'r133ir1a', 'yyhpl2', '9es', 'p', 'pgckqwtsr', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_23', '6qje', 'ktb1d2nzg3rj', 'wns', '47j2ja8dccy3', 'vjwq49yrnx', '6dvdx', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_24', 'gvplj9fj', 'uun7k1', 'z2my1og', 'v1rgeza', 'xc1clupgly', '8oitxeilp', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_25', '19cy7od033d', 'hds', 'nhed29', 'qv2', 'u331spxpw', '0bgwkxgi', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_26', '6idmp61l2o', 'ak162oca', 'je', 'vx', 'xlu49ku', 'o', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_27', '4u', 'kh', 'llbwvdpu5v0e', 'u', 'y9v2z12983', '5xoepacxdb2f', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_28', 'yet', 'xjhcf46cf', 'perxa61sjv', 'nv3ddroku', 'zc', 'ehia3', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_29', '7', 'vpc0xffwor1e', 'ksf9q', '2qg01huij', '7f8kqhiu5g', '8gxb', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_30', 'saw', 'p4kwi', 'hl7j43y7', '5ybv83kr3', 'w4jn2z19xgj', 'jacgmukfb5', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_31', 's27xh8', '8y1k253sb', '9ls1ehn1', 'daqq', 'yy', 'snp64hm', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_32', '4m0rrwbjk0', 'p', '6g', 'w', '7', 'jjplwtlzh42n', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_33', 'rji5mqk', 'na38gfxswb2d', 'zmxwdb7', 'tp5q', '1k4c', 'gwnkd4kc3', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_34', 'zr90nh', 'p9gob', '6', 'rn5u', 'phy', 'n', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_35', 'hvyx8s', 'r', 'fs3qn0b', 'm2rlxcrw', 'x0', '3rzgz84lqm', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_36', 'b3vun66', '0i', 'olt0', '0zi90o50q', '33g865zm6', 'p', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_37', '092p40', '2vil21', 'sad6q5', 'iqoauy0', '3lwh994f', 'qc1m9gr8xj', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_38', 'xd4s', '5il', 'wnd6dvygw', 'akmwgw73fy3d', 'dip', 'txfbl10qx6j', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_39', 'fc75m4s2ajdu', '6xuj90te', 'x3', '5u7709', 'qf9lx8qzabi', 'uumwu7', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_40', 'jwk6hh2', 'oe79350fzrv1', 'l93', '0xvkviql6n0r', 'psa', 'xeeinmbciv5', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_41', 'eqv3', '3uxdo', 'a0ol1z', 'mjrssbh72404', 'pp330', 'a1ngqut8', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_42', 'ojdlhl', 'pdyxk0a', 'cql1c8c', 'wvadbp0760', 'gk2hjz', 'pg1lcg', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_43', 'kj', 'og8dw16f5tqh', 'd5m', 'b', 'kr2t', 'dlb6i42', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_44', 'w5c29dwt1ha', 'vc2c4zpw8672', 've', 'jf4i5t9', '9kvnbhvi6t', '3tfn', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_45', '6sru4eu', 'io', '8o', '6b', 'p9qgjradfhj', '8zr6k53p8e5o', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_46', 'f1ur8kz', '0g5', '0j597fznqc', 'ex41fa', 'c1je44', 'u5lvdbp3c', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_47', '3o', 'lciif0l', '46upleo', 'h3m3q0pq97j', '534j5xbk11y', 'pzc7x', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_48', 'mpjj', 'ec2trn', '6j72vkwegrf', '6snl45jw5pb', 'wo', 'nhh', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_49', 'tdx5hn75', 'b733o58zbgyx', '0twou', '4', 'yi4h5c4f1q', '9w43ial8s8', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_50', 'j9fodt9k', 'cq2iae6aj6ql', '676lk8q', 'azkjyfxsov', '98', '8', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_51', '5v8ikp3q', '77cxsw', 'r1', '4vu6v8hk', 'lzy93zu8yb', '4qpog5smdhct', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_52', 'y6whwhlh5', 'i1dtdjm8ry9l', 'hw6lv7j452', '1qz', 'qt5uw42p20', 'wt', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_53', '3bj', 'suy', '6h', 'zboodl', '60sijuf', 'c2vfghixbugx', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_54', '2isdq', '4u2fkzbw', '3q5br3', 'qobvbj26k', 'xc56', 'pvp0h2fln', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_55', 'orqtl1uodbvf', 'ya6l431g', 'feg6q6gifj', 'vxt41', 'jf1qj3s', '4d', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_56', 'l6rurl72', '8ippx', '6', '59q4tkf5j4c', '2y', '485ys1gz7p3h', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_57', 'ytzip2', 'a6d2hqs4zc1', '2282rnfvk', 'mfoqp', 'ucnn53i', '8owqwx0hv', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_58', 'h59i', 'nipn6d', 'okt16', 'qb', 'jae9ps4do', 'e0b6', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_59', 'kuizi', '2308npqdb', 'wew42zl4ptf8', 'l0lw90', '2klya', 'cw1g', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_60', 'r9d3zdayv', 'uhorvccw', 'raqxeddnko4', 'dq70691b7', 's1i0k8thqz3', 's94x3', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_61', '3u', 'ge', 'rz', 'w0qgiqh4ao3k', '9v09407sw', 'b3349kf5l6rn', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_62', 'bn', 'bp96', 'v5122bvxjnuw', '4jm31nfs4', 'iom2', '85br29', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_63', 'jnnb', 'sy75w', 'nagrj6o3', '7kajtw7', 'qiuj9', '94', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_64', 'nr8dq5', 'bz', 'jmeuvjvcr9', '03f', '15y8am0q', 'ut2', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_65', '6fr11luvk4', '7wggg', '0zchdq8o', 'xze42', 'wen', '4ilc', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_66', 'w6gv', 'c9l5', 'mrsv641', '6b', 'ugt8ygq', 'fzr1', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_67', 'ikr1whx1d', 'zbb', '27z', 'uuwyewb', 'hg8', '1ev3gqe', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_68', 'btcpo1ke8euy', '0kcxl8e4bkf', 'hyyx', 'm0cm', '8usy', 'c1vk27ki', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_69', 'f5nd', 'i8', '0zqe9rs1z82', 'wy4o1', 'qirlh', '1gx', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_70', 'm29vphx5vl', '7joby01skvh4', 'my4gp', '0kr5bk0d0gkg', 'qavutce54k', 'dvf12j4ljl', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_71', 'nheb', 'yaax', 'pyee2', 't2ugy7q', 'kj2d', 'sjla91nq7dx', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_72', 'a6wan', 'l7a', 'q6gahjc', '84vxo5', 'ddfra', '2n0lwczduqt0', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_73', '7gelrrulw', 'l', 'tk', 't', 'og8ol79cnlv', 'nzpkcp', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_74', 'z43yul6g2', 'jlkkggqx', 'x1w', 'nb', 'p186', 'a9g9nw16', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_75', 'ck', 'aioh8mpzf5t', 'lsok6v', 'gc', '3b0v293muo', 'o5cwanc56', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_76', 'y2vtctr95snh', 'c1jc1', 'j3dmll8k26', 'qohr35iptx', 'lhv1', 'ti78hf', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_77', 'kmxvvf', 'aq65q', 'vero7mfr86mo', '7pt', '0qbwhbis', 'zzg8eizd0cun', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_78', 'vz', 'qiwb', 'o', '90a5nxzf', 'as9e', 'zdfe0r841i6v', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_79', 'qzy', 'etff9znz5', 'a', 'yzmae7whkuxo', '6stk1uxpevo', 'sy9i6bswqb', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_80', 'ad', 'm3japip', 'zjd2zxpmaspu', 'abl7juf', 'hq6', 'd1hg2', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_81', 'k', 'tumvp1', '9dvetwec1zu8', 'x72pbzz', 'fp2srds4', 'd57xpoymk4y', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_82', 'ffs4e2yc4ssv', 'a836iviizc5', 'd', 'lp4', 'l71l0q4nksw', '506p6790', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_83', '0dafs830rj', '63fqszsmbw', 'k5paop6', '3z5p37ek', 'hfm81p', '91mps38', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_84', '5utc4wz1h52', '5f', '05rr8l', 'vqg3r2exf0w', 'asmde', 'khn0io22', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_85', '5ig2eidvgb', '8hbw21fs7', 'yc', 'b5af', 'v61keoynaj0p', 'k4nr', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_86', 'xf', 'ip6asmj57', 'd4t9h4gw', 'pvhdbn16i83y', 'qv3c1', '0qjx29a', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_87', 'x1siacshyuv', 'n3eac7v', 'dwkko5vwsu', 'ks6r', 'y62kek7hibs', 'fh8imiuk', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_88', '0f3gc', 'wa8dxhv0a9e', 'gzmc05e27', 'v0', 'ya12ba', 'pq9c3reyy', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_89', '2upbwnk4fgnm', '2sp7', 'mu28jur734t', 'bf', '14p8sxfs', 'dwyo5k', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_90', '94kiyf8vo', 'nlyn', 'mc1ovv1mq0f', '6ghsx10hz', 'mg804o5adjd1', 'n', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_91', 'f34rn', '3o89', '0', '6837bfhy', '50', 'z3vw9z57rl1', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_92', '9mrwyzbou0gy', 'jit2fgscgm', 'qs', 'buot7nieb', 'mq5mmu4', 'r', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_93', 'l', 'l899azbbz1', 'e2s5ue', 'nd4ryz6', 'k', 'b9yy48ude', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_94', '1wmig', 'g', 'h9o', 'c9m7k0', '5', 'ymsyqh2mcnrs', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_95', 'uid2gt', 'i8oy37f', 'j', '979bvh4', '4ewrogwhfh', 'askba', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_96', 'gt1ge577of', 'wummpy7d5', '0yo4lx0w', 'a0f75koo', 'b8ej953w', 'weolubkg0s', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_97', '0sso', '9pwkya142jc', '1bi3bpf7inp', 'cso6kngyf0', 'z754ee3rj', 'qnqmi', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_98', 'y5cdp', '7t', 'e', 'b', 'ta131', 'tavns', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_99', '5qs3c2cvt', 'mkki0f', 'ht8az', 'gz9', '7', 'e6w', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_100', '7n00oq5nqyj', 'wjqg220epb', 'l', 'mxz', 'ntdhb', '3jdb', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_101', 'xtsk', 'n719', 'bivw', 'hq5zahke', 'wmj9', 'cuti0zwcmv5', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_102', 'p2468', 'uxk6z7', 'kwu8s', 'va4tntw8', 'h5de', '6psktmhq', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_103', '1', 'arf', 'n', 'tma', 'l9', 'hunj3sxridw', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_104', 'mdp3ij', '9xfb6cb', 'j17954wg', 'fr6w64', 'uoryhibfz5', 'lpwmn8q', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_105', 'jff8', 'tredoattl20n', 'f9zz8hm9zgwo', '8e9rv', 'i32iv', '5yty8elwww', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_106', '4zvb0w3duew', 'udv3ox9kpgyf', 'iyqy68c1', 'ubc08gf1', 'tfq93b67ki', 'yizoy4y32', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_107', 'urwjmnmpyojg', 'm5lkdpy', 'hdtly', 'di24v5se6fa', '23', 'aip', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_108', 'c3n', 'v8', '3v7k4', 'x7if', '3f7tciep', '9sn5rawc8kbo', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_109', '4unla', '0t6gfq', '8r', 'ndj8gkae', 'nn5', 's9em7bx4i', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_110', 'mvfrrxh6', '8o25', 'zv', 'ymp7hu', 'zsqzkco32ur', '46il', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_111', 'ms2kp5', 'btm4bttk', 'rnps7mmhl', 'e8lg', '1ynq76swu', '6z4', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_112', 'dxssn791', 'kf0obtr1w0i', 'oeg70', '4o5j0f', 'ocmk0qsjf8b', '7kqe8sfpuh0', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_113', 'a929yb3', 'ftrf7q', '7o4', 'rnoo9u7i32vd', 'ue4cssd31t', 'zy', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_114', 'jizr1fuj', 'w9z', 'v', 'p3', '4a46nc', 'i6mt983k4gv', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_115', 'y5lx0', 'm5bl2pku0', 'dp9wl5pdi', 'j17p', 'nu5cc3', '7cnltrtrdse', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_116', 'au3vveg', '6kqybb', '8j2u0k8548', 'q', '5', 'fsg3nhy', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_117', 'cjozv4', 'nm8d0aqw', 'b5cbz2', 'lt2', 'jm6', 'g9', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_118', '4', 'mggorl', 'w2q4912p', 'ssi04buzky1', '0pjn', 'q0qwz1axdx', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_119', '53', 'u', 'tzcx7ym0', '5ab2uess3q7', 'y', 'wij', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_120', '27', 'nzxmd76s0wr0', '5a7p', 'y', '9e3mthh1', '613xc', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_121', '6mbox', 't4f8b', 'd3pwwpksr', 'nlh6x', '1c7l8zys', 'i', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_122', 'mxq', '9jctvc5o43u5', '5y', 'u', 'yqq5hak5', '3', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_123', 'pj9qch', 'wgesfxz8a', 's6y1ul1ww', 'd3', 'bf1a1q', 'qq54qa', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_124', 'yvh6l6gfq', 'xgyc', 'rwd95e', '0t7seki', 'm9dyv7l', 'd5jfvkb2z7d', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_125', 'umntpv4ejvy', 'of780p3iyj3', '0obs95', 'vdxh0kccwqie', '560s', 'w1ylk0l7tpn', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_126', '6', 't6ypqzp3f', '0wvwvuf4', 'rvm', 'ba49', 'z0tk', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_127', 's19gbdz', '3g', 'r6h', '6s', 'wsr', '5r5numa19c', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_128', '3ubwgz0', 'jmezmqqbk', 'c', 'hwu', '3pe', 'b4njaqrrvsr0', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_129', '8d', 'b', 'k0lyf4p5r5', 'k29yznmu', 'p2pjjwe9qy', 'g', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_130', 'xn0fy', 'sh9y8v3ce5', 'ylwc', '8ho', '2v5q', 'xsi1onolu', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_131', '9ee3jgc9cbt', 'dbu', 'a2w2b5', '2o86cch', 'o58adh', 'n4md', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_132', 'km83k0bxojj5', '2qo4', '8woz', '2iizx913615g', 'lb8utwvxr8fs', 'lr0k8', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_133', '0h381', 'r', 'cy7587', 'bjgh', 'rntntdgucf', 'pv650pt', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_134', 'p', 'umu7ciqifp', 'i7pn', '8zg8', 'b2uxljoxim2g', 'tsaek5oij', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_135', 'wcgw4kva5dw', '7ak0', 'xdcy38', 'hko', '5kj', 'fg', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_136', 'zxbk7v82zkjx', '0nuaazgrflq', 'r7b0g38mhq', 'a', 'x548d', 'sit3z06eij9e', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_137', 'x', 'f95k0o06u', '6lx6vao', '9jso', 'ct5x4', 'gibx4kcn', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_138', 'h9', 'q84l', 'don2eax1918q', 'l7s7nvov', 'wdu', '3kql', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_139', 'i', '4ps6pt3m', 'qb', '23ik', '7cge', 'abtwsbo', -2147483648, 'major_id_1');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__54c0ad', 't1__488246', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', 't1__488246', 'z2o20', 'pj6ddlysu6ip', 'dk', 'u2gir31vwq5', 'oa2sb3u');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_2', 't1__488246', 'i1pa', 'cvwnyq', 'ouirl', 'rpouit63xyf', 'mjwpp2');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('C', 't1__488246', 'f41', '80terbfokvee', 'sltut6lu2', 'cel8mhfcim', 'n5enii0fmbgz');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('1', 't1__488246', 'nehcnt2v', 'lraxg0gt', 'ot6vp1', 'lrhqsxyube', 'yhmlrnycz8d5');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__230a54', 't1__488246', 'dd30', 'uj2sy8vsand9', '0a6m4y0yq', '40lm2wxr0f', 'l4ssv4os18g');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'bnp', 'mdpos', 'ie5', 'nw6klf', 'a9000t5c4eci');

-- Inserting into table: attendance --
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__54c0ad', 'member_id_1');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__54c0ad', 'member_id_2');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__54c0ad', 'member_id_3');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__54c0ad', 'member_id_4');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__54c0ad', 'member_id_5');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__54c0ad', 'member_id_6');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__54c0ad', 'member_id_7');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__54c0ad', 'member_id_8');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__54c0ad', 'member_id_9');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__54c0ad', 'member_id_10');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__54c0ad', 'member_id_11');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__54c0ad', 'member_id_12');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__54c0ad', 'member_id_13');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__54c0ad', 'member_id_14');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__54c0ad', 'member_id_15');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__54c0ad', 'member_id_16');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__54c0ad', 'member_id_17');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__54c0ad', 'member_id_18');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__54c0ad', 'member_id_19');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__54c0ad', 'member_id_20');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__54c0ad', 'member_id_21');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_17');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_7');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_1');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_15');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_22');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_23');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_2');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_8');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_24');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_19');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_25');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_20');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_26');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_3');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_18');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_27');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_14');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_28');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_29');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_16');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_30');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_31');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_32');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_33');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_9');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_34');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_35');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_5');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_36');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_37');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_38');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_39');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_40');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_41');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_42');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_43');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_44');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_4');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_45');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_12');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_46');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_47');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_48');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_49');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_50');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_51');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_52');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_6');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_53');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_54');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_55');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_56');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_57');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_58');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_59');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_60');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_61');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_62');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_63');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_64');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_65');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_66');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_67');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_68');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_69');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_70');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_71');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_72');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_73');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_74');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_75');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_13');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_76');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_77');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_78');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_79');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_80');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_81');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_82');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_83');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_84');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_85');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_86');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_87');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_88');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_21');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_89');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_90');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_91');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_92');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_93');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_94');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_95');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_96');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_97');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_98');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_99');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_i_100');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_i_101');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_i_102');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_i_103');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_i_104');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_i_105');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_i_106');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_i_107');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_id_18');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_id_12');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_id_97');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_id_88');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_id_8');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_id_24');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_id_21');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_id_94');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_id_46');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_id_69');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_id_86');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_id_98');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_i_108');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_id_51');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_id_95');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_i_107');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_i_109');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_i_110');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_id_16');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_id_35');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_i_105');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_id_80');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_id_6');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_id_82');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_id_27');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_id_72');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_id_81');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_id_92');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_id_28');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_id_91');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_id_30');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_id_56');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_id_26');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_i_111');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_id_31');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_id_57');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_i_112');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_i_113');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_id_90');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_id_15');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_id_14');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_i_114');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_i_115');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_i_116');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_i_117');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_i_118');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_id_5');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_id_71');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_id_93');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_id_55');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_i_119');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_i_120');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_i_121');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_i_122');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_id_45');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_id_84');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_id_48');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_id_53');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_id_63');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_i_123');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_id_50');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_id_89');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_id_23');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_id_66');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_id_76');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_id_47');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_i_124');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_i_125');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_i_126');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_id_32');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_i_127');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_i_100');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_i_128');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_i_129');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_i_130');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_id_41');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_i_131');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_i_132');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_i_133');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_i_102');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_i_134');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_id_85');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_id_19');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_i_135');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__230a54', 'member_id_62');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__54c0ad', 'member_i_136');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__54c0ad', 'member_id_90');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__54c0ad', 'member_i_114');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__54c0ad', 'member_id_92');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__54c0ad', 'member_id_36');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__54c0ad', 'member_id_74');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__54c0ad', 'member_id_89');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__54c0ad', 'member_i_137');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__54c0ad', 'member_id_62');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__54c0ad', 'member_i_124');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__54c0ad', 'member_id_97');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__54c0ad', 'member_i_138');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__54c0ad', 'member_i_134');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__54c0ad', 'member_id_44');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__54c0ad', 'member_id_34');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__54c0ad', 'member_id_46');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__54c0ad', 'member_id_88');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__54c0ad', 'member_i_117');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__54c0ad', 'member_id_83');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__54c0ad', 'member_i_139');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__54c0ad', 'member_id_49');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__54c0ad', 'member_i_116');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_name FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event GROUP BY T1.event_id HAVING COUNT(T2.link_to_event) > 20;

/*
Gold Result:
('t1__488246',)
('t1__488246',)
('t1__488246',)
*/

-- Prediction Query
SELECT "event"."event_name" FROM "event" INNER JOIN "attendance" ON "event"."event_id" = "attendance"."link_to_event" WHERE "event"."type" <> 'Fundraiser' GROUP BY "event"."event_name" HAVING COUNT("attendance"."link_to_event") > 20;

/*
Prediction Result:
('t1__488246',)
*/