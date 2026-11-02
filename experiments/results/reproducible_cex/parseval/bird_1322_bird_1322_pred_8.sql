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

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_47', 'j9fodt9k', 'cq2iae6aj6ql', '676lk8q', 'azkjyfxsov', '98', '8', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_48', '5v8ikp3q', '77cxsw', 'r1', '4vu6v8hk', 'lzy93zu8yb', '4qpog5smdhct', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_49', 'y6whwhlh5', 'i1dtdjm8ry9l', 'hw6lv7j452', '1qz', 'qt5uw42p20', 'wt', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_50', '3bj', 'suy', '6h', 'zboodl', '60sijuf', 'c2vfghixbugx', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_51', '2isdq', '4u2fkzbw', '3q5br3', 'qobvbj26k', 'xc56', 'pvp0h2fln', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_52', 'orqtl1uodbvf', 'ya6l431g', 'feg6q6gifj', 'vxt41', 'jf1qj3s', '4d', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_53', 'l6rurl72', '8ippx', '6', '59q4tkf5j4c', '2y', '485ys1gz7p3h', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_54', 'ytzip2', 'a6d2hqs4zc1', '2282rnfvk', 'mfoqp', 'ucnn53i', '8owqwx0hv', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_55', 'h59i', 'nipn6d', 'okt16', 'qb', 'jae9ps4do', 'e0b6', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_56', 'kuizi', '2308npqdb', 'wew42zl4ptf8', 'l0lw90', '2klya', 'cw1g', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_57', '7', 's1i0k8thqz3', 's94x3', 'yxg3ufg', 'efrzw0qgiqh4', 'o', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_58', '407swb334', '9kf5l6rnd3rh', 'n', 'bp96', 'v5122bvxjnuw', '4jm31nfs4', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_59', '2971k', 'jnnb', 'sy75w', 'nagrj6o3', '7kajtw7', 'qiuj9', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_60', 'r8dq', '5gbzjmeuvjv', 'cr9l03f515y', '8am0qjut2f31', '6fr11luvk4', '7wggg', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_61', 'h', 'dq8orxze42', 'wen', '4ilc', 'kspw6gvo', 'c9l5zmrsv64', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_62', 'ugt8ygq', 'fzr1', 'v7z6i', 'r1w', 'x1', 'l', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_63', 'zzuuwyewb', 'hg8', '1ev3gqe', 'nehcnt2v', 'lraxg0gt', 'ot6vp1', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_64', 'qsxyubeyhmlr', 'ycz8', '5', 'kabtcpo', '1ke8euy0kcx', '8e4', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_65', 'hyyxnm0cmn8', 'sy4c1v', '27k', '4uv', 'f5nd', 'i8', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_66', '9rs1z82twy', '4o1sqirlhj1', 'xi', 'o9km29vphx5v', '7jo', 'y', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_67', 'h4qmy4', 'p0', 'r5b', '0d0', 'gkgqavutce', '54kdvf12j4lj', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_68', 'nheb', 'yaax', 'pyee2', 't2ugy7q', 'kj2d', 'sjla91nq7dx', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_69', 'a6wan', 'l7a', 'q6gahjc', '84vxo5', 'ddfra', '2n0lwczduqt0', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_70', '7gelrrulw', 'l', 'tk', 't', 'og8ol79cnlv', 'nzpkcp', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_71', '3yul6g25', 'lkk', 'gq', 'kx1wfn', 'o', '1864', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_72', 'w16bb6teck', 'aioh8mpzf5t', 'lsok6v', 'gc', '3b0v293muo', 'o5cwanc56', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_73', 'y2vtct', '95snh', 'c1jc1', 'j3dmll8k26', 'qohr35iptx', 'lhv1', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_74', 'cw', 'wwkmxvvfta', 'q65qvero7mf', '86mok', 'pt50qbwhb', 'szz', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_75', '0', 'u', 'hg8m', 'vz', 'qiwb', 'o', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_76', 'xzfoas9ezd', 'e0', 'r841i6vn9a', '6hkqzy7etff', 'znz5cayzm', 'e', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_77', '6stk1uxpevo', 'sy9i6bswqb', 'oyhady', '3jap', 'pzj', '2', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_78', '0abl7j', 'ufkhq6sd1hg', '8jcakwtu', 'mvp19dvetw', 'ec1zu80x72pb', 'z2fp2sr', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_79', 'd57xpoymk4y', 'veffs4e', 'yc4ssva8', '6iviizc5', 'd', 'lp4', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_80', 'l0q4nksw350', '6p67904l0daf', '830rj', '63fqszsmbw', 'k5paop6', '3z5p37ek', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_81', '81p0', '1mps38vev', '5utc4wz1h52', '5f', '05rr8l', 'vqg3r2exf0w', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_82', 'e', 'khn0io22', 'u', '5ig', 'eidvgb68', 'bw', -2147483648, 'major_id_1');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__6cf877', '5k5swwqcgs', '9n8', 'Meeting', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__8fc7b1', 'hria2ypuzhs', 'rwbbp6luhvd', 'Meeting', 'tti', 'bnp', 'mdpos');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__453acb', 'ie5', 'nw6klf', 'Meeting', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('1', '9tajz9td', 'n5wcgumbc', 'Meeting', '3tdu6bd0w960', 'vzxw1rxe', '9yfk7qk162n');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('@', '55', '3dohvu0', 'Meeting', 'dza35rmki', '18ri', 'hy08ftp6');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', 'wt', 'xxnja', 'bymzn2mfx7h3', 'p6sto1cj', 'sh5knzys7', 'y');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('a', 'mg97a', 'z2o20', 'Meeting', 'pj6ddlysu6ip', 'dk', 'u2gir31vwq5');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('E', 'qzabivuumwu', 'alj0jwk6h', 'Meeting', '2o', '79', '50fzrv1l');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__caf1b9', 'o6r9', '3', 'Meeting', 'dayv5uh', 'rvcc', 'wraqxeddnko4');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'l7', 'klex14ji', '7zwau2dwyr', '13pyu', '8d99rljsl');

-- Inserting into table: attendance --
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__6cf877', 'member_id_1');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__6cf877', 'member_id_2');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__6cf877', 'member_id_3');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__6cf877', 'member_id_4');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__6cf877', 'member_id_5');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__6cf877', 'member_id_6');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__6cf877', 'member_id_7');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__6cf877', 'member_id_8');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__6cf877', 'member_id_9');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__6cf877', 'member_id_10');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__6cf877', 'member_id_11');

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

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_6');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_50');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_51');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_52');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_53');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_54');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_55');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('A', 'member_id_56');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_34');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_55');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_4');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_17');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_57');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_30');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_56');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_51');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_11');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_58');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_14');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_41');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_9');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_39');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_48');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_52');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_15');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_13');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_29');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_21');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_59');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_6');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_40');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_36');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_31');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_32');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_25');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_60');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_50');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_61');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_28');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_49');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_62');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_26');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_2');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_63');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_38');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_12');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_64');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_3');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_65');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_53');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_66');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_54');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_67');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_23');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_68');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_69');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_70');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_46');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_71');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_72');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_73');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_47');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_74');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__6cf877', 'member_id_13');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__6cf877', 'member_id_70');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__6cf877', 'member_id_75');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__6cf877', 'member_id_58');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__6cf877', 'member_id_71');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__6cf877', 'member_id_53');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__6cf877', 'member_id_76');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__6cf877', 'member_id_67');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__6cf877', 'member_id_46');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__6cf877', 'member_id_15');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__6cf877', 'member_id_21');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__caf1b9', 'member_id_77');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__6cf877', 'member_id_51');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__6cf877', 'member_id_48');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__6cf877', 'member_id_32');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__6cf877', 'member_id_77');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__6cf877', 'member_id_26');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__6cf877', 'member_id_78');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__6cf877', 'member_id_79');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__6cf877', 'member_id_80');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__6cf877', 'member_id_81');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__6cf877', 'member_id_36');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__6cf877', 'member_id_82');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__6cf877', 'member_id_57');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.event_id) FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event WHERE T1.type = 'Meeting' GROUP BY T1.type HAVING COUNT(T2.link_to_event) > 10;

/*
Gold Result:
(90,)
*/

-- Prediction Query
SELECT COUNT(T1.event_id) FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event WHERE T1.type = 'Meeting' GROUP BY T1.event_id HAVING COUNT(T2.link_to_member) > 10;

/*
Prediction Result:
(34,)
(56,)
*/