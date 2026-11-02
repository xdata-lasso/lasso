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

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_22', 'avcv', 'wnyqrouirlrp', 'ouit63xyfvmj', 'wpp26mb3aj0j', '0h3r13', 'ir1axyyh', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_23', '9es', 'p', 'pgckqwtsr', '54o6qjektb1', '2', 'zg3r', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_24', 'ns47j2', 'a8d', 'c', '3vjwq49', 'yrnxs6dvdx', 'o', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_25', 'gvplj9fj', 'uun7k1', 'z2my1og', 'v1rgeza', 'xc1clupgly', '8oitxeilp', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_26', '19cy7od033d', 'hds', 'nhed29', 'qv2', 'u331spxpw', '0bgwkxgi', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_27', '6id', 'p61l', 'o3ak162o', 'cagjeevxzxlu', '49kuboe8cd', '4u', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_28', 'llbwvdpu5v0e', 'u', 'y9v2z12983', '5xoepacxdb2f', 'c296xiy', 'et8xjhcf46c', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_29', 'rxa61sjv8nv', 'ddrokuez', 'ctehia3cmvb', '7vpc0xffwo', '1esks', '9q', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_30', '01', 'ui', '7f8', 'qhi', 'u5gm8gxb5qj', 'saw', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_31', 'kwi3hl7j', '3y795ybv', '3kr3w4jn2', '19xgjja', 'cgmukfb5if4', '80terbf', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_32', 'ee6slt', 't6lu2c', 'l8', 'mhfcimn5eni', '0fm', 'bgz5oqxs27', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_33', 'k253sb5', 'ls1ehn1md', 'aqqhyyzsnp64', 'mn', 'w4m0', 'rwbjk', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_34', '6g', 'w', '7', 'jjplwtlzh42n', 'j5yrji5', 'qkna', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_35', 'xswb2d0zmxwd', '7', 'tp5q', '1k4c', 'gwnkd4kc3', 'iikaxzr90nhs', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_36', 'b', 'nrn5ujphy', 'n', 'a', 'vhvyx8s', 'r', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_37', 'qn0b5m2r', 'xcr', 'fx03rz', 'z8', 'lqme2wb1', '3', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_38', '6e0imolt0', '0zi90o50q', '33g865zm6', 'p', 'ewew092p40', '2vil21', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_39', '6', 'q5ziqoauy0', '3lwh994f', 'qc1m9gr8xj', 'qbloxd4sj5il', 'wnd6dvygw', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_40', 'gw73fy', 'dkdiptxf', 'bl10qx6j6d4f', 'c75m4s2ajdu2', '6xuj90tefx', 'u5u7709q', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_41', 'qzabivuum', 'u7alj0', 'jwk6hh2oe7', '9350fzrv1l', '930', 'vkviql', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_42', 'rlpsaxeein', 'bciv', 'ojsmeqv3', '3uxdo', 'a0ol1z', 'mjrssbh72404', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_43', 'w5c29dwt1ha', 'vc2c4zpw8672', 've', 'jf4i5t9', '9kvnbhvi6t', '3tfn', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_44', '9qy6sru4e', 'fiof8o', '6b', 'p9qgjradfhj', '8zr6k53p8e5o', 'f0y', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_45', 'i0g50j5', '7fznqcuex', '1faxc1je', '48u5lvdb', '3ceh', 'e3oylci', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_46', 'ly46upleoh', 'm3q0pq97', '534', '5xb', '11y', 'pzc7x', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_47', 'jjve', '2', 'rn6j7', '2vkwegrf6snl', '5jw5pbgw', 'ojnhh6va3tdx', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_48', '4j9f', 'dt9k', 'cq2iae6aj6ql', '676lk8q', 'azkjyfxsov', '98', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_49', '235v8ikp3qu7', 'cxswgr124', 'u6v8hk', 'lzy93zu8yb', '4qpog5smdhct', 'nj8y6whwhl', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_50', 'dtdjm8r', 'y9lhw6lv7j45', 'k1qzqt5u', '42p20g', 'tfhk1l', 'bjksuye6', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_51', 'boodlz60si', 'ufc', 'vfghixbu', 'xi', 'lq2is', 'q', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_52', '2fkzbwx3q5b', '37qob', 'vbj26kpxc567', 'vp0h', '2flntlcorqt', '1uo', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_53', 'vf3ya6l431gf', 'g6', '6gifj', 'vxt41', 'jf1qj3s', '4d', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_54', 'l6rurl72', '8ippx', '6', '59q4tkf5j4c', '2y', '485ys1gz7p3h', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_55', 'ytzip2', 'a6d2hqs4zc1', '2282rnfvk', 'mfoqp', 'ucnn53i', '8owqwx0hv', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_56', 'h59i', 'nipn6d', 'okt16', 'qb', 'jae9ps4do', 'e0b6', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_57', 'kuizi', '2308npqdb', 'wew42zl4ptf8', 'l0lw90', '2klya', 'cw1g', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_58', 'd3zdayv5u', 'or', 'ccwraq', 'eddnko', '7dq70691', '7', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_59', 'i0k8thqz3rs', '4x3yyxg3u', 'ge', 'rz', 'w0qgiqh4ao3k', '9v09407sw', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_60', '49kf5l6r', 'nd3rhbnmbp9', 'v5122bvxj', 'uw84', 'm31', 'fs4n', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_61', '2u85', 'r', '971kpjnn', 's', 'y75w5', 'nagrj6o317ka', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_62', 'sqiuj9f94', 'ycwnr8dq', '5gbzjmeuvjv', 'cr9l03f515y', '8am0qjut2f31', '6fr11luvk4', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_63', 'g3', 'zchdq8o', 'xze42', 'wen', '4ilc', 'kspw6gvo', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_64', 'uuwyewbihg8', '1ev3gqe', 'nehcnt2v', 'lraxg0gt', 'ot6vp1', 'lrhqsxyube', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_65', 'rny', 'z', 'd5ykabtcp', '1ke8', 'uy', '0kcxl8e4bkf', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_66', 'xnm0cmn', 'usy4c1vk2', 'ki4uvof5n', 'g', '80z', 'qe9rs1z82tw', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_67', 'sqirlhj', 'gxio9km', '9vphx5vl', '7joby01skvh4', 'my4gp', '0kr5bk0d0gkg', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_68', 'e', '54kdvf12j4lj', 'hxd', 'nheb', 'yaax', 'pyee2', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_69', 'gy7qnk', 'j2dsjla91nq', '7dxug9rta6w', 'n', 'l7a', 'q6gahjc', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_70', '5sdd', 'ra', '2n0lwczduqt0', 'ig197gelrrul', 'blhtkb', 'og8ol', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_71', 'vwn', 'pkcpw0q', 'z43yul6g2', 'jlkkggqx', 'x1w', 'nb', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_72', '64a9g9nw1', 'bb6teckai', 'h8mp', 'f5tulso', 'k6vhgc3b0v2', '3muo9o5cw', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_73', '6gwfuy2v', 'ctr95', 'snhqc1jc1j3d', 'll8k', '6qohr35i', 'ptxmlhv1xt', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_74', 'w', 'wwkmxvvfta', 'q65qvero7mf', '86mok', 'pt50qbwhb', 'szz', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_75', 'd0cunhg', 'mgvzmqiwb', 'o', '90a5nxzf', 'as9e', 'zdfe0r841i6v', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_76', 'qzy', 'etff9znz5', 'a', 'yzmae7whkuxo', '6stk1uxpevo', 'sy9i6bswqb', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_77', 'ad', 'm3japip', 'zjd2zxpmaspu', 'abl7juf', 'hq6', 'd1hg2', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_78', 'oymk4yzveffs', 'e2yc4ssv', 'a836iviizc5', 'd', 'lp4', 'l71l0q4nksw', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_79', '6p67904l0daf', '830rj', '63fqszsmbw', 'k5paop6', '3z5p37ek', 'hfm81p', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_80', 's38v', 'v5', 'tc4wz1', 'h52f5fx05rr8', 'vqg', 'r2exf0wr', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_81', 'e', 'khn0io22', 'u', '5ig', 'eidvgb68', 'bw', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_82', '7hycn', 'b5afv61keoy', 'aj0p', 'k4nr', 'gnhxf6i', '6asm', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_83', '4t9h4gwpvhdb', 'n16i83ytqv3', '1', '0qjx29a', 'f', 'x1si', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_84', 'yu', 'vyn3eac7vdw', 'ko5', 'wsupks', 'ry62kek7h', 'bs5', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_85', 'imiukqf9x', '0f3gc', 'wa8dxhv0a9e', 'gzmc05e27', 'v0', 'ya12ba', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_86', '9c3reyykrf', 'k2upbwnk4f', 'nm', '2sp7', 'mu28jur734t', 'bf', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_87', '8sxf', 'swdwyo5krex', '94kiyf8vo', 'nlyn', 'mc1ovv1mq0f', '6ghsx10hz', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_88', '04o5adjd1', 'n', 't', 'mrf34rnm3o89', '0', '6837bfhy', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_89', 'vw9z57rl', 'wba9mrw', 'yzbou0gyjit2', 'fgscgmfqs8', 'u', 't7ni', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_90', 'q5mm', 'u4crtn3bll89', '9azbbz1ve2s5', 'eznd4r', 'z6ck6b9', 'y48udes', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_91', '1wmig', 'g', 'h9o', 'c9m7k0', '5', 'ymsyqh2mcnrs', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_92', 'uid2gt', 'i8oy37f', 'j', '979bvh4', '4ewrogwhfh', 'askba', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_93', 'gt1ge577of', 'wummpy7d5', '0yo4lx0w', 'a0f75koo', 'b8ej953w', 'weolubkg0s', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_94', '0sso', '9pwkya142jc', '1bi3bpf7inp', 'cso6kngyf0', 'z754ee3rj', 'qnqmi', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_95', 'y5cdp', '7t', 'e', 'b', 'ta131', 'tavns', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_96', '5qs3c2cvt', 'mkki0f', 'ht8az', 'gz9', '7', 'e6w', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_97', 'jdbdtzpx', 'sknn7', '9nbivw4', 'q5', 'zahkeowmj9cu', 'i0zwc', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_98', '468xuxk6', '7skwu8s', 'va4tntw8', 'h5de', '6psktmhq', 'skd1', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_99', 'cn', 'tma', 'l9', 'hunj3sxridw', 'emvm', 'p', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_100', 'j17954wg', 'fr6w64', 'uoryhibfz5', 'lpwmn8q', 'eop', 'ff8', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_101', 'o', 't', 'l20nf', '9zz8hm9zgw', 'q8e9', 'vqi32', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_102', '5yty8elwww', 'al4zvb0w', 'duewudv3', 'ox9kpgyf3iy', 'qy68c15ubc0', '8gf1tfq93b', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_103', 'yizoy4y32', 'cwurwj', 'mnmpyojg1m', '5lkdpythdtl', 'di24v5s', '6f', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_104', 'iaipndd3', 'uj2sy8v', 'and97', '0a6m4y0yq40', 'm2w', 'xr0fl4ssv4os', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_105', 'w8n', 'lc3n', 'v8', '3v7k4', 'x7if', '3f7tciep', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_106', 'rawc8kbo', 'w79mr4u', 'lav0', '6gfqf', 'r3ndj8gka', 'kn', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_107', '7bx4idfe4mvf', 'rxh6m', 'o25ezvwym', '7huz', 'qzkco', '32uro46ilhrc', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_108', 'mcyqwms', 'kp54btm4', 't', 'k9rnp', '7mmhl', 'e8lg', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_109', 'nq76swul6z4', '2a9b', 'dxssn791', 'kf0obtr1w0i', 'oeg70', '4o5j0f', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_110', 'k0qs', 'f8b', '7kqe8sfpuh0', '1b1', 'a929yb3xftrf', 'ql7o4rnoo', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_111', 'due4cs', 'd31tf', 'yhgh43j', 'zr1', 'fujiw9zcvgp3', '4a46nc', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_112', '83k4gvyxs', '5lx09m5', 'l', '2pku07dp9wl', 'pdioj17p', 'nu5cc3', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_113', 'trt', 'rdsehob1au3', 'vegx6k', 'ybb8j', 'u0k8548b', 'qd5yfsg3nh', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_114', 'cjozv4', 'nm8d0aqw', 'b5cbz2', 'lt2', 'jm6', 'g9', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_115', '4wmggorl5w2', '4912p', 'ssi04buzky1', '0pjn', 'q0qwz1axdx', '9', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_116', '53', 'u', 'tzcx7ym0', '5ab2uess3q7', 'y', 'wij', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_117', '27', 'nzxmd76s0wr0', '5a7p', 'y', '9e3mthh1', '613xc', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_118', '6mbox', 't4f8b', 'd3pwwpksr', 'nlh6x', '1c7l8zys', 'i', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_119', 'mxq', '9jctvc5o43u5', '5y', 'u', 'yqq5hak5', '3', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_120', 'pj9qch', 'wgesfxz8a', 's6y1ul1ww', 'd3', 'bf1a1q', 'qq54qa', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_121', 'v57yvh6l6g', 'qn', 'gycwrw', '9', 'ey0t7sek', '0m9', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_122', 'jfvkb2z7', 'dcowumntpv', '4ejvyof780p3', 'yj3', '0obs95', 'vdxh0kccwqie', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_123', 'sw1ylk0l7tpn', 'wc66t', 'ypqzp3f40', 'wvwvuf4krv', 'nba4', 'nz0tkpp01', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_124', 'z', '3g', 'r6h', '6s', 'wsr', '5r5numa19c', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_125', 'bz3ubwgz08', 'jmezmqqbkd', 'ckhwuj3peb', '4njaqrrvsr', '09nz2e8dbbk', '0lyf4p5r52k2', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_126', 'mup2', 'jjwe', '9qybg5cmtxn', 'fysh9y8', 'v3ce5nylwc', '8ho', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_127', 'q6xsi1on', 'luk7', '2x9e', '3j', 'c9', 'b', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_128', 'buwa2w2b5y2o', '6cchwo58a', 'h', 'n4md', '289b1km83k0', 'x', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_129', 'm2qo4n8w', 'z2ii', 'x913615', 'glb8utwvxr8', 'sq', 'r0k', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_130', '0h381', 'r', 'cy7587', 'bjgh', 'rntntdgucf', 'pv650pt', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_131', 'u7ci', 'ifpmi', 'pnm8zg8b2', 'xljoxi', 'm2g6tsaek5', 'ijve', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_132', 'w4', 'va5', 'w', '7ak0', 'xdcy38', 'hko', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_133', 'gfg', 'br6g', 'zxbk7v82zkjx', '0nuaazgrflq', 'r7b0g38mhq', 'a', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_134', '3z06e', 'j9e', '92wisw', 'l', 'bx7f95k0', '06uy', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_135', 'p9js', 'qct5', '42gibx', '4kcnp4yf4yeh', 'nq84ldon2', 'ax', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_i_136', '7s7', 'vovl', 'wdum3kql7ki', 'v3u', 'oici24', 's6pt', -2147483648, 'major_id_1');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__4dafa6', 't1__f55777', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_2', 't1__f55777', 'z2o20', 'pj6ddlysu6ip', 'dk', 'u2gir31vwq5', 'oa2sb3u');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('C', 't1__f55777', 'pp330', 'a1ngqut8', '184dwojdlhlz', 'dyxk', '0a0cql1c8c');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', 'wvadbp0760', 'gk2hjz', 'pg1lcg', 'a4gkjog8d', 'w16f5tqhjd', 'mabmkr2t');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('G', 't1__f55777', '75b7', '3o58zbgy', 'xt0twoua4yi4', 'h5c4f1q9w43', 'al8');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('I', 't1__f55777', 'c9l5zmrsv64', 'h6b1ugt', 'ygqofzr1q', '7z6ikr', '1whx1dlzbb');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('a', 't1__f55777', 'jcakwtumv', 'p19dvetwec1z', '80x72p', 'z', 'z2fp2srds4d5');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__50f75e', 't1__f55777', 'uz7n', '0oq5nqy', 'wjq', '22', '0epbaljmxzq');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'bnp', 'mdpos', 'ie5', 'nw6klf', 'a9000t5c4eci');

-- Inserting into table: attendance --
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_id_1');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_id_2');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_id_3');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_id_4');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_id_5');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_id_6');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_id_7');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_id_8');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_id_9');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_id_10');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_id_11');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_id_12');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_id_13');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_id_14');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_id_15');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_id_16');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_id_17');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_id_18');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_id_19');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_id_20');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_id_21');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_id_22');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_id_23');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_id_24');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_id_25');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_id_26');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_id_27');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_id_28');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_id_29');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_id_30');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_id_31');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_id_32');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_id_33');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_id_34');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_id_35');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_id_36');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_id_37');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_id_38');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_id_39');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_id_40');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_id_41');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_id_42');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_26');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_4');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_12');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_2');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_33');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_9');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_31');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_29');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_43');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_44');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_6');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_28');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_21');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_45');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_38');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_46');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_18');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_22');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_47');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_32');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_8');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_40');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_19');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_48');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_49');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_50');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_41');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_51');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_52');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_53');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_54');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_55');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_56');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_57');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_14');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_58');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_59');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_60');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_61');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_10');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_62');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_63');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_11');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_64');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_65');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_66');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_67');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_34');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_1');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_68');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_69');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_42');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_70');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_71');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_72');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_73');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_17');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_74');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_13');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_75');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_27');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_76');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_77');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_78');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_79');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_80');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_81');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_82');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_20');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_83');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_84');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_85');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_86');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_87');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_88');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_16');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_89');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_90');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_91');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_92');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_93');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_94');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_95');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_96');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_85');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_27');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_39');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_8');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_15');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_97');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_25');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_44');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_63');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_65');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_95');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_24');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_98');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_99');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_60');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_75');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_17');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_20');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_51');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_71');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_47');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_86');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_12');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_4');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_i_100');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_94');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_i_101');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_i_102');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_i_103');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_2');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_i_104');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_56');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_69');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_14');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_18');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_i_105');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_92');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_i_106');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_28');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_64');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_66');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_38');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_i_107');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_82');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_i_108');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_i_109');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_i_110');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_72');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_42');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_68');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_i_111');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_87');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_i_112');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_88');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_i_113');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_50');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_i_114');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_6');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_i_115');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_93');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_55');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_i_116');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_i_117');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_i_118');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_81');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_i_119');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_45');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_84');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_48');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_53');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_i_120');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_i_121');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_7');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_49');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_i_122');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_i_123');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_37');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_i_124');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_i_125');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_i_126');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_i_127');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_id_40');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_i_128');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_i_129');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__50f75e', 'member_i_130');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_i_102');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_i_111');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_i_108');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_i_105');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_i_131');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_i_126');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_id_61');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_i_132');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_i_133');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_id_78');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_id_95');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_i_128');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_i_122');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_i_134');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_i_129');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_id_46');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_id_93');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_i_135');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_i_112');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_i_136');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_i_120');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__4dafa6', 'member_id_49');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_name FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event GROUP BY T1.event_id HAVING COUNT(T2.link_to_event) > 20;

/*
Gold Result:
('wvadbp0760',)
('t1__f55777',)
('t1__f55777',)
*/

-- Prediction Query
SELECT event.event_name FROM event INNER JOIN attendance ON event.event_id = attendance.link_to_event WHERE event.type <> 'fundraising' GROUP BY event.event_name HAVING COUNT(attendance.link_to_member) > 20;

/*
Prediction Result:
('t1__f55777',)
('wvadbp0760',)
*/