-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: sets --
INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (1, -55602865, 'swwqcgsk', '9n8c4pgu7v', 'code_1', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw', 1908028688, 2122220075, 'p6luhvdlttil', 'n', 'rmdp', 'siie', '2012-01-01', -45536098, 1861536320, '6klfa9');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483647, 528680845, '76nium52', 'zbuo4nrqrof', 'code_2', 373262291, -472966518, -921187550, -2070843029, 328305758, 'tliqa1', 2074205376, 274769912, 'oo3o9', 'l7', 'klex14ji', '7zwau2dwyr', '2012-01-01', -1021749117, 392822403, 'yu78');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (2, -346339240, 'yp5qi2rk', '9v', 'code_3', 556727997, 1178000634, 1836127587, -1529584866, 1196308825, 'd21vy9uxj4hw', -2050247126, -736979194, 'h2gn', 'q', 'nqcx5h', 'cprj', '2012-01-01', -841004020, -361507387, '79fjgq8');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483646, -1255130038, '3d', 'qv0gcb98ozk', 'code_4', -155284187, 1686459626, -1554531873, 982314585, 638024588, '6vck6ah0f8js', -658391922, -1388029300, 'xb72fxa7r', 'fdrz16n', 'jja', '5dh', '2012-01-01', 1583472758, 1449284300, 'gjd8y');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483644, -946046410, 'tsj3ayxp1q4', '01jh3den', 'code_5', 357330522, -683007527, 2035306060, 1523825314, 2078438287, '5w1of7', 76996700, -435350511, '72ctdctmfg62', '0v', 'q8qdjpe1', 'o22', '2012-01-01', 2004147439, -691774480, 'ptt');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483643, 1467355421, 'ou5z', '36c', 'code_6', 1722106924, -2072838897, -1173368267, 382831862, -406331049, 'ezjo7wg', 1248858185, -57705450, 'xcmr0', 'ztdg', '5i3', 'q5l', '2012-01-01', 1339733032, -1556979799, 'k58qs27p');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483642, -95808609, 'h2mna', 'jla', 'code_7', 1919033056, -1428186898, -761353513, 362376128, -1311735207, 'ne578lfv', -526633767, 448935289, 'be8yvkv', '42q7sx58b4', 'pmaus3auvmkr', 'pdjwzw5chn9', '2012-01-01', 101754718, 628082526, '9n0jxfofwsz');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483641, 1010672881, 'obb0q0k', '2odwcl5a', 'code_8', 292557306, 709097796, -984562992, -605061107, -1689155697, 'dj9erhi', 1056589776, -499913447, 'yo', 'l0hdt6fuq', 'xuzkb52', 'gwnlas6', '2012-01-01', -2076274980, 1731324803, 'wii1');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483640, 1557188093, 'xih662q2xly', 'otow9oaawg', 'code_9', 1044710644, 966412849, -2061634386, -850941333, -1216952047, '39tajz9', -841516418, 152478847, '5wcgumbc3td', 'u6bd0w9603', 'vzxw1rxe9y', 'k7', '2012-01-01', -1046720861, 643589729, 'h55y');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (0, 440797047, 'vu', '6dza35r', 'code_10', 2072023304, 789756515, -1160642134, 769234989, 168442149, 'tp6ewtqxxn', -1485875026, -2080232972, 'mzn2mfx7h3', 'p6sto1cj', 'sh5knzys7', 'y', '2012-01-01', -531932574, 357443379, 'gjac');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483639, 973811121, 'ta8y3a17v4', 'ygmayq3qdpu', 'code_11', 1595033206, 1291298007, 1982265552, 2013152515, 1139012231, 'hm5wl', -1573704891, -1260548409, 'p490', 'dmsqtg', 'lc', 'qb9i9f', '2012-01-01', -788896327, -1541581575, '1quik1yhb08h');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483637, 2141720493, 'vb6m4iz78aq', 'lud8f', 'code_12', -835782528, 192271618, -312228770, 1618264449, 1639204149, 'r', 36589303, -1537647691, 'uuwsj8kjh8', 'wpxlvris', 'urz0kaqtncg', 'c8s3b7v88k', '2012-01-01', -622923312, 1789767331, 'b');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-1, 313797011, '7nxar50h', 'sjhanzxdpu', 'code_13', 2014610660, 1492264835, -642512512, -1040088060, -2081798075, '014', -967107842, -1011152325, 'mg97a', 'z2o20', 'pj6ddlysu6ip', 'dk', '2012-01-01', 658507818, 334376591, 'ir');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483635, -2014514218, 'oi1pav', 'v', 'code_14', 2095277250, 1971816668, -1067465394, 1491006943, -980625770, 'rpouit63xyf', 1394459557, -1335280432, 'wpp26mb3aj0j', '0h3r13', 'ir1axyyh', 'l2i9', '2012-01-01', -1837449583, 1299933788, 'gckqwtsr54');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483634, 17776256, 'ekt', '1', 'code_15', 1464469520, -209435372, 946571403, -1517965246, 1807244612, '47j2ja8dccy3', 1560573473, 472597763, 'wq49yrnxs6d', 'dxdo2v', '7t3gvplj9f', 'vuu', '2012-01-01', -1415215611, -251621840, 'y1ogyv1rgeza');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483633, -560601844, '1clupgly78o', 'txe', 'code_16', 1484825817, 1009703228, 1163377746, 227939734, -1164657946, '033dlhdsvnh', -1832294694, 1188203659, '9lqv26u331s', 'xpw3', 'bgwkxgi', 'nlj6idmp61', '2012-01-01', 1530380378, 1069076646, 'ak162oca');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483632, -1862623291, 'vxzxlu49ku', 'o', 'code_17', 833662145, -1943810603, 1557266002, -775706063, -1417040770, 'llbwvdpu5v0e', -1920675616, -699425950, '129835x', 'epac', 'db2f0c', '96xiyet8', '2012-01-01', 1177967285, -2001463367, '6cfperxa');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483631, -878613380, '8nv3dd', 'okuez', 'code_18', 1795932554, -831032281, 2006256976, 660144343, -169414942, 'mvb7vpc0xffw', 1983060779, -980269466, 'sk', 'f9q82', 'g01hu', 'j7f', '2012-01-01', -1663813652, 1094664154, '8gxb');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (4, -55602865, 'swwqcgsk', '9n8c4pgu7v', 'code_19', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw', 1908028688, 2122220075, 'p6luhvdlttil', 'n', 'rmdp', 'siie', '2012-01-01', -45536098, 1861536320, '6klfa9');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (6, 1620389964, '00t5c4ecigc', 'e376nium52', 'code_20', -443340271, 757448742, -1179823637, 1119186446, 781505063, 'rofqyp5s5b', 2107872094, 882961052, '2eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', '2012-01-01', -453362185, 481163439, '2dwyrq');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (7, -705985602, 'x58pz0f8je', 'd2', 'code_21', 1675430660, -688509700, -792092619, -1492524358, -1612443122, 'd', -736979194, 2103044118, 'h2gndqwnqcx5', 'hncprjtu0dz', '9fjgq8n2f', 'dqv0gcb9', '2012-01-01', 172461907, 1606439408, '3zb');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (9, -1554531873, 'yrkn6vck6ah0', '8j', 'code_22', -932772113, -639539893, 1255343543, -541746689, 1294666887, 'fdrz16n', -1496556994, -2115841792, 'dh5ogrgj', '8', 'yzt1afgogrit', 'sj3ayxp1q430', '2012-01-01', 1923912467, 518609210, '3d');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (10, -55602865, 'swwqcgsk', '9n8c4pgu7v', 'code_23', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw', 1908028688, 2122220075, 'p6luhvdlttil', 'n', 'rmdp', 'siie', '1970-01-01', -45536098, 1861536320, '6klfa9');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (11, -443340271, 'uo4nrqrofqy', '5s5b', 'code_24', 2107872094, 882961052, 743312762, -1822992503, -868774469, 'qa1', 2074205376, 274769912, 'oo3o9', 'l7', 'klex14ji', '7zwau2dwyr', NULL, -1021749117, 392822403, 'yu78');

-- Inserting into table: set_translations --
INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (1, 't2__c82683', 'code_1', '00t5c4ecigc');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483647, 't2__c82683', 'code_2', 'jsl');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (3, '2', 'code_4', '1afgo');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (0, '"', 'code_3', 't1pqo');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-1, '#', 'code_12', '31vwq51oa2s');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (4, '3pyu78d99r', 'code_14', 'jsl');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (5, '4', 'code_14', 'p5qi2rk');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (8, 't2__c82683', 'code_3', '8c68');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (7, 't2__e6fb01', 'code_12', 'vacx7afu5');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (10, '00t5c4ecigc', 'code_14', 'e376nium52');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (11, '9rljsl0b4', 'code_2', 'p5qi2rk');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT (CAST(SUM(T1.id) AS REAL) / COUNT(T1.id)) / 4, T2.language FROM sets AS T1 INNER JOIN set_translations AS T2 ON T1.id = T2.id WHERE T1.releaseDate BETWEEN '2012-01-01' AND '2015-12-31' GROUP BY T1.releaseDate ORDER BY COUNT(T2.language) DESC, (CAST(SUM(T1.id) AS REAL) / COUNT(T1.id)) / 4 NULLS LAST, T2.language NULLS LAST LIMIT 1;

/*
Gold Result:
(-89478484.83333333, 't2__c82683')
*/

-- Prediction Query
SELECT COUNT(*) / 4.0 AS annual_average_sets, (SELECT language FROM foreign_data GROUP BY language ORDER BY COUNT(*) DESC, language NULLS LAST LIMIT 1) AS most_common_language FROM sets WHERE releaseDate BETWEEN '2012-01-01' AND '2015-12-31';

/*
Prediction Result:
(5.5, None)
*/