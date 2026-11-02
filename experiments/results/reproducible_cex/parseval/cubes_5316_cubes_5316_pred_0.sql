-- Schema DDL
CREATE TABLE "medicine" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Trade_Name" TEXT, "FDA_approved" TEXT);

CREATE TABLE "enzyme" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Location" TEXT, "Product" TEXT, "Chromosome" TEXT, "OMIM" INTEGER, "Porphyria" TEXT);

CREATE TABLE "medicine_enzyme_interaction" ("enzyme_id" INTEGER, "medicine_id" INTEGER, "interaction_type" TEXT, PRIMARY KEY ("enzyme_id", "medicine_id"), FOREIGN KEY ("medicine_id") REFERENCES "medicine" ("id"), FOREIGN KEY ("enzyme_id") REFERENCES "enzyme" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: medicine --
INSERT INTO "medicine" ("id", "name", "trade_name", "fda_approved") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4');

-- Inserting into table: enzyme --
INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483648, 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', -1377057208, 'ilbnp');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483647, 'dposiie5unw', 'klfa9000t', 'c4ecigce', '76nium52', -443340271, 'uo4nrqrofqy');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483646, '5bbp0', '2eutliqa11r', 'ytoo3o9', 'l7', 1178636309, 'ex1');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483645, '7zw', 'au2dwyrq13', 'yu78', '9', 244829661, 'jsl');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483644, 'yp5qi2rk', '9v', 'x58pz', 'f8jegd2', 1675430660, 'y9uxj4');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483643, 'd', 'lph2gn', 'q', 'nqcx5h', -1245312912, 'rjtu');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483642, '79fjgq8', 'n2f3dqv0gcb9', 'ozk3zbily', 'kn6vc', 1784916884, 'ah0f8jsww');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483641, 'xb72fxa7r', 'fdrz16n', 'jja', '5dh', 1583472758, 'rg');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483640, 'yzt1afgog', 'itsj3', 'y', 'p1q430', 1923912467, 'jh3den8c68');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483639, 'acx7af', '5w1of7', 'pzo72ctdc', 'mfg62', -1744557630, '5q8qdj');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483638, 'io22785', '7cvtjpt', 'tg6bnou5zi', '6c4bfkfo', -1950324754, '7z2zezj');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483637, 'wgxd5ysxcm', '0oztd', 'j5', '3lq', 1816660482, 'npi');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483636, '58q', 's27p2r94gth2', 'najj', 'a3o', -1428186898, 'uttmu2ne5');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483635, 'yz7zzb', '8y', 'kv42q7', 'x58b4', -1122409769, 'u');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483634, 'u', 'mkrpdj', 'wzw5chn9mo70', 'a9n0jxfo', -1793230843, 'zdo2z');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483633, '0', '0k32o', 'w', 'l', 895277769, 'amsorlwyng');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483632, 'j', '9erhizgk1yoe', 'o6l0hdt', 'fuqyxuzkb', -30041412, 'gwnlas6');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483631, 'boeowii1z5nx', 'h66', 'q2xlyoto', '9oaawg', 1044710644, 'qb0tbindz39t');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483630, '9td8n5w', 'g', 'mbc3td', 'u6bd0w9603', -541917667, 'rxe9yfk');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483629, '162nh55y3d', 'ohvu06dza3', 'rmkio18r', 'i2hy08ftp6', -1853955201, 'qxxnj');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483628, 'mzn2mfx', 'h33p6sto1', 'j', 'sh5knzys7', 1487347213, 'yd1jmgj');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483627, '8q', 'ta8y3a17v4', 'ygmayq3qdpu', 'p', -845136979, 'rhm5w');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483626, '7', 'dn2np490xdm', 'sqtgelcuqb', 'i9f2ccukj', 1046248997, 'uik1y');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483625, '8hlst1p', 'qomiztvb6m', 'iz78aqql', 'd8ftb8', 1183069552, '4qbre6b');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483624, 'uuwsj8kjh8', 'wpxlvris', 'urz0kaqtncg', 'c8s3b7v88k', -622923312, 'dbdh');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483623, 'j47nxar50h', 'sjhanzxdpu', 'mwfw', 'qrlawk', 558684943, 'r5dqtsmg');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483622, '2o20pj6', 'd', 'ysu', 'iphdku2gi', 1113005977, '31vwq51oa2sb');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483621, 'i1pa', 'cvwnyq', 'ouirl', 'rpouit63xyf', 1394459557, 'jwpp');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483620, 'b3aj', '0ju0h3r133ir', 'axyyhpl', 'i9esap8p', 679285124, 'k');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483619, 'sr54o', 'qjektb1d2', 'zg3r', 'jkwns47j2j', -1881008758, 'y');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483618, 'jwq49y', 'nxs6d', 'dxdo2v', '7t3gvplj9f', -1519752081, 'uun7k10z2my1');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483617, 'yv', 'rgezaxc', '1clupgly78o', 'txe', 1484825817, 'e019');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483616, 'od033dlhd', 'vnhed', '9lqv26u3', '1spxpw30', -2051120765, 'kxginl');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483615, 'dmp', '1l2o3ak16', 'ocagjeev', 'zxlu49', -1459357985, 'o');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483614, 'e', 'uekhllbw', 'dpu5v0', 'du', -699425950, '129835x');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483613, 'acxd', 'b2f0c296xiye', '8xjhc', '46', -2003500453, 'perxa61sjv');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483612, 'ddrokuez', 'ctehia3cmvb', '7vpc0xffwo', '1esks', 1403715810, 'q82qg01hu');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483611, '7f8kqhiu5g', '8gxb', 'qjlsawsp', 'kwi3hl7j', -113489293, '795ybv8');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483610, '3w4jn', 'z19xgjja', 'cgmukfb5if4', '80terbf', 1176294340, 'vee');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483609, 'ut6lu', 'cel8mhfc', 'mn5', 'ni', -1800278299, 'bgz5oqxs27');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483608, '88y1k253s', '5', 'ls1ehn1md', 'aqqhyyzsnp64', -1669961050, 'nw4m');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483607, 'wbjk0', 'p', '6g', 'w', -1489765135, 'lwtl');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483606, '42nyj5yrji5m', 'kna38', 'fx', 'wb2d0', -1318060436, 'db7otp');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483605, '1k4c', 'gwnkd4kc3', 'iikaxzr90nhs', '9gob', -976193147, 'ujphybna');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483604, 'hvyx8s', 'r', 'fs3qn0b', 'm2rlxcrw', 1839708185, '03rzgz');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483603, 'lqme2wb1b3v', 'n66e0i', 'olt0', '0zi90o50q', 162901577, 'g865zm6d');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483602, 'we', '092p40', '2vil21', 'sad6q5', -463551703, 'oauy0');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483601, 'wh9', '4fqc1m9gr', 'xjqbloxd4', 'j5il9', 1338378083, 'nd6dvygwak');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483600, 'gw73fy3dkd', 'ptx', 'bl', '10qx6j6d4f', 877176214, '5m4s2ajdu');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483599, 'xuj90tefx', 'u5u7709q', '9l', '8qzabi', -686517061, 'mwu7al');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483598, 'jwk6hh2oe7', '9350fzrv1l', '930', 'vkviql', 680112185, 'rlpsaxe');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483597, 'mbci', '5ojsme', 'v3r3u', 'doxa0o', 858882953, 'zmjrssb');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483596, '404qpp33', '3a1ngqu', '8184d', 'ojdlhl', -451096223, 'dyxk0a0cql1');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483595, 'w', 'adbp07', '0ugk2hjzx', 'g1lc', 2076581069, 'kj');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483594, '8d', 'w16f5tqhjd', 'mabmkr2t', 'dlb6i42', -221912911, 'w5');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483593, '9dwt1havc2c4', 'pw8672f', 've0jf4i5t99k', 'nbhvi6', -871131109, 'tfndtw89');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483592, 'sru4eufio', '8o', '6b', 'p9qgjradfhj', -417454764, 'k53p8e5ol');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483591, 'f1ur8kz', '0g5', '0j597fznqc', 'ex41fa', 1358642481, 'je448u5');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483590, 'dbp3cehye3', 'ylci', 'if0ly46upl', 'eoh3m3q0pq97', -30073701, '4j5xbk11ys');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483589, 'c7xrv4p', 'pjjv', 'c2', 'rn6j7', -656237101, 'rf');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483588, '45j', '5pbgwo', 'nhh', '6va3tdx5hn7', 847336138, '33o58zbgy');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483587, 'twoua4y', '4h5', '4', '1q', -663558450, 'ial8s82s');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483586, '9fo', 't', 'kcq2iae6a', '6ql', 29713329, 'k8qazkjyfxso');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483585, '98b850235v', 'ikp3qu77c', 'swgr12', 'vu6v8hkl', 1277665386, 'u8yb4qp');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483584, 'smdhctnj', 'y6whwhlh5', 'i1dtdjm8ry9l', 'hw6lv7j452', -1421113645, 'zqt5u');

INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (-2147483583, 'p20gwtfh', '1l3', 'j', 'suy', 1564603333, 'hvzboodlz');

-- Inserting into table: medicine_enzyme_interaction --
INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483648, -2147483648, 'med_5122c7');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483647, -2147483648, 'med_5122c7');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483646, -2147483648, 'med_5122c7');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483645, -2147483648, 'med_aee4fe');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483644, -2147483648, 'med_aee4fe');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483643, -2147483648, 'med_aee4fe');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483642, -2147483648, 'med_5122c7');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483641, -2147483648, 'med_5122c7');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483640, -2147483648, 'med_5122c7');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483639, -2147483648, 'med_aee4fe');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483638, -2147483648, 'med_aee4fe');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483637, -2147483648, 'med_aee4fe');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483636, -2147483648, 'med_5122c7');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483635, -2147483648, 'med_5122c7');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483634, -2147483648, 'med_5122c7');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483633, -2147483648, 'med_aee4fe');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483632, -2147483648, 'med_aee4fe');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483631, -2147483648, 'med_aee4fe');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483630, -2147483648, NULL);

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483629, -2147483648, NULL);

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483628, -2147483648, NULL);

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483627, -2147483648, NULL);

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483626, -2147483648, NULL);

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483625, -2147483648, NULL);

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483624, -2147483648, 'med_5122c7');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483623, -2147483648, 'med_5122c7');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483622, -2147483648, 'med_5122c7');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483621, -2147483648, 'med_aee4fe');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483620, -2147483648, 'med_aee4fe');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483619, -2147483648, 'med_aee4fe');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483618, -2147483648, 'med_5122c7');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483617, -2147483648, 'med_5122c7');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483616, -2147483648, 'med_5122c7');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483615, -2147483648, 'med_aee4fe');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483614, -2147483648, 'med_aee4fe');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483613, -2147483648, 'med_aee4fe');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483612, -2147483648, 'med_5122c7');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483611, -2147483648, 'med_5122c7');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483610, -2147483648, 'med_5122c7');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483609, -2147483648, 'med_aee4fe');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483608, -2147483648, 'med_aee4fe');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483607, -2147483648, 'med_aee4fe');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483606, -2147483648, 'med_5122c7');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483605, -2147483648, 'med_5122c7');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483604, -2147483648, 'med_5122c7');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483603, -2147483648, 'med_aee4fe');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483602, -2147483648, 'med_aee4fe');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483601, -2147483648, 'med_aee4fe');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483600, -2147483648, 'med_5122c7');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483599, -2147483648, 'med_5122c7');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483598, -2147483648, 'med_5122c7');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483597, -2147483648, 'med_aee4fe');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483596, -2147483648, 'med_aee4fe');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483595, -2147483648, 'med_aee4fe');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483594, -2147483648, 'med_5122c7');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483593, -2147483648, 'med_5122c7');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483592, -2147483648, 'med_5122c7');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483591, -2147483648, 'med_aee4fe');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483590, -2147483648, 'med_aee4fe');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483589, -2147483648, 'med_aee4fe');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483588, -2147483648, 'med_5122c7');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483587, -2147483648, 'med_5122c7');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483586, -2147483648, 'med_5122c7');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483585, -2147483648, 'med_aee4fe');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483584, -2147483648, 'med_aee4fe');

INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (-2147483583, -2147483648, 'med_aee4fe');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT interaction_type, n AS count___ FROM (SELECT LHS.interaction_type AS interaction_type, LHS.n AS n, RHS.n AS n_other FROM (SELECT interaction_type, COUNT(*) AS n FROM medicine_enzyme_interaction GROUP BY interaction_type) AS LHS CROSS JOIN (SELECT MAX(n) AS n FROM (SELECT interaction_type, COUNT(*) AS n FROM medicine_enzyme_interaction GROUP BY interaction_type)) AS RHS) WHERE (n = n_other) ORDER BY interaction_type, count___ NULLS LAST;

/*
Gold Result:
('med_5122c7', 30)
('med_aee4fe', 30)
*/

-- Prediction Query
SELECT interaction_type, COUNT(*) FROM medicine_enzyme_interaction GROUP BY interaction_type ORDER BY COUNT(*) DESC, interaction_type NULLS LAST LIMIT 1;

/*
Prediction Result:
('med_5122c7', 30)
*/