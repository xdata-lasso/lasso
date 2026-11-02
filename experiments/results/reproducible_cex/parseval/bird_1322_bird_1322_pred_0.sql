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

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_18', 'ouit63xyfvmj', 'wpp26mb3aj0j', '0h3r13', 'ir1axyyh', 'l2i9', 'sa', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_19', 'k', 'wtsr5', '4o6qjektb1', '2', 'zg3r', 'jkwns47j2j', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_20', 'y', 'vjwq49yr', 'nxs6dvdxdo2v', '7t3gvplj9f', 'vuu', '7k10', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_21', 'y1ogyv1rgeza', 'xc1clupgly', '8oitxeilp', 'e019cy7od0', '3dlhdsvn', 'ed', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_22', '26u331', 'spxpw30bgwkx', 'in', 'j6i', 'dmp61l2o3ak1', '62ocagjeevx', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_23', '49kubo', '8c', 'e', 'uekhllbw', 'dpu5v0', 'du', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_24', 'z129835x', 'epac', 'db2f0c', '96xiyet8', 'jhcf46', 'f', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_25', 'rxa61sjv8nv', 'ddrokuez', 'ctehia3cmvb', '7vpc0xffwo', '1esks', '9q', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_26', '01', 'ui', '7f8', 'qhi', 'u5gm8gxb5qj', 'saw', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_27', 'ee6slt', 't6lu2c', 'l8', 'mhfcimn5eni', '0fm', 'bgz5oqxs27', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_28', '8gfxswb2d0zm', 'wdb7ot', 'p5qo1k4c6gw', 'kd4k', 'c3iikaxzr9', '0nhsp9gobb6n', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_29', 'jphybn', 'a', 'vhvyx8s', 'r', 'fs3qn0b', 'm2rlxcrw', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_30', 'm6dpewe', '092p40', '2vil21', 'sad6q5', 'iqoauy0', '3lwh994f', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_31', '9gr8', 'jqblox', '4', 'j5il9', 'nd6dvy', 'gwakmwgw73f', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_32', 'i', 'txfb', 'l10qx6j6d4fc', '5m4s2ajdu', '6xuj90te', 'x3', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_33', '709qf9lx8', 'qzabivuumwu', 'alj0jwk6h', '2o', '79', '50fzrv1l', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_34', 'vkviql6n0r', 'psa', 'xeeinmbciv5', 'jsme', 'v3r3u', 'doxa0o', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_35', 'mjrssbh72404', 'pp330', 'a1ngqut8', '184dwojdlhlz', 'dyxk', '0a0cql1c8c', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_36', 'gk2hjzxpg1l', 'g', 'a4gkjog8d', 'w16f5tqhjd', 'mabmkr2t', 'dlb6i42', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_37', 'c29dwt1h', 'v', 'c2c4zpw8672', 've', 'jf4i5t9', '9kvnbhvi6t', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_38', 'nd', 'w89qy', 'sru4eufio', '8o', '6b', 'p9qgjradfhj', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_39', 'k53p8e5ol', 'f0yf1ur8kzi', '0g50j597fz', 'qcue', '41faxc', 'je448u5', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_40', 'p', '3cehye3oylc', 'if0', 'ly46upleoh', 'm3q0pq97', '534', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_41', '11y', 'pzc7x', 'v4pmp', 'jve', '2', 'rn6j7', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_42', 'kwegrf6snl45', 'jw5pbgwojn', 'hh6va3tdx5hn', '5b733o58z', 'g', 'xt0twou', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_43', '4h5', '4', '1q', '9w43ial8s8', 'sp4j9fod', 't9kcq2iae6', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_44', '167', '6lk8qazkjy', 'fxsove98b8', '0235v8ik', '3qu7', 'cxswgr124', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_45', 'hklzy93zu', '8yb4qpog5sm', 'h', 't', 'nj8y6whwhl', '5i', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_46', 'j', '8ry9', 'hw6', 'v7j', '52k1qzqt', 'uw42p20g', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_47', 'k1', '3bj', 'suy', '6h', 'zboodl', '60sijuf', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_48', 'fghixb', 'gxislq', 'isdq44u2', 'kz', 'w', '3q5br3', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_49', 'bvbj26kpxc56', 'pvp0h2fln', 'lcorq', 'l1uod', 'v', 'f3ya6l431gf', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_50', 'fjt', 'xt41zj', 'f1qj3se4dp', '4', '6ru', 'rl72q8ippxb6', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_51', 'tkf5j4ce', 'y485ys1g', '7p3hvg0', 'ytzip2', 'a6d2hqs4zc1', '2282rnfvk', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_52', 'qpzu', 'n', 'n53i98owqwx0', 'hvv0oh59iv', 'ipn6', 'r', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_53', '16hqb', 'jae9ps4do', 'e0b6', 'piqkuizi6230', 'npqdbwew4', 'zl4ptf8u', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_54', 'w90', '2klya', 'cw1g', 'o6r9', '3', 'dayv5uh', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_55', 'c', 'wraqxeddnko4', 'dq70691b7', 's1i0k8thqz3', 's94x3', 'yxg3ufg', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_56', 'zw0qg', 'qh4', 'o', 'k79v0940', '7swb3349kf', '5l6rnd3rhb', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_57', 'p', '6v5122bvx', 'nuw', '4jm31nfs4', 'iom2', '85br29', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_58', 'jnnb', 'sy75w', 'nagrj6o3', '7kajtw7', 'qiuj9', '94', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_59', 'nr8dq5', 'bz', 'jmeuvjvcr9', '03f', '15y8am0q', 'ut2', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_60', '11luv', '4s7', 'ggg30z', 'h', 'dq8orxze42', 'wen', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_61', '3', 'spw', 'gvoc9l5zm', 'sv641', '6b', 'ugt8ygq', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_62', '1qv7z', 'ikr1whx1d', 'zbb', '27z', 'uuwyewb', 'hg8', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_63', 'qe', 'nehcnt2v', 'lraxg0gt', 'ot6vp1', 'lrhqsxyube', 'yhmlrnycz8d5', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_64', 'tcpo1ke8euy', '0kcxl8e4bkf', 'hyyx', 'm0cm', '8usy', 'c1vk27ki', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_65', 'g', '80z', 'qe9rs1z82tw', '4o1sqir', 'hj1', 'xi', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_66', '9vphx5vl', '7joby01skvh4', 'my4gp', '0kr5bk0d0gkg', 'qavutce54k', 'dvf12j4ljl', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('member_id_67', 'nheb', 'yaax', 'pyee2', 't2ugy7q', 'kj2d', 'sjla91nq7dx', -2147483648, 'major_id_1');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__7e9f45', '5k5swwqcgs', '9n8', 'Meeting', '4', 'gu7v', 'e4');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__ec56b7', 'hria2ypuzhs', 'rwbbp6luhvd', 'Meeting', 'tti', 'bnp', 'mdpos');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t1__b65199', 'ie5', 'nw6klf', 'Meeting', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('A', '9tajz9td', 'n5wcgumbc', 'Meeting', '3tdu6bd0w960', 'vzxw1rxe', '9yfk7qk162n');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('@', '55', '3dohvu0', 'Meeting', 'dza35rmki', '18ri', 'hy08ftp6');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('G', '78aqqlu', '8', 'tb', 'r9114qbre', '6bjeuuwsj8k', 'h85');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('O', '4kwi', 'hl7j43y7', '5ybv83kr3', 'w4jn2z19xgj', 'jacgmukfb5', 'f41');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Q', '88', 'y1k253sb5', 'Meeting', 'ls1ehn1md', 'aqqhyyzsnp64', 'mn');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('C', 'w4m0', 'rwbjk', 'bph6gdw', '7', 'jjplwtlzh42n', 'j5yrji5');

INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('t2__07b9dc', '3rzgz84lqm', '2w', 'Meeting', 'b1b3vun66e0i', 'olt0', '0zi90o50q');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'l7', 'klex14ji', '7zwau2dwyr', '13pyu', '8d99rljsl');

-- Inserting into table: attendance --
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__7e9f45', 'member_id_1');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__7e9f45', 'member_id_2');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__7e9f45', 'member_id_3');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__7e9f45', 'member_id_4');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__7e9f45', 'member_id_5');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__7e9f45', 'member_id_6');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__7e9f45', 'member_id_7');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__7e9f45', 'member_id_8');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__7e9f45', 'member_id_9');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__7e9f45', 'member_id_10');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__7e9f45', 'member_id_11');

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

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_6');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_4');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_15');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_3');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_2');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_1');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_16');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_8');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_5');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_17');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('G', 'member_id_9');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', 'member_id_18');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', 'member_id_19');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', 'member_id_20');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', 'member_id_21');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', 'member_id_15');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', 'member_id_22');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', 'member_id_23');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', 'member_id_24');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', 'member_id_25');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', 'member_id_26');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('@', 'member_id_10');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('O', 'member_id_23');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('O', 'member_id_18');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('O', 'member_id_14');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('O', 'member_id_25');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('O', 'member_id_10');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('O', 'member_id_3');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('O', 'member_id_9');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('O', 'member_id_1');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('O', 'member_id_27');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('O', 'member_id_12');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('O', 'member_id_26');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('C', 'member_id_7');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('C', 'member_id_26');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('C', 'member_id_9');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('C', 'member_id_6');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('C', 'member_id_24');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('C', 'member_id_28');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('C', 'member_id_25');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('C', 'member_id_29');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('C', 'member_id_3');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('C', 'member_id_12');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('C', 'member_id_14');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_18');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_15');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_30');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_20');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_25');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_27');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_21');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_28');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_9');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_19');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_31');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_13');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_32');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_33');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_12');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_34');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_35');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_23');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_22');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_1');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_4');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_2');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_16');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_36');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_29');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_37');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_38');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_39');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_40');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_10');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_41');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_42');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_43');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_44');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_45');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_46');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_47');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_48');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_49');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_5');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_7');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_50');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_51');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_52');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_53');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_54');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_55');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_56');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_57');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_58');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_59');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_6');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_60');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_14');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_61');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__7e9f45', 'member_id_15');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__7e9f45', 'member_id_45');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__7e9f45', 'member_id_62');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__7e9f45', 'member_id_27');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__7e9f45', 'member_id_59');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__7e9f45', 'member_id_48');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__7e9f45', 'member_id_52');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__7e9f45', 'member_id_28');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__7e9f45', 'member_id_63');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__7e9f45', 'member_id_25');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__7e9f45', 'member_id_46');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t2__07b9dc', 'member_id_11');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__7e9f45', 'member_id_64');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__7e9f45', 'member_id_61');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__7e9f45', 'member_id_42');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__7e9f45', 'member_id_44');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__7e9f45', 'member_id_29');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__7e9f45', 'member_id_65');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__7e9f45', 'member_id_66');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__7e9f45', 'member_id_67');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__7e9f45', 'member_id_41');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__7e9f45', 'member_id_13');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__7e9f45', 'member_id_36');

INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('t1__7e9f45', 'member_id_40');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.event_id) FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event WHERE T1.type = 'Meeting' GROUP BY T1.type HAVING COUNT(T2.link_to_event) > 10;

/*
Gold Result:
(112,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT e.event_id) FROM event AS e JOIN attendance AS a ON e.event_id = a.link_to_event WHERE e.type = 'Meeting' AND (SELECT COUNT(*) FROM attendance WHERE link_to_event = e.event_id) > 10;

/*
Prediction Result:
(3,)
*/