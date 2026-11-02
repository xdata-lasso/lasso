-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, 't1__ff4443', '2025-06-17', '2021-11-08', '2025-06-13', 'wwqcg', 'k9n8c');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (-2147483647, 't1__ff4443', '2025-06-26', '2022-08-22', '2024-05-26', 'f8jegd2', 'vy9uxj4');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2, 't1__ff4443', '2024-07-02', '2023-11-16', '2025-06-18', 'h', '9mo7');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3, '5a9n0jx', '2020-11-30', '2022-07-25', '2020-12-03', 'szdo2z', 'obb0q0k32o');

-- Inserting into table: examination --
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2025-04-30', 249.706432, 99.523333, -734455130, '4h', -992890117, 'PSS', 'a2ypuzhsrwbb', 'p6luhvdlttil', 'n', 'rmdp', 2026480202);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2021-05-25', 353.366837, 50.647649, 1581736075, 'gndqwnqc', 555413010, 'PSS', '5hncprjtu0d', '79fjgq8', 'n2f3dqv0gcb9', 'ozk3zbily', 638024588);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2025-09-09', 339.789525, 915.583344, 37673509, 'h0f8jswwlq', -566887085, 'PSS', '72fxa7ryfd', 'z16ni', 'jai', 'dh5ogrgj', -458359144);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (3, '2020-08-25', 357.061424, 979.99406, 895277769, 'amsorlwyng', -1960313034, 'PSS', 'j', '9erhizgk1yoe', 'o6l0hdt', 'fuqyxuzkb', -30041412);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (2, '2025-12-31', 277.506833, 139.117143, 769234989, '8ftp6ewtqx', 2013745856, 'PSS', 'b', 'mzn2mfx', 'h33p6sto1', 'j', 1728926031);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (3, '2021-07-15', 398.641235, 873.064955, -2128972904, 'lud8f', -835782528, 'PSS', 'r9114qbre', '6bjeuuwsj8k', 'h85', 'pxlvri', 986268139);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (2, '2023-11-10', 960.01108, 212.582014, -471852873, 'ouirl', 721232773, 'PSS', 'pouit63xyf', 'mjwpp2', 'mb3aj0ju0', '3r', -167036460);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (3, '2021-06-29', 820.122863, 657.064265, -563920971, 'lpe', 1163377746, 'PSS', 'cy7od033d', 'hds', 'nhed29', 'qv2', 1032462616);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (2, '2024-02-15', 2.719199, 506.492598, 1082379969, 'jv8nv', 2081562124, 'PSS', 'd', 'okuez', 'ctehia3cmvb', '7vpc0xffwo', -980269466);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2022-12-07', 364.736768, 715.183555, -494119248, '253', -887179029, 'PSS', '9ls1ehn1', 'daqq', 'yy', 'snp64hm', -1220782619);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2023-11-15', 992.470053, 473.557491, -1301565530, 'rwbjk', -356851435, 'PSS', 'h6gd', 'b7jjpl', 'tlzh42', 'nyj5yrji5m', 1253306312);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2024-02-19', 410.046262, 709.201306, 1142505194, 'gz84lqm', -1833815393, 'PSS', 'wb1b3vun66e0', 'mol', '070zi', '0o50q833g', -43429869);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2022-04-07', 773.037557, 881.002531, 1939546744, 'ew092p40u2vi', 770112293, 'PSS', '1xsad6q5', 'iqoauy0', '3lwh994f', 'qc1m9gr8xj', 1072042049);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2021-11-18', 614.675944, 976.142729, 513178845, '6n0', 355372240, 'PSS', 'psa', 'xeeinmbciv5', 'jsme', 'v3r3u', -562113476);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2022-06-20', 362.317546, 5.068218, 830725610, 'l1zm', -983850650, 'PSS', 'bh724', '4qpp330', 'a1ngqut8', '184dwojdlhlz', 1689665778);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2020-12-21', 703.357903, 542.619536, 1796323549, 'qgjradfhj', -417454764, 'PSS', 'k53p8e5ol', 'f0yf1ur8kzi', '0g50j597fz', 'qcue', -592652905);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2024-11-24', 88.852607, 368.989636, 1358642481, 'je448u5', -1400298523, 'PSS', 'dbp3cehye3', 'ylci', 'if0ly46upl', 'eoh3m3q0pq97', -30073701);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2025-08-17', 648.714999, 936.351291, -1395583222, '76lk8qazk', -1484908026, 'PSS', 'fxsove98b8', '0235v8ik', '3qu7', 'cxswgr124', 1905992027);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2025-09-14', 882.29503, 534.272506, -1662143968, 'lzy93zu8yb', 956649820, 'PSS', 'qpog5smdhc', 'tnj8y6whwhl', '5i', 'dtdjm8r', 209226821);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2021-01-14', 461.009986, 375.578113, 949206609, '31gfeg6q', 56216130, 'PSS', 'fjt', 'xt41zj', 'f1qj3se4dp', '4', -968316266);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2023-02-15', 174.02691, 438.371057, 196492760, 'pxb6', 2144707422, 'PSS', 'tkf5j4ce', 'y485ys1g', '7p3hvg0', 'ytzip2', 701987743);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2020-05-29', 818.627676, 664.991311, -607398188, 'gno6r9d3zd', 1169469726, 't2__104357', '5uhorv', 'c', 'wraqxeddnko4', 'dq70691b7', 692583137);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2025-11-23', 490.547086, 493.468238, 1040296707, 'rj', 27734824, 'PSS', '17kajtw7', 'qiuj9', '94', 'ycwnr8dq', 755310829);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2021-05-23', 93.981501, 535.943784, -270409176, '3gqe2n', -1831394002, 'PSS', 'n', 't2v4lraxg0g', 'xot6v', '1lrh', -524520263);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2024-11-12', 100.60932, 649.513898, -1325539976, 'vphx5vl7j', -1152460844, 'PSS', 'y01skvh4qm', '4gp0kr5', 'k', 'd0gkgqa', -772738375);

-- Inserting into table: laboratory --
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2021-06-28', -1602639011, -45536098, 123, 1861536320, 345.718563, 510.466242, 768.216462, 1620389964, 1.0, 627.258639, 947159877, 1990080517, 1408123494, -1964997180, 734.586266, 767.720387, 44.682291, 73.182847, 1155439218, 805.746877, -761141909, 779.28645, 283598170, 742285925, -747753377, 'nrqrofqy', -1106983592, 1884179925, 902551284, '2+', 'p', '02eutliqa11r', 2137741668, -525979501, 'oo3o9hl72kl', 'x1', 'ji7zwau2', 'dwyrq13pyu78', '9', 'rljsl0b4y', 'p5qi2rkf9v', 556727997);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-10-27', 1568069663, -1794176801, 123, -1194675273, 279.731401, 630.468925, 309.988616, -902895762, 1.0, 453.914926, 2111987706, -598313376, 1972233925, 1792827279, 632.340892, 687.319156, 457.141778, 410.094566, -1538707438, 774.445116, -163600466, 881.248682, -1826414375, 357330522, -683007527, 'x', -1762140823, 1371234901, -290314193, '2+', 'f77pzo72ctd', 't', -1284905200, 7929158, '0v', 'q8qdjpe1', 'o22', '8507cvtjp', 'ttg6bnou5zi3', 'c4bfkfoac', '0', 76987628);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-12-11', -461418236, -468701684, 123, 1448731351, 523.290303, 359.347359, 790.772456, -57705450, 1.0, 286.870177, -2005628382, 1721638020, 983324983, 1269522000, 698.769833, 297.258735, 104.37745, 703.796681, -1609653472, 172.799686, 1816660482, 184.430978, -1212676731, 1692046802, -1300180872, '58q', 1817366143, 1615073310, 1055237066, '2+', 'r94gth2m', 'ajjl', -2096405521, 1803796945, '8uttmu', 'ne578lfv', 'yz7zzbe8yvk', 'v42q7sx58b4p', 'aus3', 'u', 'mkrpdj', 1105964624);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (3, '2024-11-18', -1686002788, -1250380401, 123, 1718516876, 291.821648, 907.723998, 65.338043, -2076274980, 1.0, 903.105468, -1159083009, -1589605308, -268740517, -564679000, 118.293148, 946.669761, 441.511648, 446.264042, 287256667, 376.859029, 1614799674, 646.67543, 1083479253, 1774679448, 205676091, 'aawg96aqb0tb', -1216952047, -457901285, -2140923099, '2+', '9td8n5w', 'g', -794767771, 989306270, 'tdu6bd0w96', '3vzxw1r', 'e9yfk7', 'k162n', '55', '3dohvu0', 'dza35rmki', -1160642134);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (3, '2025-06-10', -1438303683, -515419519, 123, -1884062674, 670.297308, 376.149796, 425.077908, 357443379, 1.0, 194.959809, -1502591405, -2008781089, 1122899168, -161108900, 431.027804, 741.721165, 328.806478, 643.031153, 306260487, 771.998599, -499203870, 851.486083, 1432875972, 1032339628, 608093726, 'p', -845136979, -1042976410, -1670945624, '2+', 'wlic7dn2', 'p490', -592014051, 1744849810, 'sqtgelcuqb', 'i9f2ccukj', '1quik', 'yhb08hl', 't1pqo', 'iztv', '6', -1304516770);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (3, '2023-08-05', 1228655416, -388527046, 123, -1040951738, 583.099045, 643.870069, 216.231913, 697582781, 1.0, 599.871479, 1446366856, 438933248, 180947503, -622923312, 916.71268, 880.348467, 889.074497, 51.885919, 313797011, 953.185987, -1215810104, 9.534625, -982188592, 1981548099, -913430713, 'an', 1195320303, 1463445550, -1096060187, '2+', 'mwfw', 'qrlawk', 558684943, -120625031, 'dqtsmg97', 'aqz2o20pj6d', 'dlysu6iphd', 'u2g', 'r31', 'wq51oa', 'sb3uoi1p', -1971610898);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (3, '2021-06-30', 1805058154, -270436559, 123, -569461411, 379.844141, 848.895879, 242.875231, 370054768, 1.0, 444.670601, -1837449583, 1299933788, 679285124, 1752727653, 824.632363, 254.908527, 299.4394, 754.299382, 851545765, 659.070788, 987928936, 219.655532, -1042838119, 1763821445, 889799750, 'b1d2n', 946571403, -1517965246, 1807244612, '2+', '47j2ja8dccy3', 'vjwq49yrnx', 1511946366, -1910754958, 'o', 'v7t3gvpl', '9fj', 'uun7k1', 'z2my1og', 'v1rgeza', 'xc1clupgly', 139907579);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (3, '2025-03-10', -169055351, -894726713, 123, -1089715864, 461.542982, 22.436232, 358.454959, 1659285381, 1.0, 894.330875, 1718551923, 404445908, -1919229426, 495658460, 186.560838, 856.319446, 748.913804, 866.50801, -2106733603, 996.049277, -229524038, 884.782066, -1954048590, 1627742823, -1862623291, 'vxzxlu49ku', -2051917235, 833662145, -1943810603, '2+', 'uekhllbw', 'dpu5v0', -1846517698, 2117356203, 'v2z129835', 'oepacx', 'b', 'f0c296xi', 'et8xjhc', '46', 'f', 1280646590);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (3, '2020-10-07', -1424758178, 1403715810, 123, 1494789426, 255.938993, 409.488264, 123.21187, -1585280787, 1.0, 571.343568, 128895724, -1663813652, 1094664154, -1728059226, 884.814516, 493.547402, 664.385712, 698.884213, -1497515537, 833.61801, -2086261320, 858.731883, -1101370596, -1439283063, -1581061582, 'l7', -1480511510, -189319798, -51114840, '2+', 'v', '3kr3w4jn2', 1424689173, 1847608594, '9xgjjacgmukf', '5', 'f41', '80terbfokvee', 'sltut6lu2', 'cel8mhfcim', 'n5enii0fmbgz', -22531339);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2021-11-25', 1192169191, 172299659, 123, 1705419178, 859.599585, 705.094282, 696.066393, -626315618, 1.0, 438.311831, 1823879859, -1318060436, -613511812, 1705750528, 982.683174, 521.771035, 912.037404, 981.929822, 1424429365, 644.21122, 792905581, 263.978543, -317233455, 1548141293, 404180628, 'gwnkd4kc3', 872275367, -1586134101, 1199100757, '2+', 'zr90nh', 'p9gob', -976193147, -15423424, 'phy', 'n', 'a', 'vhvyx8s', 'r', 'fs3qn0b', 'm2rlxcrw', 1839708185);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2022-07-18', -551513589, -81327703, 123, -1531362377, 849.088145, 132.04121, 987.328198, 1338378083, 1.0, 612.52666, 945802166, 47431001, -698277997, 748510826, 730.504322, 720.633252, 14.936456, 621.995157, -1732139002, 524.244856, -1764222999, 466.386021, -1436037867, -1567310198, 1484560348, 'bl', -296531894, -1043691767, -1906909599, '2+', 'fc75m4s2ajdu', '6xuj90te', -1770192505, -199427879, 'u7709qf9', 'x8q', 'abivuum', 'u7alj0', 'jwk6hh2oe7', '9350fzrv1l', '930', 286693031);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-05-07', 1791555361, 463171538, 123, -358539593, 261.638238, 181.69083, 809.131891, 143677175, 1.0, 579.73437, -656017519, -2126129717, -1089271699, 1386881333, 882.971969, 98.968296, 156.80648, 120.614868, -1507399154, 368.492978, -1698199106, 173.828781, 2076581069, 1917868705, 188256891, 'w16f5tqhjd', -1332047564, -2058646672, 849869394, '2+', 'r2tzdlb6i4', '22tew5c29dwt', -1625641923, 758391026, 'c2c4zpw8672', 've', 'jf4i5t9', '9kvnbhvi6t', '3tfn', 'dtw89qy6sru4', 'uf', -1588383617);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2025-06-03', -1497850316, 1616702542, 123, -316558073, 961.162138, 892.402234, 249.359688, -455334817, 1.0, 613.250312, -587900447, 1360287391, 1102515755, -1134115109, 236.894057, 839.064026, 335.726932, 920.523547, -266037807, 627.78335, 895167757, 693.499842, 2108303347, 551248930, 829499649, 'kwegrf6snl45', -623382493, 2055961123, -2077724886, '2+', 'ojnhh6', 'a3tdx5', 847336138, 124874415, 'o58zbgyx', '0twou', '4', 'yi4h5c4f1q', '9w43ial8s8', 'sp4j9fod', 't9kcq2iae6', -2093375165);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2021-05-05', 1019149716, -1524863063, 123, -209713762, 437.076898, 398.58776, 614.733434, -1027442241, 1.0, 492.143324, 643624179, -665597852, -1102015194, 790826026, 94.717461, 300.517396, 121.633605, 432.054593, 1991996064, 287.210169, 1928368836, 219.34841, -1889113209, 822981708, 798014875, 'ufc', -737687664, -1708077219, 1608670538, '2+', 'bugxis', 'q2i', -880471265, 1754489362, '4u2fkzbw', '3q5br3', 'qobvbj26k', 'xc56', 'pvp0h2fln', 'lcorq', 'l1uod', 1038494243);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2025-08-19', 762889994, 1290341173, 123, 1232852817, 821.094627, 472.465156, 873.041338, -1948353462, 1.0, 962.57088, -254442524, 145803049, 1354931772, 1345356721, 335.834294, 166.832442, 944.988908, 89.452303, -1104938796, 924.204285, -2004793572, 729.252658, -1244820603, -1166137624, -1041632451, '0hvv0o', 1959006558, 231297195, 1427769239, '2+', 'ipn6', 'r', -1426197449, 1813484896, '6hqb9jae9ps4', 'o', 'e0b6', 'piqkuizi6230', 'npqdbwew4', 'zl4ptf8u', 'l0lw90t2kl', -2127892574);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-10-05', -373111401, 1164059352, 123, 1852558288, 392.936459, 466.616063, 271.783928, 209714160, 1.0, 365.925244, -191511230, -499801313, -1682733683, -745917239, 890.211993, 703.491659, 966.462143, 274.01046, -659241529, 722.834472, -1058831234, 132.436765, 1742533588, 1101106622, 1840016318, '3k79', -722157386, -71910989, -875587691, '2+', 'b3349kf5l6rn', '3', -1638030257, -1253560766, 'p', '6v5122bvx', 'nuw', '4jm31nfs4', 'iom2', '85br29', '1kpjnnbss', 1349128877);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2021-01-27', 857489503, -1856948760, 123, 1785422488, 155.655588, 961.758232, 650.149562, -392675823, 1.0, 598.035627, -22172292, 881719347, 2042733126, 184090233, 188.726655, 411.764609, 754.477673, 314.247186, -208707815, 459.536436, -317767232, 327.221202, -1438216227, 70240108, -1716157367, '30', -435550780, 1926794745, 1922961793, 't3__af2cb1', '8orxze42lw', 'enn4ilc3kspw', -1690083994, 1246780528, 'c9l5zmrsv64', 'h6b1ugt', 'ygqofzr1q', '7z6ikr', '1whx1dlzbb', '27z', 'uuwyewb', 1533864667);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2020-04-26', 756343111, -496224640, 123, 551417265, 177.361806, 278.006607, 617.67001, 1792208390, 101.0, 499.348658, 886201162, -865645665, -1087156585, 651885937, 635.150304, 819.701811, 726.876288, 691.897289, 1598680011, 685.73111, -784149557, 646.45275, 773955054, 406072510, 1039011719, '8e4', 513676024, 493838302, 971585276, '2+', 'hyyx', 'm0cm', 1672173400, -492514452, '1', 'k27ki4', 'vof5nd', 'i8', '0zqe9rs1z82', 'wy4o1', 'qirlh', 2038122309);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2020-06-13', 1127976372, 809990944, 1, 1893000285, 161.337069, 617.691181, 922.564872, -720139161, 1.0, 428.108935, -121197037, -1499789204, 947860475, 1504157345, 52.387344, 207.984208, 119.817012, 20.643973, -506886523, 724.690817, 430146619, 854.695233, 1779301509, 2010479348, 1832175675, '2z', -245355754, -1065110759, 685140638, '2+', '2dsjla91nq7d', 'ug9rta', -615675122, -1252742289, '7az', '6gahj', 'cu84vxo5sddf', 'a2n0l', 'czduqt', 'ig197ge', 'rru', 393697580);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2023-12-30', -1394371468, -1410959558, 1840720845, -1189171828, 986.293447, 778.024218, 548.920028, 527668055, 175.559791, 358.75435, 851083562, 1159447811, -1106305718, 2124240062, 762.688862, 824.516883, 847.895744, 666.46349, 724210726, 983.720533, -448128829, 803.910769, -145918370, 1553193892, -1679649983, 'jlkkggqx', 646367725, -312001161, -1771659759, 'o', '1864', '9', 501307804, -852945467, 'ckaioh8mpzf5', 'ulsok', 'vhgc3b0v2', '3muo9o5cw', 'anc56gwfuy', '2vtctr95snh', 'c1jc1', 470534297);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.SEX FROM Patient AS T1 INNER JOIN Examination AS T2 ON T1.ID = T2.ID INNER JOIN Laboratory AS T3 ON T3.ID = T2.ID WHERE T2.Diagnosis = 'PSS' AND T3.CRP = '2+' AND T3.CRE = 1.0 AND T3.LDH = 123;

/*
Gold Result:
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('5a9n0jx',)
('5a9n0jx',)
('5a9n0jx',)
('5a9n0jx',)
('5a9n0jx',)
('5a9n0jx',)
('5a9n0jx',)
('5a9n0jx',)
('5a9n0jx',)
('5a9n0jx',)
('5a9n0jx',)
('5a9n0jx',)
('5a9n0jx',)
('5a9n0jx',)
('5a9n0jx',)
('5a9n0jx',)
('5a9n0jx',)
('5a9n0jx',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
('t1__ff4443',)
*/

-- Prediction Query
SELECT DISTINCT T1.SEX FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID INNER JOIN Examination AS T3 ON T1.ID = T3.ID WHERE T3.Diagnosis = 'PSS' AND T2.CRP > 2 AND T2.CRE = 1 AND T2.LDH = 123;

/*
Prediction Result:
('t1__ff4443',)
('5a9n0jx',)
*/