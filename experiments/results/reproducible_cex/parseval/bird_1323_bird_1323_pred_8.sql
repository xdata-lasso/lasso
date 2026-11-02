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

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_31', '253', 'b59ls', '1ehn1mdaqq', 'yy', 'snp64hm', 'nw4m', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_32', 'k0b', 'h6gd', 'b7jjpl', 'tlzh42', 'nyj5yrji5m', 'kna38', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_33', 'mxwdb7o', 'p5qo1', '4c6', 'gwnkd4kc3ii', 'axz', '90nhs', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_34', '6', 'rn5u', 'phy', 'n', 'a', 'vhvyx8s', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_35', '3qn0b', 'm2rlxcrw', 'x0', '3rzgz84lqm', '2w', 'b1b3vun66e0i', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_36', 'xd4s', '5il', 'wnd6dvygw', 'akmwgw73fy3d', 'dip', 'txfbl10qx6j', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_37', '5m4s2ajdu', '6xuj90te', 'x3', '5u7709', 'qf9lx8qzabi', 'uumwu7', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_38', 'bciv', 'ojsmeqv3', '3uxdo', 'a0ol1z', 'mjrssbh72404', 'pp330', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_39', 'qu', '8184d', 'ojdlhl', 'pdyxk0a', 'cql1c8c', 'wvadbp0760', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_40', 'pg1lcg', 'a4gkjog8d', 'w16f5tqhjd', 'mabmkr2t', 'dlb6i42', 'tew5c29d', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_41', 'f8of', 'bp9qgjrad', 'fhj8zr6k53', '8e5o', 'f0y', '1u', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_42', '0g5', '0j597fznqc', 'ex41fa', 'c1je44', 'u5lvdbp3c', 'hy', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_43', 'lciif0l', '46upleo', 'h3m3q0pq97j', '534j5xbk11y', 'pzc7x', 'v4pmp', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_44', '2', 'rn6j7', '2vkwegrf6snl', '5jw5pbgw', 'ojnhh6va3tdx', 'hn75b733', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_45', 'yx', '0twou', '4', 'yi4h5c4f1q', '9w43ial8s8', 'sp4j9fod', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_46', 'p3q', '77cxsw', 'r1', '4vu6v8hk', 'lzy93zu8yb', '4qpog5smdhct', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_47', 'whwhlh5i1', 't', 'j', '8ry9', 'hw6', 'v7j', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_48', '1qz', 'qt5uw42p20', 'wt', 'hk', 'l3bjksu', 'e6hvzbo', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_49', 'ufc', 'vfghixbu', 'xi', 'lq2is', 'q', '4u2fkzbw', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_50', 'br37qobvbj2', 'kpxc567pv', '0h2f', 'lntlcorqtl1u', 'dbvf', 'ya6l431g', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_51', 'fjt', 'xt41zj', 'f1qj3se4dp', '4', '6ru', 'rl72q8ippxb6', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_52', 'tkf5j4ce2y48', 'ys1gz7p3', 'vg', 'wytzip2', 'a6d2hqs4zc1', '2282rnfvk', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_53', 'pzucnn53i98', 'wqwx', '0hvv0oh59iv', 'ipn6', 'r', 'okt16hqb9jae', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_54', 'done0b6p', 'qku', 'izi62308npqd', 'bwew42zl4ptf', 'ul0lw90t2', 'klyapcw1gn', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_55', 'd3zdayv5u', 'or', 'ccwraq', 'eddnko', '7dq70691', '7', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_56', 'i0k8thqz3rs', '4x3yyxg3u', 'ge', 'rz', 'w0qgiqh4ao3k', '9v09407sw', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_57', '49kf5l6r', 'nd3rhbnmbp9', 'v5122bvxj', 'uw84', 'm31', 'fs4n', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_58', '2u85', 'r', '971kpjnn', 's', 'y75w5', 'nagrj6o317ka', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_59', 'sqiuj9f94', 'ycwnr8dq', '5gbzjmeuvjv', 'cr9l03f515y', '8am0qjut2f31', '6fr11luvk4', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_60', 'g3', 'zchdq8o', 'xze42', 'wen', '4ilc', 'kspw6gvo', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_61', 'zmrsv641', '6b', 'ugt8ygq', 'fzr1', 'v7z6i', 'r1w', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_62', 'zbb', '27z', 'uuwyewb', 'hg8', '1ev3gqe', 'nehcnt2v', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_63', 'axg0gtxot6', 'p1lrhq', 'xyube', 'yhmlrnycz8d5', 'kabtcpo', '1ke8euy0kcx', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_64', 'bkfphyyxnm', 'cmn8usy', 'c1vk27ki', 'uvof5ndg', '80z', 'qe9rs1z82tw', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_65', 'sqirlhj', 'gxio9km', '9vphx5vl', '7joby01skvh4', 'my4gp', '0kr5bk0d0gkg', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_66', 'e', '54kdvf12j4lj', 'hxd', 'nheb', 'yaax', 'pyee2', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_67', 'gy7qnk', 'j2dsjla91nq', '7dxug9rta6w', 'n', 'l7a', 'q6gahjc', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_68', 'o5sddf', 'a2n0l', 'czduqt', 'ig197ge', 'rru', 'lwblhtkbto', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_69', '9cnlvwnzp', 'cpw', '0q9z43yul6g', '5jlkkggq', 'kx1wfn', 'o', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_70', '9', '9n', 'w16bb6teck', 'aioh8mpzf5t', 'lsok6v', 'gc', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_71', 'v293muo9o5cw', 'anc56gwfuy', '2vtctr95snh', 'c1jc1', 'j3dmll8k26', 'qohr35iptx', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_72', '1xti78', 'fc', 'wwkmxv', 'ftaq65', 'vero7', 'fr86', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_73', '50qbw', 'hbiszzg8eiz', '0', 'u', 'hg8m', 'vz', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_74', 'wbdo290a5nxz', 'oa', 's9ezdfe0r8', '41i6vn9a6h', 'qzy', 'etff9znz5', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_75', 'mae7whk', 'xo6stk', 'uxpevos', '9i6bswq', 'bvoyhadym3ja', 'pipzjd2zxp', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_76', 'u0ab', 'l7jufkhq6sd1', 'g2', 'jcakwtumv', 'p19dvetwec1z', '80x72p', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_77', 'fp2srds4', 'd57xpoymk4y', 'veffs4e', 'yc4ssva8', '6iviizc5', 'd', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_78', 'l71l0q4n', 'sw3', '506p67904l', '0dafs830rj', '63fqszsmbw', 'k5paop6', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_79', 'p37ekwhf', '81p0', '1mps38vev', '5utc4wz1h52', '5f', '05rr8l', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_80', 'r2exf0wrasm', 'e', 'khn0io22', 'u', '5ig', 'eidvgb68', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_81', 's7', 'yc', 'b5af', 'v61keoynaj0p', 'k4nr', 'gnhxf6i', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_82', 'j572', '4', 't9h4gwpvhdb', 'n16i83ytqv3', '1', '0qjx29a', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_83', 'x1siacshyuv', 'n3eac7v', 'dwkko5vwsu', 'ks6r', 'y62kek7hibs', 'fh8imiuk', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_84', '0f3gc', 'wa8dxhv0a9e', 'gzmc05e27', 'v0', 'ya12ba', 'pq9c3reyy', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_85', 'upbwnk4fgnm', '2sp7', 'mu28jur734t', 'bf', '14p8sxfs', 'dwyo5k', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_86', '94kiyf8vo', 'nlyn', 'mc1ovv1mq0f', '6ghsx10hz', 'mg804o5adjd1', 'n', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_87', 'f34rn', '3o89', '0', '6837bfhy', '50', 'z3vw9z57rl1', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_88', '9mrwyzbou0gy', 'jit2fgscgm', 'qs', 'buot7nieb', 'mq5mmu4', 'r', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_89', 'l89', '9azbbz1ve2s5', 'eznd4r', 'z6ck6b9', 'y48udes', 'd5q1wmigcg', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_90', 'c9m7k0', '5', 'ymsyqh2mcnrs', 'wouu', 'd2g', 'yi8oy', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_91', '097', 'bvh44ewro', 'gwhfhsaskba4', 's', 'gt1ge577of', 'wummpy7d5', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_92', '4lx0', '2a0f75', 'koo2b8ej95', 'wweolubk', '0s', '1lm0sso9pw', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_93', 'jc1bi3bp', '7i', 'pcso', '6kngyf07z7', '4ee3rjtq', 'qmia', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_94', '5cdpg7t', 'e', 'b', 'ta131', 'tavns', 'wm', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_95', 'vtvmkki0fr', 't8', 'azlgz9b7ke', 'wmuz7n00o', '5nqyj', 'wjqg220epb', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_96', 'xzqn', 'dhbn3', 'dbd', 'zpxts', 'nn7', '9nbivw4', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_97', 'zahkeowmj9cu', 'i0zwc', 'v56l', 'qp2', '68xuxk6z', 'skwu8s2va', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_98', '8nh5de', '6psktmhq', 'skd1', 'arf', 'n', 'tma', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_99', 'nj3sxr', 'idwpemvmdp3i', 'z9x', 'fb6cb3j1795', 'wgwfr6w6', '4uoryhibfz5', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_100', 'mn8qke', 'pjff', 'tredoattl', '0nf9zz8h', '9zgw', 'q8e9', -2147483648, 'major_id_1');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__71a4f8', 't1__c48531', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', 't1__c48531', 'z2o20', 'pj6ddlysu6ip', 'dk', 'u2gir31vwq5', 'oa2sb3u');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_2', 't1__c48531', 'i1pa', 'cvwnyq', 'ouirl', 'rpouit63xyf', 'mjwpp2');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('W', 'f41', '80terbfokvee', 'sltut6lu2', 'cel8mhfcim', 'n5enii0fmbgz', 'oqxs27xh');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('C', '70zi90o', '0q833g86', '5zm6dpewew0', '2p40u2vil', '1xsad6q5', 'iqoauy0');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('#', 'j0j', 'k6hh2o', '79', '50fzrv1l', '930', 'vkviql');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('G', '1havc', 'c4zpw867', 'fve0jf4i', 't99kvnbh', 'i6tp3t', 'nd');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__3cb95e', 't1__c48531', 't9kcq2iae6', 'j', 'ql1676lk8', 'azkjy', 'fxsove98b8');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'bnp', 'mdpos', 'ie5', 'nw6klf', 'a9000t5c4eci');

-- Inserting into table: attendance --
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__71a4f8', 'member_id_1');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__71a4f8', 'member_id_2');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__71a4f8', 'member_id_3');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__71a4f8', 'member_id_4');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__71a4f8', 'member_id_5');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__71a4f8', 'member_id_6');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__71a4f8', 'member_id_7');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__71a4f8', 'member_id_8');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__71a4f8', 'member_id_9');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__71a4f8', 'member_id_10');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__71a4f8', 'member_id_11');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__71a4f8', 'member_id_12');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__71a4f8', 'member_id_13');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__71a4f8', 'member_id_14');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__71a4f8', 'member_id_15');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__71a4f8', 'member_id_16');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__71a4f8', 'member_id_17');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__71a4f8', 'member_id_18');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__71a4f8', 'member_id_19');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__71a4f8', 'member_id_20');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__71a4f8', 'member_id_21');

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

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('W', 'member_id_29');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('W', 'member_id_18');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('W', 'member_id_31');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('W', 'member_id_14');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('W', 'member_id_9');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('W', 'member_id_32');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('W', 'member_id_7');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('W', 'member_id_6');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('W', 'member_id_24');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('W', 'member_id_19');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('W', 'member_id_23');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('W', 'member_id_2');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('W', 'member_id_33');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('W', 'member_id_16');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('W', 'member_id_34');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('W', 'member_id_3');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('W', 'member_id_35');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('W', 'member_id_13');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('W', 'member_id_15');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('W', 'member_id_12');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('W', 'member_id_20');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('C', 'member_id_29');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('C', 'member_id_30');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('C', 'member_id_12');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('C', 'member_id_23');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('C', 'member_id_8');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('C', 'member_id_31');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('C', 'member_id_6');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('C', 'member_id_17');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('C', 'member_id_3');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('C', 'member_id_28');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('C', 'member_id_13');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('C', 'member_id_7');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('C', 'member_id_18');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('C', 'member_id_35');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('C', 'member_id_24');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('C', 'member_id_10');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('C', 'member_id_36');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('C', 'member_id_33');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('C', 'member_id_4');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('C', 'member_id_37');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('C', 'member_id_1');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('#', 'member_id_33');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('#', 'member_id_14');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('#', 'member_id_27');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('#', 'member_id_18');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('#', 'member_id_12');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('#', 'member_id_16');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('#', 'member_id_37');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('#', 'member_id_19');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('#', 'member_id_1');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('#', 'member_id_24');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('#', 'member_id_5');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('#', 'member_id_38');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('#', 'member_id_30');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('#', 'member_id_39');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('#', 'member_id_21');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('#', 'member_id_7');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('#', 'member_id_11');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('#', 'member_id_29');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('#', 'member_id_8');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('#', 'member_id_40');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('#', 'member_id_23');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_20');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_23');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_35');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_36');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_17');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_25');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_33');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_19');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_18');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_40');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_21');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_31');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_5');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_41');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_42');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_43');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_10');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_44');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_15');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_32');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_45');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_32');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_27');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_29');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_30');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_46');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_38');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_14');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_41');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_47');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_31');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_48');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_15');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_4');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_12');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_26');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_33');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_49');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_24');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_43');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_50');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_37');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_6');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_5');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_7');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_51');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_42');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_39');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_52');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_18');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_13');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_53');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_54');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_55');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_56');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_45');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_57');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_58');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_10');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_59');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_19');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_60');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_61');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_8');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_62');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_63');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_64');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_65');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_34');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_1');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_66');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_67');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_68');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_69');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_70');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_71');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_72');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_25');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_73');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_74');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_75');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_76');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_77');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_78');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_79');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_44');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_80');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_16');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_3');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_81');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_82');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_83');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_84');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_21');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_36');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_85');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_86');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_87');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_88');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_40');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_28');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_89');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_90');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_91');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_92');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__3cb95e', 'member_id_22');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__71a4f8', 'member_id_73');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__71a4f8', 'member_id_50');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__71a4f8', 'member_id_93');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__71a4f8', 'member_id_85');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__71a4f8', 'member_id_94');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__71a4f8', 'member_id_67');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__71a4f8', 'member_id_64');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__71a4f8', 'member_id_33');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__71a4f8', 'member_id_37');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__71a4f8', 'member_id_89');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__71a4f8', 'member_id_60');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__71a4f8', 'member_id_95');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__71a4f8', 'member_id_96');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__71a4f8', 'member_id_97');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__71a4f8', 'member_id_80');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__71a4f8', 'member_id_62');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__71a4f8', 'member_id_40');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__71a4f8', 'member_id_98');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__71a4f8', 'member_id_99');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__71a4f8', 'member_i_100');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__71a4f8', 'member_id_35');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__71a4f8', 'member_id_44');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_name FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event GROUP BY T1.event_id HAVING COUNT(T2.link_to_event) > 20;

/*
Gold Result:
('j0j',)
('t1__c48531',)
('70zi90o',)
('1havc',)
('f41',)
('t1__c48531',)
('t1__c48531',)
*/

-- Prediction Query
SELECT e.event_name FROM event AS e JOIN attendance AS a ON e.event_id = a.link_to_event LEFT JOIN budget AS b ON e.event_id = b.link_to_event GROUP BY e.event_id HAVING COUNT(a.link_to_member) > 20 AND (NOT b.category IN ('Food', 'Advertisement') OR b.amount <= 150);

/*
Prediction Result:
*/