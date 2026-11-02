-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patient --
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1, 't1__b3f278', '2025-06-17', '2021-11-08', '2025-06-13', 'wwqcg', 'k9n8c');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (2, 't1__b3f278', '2025-06-26', '2022-08-22', '2024-05-26', 'f8jegd2', 'vy9uxj4');

INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (3, 't1__b3f278', '2024-07-02', '2023-11-16', '2025-06-18', 'h', '9mo7');

-- Inserting into table: examination --
INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2025-04-30', 249.706432, 99.523333, -734455130, '4h', -992890117, 'PSS', 'a2ypuzhsrwbb', 'p6luhvdlttil', 'n', 'rmdp', 2026480202);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (2, '2021-05-25', 353.366837, 50.647649, 1581736075, 'gndqwnqc', 555413010, 'PSS', '5hncprjtu0d', '79fjgq8', 'n2f3dqv0gcb9', 'ozk3zbily', 638024588);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (2, '2025-09-09', 339.789525, 915.583344, 37673509, 'h0f8jswwlq', -566887085, 'PSS', '72fxa7ryfd', 'z16ni', 'jai', 'dh5ogrgj', -458359144);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (2, '2024-09-06', 486.420817, 646.236852, -1245584612, 'xfo', -1793230843, 'PSS', 'zdo2z', 'obb0q0k32o', 'w', 'l', 895277769);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (3, '2024-05-24', 685.760212, 714.226822, -639616320, 'xe9yf', 1968783602, 'PSS', 'qk162nh55', '3dohvu0', 'dza35rmki', '18ri', 1510892261);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (2, '2022-11-04', 862.602858, 424.171576, -796609690, '1yh', -2052350430, 'PSS', 'hlst1pqom', 'ztv', '6', '4iz7', 195316816);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (3, '2025-08-15', 50.158445, 657.651282, -1385967617, 'u6iph', -1944869637, 'PSS', 'u2gir31vwq5', 'oa2sb3u', 'i1pa', 'cvwnyq', -1005394301);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (2, '2022-06-12', 606.851472, 364.037151, -1935855834, 'dxdo2v7t3g', -699779308, 'PSS', 'j9f', 'vuu', '7k10', 'z2my1ogyv1r', -1712532464);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (3, '2020-08-27', 235.490046, 779.661114, -681356377, 'du', -699425950, 'PSS', '129835x', 'epac', 'db2f0c', '96xiyet8', 1177967285);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2025-05-24', 436.070523, 986.185891, 143843552, 'erbfo', -1429883874, 'PSS', 'e6', 'ltut6', 'lu2cel8mhfc', 'mn5', -1846239934);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2021-06-14', 134.751491, 421.811676, -1800278299, 'bgz5oqxs27', -494119248, 'PSS', '253', 'b59ls', '1ehn1mdaqq', 'yy', -422857559);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2020-01-21', 801.740073, 375.525723, 754506713, 'x8scr0f', -912658170, 'PSS', 'qn0b5m2rlxcr', 'fx03rz', 'z8', 'lqme2wb1', -179078143);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2023-08-15', 685.181165, 502.32467, 61145737, 'imolt07', 354693690, 'PSS', 'i90o50q833g', '865zm6dpewew', '092p40u2vi', 'l21xsad6q5z', -1580770288);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2020-12-15', 594.765637, 869.061628, 1885635119, 'qzabivuum', -670250982, 'PSS', 'alj0jwk6h', '2o', '79', '50fzrv1l', -345924605);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2023-10-18', 167.84281, 700.246438, -728757169, 'ql6n0rlpsax', -1827274099, 'PSS', 'mbci', '5ojsme', 'v3r3u', 'doxa0o', 858882953);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2025-01-12', 850.829726, 305.059443, 1212382912, 'b6i', 1411268911, 'PSS', 'tew5c29d', 't1havc', 'c4zpw867', 'fve0jf4i', 1124850667);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2023-09-08', 218.040459, 626.486821, -1619601868, '6tp', -192243223, 'PSS', 'nd', 'w89qy', 'sru4eufio', '8o', 1796323549);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2022-03-13', 236.894057, 839.064026, -705547449, '2', -656237101, 'PSS', 'rf', '6snl45jw5pb', 'wo', 'nhh', 16782608);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2020-01-05', 950.070484, 782.652836, -1936734976, 'hn75b733', -1142502602, 'PSS', 'zbgyxt0tw', 'oua4yi4h5c', 'f1q9w43i', 'l', 196097271);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2021-11-23', 437.076898, 398.58776, -1027442241, 'uw42p20g', -623749300, 'PSS', 'hk', 'l3bjksu', 'e6hvzbo', 'dlz6', 822981708);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2021-05-28', 149.278509, 699.870997, 813052479, 'vfghixbu', -1744541202, 'PSS', 'slq', 'isdq44u2', 'kz', 'w', 1422871709);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2025-03-01', 121.70391, 96.48494, -633154726, 'zip2a', 762889994, 't2__81c337', 'hqs4zc19', '282rnfvk', 'mfoqp', 'ucnn53i', 178068376);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2024-10-05', 629.068858, 133.7713, -373111401, '8thqz3rs94x3', -525409560, 'PSS', 'g3ufge', 'rz', 'w0qgiqh4ao3k', '9v09407sw', -158691005);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2022-02-12', 789.810251, 255.310839, -1487494813, '2f316', 1646925800, 'PSS', '11luv', '4s7', 'ggg30z', 'h', 1922961793);

INSERT INTO "examination" ("id", "examination date", "acl igg", "acl igm", "ana", "ana pattern", "acl iga", "diagnosis", "kct", "rvvt", "lac", "symptoms", "thrombosis") VALUES (1, '2022-02-07', 177.361806, 278.006607, 505388843, 'z', -1902660259, 'PSS', 'kabtcpo', '1ke8euy0kcx', '8e4', 'bkfphyyxnm', -377880939);

-- Inserting into table: laboratory --
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2021-06-28', -1602639011, -45536098, 123, 1861536320, 345.718563, 510.466242, 768.216462, 1620389964, 1.0, 627.258639, 947159877, 1990080517, 1408123494, -1964997180, 734.586266, 767.720387, 44.682291, 73.182847, 1155439218, 805.746877, -761141909, 779.28645, 283598170, 742285925, -747753377, 'nrqrofqy', -1106983592, 1884179925, 902551284, '2+', 'p', '02eutliqa11r', 2137741668, -525979501, 'oo3o9hl72kl', 'x1', 'ji7zwau2', 'dwyrq13pyu78', '9', 'rljsl0b4y', 'p5qi2rkf9v', 556727997);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-10-27', 1568069663, -1794176801, 123, -1194675273, 279.731401, 630.468925, 309.988616, -902895762, 1.0, 453.914926, 2111987706, -598313376, 1972233925, 1792827279, 632.340892, 687.319156, 457.141778, 410.094566, -1538707438, 774.445116, -163600466, 881.248682, -1826414375, 357330522, -683007527, 'x', -1762140823, 1371234901, -290314193, '2+', 'f77pzo72ctd', 't', -1284905200, 7929158, '0v', 'q8qdjpe1', 'o22', '8507cvtjp', 'ttg6bnou5zi3', 'c4bfkfoac', '0', 76987628);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-12-11', -461418236, -468701684, 123, 1448731351, 523.290303, 359.347359, 790.772456, -57705450, 1.0, 286.870177, -2005628382, 1721638020, 983324983, 1269522000, 698.769833, 297.258735, 104.37745, 703.796681, -1609653472, 172.799686, 1816660482, 184.430978, -1212676731, 1692046802, -1300180872, '58q', 1817366143, 1615073310, 1055237066, '2+', 'r94gth2m', 'ajjl', -2096405521, 1803796945, '8uttmu', 'ne578lfv', 'yz7zzbe8yvk', 'v42q7sx58b4p', 'aus3', 'u', 'mkrpdj', 1105964624);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '2020-02-28', 292557306, 709097796, 123, -984562992, 359.123233, 215.801042, 870.406381, -1689155697, 1.0, 424.71131, 453340472, 211603887, -413043724, 761519897, 850.341964, 722.415629, 230.654784, 845.392744, 513375398, 514.470353, 718167481, 832.527521, -1614619556, 1435223075, 1617348603, 'yxuzk', 450555855, -206528034, -1686002788, '2+', 'las6', 'elboeowii1', -457369423, 1557188093, 'xih662q2xly', 'otow9oaawg', '6aqb0tbin', 'z', '9tajz9td', 'n5wcgumbc', '3tdu6bd0w960', 740386991);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '2021-04-27', 389700824, -1853955201, 123, -805997097, 363.494801, 887.535529, 919.033168, -1485875026, 1.0, 779.614625, -2080232972, 462225708, 1528227252, -1277305894, 363.548253, 971.683344, 113.553378, 453.840746, -891525031, 231.292236, -1971560508, 835.790392, 1728926031, -63214972, 1106724223, 'ys7dyyd1jmg', 729543907, -2108844113, 973811121, '2+', 'ta8y3a17v4', 'ygmayq3qdpu', 1595033206, 1291298007, 'tdqr', 'm5', 'wlic7dn2np', '90xdmsqt', 'el', 'u', 'qb9i9f2ccu', -1414362698);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '2022-10-24', -1043357093, -753065777, 123, 190510318, 877.828469, 305.404216, 544.766726, -312228770, 1.0, 876.781557, 1639204149, -2063751689, 36589303, -1537647691, 584.815773, 870.680595, 345.910609, 291.673489, -1451520332, 114.099596, -55270062, 243.463869, 1939337883, -996196097, 986268139, 'urz0kaqtncg', 428944759, 1446366856, 438933248, '2+', '88kwdmdbdht6', 'j47nxar50h', 460471995, -1515201134, 'n', 'xdpunmw', 'wx', 'rlawk', '14r5dqt', 'mg97a', 'z2o20', -1079009577);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '2023-07-14', -1582954378, -1143329124, 123, 1368469085, 305.710224, 500.747148, 634.169429, -471198540, 1.0, 824.672918, -1335280432, -614741184, -1106497615, -1305057240, 461.142569, 3.817455, 723.679635, 146.452142, 1663074182, 921.92038, -352678633, 848.926436, 1089332183, -167036460, -987989989, 'x', -485095266, -1617977597, -1366005916, '2+', '9es', 'p', -1452518801, -662859586, 'r54o6', 'jektb', '1d2nzg3rjk', 'ns47j2', 'a8d', 'c', '3vjwq49', -516707997);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '2024-06-11', -560601844, 541973266, 123, -1970162044, 575.65588, 236.600951, 707.803422, 653399300, 1.0, 526.310762, 139907579, 914471233, -1813651479, -1353862813, 592.613785, 935.379175, 71.759309, 659.940979, -1958403507, 516.814345, -392891099, 856.003578, 1735624376, -1665891229, -929713613, 'hed2', -1066046077, 972991637, 1032462616, '2+', '331spxpw30bg', 'kxginl', 1595944351, 1673977398, 'dmp61l2o3ak1', '62ocagjeevx', 'xlu49ku', 'o', '8c', 'e', 'uekhllbw', 1868665501);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (2, '2021-08-02', 1034238651, 1625280273, 123, -1805244571, 664.944045, 515.44898, 90.202041, 312333412, 1.0, 702.984684, -977983676, 1082379969, -878613380, 1660953326, 339.679956, 467.965633, 59.584068, 220.875898, -744133723, 980.464424, 1795932554, 306.510218, 2006256976, 660144343, -169414942, 'mvb7vpc0xffw', 1983060779, -980269466, 1202197697, '2+', 'ksf9q', '2qg01huij', 128895724, -1663813652, 'u5gm8gxb5qj', 'saw', 'p4kwi', 'hl7j43y7', '5ybv83kr3', 'w4jn2z19xgj', 'jacgmukfb5', -1603206153);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2022-05-29', -105243240, -1324600306, 123, -1250452845, 992.470053, 473.557491, 665.019137, -1301565530, 1.0, 273.359912, 668449456, 1353959969, -1449073012, -2076821826, 117.191065, 931.120575, 763.150685, 356.343739, 1022316699, 146.24274, -1398612932, 306.888303, 1297861259, 916632486, -479465694, 'yrji5mqk', 1192169191, 172299659, 1705419178, '2+', 'wb2d0', 'mxwdb7o', 1424429365, 619382464, '5qo1k4c6gwn', 'kd4kc3iikaxz', '90nhs', '9gob', '6', 'rn5u', 'phy', -2074051940);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2022-07-31', -791611500, -385549429, 123, -135032120, 787.85156, 116.726232, 953.959261, -2006209112, 1.0, 193.215124, -1691663167, 1191255697, 1903061181, 943944514, 577.163121, 179.224654, 226.949739, 58.425628, 1887949884, 283.832074, 1083095660, 176.710024, 343349384, 1293700593, 1501525023, 'mwg', -151666814, -487579632, -1884996250, '2+', 'i', 'txfb', 1018356621, -296531894, 'x6j6d', 'fc75m4s2', 'j', 'u', '6xuj90te', 'x3', '5u7709', 564132547);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2024-10-14', 1868325581, 1973330686, 123, -913045712, 30.355521, 531.151522, 726.076743, -85207801, 1.0, 482.80129, 1086562671, -1092779922, -139065717, -160446958, 436.27599, 95.484557, 326.473529, 823.438961, 898805626, 539.723587, -77974859, 355.856331, -1908406235, 2142421496, -1408342453, 'dyxk', -384734946, 1690470489, -1965798280, '2+', '1c8', 'w', -721450631, -1908930700, 'p0760ugk2h', 'jzxpg1lcg9', '4', 'kj', 'og8dw16f5tqh', 'd5m', 'b', 1132226816);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2022-12-09', -1708036926, 1103152554, 123, 1947614123, 121.871487, 698.951944, 912.694021, -417454764, 1.0, 788.478438, 1579423631, -1860416222, -1195433612, 1417636430, 420.73845, 377.419726, 992.581766, 316.515706, 1790647855, 768.968035, 718729522, 405.698651, -351624428, 861728040, 1657449784, '97fznqcu', -1874553916, -130254436, -1765864585, '2+', 'c1je44', 'u5lvdbp3c', 1696094807, 598317289, 'e3oylci', 'if0ly46upl', 'eoh3m3q0pq97', '534', '5xb', '11y', 'pzc7x', -111324604);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2023-03-23', -1116027668, 1229352231, 123, -1159228699, 617.673449, 958.579088, 562.128985, 1728774879, 1.0, 135.101055, 1232103941, -2093375165, 1733360461, 29713329, 690.778298, 157.453266, 545.694454, 260.185589, -2109911190, 563.646117, -1484908026, 601.40235, 350372898, 1373590330, -1161047208, '98', 1450500765, 946867225, 874634276, '2+', '5v8ikp3q', '77cxsw', 1469886207, -991357557, '4vu6v8hk', 'lzy93zu8yb', '4qpog5smdhct', 'nj8y6whwhl', '5i', 'dtdjm8r', 'y9lhw6lv7j45', 1234374449);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2022-12-07', 1092707574, -965918853, 123, -1007920797, 976.385144, 16.265212, 961.21363, 390858511, 1.0, 27.940468, 393716354, -1446204771, 764338493, -1985423561, 508.704018, 768.84749, 689.632627, 238.846122, 643045605, 828.512405, 1922111976, 613.16928, 1324549388, -1401481173, 1888904719, 'o', 2137119179, -854263126, 1706969416, '2+', 'dbvf', 'ya6l431g', 322498251, -1841006453, 'q6gifjtvx', '41zjf', '1qj3se4dpb4l', '6rurl72q8ip', 'pxb659q4tkf5', '4ce', 'y485ys1g', 302385175);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2023-12-04', -1041632451, -1639837436, 123, 1306618480, 410.739182, 223.30615, 849.712625, -1568596349, 1.0, 212.985803, 1562452925, 410637411, 1730574324, 767105170, 22.880322, 549.024504, 799.042695, 839.927732, -2100339368, 598.600496, -1139271161, 480.809554, 1894848627, -1830074601, 835780485, 'piqkuizi6', -223111865, -1085464899, 1234250708, '2+', 'wew42zl4ptf8', 'l0lw90', -1400434743, 1754716492, 'cw1g', 'o6r9', '3', 'dayv5uh', 'rvcc', 'wraqxeddnko4', 'dq70691b7', 692583137);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2025-05-09', 255947809, 587390904, 123, 1922661050, 184.0063, 269.549412, 218.01012, -185245437, 1.0, 788.252161, 376343297, 1275382784, 1446899409, -703840785, 755.5458, 425.606783, 446.095102, 897.604565, -559985010, 971.456797, -748409233, 531.346766, 561559089, -1291688734, -922143835, 'iom2', 158580721, -2038491821, 1824528433, 't3__a40dd4', 'pjn', 'bssy', 110647977, -625356633, 'nagrj6o317ka', 'tw7', 'qiuj9', '94', 'ycwnr8dq', '5gbzjmeuvjv', 'cr9l03f515y', 184090233);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2025-12-16', -1175155753, 735250406, 123, -461669512, 475.332579, 439.193451, 353.479578, 832376590, 101.0, 696.94774, -1233317434, -1395464118, 1147288001, 1325800971, 946.745958, 106.496657, 790.288711, 625.358507, -1406204087, 826.283711, -1300781431, 281.437794, -115883832, 425959721, 1820491976, 'ugt8ygqofzr1', -1060102360, -1576013014, -605442308, '2+', '1dlzbb', '27z', 1833037259, 1037475941, 'yewbih', '80', '1ev3gqe2nehc', 't2v4', 'lraxg0gtxot6', 'p1lrhq', 'xyube', -496224640);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2022-03-31', 1672173400, -492514452, 1, 1960351405, 430.082055, 161.431958, 448.974941, -1457351628, 1.0, 470.030221, 1164825902, -1787219074, 894128511, -1945911187, 137.20975, 532.54397, 645.543884, 399.003774, 748669029, 76.400203, 208702091, 291.293207, 137456355, -648886997, 611665243, 'o1sqirlhj1', -1715369895, -1325539976, 256346440, '2+', 'hx5v', '7jo', 1440780484, -341340731, 'skvh4qmy4gp0', 'r5b', '0d0', 'gkgqavutce', '54kdvf12j4lj', 'hxd', 'nheb', -1221167808);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2020-01-26', 965039732, 430146619, 1523404426, 1779301509, 968.101199, 926.586636, 825.408742, 1097132010, 996.879871, 302.116714, -245355754, -1065110759, 685140638, 917021023, 982.502126, 679.695536, 283.924871, 933.669628, 648284786, 848.130529, 996091596, 204.300627, 2040233149, 1845406169, -946327543, 'a6wanil7azq6', -1737335305, -1644157237, 844210576, '84vxo5', 'ddfra', '2n0lwczduqt0', 1059686731, 132846311, 'lr', 'rulwblhtkb', 'og8ol', '9cnlvwnzp', 'cpw', '0q9z43yul6g', '5jlkkggq', 1575835261);

INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1, '2021-11-22', -557174317, -645751914, -1243844048, -1179860454, 652.323678, 424.500693, 573.543575, 28230646, 12.697466, 645.071965, 501307804, -852945467, 1009463211, -2122365401, 231.5989, 986.50622, 897.467257, 240.321833, -1776405674, 305.113042, 1952215203, 283.438688, 1867323172, 1902473211, -1629403011, 'c3b0v293mu', -1177451295, 592134998, 1161208830, 'nc56gwfuy2', 'vtctr95snhq', '1', -1513522755, 512678089, 'j3dmll8k26', 'qohr35iptx', 'lhv1', 'ti78hf', 'w', 'wwkmxvvfta', 'q65qvero7mf', 1977598631);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.SEX FROM Patient AS T1 INNER JOIN Examination AS T2 ON T1.ID = T2.ID INNER JOIN Laboratory AS T3 ON T3.ID = T2.ID WHERE T2.Diagnosis = 'PSS' AND T3.CRP = '2+' AND T3.CRE = 1.0 AND T3.LDH = 123;

/*
Gold Result:
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
('t1__b3f278',)
*/

-- Prediction Query
SELECT DISTINCT patient.sex FROM patient INNER JOIN examination ON patient.id = examination.id INNER JOIN laboratory ON patient.id = laboratory.id WHERE examination.diagnosis = 'PSS' AND laboratory.cre = 1;

/*
Prediction Result:
('t1__b3f278',)
*/