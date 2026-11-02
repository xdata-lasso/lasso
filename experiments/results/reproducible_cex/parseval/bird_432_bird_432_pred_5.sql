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
INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (1, -55602865, 'swwqcgsk', '9n8c4pgu7v', 't1__934861', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw', 1908028688, 2122220075, 'p6luhvdlttil', 'n', 'rmdp', 'siie', '2025-06-27', -1209887326, -1399556171, 'a9000t5c4eci');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (0, -443340271, 'uo4nrqrofqy', '5s5b', 'A', 2107872094, 882961052, 743312762, -1822992503, -868774469, 'qa1', 2074205376, 274769912, 'oo3o9', 'l7', 'klex14ji', '7zwau2dwyr', '2022-12-09', -1097120355, 244829661, 'jsl');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483647, -443340271, 'b4yp5qi', 'rkf9vqx5', 'code_2', 1836127587, -1529584866, 1196308825, 910894705, -283454505, '9uxj4hw', -2050247126, -736979194, 'h2gn', 'q', 'nqcx5h', 'cprj', '2023-05-30', -792947627, -1898531797, '9fjgq8n2f');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483645, -1056308489, 'gcb98oz', '3zb', 't1__05bedd', -1554531873, 982314585, 638024588, -688098735, 1784916884, 'ah0f8jsww', -1388029300, -566887085, '72fxa7ryfd', 'z16ni', 'jai', 'dh5ogrgj', '2020-08-13', 1074760385, 1129658414, '1afgo');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-1, -902895762, 'ayxp1q43', '1jh3den', '_', 357330522, -683007527, 2035306060, 1523825314, 2078438287, '5w1of7', 76996700, -435350511, '72ctdctmfg62', '0v', 'q8qdjpe1', 'o22', '2025-10-23', 199672698, 2119806856, '7cvtjpttg6b');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483643, 1691780814, '6c4bfkfo', 'c', 'code_6', -406331049, -461418236, -468701684, 1448731351, -604098478, 'd5ysxc', -405743609, -1935752926, '5i3', 'q5l', 'pim5', '58q', '2023-03-22', 1615073310, 1055237066, 'r94gth2m');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483642, -233617564, '7sx58b4pma', 'us3auvmkrpdj', 't2__5f05bd', 1105964624, -663234145, -2013213247, 101754718, 628082526, '9n0jxfofwsz', -210159774, 270415200, 'b', 'q0k32od', 'cl5ams', 'orlwyngc1dj', '2020-10-18', -413043724, 761519897, 'yoeyo6l');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483641, 1048147204, 'eowi', '1z5', 't1__d54944', 1557188093, 548968280, -1552469358, 7342822, -1034034171, 'lyotow', 205676091, -2094843966, '96', 'aqb0tbindz39', 'ajz9t', '8', '2022-04-25', -625404808, -1694533100, 'bc3t');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483640, 2, '6dza35r', 'mkio18ri2hy', 'code_9', -1853955201, -805997097, -586285368, 1664452437, -1485875026, 'bymzn2mfx7h3', -891525031, -1154091048, 'j', 'sh5knzys7', 'y', 'yd1jmgjach8', '2022-11-06', 280292620, 620355627, '8y3a17v4yg');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483639, 2, '96rn', 'dqrhm', 'code_10', 555368535, -1369148652, 899787662, 594760660, 833568923, '90xdmsqt', -1685482179, -1391541536, 'qb9i9f', 'ccukjq1q', 'ik1yhb', '8hlst1p', '2022-10-24', 1980131681, 1222311103, 'ztv');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483638, 2, '4iz7', 'aqqlud8ft', 'code_11', 1183069552, -1057355067, -1004098188, 316163741, -752650834, 'j8kjh', 1138926079, -609840352, 'lvrisu', 'z0kaq', 'ncgc8', '3b7v8', '2021-10-15', -622923312, 1789767331, 'b');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483637, 2, '6j47n', 'ar50hs', 'code_12', -1515201134, -2121944911, 1195320303, 1463445550, -1096060187, 'mwfw', -544173163, -958321297, 'w', '014', '5dqts', 'g97a', '2022-12-11', -459764012, -1148194959, 'pj6ddly');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (3, 1, '5k5swwqcgs', '9n8', 'code_13', 1610062532, -106629402, 1871297066, 809183447, 89267185, 'e4', 1160656988, -992890117, 'a2ypuzhsrwbb', 'p6luhvdlttil', 'n', 'rmdp', '2022-07-21', -918961358, -1602639011, 'unw6klfa');

-- Inserting into table: set_translations --
INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483648, 'Russian', 't1__934861', 'gce376nium52');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483647, 'Russian', 't1__05bedd', 'ri');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483646, 'Russian', 't1__05bedd', 'ou5z');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483645, 'Russian', 't1__05bedd', 'ajjl');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483644, 'Russian', 't1__05bedd', 'okv8uttmu2');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483643, 'Russian', 't1__05bedd', '78lfvyz7');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483642, 'Russian', 't1__05bedd', 'be8yvkv');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (2, 'Russian', 't2__5f05bd', 'hdt6fuq');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (3, 'Russian', 't2__5f05bd', 'xuzkb52');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483639, 'Russian', 't1__934861', 'u');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483638, 'Russian', 't1__934861', 'bd0w9603v');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483637, 'Russian', 't1__934861', 'xw1rxe9yfk7');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483636, 'Russian', 't1__934861', 'k162n');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483635, 'Russian', 't1__934861', 'o');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483634, 'Russian', 't1__934861', 'vu');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483633, 'Russian', 't1__934861', 'mayq3qdpua');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483632, 'Russian', 't1__934861', '6');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483631, 'Russian', 't1__934861', 'h');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483630, 'Russian', 't1__934861', 'u6iph');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (5, 'Russian', 't1__934861', '9000t5c4ec');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (4, 'Russian', 'code_2', 'gce376nium52');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (6, 't2__a4a756', 't1__934861', 'zbuo4nrqrof');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (7, NULL, 't1__934861', 'qyp5s5bbp0');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.id FROM sets AS T1 INNER JOIN set_translations AS T2 ON T1.code = T2.setCode WHERE T2.language = 'Russian' GROUP BY T1.baseSetSize ORDER BY COUNT(T1.id) DESC, T1.id NULLS LAST LIMIT 1;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT sets.name FROM sets INNER JOIN set_translations ON sets.code = set_translations.setcode WHERE set_translations.language = 'Russian' AND sets.basesetsize = (SELECT MAX(basesetsize) FROM sets INNER JOIN set_translations ON sets.code = set_translations.setcode WHERE set_translations.language = 'Russian');

/*
Prediction Result:
('rmdp',)
('rmdp',)
('rmdp',)
('rmdp',)
('rmdp',)
('rmdp',)
('rmdp',)
('rmdp',)
('rmdp',)
('rmdp',)
('rmdp',)
('rmdp',)
*/