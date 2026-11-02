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
INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483648, -55602865, 'swwqcgsk', '9n8c4pgu7v', 't1__c6b1f0', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw', 1908028688, 2122220075, 'p6luhvdlttil', 'n', 'Salvat 2011', 'rmdp', '2022-07-21', -918961358, -1602639011, 'unw6klfa');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483647, -1683203397, 'e376nium52', 'zbuo4nrqrof', 'A', 373262291, -472966518, -921187550, -2070843029, 328305758, 'tliqa1', 2074205376, 274769912, 'oo3o9', 'l7', 'Salvat 2011', 'klex14ji', '2025-11-18', -453362185, 481163439, '2dwyrq');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483646, -1097120355, '78d99r', 'jsl', 'C', -346339240, 1692174491, -1025564911, -227162283, 2056419640, 'vqx58pz0f', 176555546, -1937207087, 'vy9uxj4', 'wb', 'v', 'ph2', '2021-03-22', -1264842910, -1052964641, 'qcx5');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483645, -1056308489, 'gcb98oz', '3zb', 'O', -1554531873, 982314585, 638024588, -688098735, 1784916884, 'ah0f8jsww', -1388029300, -566887085, '72fxa7ryfd', 'z16ni', 'jai', 'dh5ogrgj', '2020-08-13', 1074760385, 1129658414, '1afgo');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483644, -1538707438, 'den8c68x', 'vacx7afu5', 't2__18ebea', -290314193, 76996700, -435350511, 1992637800, -820614248, 't', -1284905200, 7929158, '0v', 'q8qdjpe1', 'Salvat 2011', 'o22', '2025-10-23', 199672698, 2119806856, '7cvtjpttg6b');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (7, -55602865, 'swwqcgsk', '9n8c4pgu7v', 'code_6', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw', 1908028688, 2122220075, 'p6luhvdlttil', 'n', 'Salvat 2011', 'rmdp', '2022-07-21', -918961358, -1602639011, 'unw6klfa');

-- Inserting into table: set_translations --
INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483648, '9000t5c4ec', 't1__c6b1f0', 't2__aeb1d2');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483647, 'hncprjtu0dz', 'C', 't2__aeb1d2');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483646, '9fjgq8n2f', 'C', 't2__aeb1d2');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483645, 'ri', 'O', 't2__aeb1d2');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483644, 'tsj3ayxp1q4', 'O', 't2__aeb1d2');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (2, 'ou5z', 't2__18ebea', 't2__aeb1d2');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (3, '36c', 't2__18ebea', 't2__3c66b6');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483641, 'bfkfoacd', 't1__c6b1f0', 't2__aeb1d2');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483640, '7z2zezj', 't1__c6b1f0', NULL);

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483639, '7wgx', 't1__c6b1f0', 't2__aeb1d2');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (4, '000t5c4ec', 't2__18ebea', 't2__aeb1d2');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (6, 'gce', 't1__c6b1f0', 't2__aeb1d2');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (5, '76nium52', 't1__c6b1f0', NULL);

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (7, 'zbuo4nrqrof', 't1__c6b1f0', NULL);

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (8, 'qyp5s5bbp0', 't1__c6b1f0', NULL);

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (9, '2eutliqa11r', 't1__c6b1f0', NULL);

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (10, 'ytoo3o9', 't1__c6b1f0', NULL);

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (11, 'l7', 't1__c6b1f0', NULL);

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (12, 'klex14ji', 't1__c6b1f0', NULL);

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (13, '7zwau2dwyr', 't1__c6b1f0', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T2.translation) FROM sets AS T1 INNER JOIN set_translations AS T2 ON T2.setCode = T1.code WHERE T1.name = 'Salvat 2011' AND NOT T2.translation IS NULL;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(T1.translation) FROM set_translations AS T1 INNER JOIN sets AS T2 ON T1.setCode = T2.code WHERE T2.name = 'Salvat 2011' AND NOT T1.translation IS NULL;

/*
Prediction Result:
(7,)
*/