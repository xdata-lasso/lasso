-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, '5k5swwqcgs', '2021-12-04', '2022-04-27', '2020-06-08', 'pgu7vfe4', 'hria2ypuzhs');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3, 'qdjpe1io2', '2024-12-31', '2025-10-23', '2025-07-18', '7cvtjpt', 'tg6bnou5zi');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2, 'fvy', '2024-05-28', '2025-12-01', '2024-06-05', 'be8yvkv', '42q7sx58b4');

-- Inserting into table: examination --
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2023-01-03', 711.020062, 944.247544, 2122220075, 'p6luhvdlttil', 429706943, 'rmdp', 'siie', 'unw6klfa', '9000t5c4ec', 'gce', 0);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2025-03-28', 517.275698, 962.037451, 1155439218, 'um5', 742285925, 'u', '4nrq', 'rofqyp5s5b', 'p', '02eutliqa11r', 0);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (3, '2025-03-18', 510.534763, 32.017558, -68044929, 'kf', 1923659053, 'c', '0', '7z2zezjo7wg', 'd5ysxc', 'r0oz', 0);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (3, '2023-05-02', 49.297401, 145.027285, -20116244, 'lq5lnpim', -55240145, '8qs27p2r', '4gth2mnaj', 'la3', 'okv8uttmu2', 'e578', 0);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (3, '2023-06-07', 644.437797, 839.760651, -531872415, '1', 339193890, 'ygmayq3q', 'dpuap96rnt', 'q', 'hm5wl', 'c7d', 0);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (3, '2022-04-25', 439.465402, 210.16546, 833568923, '90xdmsqt', -1685482179, 'cuq', '9', 'i9f2ccukjq1q', 'ik1yhb', '8hlst1p', 0);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (3, '2022-11-10', 345.665971, 992.371408, 1339281953, '4o6qjektb1', 1464469520, 'nzg3rjkw', 'ns47j2ja8dc', 'y', 'vjwq49yr', 'nxs6dvdxdo2v', 0);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (3, '2025-12-15', 299.665391, 456.148624, 1805923837, 'plj9fj', -743497747, '7k10', 'z2my1ogyv1r', 'ez', 'x', '1', 0);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2023-01-18', 941.428702, 668.329279, 1347243533, 'n2z', 1847608594, '9xgjjacgmukf', '5', 'f41', '80terbfokvee', 'sltut6lu2', 0);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2020-05-10', 63.437766, 681.697643, 1224512097, 'mhfcimn5e', -1246023488, '0fm', 'bgz5oqxs27', 'h888y1', '253', 'b59ls', 0);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2022-05-21', 715.556105, 60.411092, 1293700593, 'gwakmwg', -151666814, '3dkdipt', 'fbl10q', '6j6d4f', 'c75m4s2ajdu2', '6xuj90tefx', 0);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2025-01-31', 321.062263, 323.857282, 99716186, 'qf9lx8qza', -1552763743, 'umwu7a', 'j0j', 'k6hh2o', '79', '50fzrv1l', 0);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2022-05-22', 261.515659, 34.375566, -1874553916, '1faxc1je', -115971578, 'u5lvdbp3c', 'hy', '3o', 'lciif0l', '46upleo', 0);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2021-05-25', 978.525404, 659.599869, -1325997790, '0pq97', -30073701, '4j5xbk11ys', 'zc7x', 'v4pmp', 'jve', '2', 0);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2024-02-14', 17.098049, 93.817349, -1548627424, 'q2i', -880471265, '44u2f', 'zbw', '3q5br3', 'qobvbj26k', 'xc56', 1);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2025-10-17', 768.84749, 689.632627, 643045605, '2flntlcorqt', -1374868354, 'uodbvf3ya6l4', '1gfeg6q6', 'if', 'tvx', '41zjf', 1);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2025-05-09', 729.399998, 559.592494, 587390904, '5l6rnd3rhb', -1253560766, 'p', '6v5122bvx', 'nuw', '4jm31nfs4', 'iom2', 0);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2023-08-09', 602.612663, 495.948702, -992513509, '71kpjnnbs', -40599967, 'nagrj6o3', '7kajtw7', 'qiuj9', '94', 'ycwnr8dq', 0);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2021-05-26', 974.537329, 434.079372, 683709377, 'o9km29vphx5v', 461626933, 'by01', 'skvh4qmy4gp0', 'r5b', '0d0', 'gkgqavutce', 0);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2025-08-05', 940.748472, 161.337069, 1814902329, 'f12j4l', -1499789204, 'hxdpnhebny', 'a', 'xtpyee2zt2', 'gy7qnk', 'j2dsjla91nq', 0);

-- Inserting into table: laboratory --
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-03-30', -525979501, 1898504886, 624571013, 1644911394, 228.583847, 111.926013, 731.301441, 1178636309, 176.308171, 763.856372, 1055976837, 1775126557, 249, -74849714, 133.223471, 524.649571, 353.163664, 15.406045, 1909986641, 845.831524, -511185946, 262.105498, 392822403, 2142703426, -533293970, '8d99rljsl', -346339240, 1692174491, -1025564911, 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4', -1612443122, -2050247126, 'lph2gn', 'q', 'nqcx5h', 'cprj', 'u0dz7', 'fjgq8n2f3', 'dqv0gcb98ozk', -155284187);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2020-03-07', -1554531873, 982314585, 638024588, -688098735, 915.583344, 508.771546, 591.134092, 834709651, 418.948509, 532.326819, -932772113, -639539893, 249, 1255343543, 21.129657, 525.144763, 626.23891, 440.643674, -541746689, 584.342044, 1294666887, 379.883722, 1427161052, 564390026, -1259474148, 'jai', 1746373317, 1360271423, 1583472758, 'rg', 'd8y', 't1afgog', -946046410, -902895762, 'ayxp1q43', '1jh3den', 'c68x8vacx', 'afu5w1of7', 'pzo72ctdc', 'mfg62', '0v', 820970595);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '2022-09-04', 319284352, 1164790775, -200807520, -790819470, 202.422113, 995.150295, 273.34105, -1140595602, 144.157236, 677.090643, -609553675, 989018473, 249, -55494714, 110.207708, 554.705331, 691.814216, 873.959948, -354292049, 858.19408, 238533676, 419.43898, -1514700303, -1796351243, -1793230843, 'zdo2z', 270415200, -2071531094, -397848196, '0k32odwcl5a', 'msorlwyngc', 'dj9erhi', 1056589776, -499913447, 'yo', 'l0hdt6fuq', 'xuzkb52', 'gwnlas6', 'elboeowii1', '5nxih66', 'q2xlyoto', 1774679448);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '2022-08-11', -2094843966, -1048779857, -381485009, 868039568, 617.126317, 58.176945, 466.613431, 2085299664, 974.58376, 151.892832, 1376887048, 261633665, 249, 748154000, 767.502854, 36.996954, 314.953709, 30.758515, 989306270, 853.967947, 1147652228, 821.043976, 1964331395, -1943814113, 1514371324, '603vzxw1r', 237552112, -1046720861, 643589729, 'h55y', 'dohvu06d', 'a35rmki', -1160642134, 769234989, '8ftp6ewtqx', 'njabym', 'n2mfx7h', '3p6sto1c', '8sh', 'knzys7dy', 'yd1jmgjach8', 973811121);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '2022-10-24', 1980131681, 1222311103, 2141720493, 1793241362, 17.438617, 196.268517, 137.186478, 195316816, 250.961854, 902.378196, -1370566258, 948460309, 249, 1183069552, 429.343103, 484.123386, 253.815338, 266.215168, 316163741, 71.721662, -752650834, 997.078987, 1379644459, 136003842, -1486030107, '5wpxlvris', 2042428747, 1228655416, -388527046, 'q', 'ncgc8', '3b7v8', 180947503, -622923312, 'dbdh', '6j47n', 'ar50hs', 'han', 'xdpunmw', 'wx', 'rlawk', 558684943);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '2025-04-16', -967107842, -1011152325, 1298113538, -1340460158, 977.087263, 912.323762, 654.911516, -2098439423, 392.952848, 232.665028, 944310519, 6224071, 249, 1928920679, 783.349866, 383.695713, 989.668309, 284.012583, -1087163929, 47.174746, 658507818, 577.853117, 1154884242, 1352531282, -269868995, 'q51oa2', 1907670428, 1265709623, 1731005516, 'i1pa', 'cvwnyq', 'ouirl', 721232773, 323781506, 'ouit63xyfvmj', 'wpp26mb3aj0j', '0h3r13', 'ir1axyyh', 'l2i9', 'sa', '8pgc', 1394285393);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '2020-06-18', -754769711, 1128553504, 1374917235, -563920971, 137.022383, 845.712946, 240.007077, 1009703228, 421.254208, 770.869988, 227939734, -1164657946, 249, 693108667, 457.405588, 461.555144, 667.832657, 61.784403, 935816178, 53.073416, -690382359, 118.01298, 253464886, 764443911, -159572656, 'spxpw30', -2051120765, -607931326, 1659285381, 'in', 'j6i', 'dmp61l2o3ak1', 1562909425, 950497469, 'g', 'eev', 'zxlu49', 'ubo', '8c', 'e', 'uekhllbw', 1868665501);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '2020-08-27', 1201135348, -681356377, -1846517698, 2117356203, 561.452917, 691.862891, 450.037356, -54963162, 752.597021, 74.371479, 765955451, 1372042958, 249, 1147974039, 448.700958, 419.701122, 444.074683, 557.815176, -537413388, 968.398112, 1755688363, 298.019011, 1177967285, -2001463367, -2003500453, 'perxa61sjv', -1265768652, 2081562124, -1879135081, 'okuez', 'ctehia3cmvb', '7vpc0xffwo', -980269466, 1202197697, 'ksf9q', '2qg01huij', '7f8kqhiu5g', '8gxb', 'qjlsawsp', 'kwi3hl7j', '3y795ybv', -197208169);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-10-12', 1115155768, 428576631, -1253720301, 1134827548, 574.678854, 714.004082, 1.177623, -1016026459, 804.099076, 838.769485, -514593578, -1224799639, 249, 28414592, 111.181894, 215.764397, 345.351353, 586.359273, 355299538, 420.075769, -619134105, 785.465366, -1524222898, -356851435, -1093026980, 'gdwb7jjpl', -604038417, -1369846060, 1693885387, '42nyj5yrji5m', 'kna38', 'fx', 1544468471, -626315618, 'd0zmxwdb', 'otp5qo1k4', 'c6gwnkd4kc', 'iikaxzr9', '0nhsp9gobb6n', 'n5ujp', 'yb', -2125510968);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2023-10-11', 754506713, -500097534, -895541641, -972469277, 89.398476, 462.734652, 773.035689, -1023831089, 415.172857, 21.426602, 1287135899, -1334768184, 249, 364506391, 172.424304, 905.385278, 275.321076, 928.340436, -563209298, 614.41989, 1950697910, 627.141288, -964661721, 1269188010, 1901522221, 'e2wb', -322010175, 1154760301, -367478888, 'olt0', '0zi90o50q', '33g865zm6', 1636393410, 1939546744, 'ew092p40u2vi', 'l21xsad6q5z', 'qoa', 'uy023lwh99', 'fqc1m9gr', 'xjqbloxd4', 'j5il9', 1338378083);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2022-01-12', 237209369, 1719477248, 286693031, -728757169, 683.94905, 265.075245, 832.919244, 680112185, 995.863187, 582.741546, 641545472, 666969074, 249, -1827274099, 774.366984, 851.932547, 197.507491, 23.705922, -1598084888, 986.237451, -46379547, 154.178061, -890072422, -1842328080, 1844867559, '3uxdo', 830725610, -1392585113, 1868325581, 'ssbh7', '404qpp33', '3a1ngqu', 359389091, -1879482337, 'jdlh', 'zpd', 'yxk0a0cql1c8', 'w', 'adbp07', '0ugk2hjzx', 'g1lc', 2076581069);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2021-01-23', 188256891, 286007666, 1314064183, -805818449, 116.378465, 746.49778, 487.357623, -1332047564, 20.683968, 697.875635, -976424792, -837263309, 249, 1212382912, 185.391262, 514.781595, 481.182693, 691.172977, 1411268911, 874.402694, -221912911, 912.664032, -641282671, 258755990, -617631089, 'havc2c4', -429097391, 1690729846, 933590348, 'e0jf4i5t99kv', 'bhvi', 'tp3tfndtw', 232457376, 782631880, '4eufiof8of6', 'bp9qgjradf', 'j8', 'zr6k53p8e5o', 'f0y', '1u', 'r8kzi0g50j5', 1617485225);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2023-06-11', 895167757, 831075499, 2108303347, 551248930, 885.055234, 693.132939, 699.758151, 809540172, 76.414184, 279.112846, 1686819558, -1256487758, 249, 1220359260, 930.193814, 494.405694, 249.917624, 985.737768, 1652097981, 103.458124, 934369722, 149.924656, -1611243101, 16782608, -164454935, 'dx5hn75b73', -197352413, -445327932, -1714719754, 'xt0twoua4yi4', 'h5c4f1q9w43', 'al8', 196097271, -912378949, 'j9fodt9k', 'cq2iae6aj6ql', '676lk8q', 'azkjyfxsov', '98', '8', '0235v8ik', -192454950);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2023-08-22', -1947520594, 970728092, 575216233, 1469886207, 269.181583, 438.595842, 339.65676, 1905992027, 508.713177, 336.779777, 1646694792, 1349767879, 249, 1277665386, 393.124806, 657.82926, 539.796512, 714.201173, 1694002877, 722.73739, 1424903685, 235.871831, -1679192241, -922296677, -1919962183, 't', 931265534, 177710966, 1530956156, 'hlh5i1', 't', 'j', 2109623518, -1633323209, 'lv7j452k1', 'zqt5u', '42p20g', 'tfhk1l', 'bjksuye6', 'hvzboodlz60', 'sijufc2vfgh', 1608670538);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-10-23', -1048787950, -190180302, -1119890665, -109711729, 644.221131, 973.431455, 322.219154, 270795691, 174.02691, 438.371057, 196492760, -1127007729, 249, 2144707422, 477.631939, 303.474321, 165.941731, 944.164141, -15764418, 473.148844, -1814058838, 773.493764, -29054318, 1450323131, 934708702, '7p3hvg0', -633154726, -412910283, -1138640988, 'a6d2hqs4zc1', '2282rnfvk', 'mfoqp', -755719771, 1410336613, '3i98owqw', '0hvv0o', '59', 'vni', 'n6dr', 'okt16hqb9jae', '9ps4done0b', -1090577818);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2022-11-29', 522198308, 2133566015, 47676950, -158083859, 543.508256, 577.133888, 253.028726, 921580808, 824.908798, 830.760194, -1836655128, -127748294, 249, -434565991, 979.991015, 759.075716, 249.339277, 940.380149, 666381636, 181.75299, 220828440, 305.099449, -1400434743, 1754716492, -1089704776, 'w1gno6r9d3zd', 1169469726, -772755259, -1176524414, 'ccwraq', 'eddnko', '7dq70691', 1807699260, 2115162734, '8th', 'z3rs9', 'x3yyxg3u', 'ge', 'rz', 'w0qgiqh4ao3k', '9v09407sw', -158691005);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2025-06-27', -2038978824, 2115388252, 1917779970, 1087107269, 313.498414, 340.205328, 338.632308, -1951301248, 553.883614, 693.883601, 1342397236, -2130742032, 250, 1244725562, 255.310839, 153.665627, 303.470391, 92.15847, 1646925800, 885.420339, 1481930618, 805.524881, -1358863224, -720395989, -130970718, 'wggg30zch', 1922961793, -1175155753, 735250406, 'ze42lwenn4', 'lc3', 'spw', -1690083994, 1246780528, 'c9l5zmrsv64', 'h6b1ugt', 'ygqofzr1q', '7z6ikr', '1whx1dlzbb', '27z', 'uuwyewb', 1533864667);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2021-05-23', -270409176, 1211763656, -1068238654, -237981586, 73.595353, 809.161522, 839.95373, 2134974396, 857.63843, 342.970464, 1405721813, 475909435, 250, 1789020183, 655.002457, 637.755439, 308.700293, 818.607132, -1151800790, 730.123234, -728378511, 861.109731, 823785254, 338007473, 931140648, 'xyube', -496224640, 551417265, -953454343, 'ycz8d5ykab', 'tcpo1ke8euy', '0kcxl8e4bkf', 2105067810, -473422461, 'm0cm', '8usy', 'c1vk27ki', 'uvof5ndg', '80z', 'qe9rs1z82tw', '4o1sqir', 1505875875);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2025-11-01', -1931313326, 2141560768, 1323477219, 258294467, 308.508953, 964.719456, 4.512314, 325036503, 7.047588, 139.042148, 101396312, 2105679482, 249, 13363947, 1.34913, 143.391972, 32.164852, 544.22514, -120719467, 371.626384, -1153588317, 295.747398, 997629714, 1072213049, 1291840872, 'a2n0l', -642971630, -1035489492, 1772524500, 'ig197gelrrul', 'blhtkb', 'og8ol', 210109936, 527668055, 'vwn', 'pkcpw0q', 'z43yul6g2', 'jlkkggqx', 'x1w', 'nb', 'p186', -98939200);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2021-03-12', 267362922, 350405500, 1611685862, -2040803304, 795.753322, 508.699855, 962.13785, -2001885682, 638.711877, 138.931284, -1310826078, -416331440, 249, -35614829, 325.461208, 184.258426, 669.980175, 826.377498, -720003270, 106.597987, -2044534767, 687.959979, -142693322, 747914915, -1177451295, 'cwanc56gwfu', -699588718, -2004875726, 443228732, 'snhqc1jc1j3d', 'll8k', '6qohr35i', 1074058348, -1639499826, 'xti78hf', 'w', 'wwkmxvvfta', 'q65qvero7mf', '86mok', 'pt50qbwhb', 'szz', 449203420);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.ID FROM Laboratory AS T1 INNER JOIN Examination AS T2 ON T1.ID = T2.ID WHERE T2.Thrombosis = 0 AND T1.CPK < 250;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT E.ID FROM Examination AS E INNER JOIN Laboratory AS L ON E.ID = L.ID WHERE E.Thrombosis = 0 AND L.CPK < 250;

/*
Prediction Result:
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
*/