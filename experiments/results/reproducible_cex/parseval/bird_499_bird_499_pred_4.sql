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
INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483648, -55602865, 'swwqcgsk', '9n8c4pgu7v', 't1__fdbf4a', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw', 1908028688, 2122220075, 'p6luhvdlttil', 'n', 'Salvat 2011', 'rmdp', '2022-07-21', -918961358, -1602639011, 'unw6klfa');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483647, -1683203397, 'e376nium52', 'zbuo4nrqrof', 'C', 373262291, -472966518, -921187550, -2070843029, 328305758, 'tliqa1', 2074205376, 274769912, 'oo3o9', 'l7', 'Salvat 2011', 'klex14ji', '2025-11-18', -453362185, 481163439, '2dwyrq');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483646, -1097120355, '78d99r', 'jsl', 'A', -346339240, 1692174491, -1025564911, -227162283, 2056419640, 'vqx58pz0f', 176555546, -1937207087, 'vy9uxj4', 'wb', 'v', 'ph2', '2021-03-22', -1264842910, -1052964641, 'qcx5');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483645, -1748371085, 'q8', 'n2f3dqv0gcb9', 'G', 172461907, 1606439408, 1443629118, -155284187, 1686459626, 'lyr', 1038566008, 32204797, 'k', 'ah0f8jsww', 'Salvat 2011', 'q7x', '2020-03-27', 602161869, 1350414441, 'a7ryfd');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483644, 2011234363, 'ai5', 'h', 'O', 1583472758, 1449284300, -977470238, -1478247928, 1074760385, 't1afgog', -946046410, -902895762, 'ayxp1q43', '1jh3den', 'Salvat 2011', 'c68x8vacx', '2025-10-14', 1523825314, 2078438287, '5w1of7');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483643, -1744557630, '5q8qdj', 'e1io', 't2__f2daf2', -241848752, 2004147439, -691774480, -1523347137, 1582582341, 'tg6bnou5zi', 1944978593, 1722106924, 'f', 'foa', 'Salvat 2011', 'cd07z2zezjo7', '2024-01-11', -542502665, 1999335832, 'sxcmr0o');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (6, -55602865, 'swwqcgsk', '9n8c4pgu7v', 'code_7', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw', 1908028688, 2122220075, 'p6luhvdlttil', 'n', 'Salvat 2011', 'rmdp', '2022-07-21', -918961358, -1602639011, 'unw6klfa');

-- Inserting into table: set_translations --
INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483648, '9000t5c4ec', 't1__fdbf4a', 't2__16b2dd');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483647, 'hncprjtu0dz', 'A', 't2__16b2dd');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483646, 'z16ni', 'A', 't2__16b2dd');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483645, 'pzo72ctdc', 'A', 't2__16b2dd');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483644, 'mfg62', 'A', 't2__16b2dd');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (2, 'ztdgj5i3lq5l', 't2__f2daf2', 't2__16b2dd');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (3, 'pim5', 't2__f2daf2', 't2__448653');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483641, '58q', 't1__fdbf4a', 't2__16b2dd');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483640, 's27p2r94gth2', 't1__fdbf4a', NULL);

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483639, 'najj', 't1__fdbf4a', 't2__16b2dd');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (7, '9000t5c4ec', 't1__fdbf4a', 't2__16b2dd');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (5, 'gce376nium52', 'C', 't2__16b2dd');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (4, 'zbuo4nrqrof', 't1__fdbf4a', NULL);

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (6, 'qyp5s5bbp0', 't1__fdbf4a', NULL);

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (8, '2eutliqa11r', 't1__fdbf4a', NULL);

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (9, 'ytoo3o9', 't1__fdbf4a', NULL);

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (10, 'l7', 't1__fdbf4a', NULL);

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (11, 'klex14ji', 't1__fdbf4a', NULL);

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (12, '7zwau2dwyr', 't1__fdbf4a', NULL);

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (13, '13pyu', 't1__fdbf4a', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T2.translation) FROM sets AS T1 INNER JOIN set_translations AS T2 ON T2.setCode = T1.code WHERE T1.name = 'Salvat 2011' AND NOT T2.translation IS NULL;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(T2.translation) FROM sets AS T1 INNER JOIN set_translations AS T2 ON T1.code = T2.setCode WHERE T1.name = 'Tenth Edition';

/*
Prediction Result:
(0,)
*/