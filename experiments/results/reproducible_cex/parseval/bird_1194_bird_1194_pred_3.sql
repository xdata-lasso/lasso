-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, 't1__482505', '2025-06-17', '2021-11-08', '2025-06-13', 'wwqcg', 'k9n8c');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3, 't1__482505', '2025-06-26', '2022-08-22', '2024-05-26', 'f8jegd2', 'vy9uxj4');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2, 'w5chn9m', '2022-07-11', '2025-11-15', '2024-09-06', 'a9n0jxfo', 'ws');

-- Inserting into table: examination --
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2025-04-30', 249.706432, 99.523333, -734455130, '4h', -992890117, 'PSS', 'a2ypuzhsrwbb', 'p6luhvdlttil', 'n', 'rmdp', 2026480202);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2021-05-25', 353.366837, 50.647649, 1581736075, 'gndqwnqc', 555413010, 'PSS', '5hncprjtu0d', '79fjgq8', 'n2f3dqv0gcb9', 'ozk3zbily', 638024588);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2025-09-09', 339.789525, 915.583344, 37673509, 'h0f8jswwlq', -566887085, 'PSS', '72fxa7ryfd', 'z16ni', 'jai', 'dh5ogrgj', -458359144);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (2, '2024-06-14', 55.294573, 221.713281, -210159774, 'obb0q0k32o', -1898678660, 'PSS', 'l', '5amsorlwyngc', 'dj9erhi', 'zgk1yoeyo6l0', -1614619556);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (2, '2024-06-17', 6.073642, 485.223245, 1595632888, 'mkio18ri2hy', -1853955201, 'PSS', 'qxxnj', 'b', 'mzn2mfx', 'h33p6sto1', -1971560508);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (2, '2024-10-24', 876.781557, 881.656954, -2063751689, '6b', -1537647691, 'PSS', 'uuwsj8kjh8', 'wpxlvris', 'urz0kaqtncg', 'c8s3b7v88k', -622923312);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (2, '2022-02-13', 154.253041, 960.423122, -1094296226, '6mb3aj0j', 982289268, 'PSS', '3r', '133ir1axyy', 'hpl2i9esap', 'pgckqwtsr', 987928936);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (2, '2021-12-24', 683.8774, 677.985968, -159572656, 'spxpw30', -2051120765, 'PSS', 'kxginl', '6id', 'p61l', 'o3ak162o', -1954048590);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (2, '2020-03-21', 601.929722, 518.669812, -1077762203, 'xffwor1', 1202197697, 'PSS', 'ksf9q', '2qg01huij', '7f8kqhiu5g', '8gxb', 854201197);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2022-06-02', 208.856257, 992.470053, -1301565530, 'rwbjk', -356851435, 'PSS', 'h6gd', 'b7jjpl', 'tlzh42', 'nyj5yrji5m', 1253306312);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2021-11-25', 954.599684, 217.096714, 1192169191, '8gfxswb2d0zm', -600498375, 'PSS', 'b', 'otp5qo1k4', 'c6gwnkd4kc', 'iikaxzr9', 1008864713);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2022-07-18', 371.590734, 998.623505, -81327703, '5il', 1338378083, 'PSS', 'nd6dvygwak', 'mwgw73fy3d', 'dip', 'txfbl10qx6j', 41724575);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2025-04-22', 980.093596, 954.183393, 877176214, '5m4s2ajdu', -567584339, 'PSS', 'j90tefx3u5u', '709qf9lx8', 'qzabivuumwu', 'alj0jwk6h', -1632840156);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2021-03-04', 427.330145, 43.85128, 219919626, 'gkjog8dw', 1314064183, 'PSS', 'qhjd5', 'abmk', 'r2tzdlb6i4', '22tew5c29dwt', -1625641923);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2023-10-14', 658.745155, 792.049687, -1963616196, 'pw8672f', 1770083132, 'PSS', 'jf4i5t9', '9kvnbhvi6t', '3tfn', 'dtw89qy6sru4', -1877887746);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2022-10-18', 827.940713, 32.782701, 1686931087, 'v4pmp', -1502776895, 'PSS', 'c2', 'rn6j7', '2vkwegrf6snl', '5jw5pbgw', 934369722);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2021-09-06', 680.85611, 744.755708, 1853786940, '6v', -164454935, 'PSS', 'dx5hn75b73', 'o58zbgyx', '0twou', '4', 453154609);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2023-06-07', 49.062825, 900.10851, 2109623518, 'lhw6lv7j4', -209713762, 'PSS', 'qzqt5uw', '2p20gwtf', 'k1', '3bj', -1417432574);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2023-07-24', 379.209033, 71.669711, 1928368836, 'odlz', 22415446, 'PSS', 'sijufc2vfgh', 'xbu', 'xi', 'lq2is', -69826970);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2024-09-23', 352.582174, 297.40565, -412910283, '2a6d', 1290341173, 'PSS', 's4zc1', '2282rnfvk', 'mfoqp', 'ucnn53i', 178068376);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2023-12-04', 996.964744, 257.476042, -1639837436, 'v0oh59ivnipn', 52953901, 'PSS', 'okt16', 'qb', 'jae9ps4do', 'e0b6', 1039998344);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2020-12-13', 274.01046, 735.018399, -659241529, 'qgiqh4ao3k79', -722157386, 't2__237dfb', '407swb334', '9kf5l6rnd3rh', 'n', 'bp96', 1061006043);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2020-10-26', 475.332579, 439.193451, 832376590, 'nn4ilc3kspw6', -1690083994, 'PSS', 'c9l5', 'mrsv641', '6b', 'ugt8ygq', 852372792);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2023-10-12', 161.431958, 448.974941, -1457351628, 'uvof5ndg', 625106229, 'PSS', 'qe9rs1z', '82twy4o1sqi', 'rlhj1gxio9', 'm29', -709260001);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2020-01-29', 208.323204, 172.239114, -463649338, '6gahjcu84vx', 1709664327, 'PSS', 'sddfra2n', 'lwczduq', '0ig19', 'gelrrulwb', 1994640301);

-- Inserting into table: laboratory --
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2021-06-28', -1602639011, -45536098, 123, 1861536320, 345.718563, 510.466242, 768.216462, 1620389964, 1.0, 627.258639, 947159877, 1990080517, 1408123494, -1964997180, 734.586266, 767.720387, 44.682291, 73.182847, 1155439218, 805.746877, -761141909, 779.28645, 283598170, 742285925, -747753377, 'nrqrofqy', -1106983592, 1884179925, 902551284, '2+', 'p', '02eutliqa11r', 2137741668, -525979501, 'oo3o9hl72kl', 'x1', 'ji7zwau2', 'dwyrq13pyu78', '9', 'rljsl0b4y', 'p5qi2rkf9v', 556727997);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-10-27', 1568069663, -1794176801, 123, -1194675273, 279.731401, 630.468925, 309.988616, -902895762, 1.0, 453.914926, 2111987706, -598313376, 1972233925, 1792827279, 632.340892, 687.319156, 457.141778, 410.094566, -1538707438, 774.445116, -163600466, 881.248682, -1826414375, 357330522, -683007527, 'x', -1762140823, 1371234901, -290314193, '2+', 'f77pzo72ctd', 't', -1284905200, 7929158, '0v', 'q8qdjpe1', 'o22', '8507cvtjp', 'ttg6bnou5zi3', 'c4bfkfoac', '0', 76987628);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-12-11', -461418236, -468701684, 123, 1448731351, 523.290303, 359.347359, 790.772456, -57705450, 1.0, 286.870177, -2005628382, 1721638020, 983324983, 1269522000, 698.769833, 297.258735, 104.37745, 703.796681, -1609653472, 172.799686, 1816660482, 184.430978, -1212676731, 1692046802, -1300180872, '58q', 1817366143, 1615073310, 1055237066, '2+', 'r94gth2m', 'ajjl', -2096405521, 1803796945, '8uttmu', 'ne578lfv', 'yz7zzbe8yvk', 'v42q7sx58b4p', 'aus3', 'u', 'mkrpdj', 1105964624);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '2023-05-23', -795975227, 1294064538, 123, 778835680, 908.792879, 852.508842, 793.946774, 450555855, 1.0, 451.913941, -1686002788, -1250380401, 1718516876, -2076274980, 903.105468, 230.129952, 129.891173, 437.428969, -564679000, 118.293148, -251205568, 446.264042, 287256667, 1614799674, 1083479253, '9oaawg', 1044710644, 966412849, -2061634386, '2+', 'bindz', '9tajz9td', 152478847, -625404808, 'um', 'c', '3tdu6bd0w960', 'vzxw1rxe', '9yfk7qk162n', '55', '3dohvu0', 30861410);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (3, '2023-04-07', -1643065004, -1438303683, 123, -515419519, 527.830294, 61.332474, 670.297308, -531932574, 1.0, 425.077908, 357443379, -1502591405, -2008781089, 1122899168, 462.488905, 431.027804, 741.721165, 328.806478, 614314115, 96.243596, 306260487, 771.998599, -499203870, 1509621238, 1432875972, 'dpuap96rnt', 1139012231, -951706262, -1324935647, '2+', 'wlic7dn2np', '90xdmsqt', -1685482179, -1391541536, 'qb9i9f', 'ccukjq1q', 'ik1yhb', '8hlst1p', 'qomiztvb6m', 'iz78aqql', 'd8ftb8', 1183069552);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '2022-03-06', 1633584225, 1671062261, 123, -1924635316, 303.260196, 573.061557, 953.185987, -1215810104, 1.0, 9.534625, -982188592, 1981548099, -913430713, -1652411404, 210.413164, 391.732565, 371.216432, 643.876849, 1720208360, 323.180064, -1243923337, 786.644633, -1782325492, -544173163, -958321297, 'w', -1439417265, -300547632, -967107842, '2+', 'dqtsmg97aqz2', '20pj', -1385967617, 1813965704, 'u6iphdku2gi', '31vwq', '1oa2sb3u', 'i1pa', 'cvwnyq', 'ouirl', 'rpouit63xyf', 1394459557);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (3, '2022-06-18', 17776256, -1464066437, 123, -1892701926, 211.896872, 392.889739, 961.420907, 1794943626, 1.0, 706.50358, 294604606, -1460437682, 1014069980, 1070869226, 519.969066, 740.685871, 145.530816, 146.640308, 173803229, 41.066446, -526608193, 584.512314, 1560573473, 472597763, 826141460, '49yrn', -583955995, -1935855834, 294818731, '2+', 'do2v7t', 'gvplj9fj', -743497747, -1415215611, 'z2my1og', 'v1rgeza', 'xc1clupgly', '8oitxeilp', 'e019cy7od0', '3dlhdsvn', 'ed', 1188203659);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '2021-02-09', -1862623291, -696200137, 123, -410809407, 178.444842, 989.611258, 473.564222, 207561330, 1.0, 318.136826, -1195170145, -2007399097, -92242817, 426006253, 117.474993, 177.621593, 181.017398, 818.343683, 1097428449, 348.456963, -712974538, 235.490046, 1201135348, -681356377, -1846517698, 'y9v2z1', 516500236, 171585273, 1870044139, '2+', 'oepacx', 'b', -220327705, -344881050, '96xiyet8', 'jhcf46', 'f', 'perxa61sjv', 'nv3ddroku', 'zc', 'ehia3', 652687353);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (3, '2021-09-11', 1311066510, -924570154, 123, -99415515, 351.937764, 465.004005, 176.773224, -1480511510, 1.0, 455.92055, -51114840, -2018922963, -197208169, 2089151689, 437.949634, 392.521113, 432.50828, 550.07897, -561387633, 152.79514, -1496507520, 897.384932, 2062713020, -1725535379, 1709325128, 'if4180te', -1003698590, -1147551293, -716185359, '2+', '6s', 'tut', 1143458360, -769244829, 'cel8mhfcim', 'n5enii0fmbgz', 'oqxs27xh', '88y1k253s', '5', 'ls1ehn1md', 'aqqhyyzsnp64', -1669961050);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2022-06-02', -1660176735, -1205570400, 123, -976193147, 496.408957, 913.067252, 244.070345, -478462425, 1.0, 215.23512, -2125510968, 2017526622, -693920036, 195093192, 44.154251, 414.589719, 287.505213, 710.920615, 1378228777, 203.913632, 355859046, 835.467188, -1500616, -1001218462, -1965995887, 'fx03rz', 1269188010, 1901522221, -1292966884, '2+', 'wb1b3vun', '6e0imolt0', 80244587, -379984089, '0q833g86', '5zm6dpewew0', '2p40u2vil', '1xsad6q5', 'iqoauy0', '3lwh994f', 'qc1m9gr8xj', 1072042049);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2022-06-19', 1342717090, 1100953564, 123, 1125313981, 761.899533, 767.254072, 427.032591, -345924605, 1.0, 870.107066, -693758664, 2045017461, 513178845, -974198226, 922.48136, 571.630286, 747.569842, 0.724194, -549996867, 772.012331, 1389572296, 735.576317, -2010362797, 1938400567, -1191120749, 'meqv3', -986328637, 1784235325, -562113476, '2+', 'oxa0ol1zmjrs', 'bh724', -373858639, 1550708132, '303a1ngq', 't8184d', 'ojdlhl', 'pdyxk0a', 'cql1c8c', 'wvadbp0760', 'gk2hjz', -564818339);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2020-12-21', -1588383617, 2062633134, 123, 183049515, 854.858382, 81.990842, 911.180679, 1796323549, 1.0, 557.843587, -1022360195, -1517836823, -2124619836, -1746125330, 151.41893, 948.733582, 832.338956, 678.153436, 24627578, 656.078964, 2033421216, 684.937786, 376872332, -23658516, -1799118529, 'f1ur8kz', 903854855, -1701090371, -1531116262, '2+', '7fznqcuex', '1faxc1je', -115971578, 774567335, 'lvdbp3ce', 'hye3oylciif', 'ly46upl', 'eoh3m3q0pq97', '534', '5xb', '11y', 1685354754);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2021-07-05', 882611339, -1623767807, 123, -1999209177, 80.491891, 778.61746, 254.989211, 205472765, 1.0, 478.132385, -1597057552, 1940380266, 196097271, -912378949, 478.946677, 155.476935, 722.70821, 556.031816, 1409447791, 54.073897, 1090670329, 915.180208, -211490974, 270553125, 57070932, '6ql', 29713329, -2109911190, 273358004, '2+', 'yfx', 'ove98', 1450500765, 946867225, '235v8ikp3qu7', 'cxswgr124', 'u6v8hk', 'lzy93zu8yb', '4qpog5smdhct', 'nj8y6whwhl', '5i', -270264442);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-12-14', -1775767623, 1809278717, 123, -2015974250, 361.572263, 831.288133, 261.68916, -2051635326, 1.0, 467.084456, 1823535648, 1006743508, -674972001, 589902891, 237.532607, 598.095415, 364.93966, 487.054404, -693134353, 902.638617, 1094417174, 204.453746, -1174111678, -1042280380, -1374868354, 'uodbvf3ya6l4', -286729739, 322498251, -1841006453, '2+', 'q6gifjtvx', '41zjf', -304309687, -1492410135, 'e4dpb', 'l6rurl72', '8ippx', '6', '59q4tkf5j4c', '2y', '485ys1gz7p3h', -728546991);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2021-06-12', -1448153489, 1850954065, 123, 1934880232, 892.262756, 989.463825, 448.052723, -1085464899, 1.0, 665.96145, 1234250708, 868170608, 1027490015, -607926366, 441.741514, 173.421793, 484.222068, 939.624043, 1590087415, 564.842829, -393305044, 357.692447, -343838991, 1772920250, 382158362, 'lyapcw1gno', 49871159, -1903211911, 1565665313, '2+', 'a', 'v5uhorv', 768162102, -582426548, 'd', 'ko47', 'q', '0691b7s1i', 'k8thqz3', 's94x3', 'yxg3ufg', 873990042);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2025-06-28', -319516445, -231519772, 123, 1707698621, 369.618328, 971.456797, 325.747396, 561559089, 1.0, 145.917877, -1291688734, -922143835, -1152645284, -236062015, 602.612663, 495.948702, 268.912438, 908.048463, -289518843, 240.797548, -1505803580, 217.181318, 1922143801, -40599967, 1040296707, 'rj', 27734824, -193070748, -1463508844, '2+', 'tw7', 'qiuj9', 262270895, -16092271, 'cwnr8dq5gb', 'jmeuvjv', 'cr9l03f515y', '8am0qjut2f31', '6fr11luvk4', '7wggg', '0zchdq8o', 329158882);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-07-14', -949971733, -1060102360, 123, -1576013014, 270.837594, 424.154108, 359.034472, -596283718, 1.0, 813.046813, -1368673332, -2030631507, -1464232115, 92746551, 393.193511, 926.787245, 741.556192, 345.842104, -1862877787, 17.35933, -1585814665, 93.981501, -270409176, 1211763656, -1068238654, 'nehcnt2v', -1374226972, -2137694729, 1294151931, 't3__4ad87c', '0gtxot6vp1lr', 'qs', 1706126398, 430478888, 'beyhml', 'rnycz8d5yka', 'btcpo1ke8euy', '0kcxl8e4bkf', 'hyyx', 'm0cm', '8usy', -2002127241);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2021-04-18', -568626324, -703010907, 123, -1520839536, 20.798757, 996.428643, 835.457849, -341340731, 101.0, 740.562694, -1445498465, -1625027824, -1044387325, -97237819, 246.782913, 718.932155, 156.423615, 485.811427, -1429787934, 59.758622, 1233437190, 578.239193, 1121644957, 382154633, -2122774702, 'tce54k', -1890973087, -1801965762, 317664148, '2+', '4lj', 'hxd', -1081595696, 1780490976, 'bn', 'aaxtpye', '2z', '2ugy7', 'nkj2d', 'sjla91nq7dx', 'g9rta6', 325036503);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2021-05-08', -1410959558, 1840720845, 1, -1189171828, 986.293447, 778.024218, 548.920028, 527668055, 1.0, 175.559791, 851083562, 1159447811, -1106305718, 2124240062, 762.688862, 824.516883, 847.895744, 666.46349, 724210726, 983.720533, -448128829, 803.910769, -145918370, 1553193892, -1679649983, 'jlkkggqx', 646367725, -312001161, -1771659759, '2+', 'o', '1864', 501307804, -852945467, 'ckaioh8mpzf5', 'ulsok', 'vhgc3b0v2', '3muo9o5cw', 'anc56gwfuy', '2vtctr95snh', 'c1jc1', 470534297);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2025-02-02', -1936567895, 1590568619, 1852395634, -1462243636, 683.92629, 513.935639, 578.67893, -1170204706, 265.79507, 656.220011, 1191031510, 1446919217, 341329391, -1287895402, 585.304783, 333.02414, 365.941572, 593.88391, -1657244403, 37.674325, -607510855, 170.156913, -585011180, 322037946, -863095783, 'q65qvero7mf', 1977598631, 2049183742, 131124756, '50qbw', 'hbiszzg8eiz', '0', -1999014905, 1090297537, 'g8', 'gvzm', 'iwbdo', '90a5nxzf', 'as9e', 'zdfe0r841i6v', '9a6h', -1421250640);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.SEX FROM Patient AS T1 INNER JOIN Examination AS T2 ON T1.ID = T2.ID INNER JOIN Laboratory AS T3 ON T3.ID = T2.ID WHERE T2.Diagnosis = 'PSS' AND T3.CRP = '2+' AND T3.CRE = 1.0 AND T3.LDH = 123;

/*
Gold Result:
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('w5chn9m',)
('w5chn9m',)
('w5chn9m',)
('w5chn9m',)
('w5chn9m',)
('w5chn9m',)
('w5chn9m',)
('w5chn9m',)
('w5chn9m',)
('w5chn9m',)
('w5chn9m',)
('w5chn9m',)
('w5chn9m',)
('w5chn9m',)
('w5chn9m',)
('w5chn9m',)
('w5chn9m',)
('w5chn9m',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
('t1__482505',)
*/

-- Prediction Query
SELECT P.SEX FROM Patient AS P INNER JOIN Laboratory AS L ON P.ID = L.ID WHERE P.Diagnosis = 'PSS' AND L.CRP > 2 AND L.CRE = 1 AND L.LDH = 123;

/*
Prediction Result:
*/