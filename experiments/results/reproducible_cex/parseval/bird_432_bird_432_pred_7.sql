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
INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (1, -55602865, 'swwqcgsk', '9n8c4pgu7v', 't1__1f9376', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw', 1908028688, 2122220075, 'p6luhvdlttil', 'n', 'rmdp', 'siie', '2025-06-27', -1209887326, -1399556171, 'a9000t5c4eci');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (0, -443340271, 'uo4nrqrofqy', '5s5b', 'A', 2107872094, 882961052, 743312762, -1822992503, -868774469, 'qa1', 2074205376, 274769912, 'oo3o9', 'l7', 'klex14ji', '7zwau2dwyr', '2022-12-09', -1097120355, 244829661, 'jsl');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483647, -443340271, 'b4yp5qi', 'rkf9vqx5', 'code_2', 1836127587, -1529584866, 1196308825, 910894705, -283454505, '9uxj4hw', -2050247126, -736979194, 'h2gn', 'q', 'nqcx5h', 'cprj', '2023-05-30', -792947627, -1898531797, '9fjgq8n2f');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483645, -1056308489, 'gcb98oz', '3zb', 'C', -1554531873, 982314585, 638024588, -688098735, 1784916884, 'ah0f8jsww', -1388029300, -566887085, '72fxa7ryfd', 'z16ni', 'jai', 'dh5ogrgj', '2020-08-13', 1074760385, 1129658414, '1afgo');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483644, -902895762, 'ayxp1q43', '1jh3den', 'code_5', 357330522, -683007527, 2035306060, 1523825314, 2078438287, '5w1of7', 76996700, -435350511, '72ctdctmfg62', '0v', 'q8qdjpe1', 'o22', '2025-10-23', 199672698, 2119806856, '7cvtjpttg6b');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483643, -1171104889, '5zi36c4bfkfo', 'c', 'O', -406331049, -461418236, -468701684, 1448731351, -604098478, 'd5ysxc', -405743609, -1935752926, '5i3', 'q5l', 'pim5', '58q', '2023-03-22', 1615073310, 1055237066, 'r94gth2m');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483642, 1908593332, 'vy', '7zzbe8y', 'G', -705922211, 1043710187, 318331233, -233617564, 79330142, '58b4pm', 1849819405, -929383517, 'u', 'mkrpdj', 'wzw5chn9mo70', 'a9n0jxfo', '2020-12-03', -634585028, 1719800120, 'o');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483641, 364043263, 'sorlwyngc1', 'j', 't2__b4cb76', 211603887, -413043724, 761519897, 1504707292, 955267863, 'eyo6', -360096930, -1942581013, 'fuqyxuzkb', '521gwnlas6e', 'lboeowii1z5', 'xih6', '2025-08-17', -251205568, 287256667, 'otow9oa');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (3, 1, '5k5swwqcgs', '9n8', 'code_9', 1610062532, -106629402, 1871297066, 809183447, 89267185, 'e4', 1160656988, -992890117, 'a2ypuzhsrwbb', 'p6luhvdlttil', 'n', 'rmdp', '2022-07-21', -918961358, -1602639011, 'unw6klfa');

-- Inserting into table: set_translations --
INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483648, 'Russian', 't1__1f9376', 'gce376nium52');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483647, 'Russian', 'C', 'ri');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483646, 'Russian', 'O', 'ajjl');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483645, 'Russian', 'O', 'okv8uttmu2');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483644, 'Russian', 'G', '2zobb0q0k32o');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483643, 'Russian', 'O', 'l');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (2, 'Russian', 't2__b4cb76', 'awg96aqb0tbi');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (3, 'Russian', 't2__b4cb76', 'ndz39tajz9');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (4, 'Russian', 'code_9', '00t5c4e');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (5, 'Russian', 't1__1f9376', 'cigce376nium');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (6, 't2__e4eb41', 't1__1f9376', '52zbuo4nrq');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (7, NULL, 't1__1f9376', 'rofqyp5s5b');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.id FROM sets AS T1 INNER JOIN set_translations AS T2 ON T1.code = T2.setCode WHERE T2.language = 'Russian' GROUP BY T1.baseSetSize ORDER BY COUNT(T1.id) DESC, T1.id NULLS LAST LIMIT 1;

/*
Gold Result:
(-2147483643,)
*/

-- Prediction Query
SELECT T1.name FROM sets AS T1 INNER JOIN set_translations AS T2 ON T1.code = T2.setCode WHERE T2.language = 'Russian' ORDER BY T1.totalSetSize DESC, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Prediction Result:
('wzw5chn9mo70',)
*/