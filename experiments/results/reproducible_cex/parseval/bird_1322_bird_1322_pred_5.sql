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

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_15', 'isurz', 'kaqtncg', 'c8s3b7v88k', 'dmdbdh', '6j47n', 'ar50hs', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_16', 'p', 'nmwfwx', 'rlawk', '14r5dqt', 'mg97a', 'z2o20', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_17', 'su6iphd', 'u2g', 'r31', 'wq51oa', 'sb3uoi1p', 'avcvwnyqroui', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_18', 'l2i9esap8pg', 'k', 'wtsr5', '4o6qjektb1', '2', 'zg3r', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_19', 'ns47j2ja8dc', 'y', 'vjwq49yr', 'nxs6dvdxdo2v', '7t3gvplj9f', 'vuu', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_20', '2my1ogyv1rg', 'za', 'xc1clupgly', '8oitxeilp', 'e019cy7od0', '3dlhdsvn', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_21', '26u331', 'spxpw30bgwkx', 'in', 'j6i', 'dmp61l2o3ak1', '62ocagjeevx', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_22', '49kubo', '8c', 'e', 'uekhllbw', 'dpu5v0', 'du', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_23', 'z129835x', 'epac', 'db2f0c', '96xiyet8', 'jhcf46', 'f', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_24', 'rxa61sjv8nv', 'ddrokuez', 'ctehia3cmvb', '7vpc0xffwo', '1esks', '9q', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_25', '01', 'ui', '7f8', 'qhi', 'u5gm8gxb5qj', 'saw', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_26', 'i3hl7j', '3y795ybv', '3kr3w4jn2', '19xgjja', 'cgmukfb5if4', '80terbf', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_27', 'e6', 'ltut6', 'lu2cel8mhfc', 'mn5', 'ni', '0fm', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_28', 'oqxs27xh', '88y1k253s', '5', 'ls1ehn1md', 'aqqhyyzsnp64', 'mn', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_29', 'rrwbjk0', 'p', '6g', 'w', '7', 'jjplwtlzh42n', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_30', 'rji5mqk', 'na38gfxswb2d', 'zmxwdb7', 'tp5q', '1k4c', 'gwnkd4kc3', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_31', 'x', 'r90nhsp', 'gobb6nrn5', 'jphybn', 'a', 'vhvyx8s', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_32', 's3', 'qn0b5m2rlxcr', 'fx03rz', 'z8', 'lqme2wb1', '3', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_33', 'il21xs', 'd', '6q5ziqoauy0', '3lwh994f', 'qc1m9gr8xj', 'qbloxd4sj5il', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_34', 'gwakmwg', '73fy3d', 'dip', 'txfbl10qx6j', 'd4fc75m4s', 'ajdu26xu', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_35', 'x3', '5u7709', 'qf9lx8qzabi', 'uumwu7', 'l', '0jw', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_36', 'oe79350f', 'zrv1ll930xvk', 'viql6n0rlp', 'saxeeinmbc', 'v5o', 'sme', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_37', 'o', 'a0ol1z', 'mjrssbh72404', 'pp330', 'a1ngqut8', '184dwojdlhlz', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_38', 'xk0a0cql1c8c', 'wvadbp0760', 'gk2hjz', 'pg1lcg', 'a4gkjog8d', 'w16f5tqhjd', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_39', 'tzdlb6i4', '22tew5c29dwt', 'havc2c4', 'pw8672f', 've0jf4i5t99k', 'nbhvi6', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_40', 'nd', 'w89qy', 'sru4eufio', '8o', '6b', 'p9qgjradfhj', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_41', 'k53p8e5ol', 'f0yf1ur8kzi', '0g50j597fz', 'qcue', '41faxc', 'je448u5', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_42', '3ceh', 'e3oylci', 'if0ly46upl', 'eoh3m3q0pq97', '534', '5xb', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_43', 'spzc7xr', '4pmpjj', 'ec2trn', '6j72vkwegrf', '6snl45jw5pb', 'wo', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_44', '6v', '3', 'dx5hn', '5b733o58z', 'g', 'xt0twou', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_45', '4h5', '4', '1q', '9w43ial8s8', 'sp4j9fod', 't9kcq2iae6', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_46', '167', '6lk8qazkjy', 'fxsove98b8', '0235v8ik', '3qu7', 'cxswgr124', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_47', 'hklzy93zu', '8yb4qpog5sm', 'h', 't', 'nj8y6whwhl', '5i', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_48', 'm8r', 'y9lhw6lv7j45', 'k1qzqt5u', '42p20g', 'tfhk1l', 'bjksuye6', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_49', 'boodlz6', 'sijufc2', 'fghixb', 'gxislq', 'isdq44u2', 'kz', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_50', '3q5br37qobv', 'j', '26kpxc567p', 'vp0h2flntlco', 'qtl1u', 'dbvf', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_51', 'l431gfeg6', '6gifj', 'vxt41', 'jf1qj3s', '4d', 'pb4l6rurl72q', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_52', 'pxb659q4tkf5', '4ce', 'y485ys1g', '7p3hvg0', 'ytzip2', 'a6d2hqs4zc1', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_53', '2rnfvkrmf', 'qpzu', 'n', 'n53i98owqwx0', 'hvv0oh59iv', 'ipn6', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_54', 'kt16hqb9ja', '9p', '4done', 'b6piqku', 'izi62308npqd', 'bwew42zl4ptf', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_55', '0lw90t2klya', 'cw1g', 'o6r9', '3', 'dayv5uh', 'rvcc', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_56', 'q', 'eddnko', '7dq70691', '7', 's1i0k8thqz3', 's94x3', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_57', 'ufgefrzw', 'qgiqh4a', '3k79', '09407s', 'b3349k', 'f5l6rnd3rhb', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_58', 'p', '6v5122bvx', 'nuw', '4jm31nfs4', 'iom2', '85br29', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_59', 'jnnb', 'sy75w', 'nagrj6o3', '7kajtw7', 'qiuj9', '94', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_60', 'nr8dq5', 'bz', 'jmeuvjvcr9', '03f', '15y8am0q', 'ut2', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_61', '11luv', '4s7', 'ggg30z', 'h', 'dq8orxze42', 'wen', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_62', 'c3k', 'spw6gvoc9l', 'zmrsv641', '6b', 'ugt8ygq', 'fzr1', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_63', 'ikr1whx1d', 'zbb', '27z', 'uuwyewb', 'hg8', '1ev3gqe', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_64', 'cn', 't2v4lraxg0g', 'xot6v', '1lrh', 'qsxyubeyhmlr', 'ycz8', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_65', 'p', '1ke8', 'uy', '0kcxl8e4bkf', 'hyyx', 'm0cm', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_66', 'vk27ki4', 'vof5nd', 'i8', '0zqe9rs1z82', 'wy4o1', 'qirlh', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_67', '9km29vphx5', 'l7joby', '1skvh4q', 'y4gp', '0kr5bk0d0gkg', 'qavutce54k', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_68', '2j4ljlh', 'dpnheb', 'yaax', 'pyee2', 't2ugy7q', 'kj2d', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_69', '7dxug', 'rta6wanil', 'azq6gahjc', '84vxo5', 'ddfra', '2n0lwczduqt0', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_70', 'lr', 'rulwblhtkb', 'og8ol', '9cnlvwnzp', 'cpw', '0q9z43yul6g', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_71', 'ggq', 'kx1wfn', 'o', '1864', '9', '9n', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_72', 'teckaioh8', 'pzf5', 'ulsok', 'vhgc3b0v2', '3muo9o5cw', 'anc56gwfuy', -2147483648, 'major_id_1');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__f67312', '5k5swwqcgs', '9n8', 'Meeting', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__8239d5', 'hria2ypuzhs', 'rwbbp6luhvd', 'Meeting', 'tti', 'bnp', 'mdpos');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__0187d2', 'ie5', 'nw6klf', 'Meeting', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', '9tajz9td', 'n5wcgumbc', 'Meeting', '3tdu6bd0w960', 'vzxw1rxe', '9yfk7qk162n');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('@', '55', '3dohvu0', 'Meeting', 'dza35rmki', '18ri', 'hy08ftp6');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('M', '78aqqlu', '8', 'tb', 'r9114qbre', '6bjeuuwsj8k', 'h85');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('G', 'rpo', 'it63xy', 'vm', 'wpp', '6mb3aj0j', '0h3r13');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__98c5d1', 'un66e0', 'mol', 'Meeting', '070zi', '0o50q833g', '865zm6dpewew');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'l7', 'klex14ji', '7zwau2dwyr', '13pyu', '8d99rljsl');

-- Inserting into table: attendance --
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f67312', 'member_id_1');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f67312', 'member_id_2');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f67312', 'member_id_3');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f67312', 'member_id_4');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f67312', 'member_id_5');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f67312', 'member_id_6');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f67312', 'member_id_7');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f67312', 'member_id_8');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f67312', 'member_id_9');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f67312', 'member_id_10');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f67312', 'member_id_11');

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

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('M', 'member_id_6');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('M', 'member_id_4');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('M', 'member_id_15');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('M', 'member_id_3');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('M', 'member_id_2');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('M', 'member_id_1');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('M', 'member_id_16');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('M', 'member_id_8');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('M', 'member_id_5');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('M', 'member_id_17');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('M', 'member_id_9');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_15');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_5');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_9');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_14');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_1');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_12');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_13');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_18');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_19');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_7');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_17');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_6');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_20');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_4');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_3');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_2');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_21');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_22');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_23');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_24');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_25');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_10');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', 'member_id_26');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', 'member_id_25');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', 'member_id_27');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', 'member_id_19');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', 'member_id_28');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', 'member_id_7');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', 'member_id_29');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', 'member_id_30');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', 'member_id_23');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', 'member_id_31');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', 'member_id_32');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_27');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_29');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_16');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_31');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_33');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_23');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_14');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_4');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_34');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_10');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_35');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_11');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_36');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_17');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_22');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_30');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_18');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_37');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_38');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_32');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_13');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_1');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_2');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_39');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_20');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_40');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_41');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_12');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_42');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_43');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_44');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_45');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_46');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_47');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_28');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_48');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_49');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_50');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_51');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_52');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_53');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_54');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_55');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_56');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_25');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_57');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_58');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_59');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_60');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_6');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_61');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_62');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_63');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_64');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_8');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f67312', 'member_id_64');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f67312', 'member_id_50');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f67312', 'member_id_22');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f67312', 'member_id_65');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f67312', 'member_id_28');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f67312', 'member_id_41');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f67312', 'member_id_38');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f67312', 'member_id_66');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f67312', 'member_id_20');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f67312', 'member_id_56');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f67312', 'member_id_13');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__98c5d1', 'member_id_67');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f67312', 'member_id_68');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f67312', 'member_id_37');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f67312', 'member_id_19');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f67312', 'member_id_24');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f67312', 'member_id_69');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f67312', 'member_id_17');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f67312', 'member_id_70');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f67312', 'member_id_58');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f67312', 'member_id_63');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f67312', 'member_id_71');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f67312', 'member_id_45');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__f67312', 'member_id_72');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.event_id) FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event WHERE T1.type = 'Meeting' GROUP BY T1.type HAVING COUNT(T2.link_to_event) > 10;

/*
Gold Result:
(112,)
*/

-- Prediction Query
SELECT COUNT(T1.type) FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event WHERE T1.type = 'Meeting' GROUP BY T2.link_to_event HAVING COUNT(T2.link_to_event) > 10;

/*
Prediction Result:
(22,)
(34,)
(56,)
*/