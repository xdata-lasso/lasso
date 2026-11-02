-- Schema DDL
CREATE TABLE "member" ("Member_ID" TEXT PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Role" TEXT);

CREATE TABLE "performance" ("Performance_ID" REAL PRIMARY KEY, "Date" TEXT, "Host" TEXT, "Location" TEXT, "Attendance" INTEGER);

CREATE TABLE "member_attendance" ("Member_ID" INTEGER, "Performance_ID" INTEGER, "Num_of_Pieces" INTEGER, PRIMARY KEY ("Member_ID", "Performance_ID"), FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: performance --
INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (582.588439, '5k5swwqcgsk', '9n8c4pgu7v', 'per_3d3ee1', -1865039888);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (779.409124, 'hria2ypuzhs', 'rwbbp6luhvd', 'per_3d3ee1', -1377057208);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (304.02808, 'bnp', 'mdpos', 'per_3d3ee1', -1576219117);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (75.403642, 'nw6klf', 'a9000t5c4eci', 'per_661cdd', 1149850321);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (44.682291, '37', 'nium52zbu', 'per_661cdd', -1179823637);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (760.580899, 'rqrofqyp5s', 'bbp02eut', 'per_661cdd', -1347802441);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (889.661694, '1', 'ryytoo3', 'per_3d3ee1', -1666765085);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (731.301441, '72klex14ji7z', 'au2dwy', 'per_3d3ee1', -953437896);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (433.533777, 'pyu78d99', 'ljsl0', 'per_3d3ee1', -2031361952);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (884.000446, 'p5qi2rkf9v', 'x58pz', 'per_661cdd', -1529584866);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (755.698226, 'd2', 'vy9uxj4', 'per_661cdd', -1612443122);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (22.63964, 'lph2gn', 'q', 'per_661cdd', -664193365);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (250.856497, 'x5hncprjtu0', 'z', 'per_3d3ee1', -1748371085);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (94.390081, 'n2f3dqv0g', 'cb98ozk3zbil', 'per_3d3ee1', 982314585);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (279.382219, 'n6v', 'k', 'per_3d3ee1', 37673509);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (591.134092, 'h0f8jswwlq7x', '7', 'per_661cdd', 602161869);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (814.417862, 'a7ryfd', 'z16ni', 'per_661cdd', 2011234363);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (154.68882, '5dh', 'ogrgjd8y', 'per_661cdd', 1129658414);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (308.482994, 'afgogri', 'tsj3ayxp1q4', NULL, -1538707438);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (774.445116, 'den8c68x', 'vacx7afu5', NULL, -290314193);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (850.85096, '77', 'zo72', NULL, -1957268147);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (51.002063, 'mfg62', '0v', NULL, 820970595);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (537.702873, 'djpe1', 'o22', NULL, 2004147439);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (338.933701, 'ptt', '6b', NULL, -1171104889);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (813.864654, 'zi36c4bf', 'foa', 'per_3d3ee1', 382831862);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (60.937725, '7z2zezj', '7wgx', 'per_3d3ee1', -57705450);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (286.870177, 'm', '0oztd', 'per_3d3ee1', -1699185893);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (703.796681, '3lq', '5lnpim5k58qs', 'per_661cdd', 1615073310);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (628.658254, 'p2r94gth2mna', 'jla', 'per_661cdd', 1919033056);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (904.028668, 'v8u', 'tmu2n', 'per_661cdd', -1817527403);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (572.833475, 'lfvyz7zzb', '8y', 'per_3d3ee1', -705922211);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (743.007715, '42q7sx58b4', 'pmaus3auvmkr', 'per_3d3ee1', 609771851);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (49.701386, 'wzw5chn9mo70', 'a9n0jxfo', 'per_3d3ee1', -1793230843);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (296.34381, 'do2zobb', 'q0k32od', 'per_661cdd', -613916489);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (979.99406, '5amsorlwyngc', 'dj9erhi', 'per_661cdd', 1056589776);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (106.602942, '1yo', 'yo', 'per_661cdd', 718167481);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (832.527521, 'dt', 'fuqyxuzkb', 'per_3d3ee1', -30041412);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (435.41097, 'nlas6e', 'lboeowii1z5', 'per_3d3ee1', 1557188093);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (627.816635, 'h66', 'q2xlyoto', 'per_3d3ee1', 1774679448);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (547.887692, 'aawg96aqb0tb', 'indz39tajz', 'per_661cdd', 261633665);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (49.319338, '5wcg', 'mbc3td', 'per_661cdd', 1964331395);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (506.209886, 'd', 'w9603vz', 'per_661cdd', 920097188);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (351.077724, 'xe9yf', '7qk', 'per_3d3ee1', 643589729);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (213.271827, '55y3dohvu06d', 'a35rmki', 'per_3d3ee1', -1160642134);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (816.359248, 'i2hy0', '8ftp6ewtqx', 'per_3d3ee1', 2013745856);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (2.747847, 'bymzn2mfx7h3', 'p6sto1cj', 'per_661cdd', 1728926031);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (485.281618, 'zys7', 'y', 'per_661cdd', -531932574);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (425.077908, 'jmgjach8qt', 'a8y3a17v4yg', 'per_661cdd', -2081662466);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (262.000738, 'qdpuap96', 'ntdqr', 'per_3d3ee1', -1670945624);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (487.287849, 'wlic7dn2np', '90xdmsqt', 'per_3d3ee1', -1685482179);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (176.006489, 'qb9i9f', 'ccukjq1q', 'per_3d3ee1', -796609690);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (160.296838, 'yhb08hlst1pq', 'mizt', 'per_661cdd', 1793241362);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (17.438617, '4iz7', 'aqqlud8ft', 'per_661cdd', 1183069552);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (429.343103, 'qbre6bje', 'uuwsj8kjh8', 'per_661cdd', -55270062);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (243.463869, 'lvrisurz0k', 'q', 'per_3d3ee1', 1388796595);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (43.32037, 'c8', '3b7v8', 'per_3d3ee1', 180947503);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (354.964361, 'dbdh', '6j47n', 'per_3d3ee1', -556370776);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (766.476432, '0hsjhanz', 'dpunmw', 'per_661cdd', -1782325492);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (373.299809, 'lawk0', '14r5dqtsmg97', 'per_661cdd', -2098439423);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (392.952848, '20pj', 'ddlysu6ip', 'per_661cdd', -1664440372);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (168.487055, '2gir31', 'wq51oa', 'per_3d3ee1', 1813968674);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (706.295383, 'b3uoi', 'pavcvwn', 'per_3d3ee1', 1971816668);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (251.461344, 'uirl', 'rpouit63xyf', 'per_3d3ee1', 1394459557);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (189.105795, 'wpp26mb3aj0j', '0h3r13', 'per_661cdd', -156860347);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (654.86752, 'r1axyyhpl2', '9es', 'per_661cdd', 1299933788);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (603.11072, 'gckqwtsr54o', 'qjektb1d2', 'per_661cdd', -460035045);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (961.420907, '3rjkwns47j2', 'a8d', 'per_3d3ee1', -1971104604);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (377.389472, 'vjwq49yrnx', '6dvdx', 'per_3d3ee1', -1900450199);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (445.910628, '7t3gvplj9f', 'vuu', 'per_3d3ee1', -1415215611);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (411.706646, '2my1ogy', '1rgeza', 'per_661cdd', 423028705);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (46.864581, 'clupgly', '8oitxeilp', 'per_661cdd', -1839279753);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (659.940979, '9cy7od0', '3dlhdsvn', 'per_661cdd', -1640621748);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (52.562883, '9lqv26u3', '1spxpw30', 'per_3d3ee1', -2051120765);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (358.454959, 'xginlj6idm', '61l2', 'per_3d3ee1', 1069076646);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (866.50801, 'k', '62ocagj', 'per_3d3ee1', 1361395061);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (63.114566, 'vxzxlu49ku', 'o', 'per_661cdd', 833662145);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (47.421322, 'uekhllbw', 'dpu5v0', 'per_661cdd', -1846517698);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (326.821585, '9v2z129', '835xoepacxdb', 'per_661cdd', -220327705);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (419.701122, '96xiyet8', 'jhcf46', 'per_3d3ee1', -2003500453);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (990.684439, 'erxa', '1sjv8nv3d', 'per_3d3ee1', -1891572006);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (220.875898, 'ezcteh', 'a3c', 'per_3d3ee1', 806158445);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (608.369624, 'b7vpc0', 'ffwor1', 'per_661cdd', 1202197697);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (294.17485, 'sf9', '82qg0', 'per_661cdd', -314024594);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (316.922017, '7f8', 'qhi', 'per_661cdd', 1094664154);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (188.706193, 'xb', 'qjlsawsp', 'per_3d3ee1', -99415515);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (351.937764, 'hl7j43y7', '5ybv83kr3', 'per_3d3ee1', 722968762);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (813.67958, 'n2z', '9xgjjac', 'per_3d3ee1', -1725535379);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (320.34146, 'fb5', 'f41', 'per_661cdd', -813616969);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (266.308211, 'ok', 'ee6slt', 'per_661cdd', -759584258);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (618.173643, 'lu2cel8mh', 'ci', 'per_661cdd', -1266238892);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (790.556617, 'ni', '0fm', 'per_3d3ee1', 325130763);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (97.977734, '5oqxs27', 'h888y1', 'per_3d3ee1', -30240851);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (293.437533, '9ls1ehn1', 'daqq', 'per_3d3ee1', 1306095601);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (838.769485, 'yzsnp64', 'mn', 'per_661cdd', -1250452845);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (992.470053, 'm0rrwbjk', 'bph6gdw', 'per_661cdd', -1489765135);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (245.656905, 'wtl', 'h42nyj5', 'per_661cdd', 411661379);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (149.30112, 'mqkna38g', 'xs', 'per_3d3ee1', -626315618);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (438.311831, 'zmxwdb7', 'tp5q', 'per_3d3ee1', -1147699861);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (161.351129, 'c6gwnkd4', 'c3i', 'per_3d3ee1', -1586134101);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (779.187396, 'zr90nh', 'p9gob', 'per_661cdd', -976193147);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (496.408957, 'phy', 'n', 'per_661cdd', 1487440939);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (801.740073, 'vhvyx8s', 'r', 'per_661cdd', -366834342);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (287.505213, 'qn0b5m2rlxcr', 'fx03rz', 'per_3d3ee1', 1269188010);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (401.314836, 'lqme2wb1', '3', 'per_3d3ee1', -367478888);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (199.321149, 'olt070zi90', '50q8', 'per_3d3ee1', -193700628);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (100.260607, '865zm6dpewew', '092p40u2vi', 'per_661cdd', 770112293);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (439.205612, 'sad6q5', 'iqoauy0', 'per_661cdd', -215230989);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (176.854966, 'h994fq', 'c1m9gr8xjq', 'per_661cdd', 943944514);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (577.163121, 'oxd', 'sj5il9wn', 'per_3d3ee1', 1293700593);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (381.322085, 'gwakmwgw73f', '3dkdipt', 'per_3d3ee1', -544010785);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (693.880514, 'l10qx6j6d4fc', '5m4s2ajdu', 'per_3d3ee1', -567584339);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (632.695299, '90t', 'fx', 'per_661cdd', -199427879);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (495.754311, '709qf9lx8', 'qzabivuumwu', 'per_661cdd', -2091687257);

INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (140.885725, 'jwk6hh2', 'oe79350fzrv1', 'per_661cdd', -1406020933);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT location_other AS LOCATION FROM (SELECT LHS.location AS LOCATION, LHS.n AS n, LHS.maxn AS maxn, RHS.location AS location_other, RHS.n AS n_other, RHS.maxn AS maxn_other FROM (SELECT LOCATION, n, MAX(n) OVER () AS maxn FROM (SELECT LOCATION, COUNT(*) AS n FROM performance GROUP BY LOCATION)) AS LHS CROSS JOIN (SELECT LOCATION, n, MAX(n) OVER () AS maxn FROM (SELECT LOCATION, COUNT(*) AS n FROM performance GROUP BY LOCATION)) AS RHS) WHERE (n < maxn AND maxn <= n_other) ORDER BY LOCATION;

/*
Gold Result:
('per_3d3ee1',)
('per_661cdd',)
*/

-- Prediction Query
SELECT LOCATION FROM performance GROUP BY LOCATION ORDER BY COUNT(*) DESC, LOCATION NULLS LAST LIMIT 1;

/*
Prediction Result:
('per_3d3ee1',)
*/