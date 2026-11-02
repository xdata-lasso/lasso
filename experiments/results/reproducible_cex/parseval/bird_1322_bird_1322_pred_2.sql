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

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_12', 'gjach8qta8y', 'a17v4ygm', 'y', '3qdpu', 'p', '6rntdqrhm', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_13', 'c7d', 'n2np490xdms', 'tgelc', 'qb9i9f', 'ccukjq1q', 'ik1yhb', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_14', 't1pqo', 'iztv', '6', '4iz7', 'aqqlud8ft', '8', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_15', 'qbre6bje', 'uuwsj8kjh8', 'wpxlvris', 'urz0kaqtncg', 'c8s3b7v88k', 'dmdbdh', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_16', 'nxar50hsj', 'an', 'xdpunmw', 'wx', 'rlawk', '14r5dqt', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_17', 'sb3uoi1p', 'avcvwnyqroui', 'lrpou', 't63', 'xyfvmjwpp26', 'b3aj', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_18', '0h3r133ir1ax', 'yhpl2i9', 'sa', '8pgc', 'qwt', 'r54o6', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_19', 'b1d2n', 'zg3rjkwns47j', 'ja8dccy3', 'vjwq49yrnx', '6dvdx', 'o', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_20', 'gvplj9fj', 'uun7k1', 'z2my1og', 'v1rgeza', 'xc1clupgly', '8oitxeilp', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_21', '19cy7od033d', 'hds', 'nhed29', 'qv2', 'u331spxpw', '0bgwkxgi', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_22', '6id', 'p61l', 'o3ak162o', 'cagjeevxzxlu', '49kuboe8cd', '4u', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_23', 'llbwvdpu5v0e', 'u', 'y9v2z12983', '5xoepacxdb2f', 'c296xiy', 'et8xjhcf46c', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_24', 'rxa61sjv8nv', 'ddrokuez', 'ctehia3cmvb', '7vpc0xffwo', '1esks', '9q', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_25', '01', 'ui', '7f8', 'qhi', 'u5gm8gxb5qj', 'saw', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_26', 'wi3', 'l7', 'j43y795ybv83', 'r3w', 'jn2z19xg', 'jac', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_27', 'kfb5if', '180terbf', 'kvee', 'sltut6lu2', 'cel8mhfcim', 'n5enii0fmbgz', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_28', 's27xh8', '8y1k253sb', '9ls1ehn1', 'daqq', 'yy', 'snp64hm', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_29', '4m0rrwbjk0', 'p', '6g', 'w', '7', 'jjplwtlzh42n', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_30', 'rji5mqk', 'na38gfxswb2d', 'zmxwdb7', 'tp5q', '1k4c', 'gwnkd4kc3', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_31', 'axz', '90nhs', '9gob', '6', 'rn5u', 'phy', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_32', 'y', 'hvyx8s', 'r', 'fs3qn0b', 'm2rlxcrw', 'x0', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_33', 'z8', 'lqme2wb1', '3', 'un66e0', 'mol', '070zi', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_34', 'q833g86', '5zm6dpewew0', '2p40u2vil', '1xsad6q5', 'iqoauy0', '3lwh994f', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_35', '9gr8', 'jqblox', '4', 'j5il9', 'nd6dvy', 'gwakmwgw73f', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_36', 'dip', 'txfbl10qx6j', 'd4fc75m4s', 'ajdu26xu', 'j90tefx3u5u', '709qf9lx8', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_37', 'vkviql', 'n0rlpsaxe', 'in', 'bciv', 'ojsmeqv3', '3uxdo', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_38', 'l1zm', 'rss', 'h', '2404qpp33', '3a1ngqu', '8184d', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_39', 'l', 'lz', 'dyxk', '0a0cql1c8c', 'wvadbp0760', 'gk2hjz', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_40', 'lcg9a4g', 'kjog8dw16f5t', 'hjd5m', 'b', 'kr2t', 'dlb6i42', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_41', 'w5c29dwt1ha', 'vc2c4zpw8672', 've', 'jf4i5t9', '9kvnbhvi6t', '3tfn', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_42', '6sru4eu', 'io', '8o', '6b', 'p9qgjradfhj', '8zr6k53p8e5o', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_43', 'f1ur8kz', '0g5', '0j597fznqc', 'ex41fa', 'c1je44', 'u5lvdbp3c', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_44', '3o', 'lciif0l', '46upleo', 'h3m3q0pq97j', '534j5xbk11y', 'pzc7x', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_45', 'mpjj', 'ec2trn', '6j72vkwegrf', '6snl45jw5pb', 'wo', 'nhh', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_46', 'tdx5hn75', 'b733o58zbgyx', '0twou', '4', 'yi4h5c4f1q', '9w43ial8s8', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_47', 'ove98', '8', '0235v8ik', '3qu7', 'cxswgr124', 'u6v8hk', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_48', 'y93zu8yb4q', 'og5s', 'dhct', 'nj8y6whwhl', '5i', 'dtdjm8r', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_49', 'hw6lv7j452', '1qz', 'qt5uw42p20', 'wt', 'hk', 'l3bjksu', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_50', 'zboodl', '60sijuf', 'c2vfghixbugx', 'slq', 'isdq44u2', 'kz', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_51', '5br37', 'obvbj', '26kpxc567p', 'vp0h2flntlco', 'qtl1u', 'dbvf', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_52', 'l431gfeg6', '6gifj', 'vxt41', 'jf1qj3s', '4d', 'pb4l6rurl72q', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_53', 'pxb659q4tkf5', '4ce', 'y485ys1g', '7p3hvg0', 'ytzip2', 'a6d2hqs4zc1', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_54', '2rnfvkrmf', 'qpzu', 'n', 'n53i98owqwx0', 'hvv0oh59iv', 'ipn6', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_55', 'kt16hqb9ja', '9p', '4done', 'b6piqku', 'izi62308npqd', 'bwew42zl4ptf', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_56', '0lw90t2klya', 'cw1g', 'o6r9', '3', 'dayv5uh', 'rvcc', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_57', 'qgiqh4ao3k79', '09407s', 'b3349k', 'f5l6rnd3rhb', 'nmbp96v512', 'bvxjnuw8', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_58', 's4', 'iom2', '85br29', '1kpjnnbss', '75w5nag', 'rj6o317kajtw', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_59', 'j9f945', 'cwnr8dq', '5gbzjmeuvjv', 'cr9l03f515y', '8am0qjut2f31', '6fr11luvk4', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_60', 'g3', 'zchdq8o', 'xze42', 'wen', '4ilc', 'kspw6gvo', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_61', 'zmrsv641', '6b', 'ugt8ygq', 'fzr1', 'v7z6i', 'r1w', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_62', '27z', 'uuwyewb', 'hg8', '1ev3gqe', 'nehcnt2v', 'lraxg0gt', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_63', '6vp1l', 'rhqsxyubey', 'ml', 'rnycz8d5yka', 'btcpo1ke8euy', '0kcxl8e4bkf', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_64', 'xnm0cmn', 'usy4c1vk2', 'ki4uvof5n', 'g', '80z', 'qe9rs1z82tw', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_65', 'sqirlhj', 'gxio9km', '9vphx5vl', '7joby01skvh4', 'my4gp', '0kr5bk0d0gkg', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_66', 'tce54k', 'dvf12j4ljl', 'hxdpnhebny', 'a', 'xtpyee2zt2', 'gy7qnk', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_67', 'la9', '1nq7dxug9rta', 'wanil7azq', '6gahjcu84vx', '5sdd', 'ra', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_68', 'lwczduqt0i', '19', 'gelrrulwb', 'htk', 't', 'og8ol79cnlv', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_69', 'kcpw', '0q9z43yul6g', '5jlkkggq', 'kx1wfn', 'o', '1864', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_70', 'teckaioh8', 'pzf5', 'ulsok', 'vhgc3b0v2', '3muo9o5cw', 'anc56gwfuy', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_71', 't', '95snh', 'c1jc1', 'j3dmll8k26', 'qohr35iptx', 'lhv1', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_72', 'w', 'wwkmxvvfta', 'q65qvero7mf', '86mok', 'pt50qbwhb', 'szz', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_73', 'd0cunhg', 'mgvzmqiwb', 'o', '90a5nxzf', 'as9e', 'zdfe0r841i6v', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_74', 'qzy', 'etff9znz5', 'a', 'yzmae7whkuxo', '6stk1uxpevo', 'sy9i6bswqb', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_75', 'd', 'm3japip', 'zjd2zxpmaspu', 'abl7juf', 'hq6', 'd1hg2', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_76', 'k', 'tumvp1', '9dvetwec1zu8', 'x72pbzz', 'fp2srds4', 'd57xpoymk4y', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_77', '4e2yc', 'ssva836i', 'iizc5c', 'dllp4l71l0q', 'nksw3506', '6790', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_78', '830rj', '63fqszsmbw', 'k5paop6', '3z5p37ek', 'hfm81p', '91mps38', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_79', 'tc4wz1', 'h52f5fx05rr8', 'vqg', 'r2exf0wr', 's', 'de2k', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_80', '2dui5ig2', 'eidvgb68hbw', '1fs7hycn', 'b5afv61keoy', 'aj0p', 'k4nr', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_81', 'j572', '4', 't9h4gwpvhdb', 'n16i83ytqv3', '1', '0qjx29a', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_82', 'x1siacshyuv', 'n3eac7v', 'dwkko5vwsu', 'ks6r', 'y62kek7hibs', 'fh8imiuk', -2147483648, 'major_id_1');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__c30d27', '5k5swwqcgs', '9n8', 'Meeting', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__40e3aa', 'hria2ypuzhs', 'rwbbp6luhvd', 'Meeting', 'tti', 'bnp', 'mdpos');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__109f67', 'ie5', 'nw6klf', 'Meeting', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Q', '9tajz9td', 'n5wcgumbc', 'Meeting', '3tdu6bd0w960', 'vzxw1rxe', '9yfk7qk162n');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('@', '55', '3dohvu0', 'Meeting', 'dza35rmki', '18ri', 'hy08ftp6');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', 'wt', 'xxnja', 'bymzn2mfx7h3', 'p6sto1cj', 'sh5knzys7', 'y');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('i', 'mg97a', 'z2o20', 'Meeting', 'pj6ddlysu6ip', 'dk', 'u2gir31vwq5');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('E', 'qzabivuumwu', 'alj0jwk6h', 'Meeting', '2o', '79', '50fzrv1l');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('I', 'sp4j9fod', 't9kcq2iae6', 'Meeting', 'j', 'ql1676lk8', 'azkjy');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__94013e', 'wraqxeddnko4', 'dq70691b7', 'Meeting', 's1i0k8thqz3', 's94x3', 'yxg3ufg');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'l7', 'klex14ji', '7zwau2dwyr', '13pyu', '8d99rljsl');

-- Inserting into table: attendance --
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__c30d27', 'member_id_1');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__c30d27', 'member_id_2');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__c30d27', 'member_id_3');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__c30d27', 'member_id_4');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__c30d27', 'member_id_5');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__c30d27', 'member_id_6');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__c30d27', 'member_id_7');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__c30d27', 'member_id_8');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__c30d27', 'member_id_9');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__c30d27', 'member_id_10');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__c30d27', 'member_id_11');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_11');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_7');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_1');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_12');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_8');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_10');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_13');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_14');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_5');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_15');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_16');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_17');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_18');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_9');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_19');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_20');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_21');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_22');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_3');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_23');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_24');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_25');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_26');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_27');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_28');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_29');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_30');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_31');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_32');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_33');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_34');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_35');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_36');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_37');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_38');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_39');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_40');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_41');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_4');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_42');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_43');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_44');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_45');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_46');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_47');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_48');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_49');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_50');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_2');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_51');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_52');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_53');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_54');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_55');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_56');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_46');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_5');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_6');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_18');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_26');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_48');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_38');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_57');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_43');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_41');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_31');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_10');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_13');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_30');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_58');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_49');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_34');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_19');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_54');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_59');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_60');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_61');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_8');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_24');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_28');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_53');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_4');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_12');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_62');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_63');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_16');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_64');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_65');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_66');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_20');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_67');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_68');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_69');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_2');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_14');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_27');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_45');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_56');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_70');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_71');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_47');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_40');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_17');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_72');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_73');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_74');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_44');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_75');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_76');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_52');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__c30d27', 'member_id_43');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__c30d27', 'member_id_77');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__c30d27', 'member_id_62');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__c30d27', 'member_id_24');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__c30d27', 'member_id_73');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__c30d27', 'member_id_53');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__c30d27', 'member_id_78');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__c30d27', 'member_id_44');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__c30d27', 'member_id_79');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__c30d27', 'member_id_16');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__c30d27', 'member_id_28');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__94013e', 'member_id_80');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__c30d27', 'member_id_55');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__c30d27', 'member_id_13');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__c30d27', 'member_id_27');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__c30d27', 'member_id_15');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__c30d27', 'member_id_47');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__c30d27', 'member_id_12');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__c30d27', 'member_id_65');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__c30d27', 'member_id_18');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__c30d27', 'member_id_32');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__c30d27', 'member_id_76');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__c30d27', 'member_id_81');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__c30d27', 'member_id_82');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.event_id) FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event WHERE T1.type = 'Meeting' GROUP BY T1.type HAVING COUNT(T2.link_to_event) > 10;

/*
Gold Result:
(90,)
*/

-- Prediction Query
SELECT COUNT(*) AS meeting_count FROM event AS e INNER JOIN attendance AS a ON e.event_id = a.link_to_event WHERE e.type = 'Meeting' GROUP BY e.event_id HAVING COUNT(a.link_to_member) > 10;

/*
Prediction Result:
(34,)
(56,)
*/