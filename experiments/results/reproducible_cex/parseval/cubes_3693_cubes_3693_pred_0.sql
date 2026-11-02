-- Schema DDL
CREATE TABLE "event" ("Event_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT, "Event_Attendance" INTEGER);

CREATE TABLE "journalist" ("journalist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT, "Years_working" INTEGER);

CREATE TABLE "news_report" ("journalist_ID" INTEGER, "Event_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("journalist_ID", "Event_ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("Event_ID"), FOREIGN KEY ("journalist_ID") REFERENCES "journalist" ("journalist_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: journalist --
INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483648, '5k5swwqcgs', 'jou_efa314', 'jou_2fb13e', 247012447);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483647, '8c4pgu7vfe', 'jou_efa314', 'jou_2fb13e', -1633151678);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483646, 'a2y', 'jou_efa314', 'jou_2fb13e', 1115440883);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483645, 'hsrwbbp', 'jou_8e5b03', 'jou_5a9af0', 13244799);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483644, 'hvdltt', 'jou_8e5b03', 'jou_5a9af0', -1610064545);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483643, 'n', 'jou_8e5b03', 'jou_5a9af0', 462974032);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483642, 'posiie5unw6k', 'jou_efa314', 'jou_2fb13e', 1151980946);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483641, 'a9', 'jou_efa314', 'jou_2fb13e', 1620389964);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483640, '00t5c4ecigc', 'jou_efa314', 'jou_2fb13e', 528680845);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483639, '76nium52', 'jou_8e5b03', 'jou_5a9af0', -443340271);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483638, 'uo4nrqrofqy', 'jou_8e5b03', 'jou_5a9af0', -1106983592);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483637, '5bbp0', 'jou_8e5b03', 'jou_5a9af0', 743312762);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483636, 'eutliqa11r', NULL, 'jou_2fb13e', 2137741668);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483635, 'ytoo3o9hl7', NULL, 'jou_2fb13e', 1178636309);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483634, 'ex1', NULL, 'jou_2fb13e', -74849714);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483633, '7zw', NULL, 'jou_5a9af0', 481163439);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483632, '2dwyrq', NULL, 'jou_5a9af0', -1097120355);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483631, '78d99r', NULL, 'jou_5a9af0', -1362461264);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483630, 'l0b4y', 'jou_efa314', NULL, -1116181514);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483629, 'i2rkf', 'jou_efa314', NULL, 222415430);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483628, 'x58pz', 'jou_efa314', NULL, -1529584866);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483627, 'd2', 'jou_8e5b03', NULL, 1675430660);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483626, 'y9uxj4', 'jou_8e5b03', NULL, -1612443122);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483625, 'd', 'jou_8e5b03', NULL, -736979194);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483624, 'h2gn', 'jou_efa314', 'jou_2fb13e', 1968874827);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483623, 'nqcx5h', 'jou_efa314', 'jou_2fb13e', -1245312912);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483622, 'rjtu', 'jou_efa314', 'jou_2fb13e', -361507387);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483621, '79fjgq8', 'jou_8e5b03', 'jou_5a9af0', -1255130038);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483620, '3d', 'jou_8e5b03', 'jou_5a9af0', 513454646);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483619, '0gcb98', 'jou_8e5b03', 'jou_5a9af0', -1454058168);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483618, 'bilyrkn', 'jou_efa314', 'jou_2fb13e', -688098735);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483617, '6ah', 'jou_efa314', 'jou_2fb13e', -348113485);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483616, 'jswwlq7xb', 'jou_efa314', 'jou_2fb13e', 602161869);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483615, 'xa', 'jou_8e5b03', 'jou_5a9af0', 1294666887);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483614, 'fdrz16n', 'jou_8e5b03', 'jou_5a9af0', -1496556994);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483613, 'i', 'jou_8e5b03', 'jou_5a9af0', 1746373317);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483612, 'h', 'jou_efa314', 'jou_2fb13e', 1583472758);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483611, 'rg', 'jou_efa314', 'jou_2fb13e', -1478247928);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483610, 'yzt1afgog', 'jou_efa314', 'jou_2fb13e', -946046410);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483609, 'tsj3ayxp1q4', 'jou_8e5b03', 'jou_5a9af0', -1538707438);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483608, 'den8c68x', 'jou_8e5b03', 'jou_5a9af0', 1774087382);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483607, 'c', 'jou_8e5b03', 'jou_5a9af0', 1523825314);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483606, 'u5', 'jou_efa314', 'jou_2fb13e', -290314193);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483605, 'f77pzo72ctd', 'jou_efa314', 'jou_2fb13e', 481546706);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483604, 'g6', 'jou_efa314', 'jou_2fb13e', -242584410);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483603, 'v5q8qdj', 'jou_8e5b03', 'jou_5a9af0', -1139855872);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483602, 'io22785', 'jou_8e5b03', 'jou_5a9af0', 2119806856);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483601, '7cvtjpttg6b', 'jou_8e5b03', 'jou_5a9af0', -1171104889);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483600, '5zi36c4bfkfo', 'jou_efa314', 'jou_2fb13e', -1950324754);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483599, '7z2zezj', 'jou_efa314', 'jou_2fb13e', 1448731351);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483598, 'wgxd5ysxc', 'jou_efa314', 'jou_2fb13e', -405743609);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483597, 'g', 'jou_8e5b03', 'jou_5a9af0', -20116244);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483596, 'lq5lnpim', 'jou_8e5b03', 'jou_5a9af0', -55240145);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483595, '8qs27p2r', 'jou_8e5b03', 'jou_5a9af0', -95808609);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483594, 'h2mna', 'jou_efa314', 'jou_2fb13e', -1524425594);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483593, 'a3o', 'jou_efa314', 'jou_2fb13e', -1428186898);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483592, 'uttmu2ne5', 'jou_efa314', 'jou_2fb13e', -1402164108);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483591, 'yz7zzb', 'jou_8e5b03', 'jou_5a9af0', 924693315);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483590, 'kv42q7', 'jou_8e5b03', 'jou_5a9af0', -2060082151);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483589, 'pmaus3auvmkr', 'jou_8e5b03', 'jou_5a9af0', 609771851);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483588, 'j', 'jou_efa314', 'jou_2fb13e', 1105964624);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483587, 'w5chn9m', 'jou_efa314', 'jou_2fb13e', 823835795);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483586, '05a9n0jxf', 'jou_efa314', 'jou_2fb13e', -1165594842);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483585, 'szdo2z', 'jou_8e5b03', 'jou_5a9af0', 270415200);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483584, 'b', 'jou_8e5b03', 'jou_5a9af0', -397848196);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483583, '0k32odwcl5a', 'jou_8e5b03', 'jou_5a9af0', 292557306);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483582, 'orlwyngc1dj', 'jou_efa314', 'jou_2fb13e', 211603887);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483581, 'rhizgk1yoey', 'jou_efa314', 'jou_2fb13e', 513375398);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483580, 'l0hdt6fuq', 'jou_efa314', 'jou_2fb13e', 1294064538);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483579, 'uzkb52', 'jou_8e5b03', 'jou_5a9af0', -277407746);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483578, 'nlas6e', 'jou_8e5b03', 'jou_5a9af0', 1468640756);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483577, 'boeowii1z5nx', 'jou_8e5b03', 'jou_5a9af0', -1552469358);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483576, '62q2xlyot', 'jou_efa314', 'jou_2fb13e', 1083479253);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483575, '9oaawg', 'jou_efa314', 'jou_2fb13e', 1044710644);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483574, 'qb0tbindz39t', 'jou_efa314', 'jou_2fb13e', 2038321753);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483573, 'z9t', 'jou_8e5b03', 'jou_5a9af0', 748154000);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483572, 'cgumbc', 'jou_8e5b03', 'jou_5a9af0', 1295379066);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483571, 'd0w9603vzxw1', 'jou_8e5b03', 'jou_5a9af0', 1689143863);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483570, 'e9yfk7', 'jou_efa314', 'jou_2fb13e', -1046720861);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483569, '162nh55y3d', 'jou_efa314', 'jou_2fb13e', 440797047);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483568, 'vu', 'jou_efa314', 'jou_2fb13e', 1654100852);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483567, 'dza35rmki', 'jou_8e5b03', 'jou_5a9af0', -1160642134);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483566, 'ri2hy08ft', 'jou_8e5b03', 'jou_5a9af0', 2066302536);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483565, 'ewtqxxnja', 'jou_8e5b03', 'jou_5a9af0', -2080232972);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483564, 'mzn2mfx7h3', 'jou_efa314', 'jou_2fb13e', -891525031);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483563, '1cj8', 'jou_efa314', 'jou_2fb13e', 1728926031);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483562, 'knzys7dy', 'jou_efa314', 'jou_2fb13e', -531932574);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483561, 'jmgjach', 'jou_8e5b03', 'jou_5a9af0', 1122899168);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483560, 'a17v4ygm', 'jou_8e5b03', 'jou_5a9af0', 1168225104);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483559, 'q3qdpua', 'jou_8e5b03', 'jou_5a9af0', 1291298007);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483558, 'tdqr', 'jou_efa314', 'jou_2fb13e', -1670945624);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483557, 'wlic7dn2', 'jou_efa314', 'jou_2fb13e', 1409697108);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483556, 'p490xdmsqt', 'jou_efa314', 'jou_2fb13e', -1685482179);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483555, 'cuq', 'jou_8e5b03', 'jou_5a9af0', -1750715330);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483554, 'ccukjq1qui', 'jou_8e5b03', 'jou_5a9af0', -1459013972);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483553, 'yhb08hlst1pq', 'jou_8e5b03', 'jou_5a9af0', 1980131681);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483552, 'iztv', 'jou_efa314', 'jou_2fb13e', -1304516770);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483551, 'z78', 'jou_efa314', 'jou_2fb13e', -2128972904);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483550, 'lud8f', 'jou_efa314', 'jou_2fb13e', -835782528);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483549, 'r9114qbre', 'jou_8e5b03', 'jou_5a9af0', 316163741);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483548, 'uu', 'jou_8e5b03', 'jou_5a9af0', -1451520332);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483547, '85', 'jou_8e5b03', 'jou_5a9af0', -609840352);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483546, 'lvrisu', 'jou_efa314', 'jou_2fb13e', 1228655416);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483545, 'kaqtncg', 'jou_efa314', 'jou_2fb13e', 428944759);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483544, 's3b7v88kw', 'jou_efa314', 'jou_2fb13e', -2070247503);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483543, 't6', 'jou_8e5b03', 'jou_5a9af0', 313797011);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483542, '7nxar50h', 'jou_8e5b03', 'jou_5a9af0', 460471995);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483541, 'han', 'jou_8e5b03', 'jou_5a9af0', 1195320303);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483540, 'dpunmw', 'jou_efa314', 'jou_2fb13e', -1782325492);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483539, 'qrlawk', 'jou_efa314', 'jou_2fb13e', 558684943);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483538, 'r5dqtsmg', 'jou_efa314', 'jou_2fb13e', -2098439423);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483537, '2o20pj6', 'jou_8e5b03', 'jou_5a9af0', -1385967617);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483536, 'u6iph', 'jou_8e5b03', 'jou_5a9af0', -1944869637);

INSERT INTO "journalist" ("journalist_id", "name", "nationality", "age", "years_working") VALUES (-2147483535, 'u2gir31vwq5', 'jou_8e5b03', 'jou_5a9af0', -299585625);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT nationality_other AS nationality FROM (SELECT LHS.age AS age, LHS.nationality AS nationality, LHS.maxn AS maxn, RHS.age AS age_other, RHS.nationality AS nationality_other, RHS.maxn AS maxn_other FROM (SELECT age, nationality, MAX(n) AS maxn FROM (SELECT age, nationality, COUNT(*) AS n FROM journalist GROUP BY age, nationality) GROUP BY age, nationality) AS LHS CROSS JOIN (SELECT age, nationality, MAX(n) AS maxn FROM (SELECT age, nationality, COUNT(*) AS n FROM journalist GROUP BY age, nationality) GROUP BY age, nationality) AS RHS) WHERE (maxn < maxn_other) ORDER BY nationality;

/*
Gold Result:
('jou_8e5b03',)
('jou_efa314',)
*/

-- Prediction Query
SELECT Nationality FROM journalist GROUP BY Nationality ORDER BY COUNT(*) DESC, Nationality NULLS LAST LIMIT 1;

/*
Prediction Result:
('jou_8e5b03',)
*/