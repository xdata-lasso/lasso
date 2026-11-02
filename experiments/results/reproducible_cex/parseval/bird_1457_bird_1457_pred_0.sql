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
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__22a8e8', '7zwau2dwyr', '13pyu', '8d99rljsl', 'b4yp5qi', 'rkf9vqx5', 'pz0f8jegd', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__ec4d13', 't3__7f6e6d', 't3__cdf8b7', 'y9uxj4', 'wb', 'v', 't3__f871ed', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t1__b282fe', 'xb72fxa7r', 'fdrz16n', 'jja', '5dh', 'ogrgjd8y', 't1afgog', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('A', 't3__7f6e6d', 't3__cdf8b7', 'jpttg', 'bnou5zi36', '4', 't3__f871ed', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('@', 'oacd07z2zez', 'o7w', 'xd', 'ysxcmr0o', 'ztdgj5i3lq5l', 'pim5', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('G', 'wii1', '5nxih66', 'q2xlyoto', '9oaawg', '6aqb0tbin', 'z', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('O', 'ta8y3a17v4', 'ygmayq3qdpu', 'p', '6rntdqrhm', 'wlic7dn2', 'p490', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('?', 'u5v0', 'du', 'y9v2z12983', '5xoepacxdb2f', 'c296xiy', 'et8xjhcf46c', -2147483648, 'major_id_1');

INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('t3__5a0a4c', 'jf4i5t9', '9kvnbhvi6t', '3tfn', 'dtw89qy6sru4', 'uf', 'of8', -2147483648, 'major_id_1');

-- Inserting into table: event --
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('event_id_1', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs');

-- Inserting into table: major --
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('major_id_1', 'um5', 'zbuo4nrq', 'rofqyp5s5b');

-- Inserting into table: zip_code --
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (-2147483648, 'p', '02eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji');

-- Inserting into table: budget --
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('_', 'rwbbp6luhvd', 179.378884, 304.02808, -1364429300, 'nprmdposii', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t1__2d025c', 'unw6klfa', 587.783596, 558.971814, 1419861592, '4ecigce376n', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('A', 'gndqwnqc', 629.317167, 668.309685, 580968159, 'cprj', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('/', 'bilyrkn', 692.775559, 339.789525, 1784916884, 'ah0f8jsww', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t1__5d0588', 'ctdctmfg62g0', 935.463334, 492.883123, 820970595, 'qdjpe1io2', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('O', 'orlwyngc1dj', 821.485286, 549.267866, -413043724, 'k1yoeyo6l0h', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('@', 'ly78oitxeilp', 592.613785, 935.379175, -1839279753, '19cy7od033d', 'event_id_1');

INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('t2__b859d0', '6b', 646.925851, 237.139013, 1388472267, 'jr', 'event_id_1');

-- Inserting into table: expense --
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_1', 'u0dz7', 'fjgq8n2f3', 687.701166, 'qv0gcb98ozk', 't1__ec4d13', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_2', 'itsj3', 'y', 360.694313, 'q4301jh', 't1__b282fe', '/');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_3', 'den8c68x', 'vacx7afu5', 354.593207, 'of77pzo', 't1__22a8e8', 't1__2d025c');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_4', '58q', 's27p2r94gth2', 193.695314, 'ajjl', '@', 't1__5d0588');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_5', '3', 'okv8uttmu2', 208.49371, '78lfvyz7', '@', 't1__5d0588');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_6', 'zzbe8yvkv4', 'q7sx58b4', 710.005534, 'maus', 't1__22a8e8', 't1__2d025c');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_7', 'j', 'wzw5chn9mo70', 486.420817, 'a9n0jxfofws', 't1__ec4d13', 't1__5d0588');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_8', 'do2zobb', 'q0k32od', 357.061424, '5am', 't1__b282fe', 't1__5d0588');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_id_9', 't', 'fuqyxuzkb', 904.57762, '521gwnlas6e', 't1__22a8e8', 'O');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_10', '9td8n5w', 'g', 314.953709, 'c', 't1__ec4d13', 't1__5d0588');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_11', '3tdu6bd0w960', 'vzxw1rxe', 673.390668, 'fk7qk16', 't1__b282fe', 't1__5d0588');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_12', '2nh55y3doh', 'u06dza', 464.095805, 'rmkio18ri2', 'A', 't1__2d025c');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_13', 'qxxnj', 'b', 376.823393, 'zn2m', 't1__ec4d13', 't1__5d0588');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_14', 'x7', '33', 753.382585, '6sto', 't1__b282fe', 't1__5d0588');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_15', 'cj8sh5k', 'zys7', 846.300006, 'yd1jmgj', 't1__22a8e8', 'O');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_16', 'tgelc', 'qb9i9f', 446.993541, 'c', 't1__ec4d13', 't1__5d0588');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_17', 'kjq1qu', 'k1y', 680.51123, '0', 't1__b282fe', 't1__5d0588');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_18', 'hlst1pqom', 'ztv', 17.438617, '4iz7', 'A', 't1__2d025c');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_19', '8', '9114q', 19.495363, '6b', 't1__ec4d13', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_20', 'jeuuwsj8kj', '85', 358.01048, 'lvrisu', 't1__b282fe', '_');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_21', 'z0kaq', 'ncgc8', 836.758526, 'b7v88kwd', 't1__22a8e8', 't1__2d025c');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_22', 'nxar50hsj', 'an', 778.307195, 'dpunmw', '@', 't1__5d0588');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_23', 'wx', 'rlawk', 417.346356, '14r5dqtsmg97', '@', 't1__5d0588');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_24', 'aqz2o20pj6d', 'dlysu6iphd', 168.487055, '2gir31', 't1__22a8e8', 't1__2d025c');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_25', 'sb3uoi1pavcv', 'wnyqrouirlrp', 738.89705, 'it63xy', 't1__ec4d13', 't1__5d0588');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_26', 'vm', 'wpp', 440.050658, 'b3aj', 't1__b282fe', 't1__5d0588');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_27', '0ju0h3r133ir', 'axyyhpl', 444.670601, '9es', 't1__22a8e8', '_');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_28', 'sr54o', 'qjektb1d2', 211.896872, 'g3rjkwn', 't1__ec4d13', 't1__5d0588');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_29', '47j2j', '8', 62.043518, 'y', 't1__b282fe', 't1__5d0588');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_30', 'vjwq49yr', 'nxs6dvdxdo2v', 848.951769, '7t3gvplj9f', 'A', 't1__2d025c');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_31', 'z2my1ogyv1r', 'ez', 9.845649, 'c1clup', 't1__ec4d13', 'A');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_32', 'hds', 'nhed29', 176.647154, 'qv26u331spx', 't1__b282fe', '@');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_33', 'pw30bgwkxgi', 'nlj6idmp61', 186.560838, 'o3ak162o', 't1__22a8e8', 't1__2d025c');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_34', 'xlu49ku', 'o', 66.494394, 'cde4uekhllbw', '@', 't1__5d0588');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_35', 'pe', 'rxa61sjv8nv', 984.65145, 'd', '?', 't1__5d0588');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_36', 'okuez', 'ctehia3cmvb', 601.929722, 'vpc0xffwo', 't1__22a8e8', 't1__2d025c');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('O', '2qg01huij', '7f8kqhiu5g', 188.706193, 'xb', 't1__ec4d13', 't1__5d0588');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('A', 'qjlsawsp', 'kwi3hl7j', 473.576214, '795ybv8', 't1__b282fe', 't1__5d0588');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_39', 'kr3w4jn2', '19xgjja', 897.384932, 'g', 't1__22a8e8', 't1__2d025c');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('G', '180terbf', 'kvee', 513.813043, 'tut', 't1__ec4d13', 't1__5d0588');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_41', '6lu2cel8mh', 'ci', 190.485743, '5eni', 't1__22a8e8', 't1__2d025c');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_42', 'qxs2', 'xh888y1k2', 572.142851, 'sb59ls1e', 't1__ec4d13', 't1__5d0588');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_43', 'hn1mdaqqhy', 'zsnp64h', 191.592457, 'w4m0', 't1__b282fe', 't1__5d0588');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('Q', 'rwbjk', 'bph6gdw', 30.178715, 'jjplwtlzh42n', 't1__22a8e8', 't1__2d025c');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_45', 'qkna', '38gfxswb2d0', 406.024611, 'xwdb', 't1__ec4d13', 't1__5d0588');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_46', 'otp5qo1k4', 'c6gwnkd4kc', 453.882126, 'ika', 't1__b282fe', 't1__5d0588');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('_', 'zr90nh', 'p9gob', 24.973024, 'rn5u', 't1__22a8e8', 't1__2d025c');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_48', 'vhvyx8s', 'r', 414.589719, '3qn0b', 't1__ec4d13', 't1__5d0588');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_49', 'm2rlxcrw', 'x0', 614.41989, 'rzgz84lq', 't1__b282fe', 't1__5d0588');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_50', 'un66e0', 'mol', 795.865367, '70zi90o', 't1__ec4d13', 't1__5d0588');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_51', '0q833g86', '5zm6dpewew0', 549.311325, 'p40u2vil', 't1__b282fe', 't1__5d0588');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('I', '1xsad6q5', 'iqoauy0', 449.887629, 'wh9', 't1__22a8e8', 't1__2d025c');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_53', 'xjqbloxd4', 'j5il9', 811.615432, 'nd6dvygwak', 't1__22a8e8', 't1__2d025c');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_54', 'k', 'i', 240.446424, 'xfbl1', 't1__22a8e8', 't1__2d025c');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_55', '5m4s2ajdu', '6xuj90te', 87.844941, 'u5u7709q', 't1__ec4d13', 't1__5d0588');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_56', '9l', '8qzabi', 340.157787, 'mwu7al', 't1__b282fe', 't1__5d0588');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_57', 'oe79350fzrv1', 'l93', 732.145658, '0xvkviql6n', 't1__ec4d13', 't1__5d0588');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_58', 'rlpsaxe', 'in', 851.932547, 'bciv', 't1__b282fe', 't1__5d0588');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_59', 'r3uxdoxa', '0ol1zmjrssbh', 531.151522, '404qpp3303a1', 't1__22a8e8', 't1__2d025c');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_60', 'ojdlhl', 'pdyxk0a', 893.593329, 'q', 't1__22a8e8', 't1__2d025c');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_61', 'p', '760ugk2', 120.614868, 'zxp', 't1__ec4d13', 't1__5d0588');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_62', '1l', 'g', 551.204026, 'gkjog8dw', 't1__b282fe', 't1__5d0588');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_63', '6f5tqhj', 'd5mabmkr2tzd', NULL, 'b6i', 't1__22a8e8', 't1__2d025c');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_64', '22tew5c2', '9dwt1havc2c4', NULL, 'pw8672f', 't1__22a8e8', 't1__2d025c');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_65', '8e5o', 'f0y', 80.779225, 'ur8kzi0', 't1__ec4d13', 't1__5d0588');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_66', '50', 'j597fznqcuex', 469.672773, 'ax', 't1__b282fe', 't1__5d0588');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_67', 'c1je448u5lv', 'dbp3cehye3', NULL, 'ylci', 't1__22a8e8', 't1__2d025c');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_68', 'if0ly46upl', 'eoh3m3q0pq97', NULL, '534', 't1__22a8e8', 't1__2d025c');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_69', 'pzc7x', 'v4pmp', 146.330199, 'vec', 't1__ec4d13', 't1__5d0588');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_70', 'trn6j72v', 'kwegrf6snl45', 567.292808, 'w5p', 't1__b282fe', 't1__5d0588');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_71', 'bgwojnhh6va', 'tdx5hn75', NULL, 'b733o58zbgyx', 't1__22a8e8', 't1__2d025c');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_72', '0twou', '4', NULL, 'yi4h5c4f1q', 't1__22a8e8', 't1__2d025c');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_73', 'p4j9f', 'dt9k', 765.725315, 'cq2iae6aj6ql', 't1__ec4d13', 't1__5d0588');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_74', '676lk8q', 'azkjyfxsov', 75.616312, '8b850235v', 't1__b282fe', 't1__5d0588');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_75', 'ikp3qu77c', 'swgr12', NULL, 'vu6v8hkl', 't1__22a8e8', 't1__2d025c');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_76', 'y93zu8y', 'b4qpog5smdhc', NULL, 'tnj8y6whwhl', 't1__22a8e8', 't1__2d025c');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_77', '8ry9', 'hw6', 181.46113, 'v7j452k1qzqt', 't1__ec4d13', 't1__5d0588');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_78', 'uw42p20g', 'tfhk1l', 824.540492, 'j', 't1__b282fe', 't1__5d0588');

INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('expense_i_79', 'suy', '6h', 910.141299, 'boodlz6', 't1__22a8e8', 't1__2d025c');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.first_name, T3.last_name, T3.phone FROM expense AS T1 INNER JOIN budget AS T2 ON T1.link_to_budget = T2.budget_id INNER JOIN member AS T3 ON T3.member_id = T1.link_to_member WHERE T1.cost > (SELECT AVG(T1.cost) FROM expense AS T1 INNER JOIN budget AS T2 ON T1.link_to_budget = T2.budget_id INNER JOIN member AS T3 ON T3.member_id = T1.link_to_member);

/*
Gold Result:
('t3__7f6e6d', 't3__cdf8b7', 't3__f871ed')
('7zwau2dwyr', '13pyu', 'pz0f8jegd')
('xb72fxa7r', 'fdrz16n', 't1afgog')
('oacd07z2zez', 'o7w', 'pim5')
('u5v0', 'du', 'et8xjhcf46c')
*/

-- Prediction Query
SELECT T2.first_name, T2.last_name, T2.phone FROM expense AS T1 INNER JOIN member AS T2 ON T1.link_to_member = T2.member_id WHERE T1.cost > (SELECT AVG(cost) FROM expense);

/*
Prediction Result:
('t3__7f6e6d', 't3__cdf8b7', 't3__f871ed')
('7zwau2dwyr', '13pyu', 'pz0f8jegd')
('t3__7f6e6d', 't3__cdf8b7', 't3__f871ed')
('7zwau2dwyr', '13pyu', 'pz0f8jegd')
('xb72fxa7r', 'fdrz16n', 't1afgog')
('t3__7f6e6d', 't3__cdf8b7', 't3__f871ed')
('xb72fxa7r', 'fdrz16n', 't1afgog')
('7zwau2dwyr', '13pyu', 'pz0f8jegd')
('xb72fxa7r', 'fdrz16n', 't1afgog')
('7zwau2dwyr', '13pyu', 'pz0f8jegd')
('oacd07z2zez', 'o7w', 'pim5')
('t3__7f6e6d', 't3__cdf8b7', 't3__f871ed')
('t3__7f6e6d', 't3__cdf8b7', 't3__f871ed')
('u5v0', 'du', 'et8xjhcf46c')
('7zwau2dwyr', '13pyu', 'pz0f8jegd')
('xb72fxa7r', 'fdrz16n', 't1afgog')
('7zwau2dwyr', '13pyu', 'pz0f8jegd')
('t3__7f6e6d', 't3__cdf8b7', 't3__f871ed')
('t3__7f6e6d', 't3__cdf8b7', 't3__f871ed')
('xb72fxa7r', 'fdrz16n', 't1afgog')
('xb72fxa7r', 'fdrz16n', 't1afgog')
('t3__7f6e6d', 't3__cdf8b7', 't3__f871ed')
('xb72fxa7r', 'fdrz16n', 't1afgog')
('7zwau2dwyr', '13pyu', 'pz0f8jegd')
('t3__7f6e6d', 't3__cdf8b7', 't3__f871ed')
('xb72fxa7r', 'fdrz16n', 't1afgog')
('7zwau2dwyr', '13pyu', 'pz0f8jegd')
('7zwau2dwyr', '13pyu', 'pz0f8jegd')
('xb72fxa7r', 'fdrz16n', 't1afgog')
('xb72fxa7r', 'fdrz16n', 't1afgog')
('xb72fxa7r', 'fdrz16n', 't1afgog')
('t3__7f6e6d', 't3__cdf8b7', 't3__f871ed')
('xb72fxa7r', 'fdrz16n', 't1afgog')
('7zwau2dwyr', '13pyu', 'pz0f8jegd')
*/