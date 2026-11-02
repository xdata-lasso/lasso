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

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_48', '5pbgwo', 'nhh', '6va3tdx5hn7', 'b733o58z', 'g', 'xt0twou', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_49', '4h5', '4', '1q', '9w43ial8s8', 'sp4j9fod', 't9kcq2iae6', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_50', '167', '6lk8qazkjy', 'fxsove98b8', '0235v8ik', '3qu7', 'cxswgr124', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_51', 'hklzy93zu', '8yb4qpog5sm', 'h', 't', 'nj8y6whwhl', '5i', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_52', 'j', '8ry9', 'hw6', 'v7j', '52k1qzqt', 'uw42p20g', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_53', 'k1', '3bj', 'suy', '6h', 'zboodl', '60sijuf', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_54', 'fghixb', 'gxislq', 'isdq44u2', 'kz', 'w', '3q5br3', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_55', 'bvbj26kpxc56', 'pvp0h2fln', 'lcorq', 'l1uod', 'v', 'f3ya6l431gf', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_56', '6gifjtvxt41z', 'jf1qj3se4d', 'pb4l6rurl72q', 'ippxb659q', 'tkf5j4ce', 'y485ys1g', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_57', 'vg', 'wytzip2', 'a6d2hqs4zc1', '2282rnfvk', 'mfoqp', 'ucnn53i', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_58', 'wx0hv', 'v0oh59ivnipn', 'drokt16hq', '9', 'jae9ps4don', 'e0b6piqkuizi', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_59', '8npqdbw', 'ew42zl4ptf8u', 'l0lw90t2kl', 'apcw1gn', 'o6r9d3zdayv5', 'horvcc', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_60', 'q', 'eddnko', '7dq70691', '7', 's1i0k8thqz3', 's94x3', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_61', '3u', 'ge', 'rz', 'w0qgiqh4ao3k', '9v09407sw', 'b3349kf5l6rn', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_62', 'bn', 'bp96', 'v5122bvxjnuw', '4jm31nfs4', 'iom2', '85br29', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_63', 'jnnb', 'sy75w', 'nagrj6o3', '7kajtw7', 'qiuj9', '94', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_64', 'nr8dq5', 'bz', 'jmeuvjvcr9', '03f', '15y8am0q', 'ut2', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_65', '6fr11luvk4', '7wggg', '0zchdq8o', 'xze42', 'wen', '4ilc', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_66', 'w6gv', 'c9l5', 'mrsv641', '6b', 'ugt8ygq', 'fzr1', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_67', 'ikr1whx1d', 'zbb', '27z', 'uuwyewb', 'hg8', '1ev3gqe', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_68', 'cn', 't2v4lraxg0g', 'xot6v', '1lrh', 'qsxyubeyhmlr', 'ycz8', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_69', 'kabtcpo1ke8e', 'y0kcxl', 'e4bkfphyy', 'nm0cmn', 'usy4c1vk2', 'ki4uvof5n', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_70', '0zqe9rs1z', '82twy4o1sqi', 'rlhj1gxio9', 'm29', 'phx5vl', '7joby01skvh4', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_71', 'gp0kr5bk', 'd0gkgqa', 'utce54', 'dvf', '2j4ljlh', 'dpnheb', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_72', 'axtpyee2zt2u', 'gy7qnkj2dsjl', 'a91nq7dxug9', 'ta6wa', 'il7a', 'q6gahjc', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_73', 'o5sddf', 'a2n0l', 'czduqt', 'ig197ge', 'rru', 'lwblhtkbto', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_74', '9cnlvwnzp', 'cpw', '0q9z43yul6g', '5jlkkggq', 'kx1wfn', 'o', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_75', '9', '9n', 'w16bb6teck', 'aioh8mpzf5t', 'lsok6v', 'gc', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_76', 'v293muo', 'o5cwanc56', 'wf', 'y2vtct', '95snh', 'c1jc1', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_77', 'll8k', '6qohr35i', 'ptxmlhv1xt', 'i78hfcwwwk', 'xvvf', 'aq65q', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_78', 'ro7mfr86mok', 'pt50qbwhb', 'szz', 'g8eizd0cun', 'g8', 'gvzm', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_79', 'd', '290a', 'nxzfoas9', 'zd', 'e0', 'r841i6vn9a', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_80', 'zy7et', 'f9', 'nz5cayz', 'ae7w', 'ku', 'o6stk1', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_81', 'vo', 'sy9i6bswqb', 'oyhady', '3jap', 'pzj', '2', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_82', 'maspu0abl7', 'ufk', 'q6', 'd1hg2', 'jcakwtumv', 'p19dvetwec1z', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_83', '2pbzz2fp2', 'rds4d', '7xpoymk4', 'zveffs4', 'e2yc4ssva83', 'iviizc5cd', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_84', 'l71l0q4n', 'sw3', '506p67904l', '0dafs830rj', '63fqszsmbw', 'k5paop6', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_85', 'p37ekwhf', '81p0', '1mps38vev', '5utc4wz1h52', '5f', '05rr8l', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_86', 'r2exf0wr', 's', 'de2k', 'n0', 'o22', 'u', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_87', 'g2eidvgb68hb', '21fs7h', 'cnb5afv', '1keoynaj0', 'ok4n', 'r1gnhxf6ip', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_88', 'j572', '4', 't9h4gwpvhdb', 'n16i83ytqv3', '1', '0qjx29a', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_89', 'siacshy', 'vyn3ea', '7', 'vdwkko5vws', 'upks6ry62k', 'ek7hibs5fh8', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_90', 'kqf9xs', '0f3gcwa8dx', 'v0', '9', '8g', 'zmc05e27hv', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_91', '1', '2ba9pq9c3rey', 'krfk2up', 'w', 'k4fg', 'mo2s', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_92', '28jur7', '4thbf514', '8sxf', 'swdwyo5krex', '94kiyf8vo', 'nlyn', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_93', 'ovv1mq0', '76', 'hs', 'x10hzmg804o5', 'd', 'd1c', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_94', 'mrf34rnm3o89', '0', '6837bfhy', '50', 'z3vw9z57rl1', 'ba9mrw', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_95', 'u0gy', 'jit2fgscgm', 'qs', 'buot7nieb', 'mq5mmu4', 'r', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_96', 'l', 'l899azbbz1', 'e2s5ue', 'nd4ryz6', 'k', 'b9yy48ude', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_97', '1wmig', 'g', 'h9o', 'c9m7k0', '5', 'ymsyqh2mcnrs', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_98', 'uid2gt', 'i8oy37f', 'j', '979bvh4', '4ewrogwhfh', 'askba', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_99', 'gt1ge577of', 'wummpy7d5', '0yo4lx0w', 'a0f75koo', 'b8ej953w', 'weolubkg0s', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_100', '0sso', '9pwkya142jc', '1bi3bpf7inp', 'cso6kngyf0', 'z754ee3rj', 'qnqmi', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_101', 'y5cdp', '7t', 'e', 'b', 'ta131', 'tavns', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_102', '5qs3c2cvt', 'mkki0f', 'ht8az', 'gz9', '7', 'e6w', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_103', '7n00oq5', 'qyjw', 'qg2', '0epbaljm', 'zqntdh', 'bn3jdbdtzpx', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_104', 'n719', 'bivw', 'hq5zahke', 'wmj9', 'cuti0zwcmv5', 'llqp2468x', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_105', 'z7skwu8s2', 'va4tntw8nh', 'de26pskt', 'hqms', 'd1l', 'arfcnltmafl', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_106', 'nj3sxridwp', 'mv', 'dp3i', 'z9x', 'fb6cb3j1795', 'wgwfr6w6', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_107', 'ryhi', 'f', '5ylpwmn', 'qkeopjff8', 'tredoattl20n', 'f9zz8hm9zgwo', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_108', 'qi32iv', '5yty8elwww', 'al4zvb0w', 'duewudv3', 'ox9kpgyf3iy', 'qy68c15ubc0', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_109', '1tfq93b67ki', 'yizoy4y32', 'cwurwj', 'mnmpyojg1m', '5lkdpythdtl', 'di24v5s', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_110', 'wxr0fl4s', 'v4os1', 'gifdlkw8n', 'lc3n', 'v8', '3v7k4', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_111', '3f7tciep9s', '5raw', '8', 'kbozw79mr4un', 'av0', '6gfqf', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_112', 'dj8g', 'aek', 'n56s', 'em7bx4idf', '4m', 'frrxh6', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_113', 'huzsqzkco', '32uro46ilhrc', 'n9no1mcyqwm', '2kp54', 'btm4bttk9r', 'ps7m', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_114', 'e8lg', '1ynq76swu', '6z4', '2a9b', 'dxssn791', 'kf0obtr1w0i', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_115', '70v4o5j0foc', 'k0qs', 'f8b', '7kqe8sfpuh0', '1b1', 'a929yb3xftrf', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_116', 'o4rnoo9u7', '32v', 'u', '4c', 'sd31t', 'zy', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_117', 'izr', 'fujiw9z', 'v', 'p3', '4a46nc', 'i6mt983k4gv', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_118', '5lx09m5', 'l', '2pku07dp9wl', 'pdioj17p', 'nu5cc3', '7cnltrtrdse', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_119', 'au3vveg', '6kqybb', '8j2u0k8548', 'q', '5', 'fsg3nhy', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_120', 'v42nm8d', 'aqwwb5c', 'z', 'ilt2jjm6', 'g9', 's', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_121', '4wmggorl5w2', '4912p', 'ssi04buzky1', '0pjn', 'q0qwz1axdx', '9', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_122', 'sh53du2t', 'cx7ym05', 'b', 'uess3q7c', 'kwijuhe', '7nzxmd76', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_123', '0p5a7pdy59e3', 'mthh1s613x', '9', 'sq6mbox', 't4f8b', 'd3pwwpksr', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_124', '6x', '1c7l8zys', 'i', 'xokmxq9jctv', '5', '43u5', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_125', 'u', 'yqq5hak5', '3', 'x050cx', 'j9qc', '8w', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_126', 'xz', '8a7s6y1ul1ww', 'd3', 'bf1a1q', 'qq54qa', 'l6xv57y', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_127', '6gfqnxgycwrw', '9', 'ey0t7sek', '0m9', 'y', '7ld5jf', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_128', 'z7dcowum', 'tpv4', 'jv', 'of780p3', 'yj3', '0obs95', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_129', 'kccwqie', '560s', 'w1ylk0l7tpn', 'wc66t', 'ypqzp3f40', 'wvwvuf4krv', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_130', '0tkpp01s19gb', 'z', '3g', 'r6h', '6s', 'wsr', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_131', 'uma1', 'c08lbz3ub', 'gz08jm', 'ezmqqbkdckhw', 'j3peb4', 'jaqr', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_132', '09nz2e8dbbk', '0lyf4p5r52k2', 'yznmup2pj', 'we9', 'qybg5cmtxn0f', 'sh9y8v3', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_133', 'lwcl8hon2v5q', 'xsi1onolu', '7m2', '9ee3jg', '9', 'b', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_134', '2', '2b5y2o', '6cchwo58a', 'h', 'n4md', '289b1km83k0', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_135', 'j5m', 'qo4n8woz', '2iizx913615g', 'lb8utwvxr8fs', 'lr0k8', 's8vq0h3', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_136', 'cy7587', 'bjgh', 'rntntdgucf', 'pv650pt', 'z100cpumu7', 'ciqifpmi7pnm', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_137', 'xljoxi', 'm2g6tsaek5', 'ijve', 'pdwcgw4k', 'va5dwp7ak0', 'xdcy38', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_138', 'k5kj', 'fg', 'br6g', 'zxbk7v82zkjx', '0nuaazgrflq', 'r7b0g38mhq', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_139', '548dsit3z0', 'eij9ew92w', 'swd', '5bx', 'f95k0o06u', '6lx6vao', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_140', '42gibx', '4kcnp4yf4yeh', 'nq84ldon2', 'ax', '918q5l7', 's7nvovlwdu', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_141', '3uwoic', '24p', '6pt3m', 'qb', '23ik', '7cge', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_142', 'wsbom2vnvmob', 'dk9pd991', 'y6t1bc9278', 'a7bfvfhm', 's5wxa8x5sn1', '0ulc2l6', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_143', 'egqwovggz0', 'n68ldxi3xgf', '61q', 'wmoi2l', 'o1o8gw', '6z5o6n8x6dy', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_144', 'k', '7fmvqn8a', 'bd2ow6a', 'og3ni', 'b0ftst4g', 'q48m3cdo', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_145', 'giird', 'jwin', 'btvakgqw485', 'j', 'qfmus', '0w4e', -2147483648, 'major_id_1');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__f5ef5f', 't1__646ce6', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', 't1__646ce6', 'z2o20', 'pj6ddlysu6ip', 'dk', 'u2gir31vwq5', 'oa2sb3u');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_2', 't1__646ce6', 'i1pa', 'cvwnyq', 'ouirl', 'rpouit63xyf', 'mjwpp2');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('C', 't1__646ce6', 'f41', '80terbfokvee', 'sltut6lu2', 'cel8mhfcim', 'n5enii0fmbgz');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('@', 't1__646ce6', 'v4pmp', 'jve', '2', 'rn6j7', '2vkwegrf6snl');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__c0995b', 't1__646ce6', '6f', 'e', '3iaipndd', '0uj2sy8v', 'and97');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'bnp', 'mdpos', 'ie5', 'nw6klf', 'a9000t5c4eci');

-- Inserting into table: attendance --
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f5ef5f', 'member_id_1');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f5ef5f', 'member_id_2');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f5ef5f', 'member_id_3');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f5ef5f', 'member_id_4');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f5ef5f', 'member_id_5');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f5ef5f', 'member_id_6');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f5ef5f', 'member_id_7');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f5ef5f', 'member_id_8');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f5ef5f', 'member_id_9');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f5ef5f', 'member_id_10');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f5ef5f', 'member_id_11');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f5ef5f', 'member_id_12');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f5ef5f', 'member_id_13');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f5ef5f', 'member_id_14');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f5ef5f', 'member_id_15');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f5ef5f', 'member_id_16');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f5ef5f', 'member_id_17');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f5ef5f', 'member_id_18');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f5ef5f', 'member_id_19');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f5ef5f', 'member_id_20');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f5ef5f', 'member_id_21');

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

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_6');

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

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_i_108');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_i_109');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_id_85');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_id_53');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_id_2');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_id_65');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_id_25');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_id_62');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_id_50');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_id_74');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_id_54');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_id_49');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_id_33');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_i_105');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_id_77');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_id_61');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_i_110');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_id_31');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_id_47');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_id_67');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_id_17');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_i_111');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_i_112');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_id_26');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_id_69');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_id_80');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_id_29');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_id_58');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_id_76');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_id_63');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_id_9');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_id_51');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_id_44');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_id_45');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_i_113');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_i_102');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_i_114');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_id_39');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_i_115');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_i_116');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_id_90');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_id_15');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_id_14');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_id_94');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_i_117');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_id_81');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_i_118');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_id_16');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_i_119');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_id_27');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_id_38');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_id_57');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_id_43');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_id_5');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_i_120');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_i_121');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_i_122');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_id_37');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_i_123');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_i_124');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_i_125');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_i_126');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_i_127');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_i_128');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_id_88');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_i_129');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_id_52');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_id_55');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_id_8');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_id_1');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_i_130');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_i_131');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_id_71');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_i_132');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_id_10');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_id_18');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_i_133');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_id_79');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_id_36');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_id_13');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_i_134');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_i_135');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_i_136');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_i_101');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_i_137');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_i_138');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__c0995b', 'member_id_3');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f5ef5f', 'member_i_139');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f5ef5f', 'member_id_62');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f5ef5f', 'member_id_37');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f5ef5f', 'member_id_76');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f5ef5f', 'member_id_60');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f5ef5f', 'member_id_68');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f5ef5f', 'member_i_140');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f5ef5f', 'member_id_49');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f5ef5f', 'member_i_120');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f5ef5f', 'member_id_44');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f5ef5f', 'member_id_66');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f5ef5f', 'member_id_47');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f5ef5f', 'member_i_134');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f5ef5f', 'member_i_141');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f5ef5f', 'member_id_99');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f5ef5f', 'member_i_142');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f5ef5f', 'member_id_61');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f5ef5f', 'member_i_143');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f5ef5f', 'member_i_118');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f5ef5f', 'member_i_144');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f5ef5f', 'member_i_145');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f5ef5f', 'member_i_103');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_name FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event GROUP BY T1.event_id HAVING COUNT(T2.link_to_event) > 20;

/*
Gold Result:
('t1__646ce6',)
('t1__646ce6',)
('t1__646ce6',)
*/

-- Prediction Query
SELECT DISTINCT event.event_name FROM event INNER JOIN attendance ON event.event_id = attendance.link_to_event WHERE event.type <> 'fundraiser' GROUP BY event.event_id HAVING COUNT(attendance.link_to_member) > 20;

/*
Prediction Result:
('t1__646ce6',)
*/