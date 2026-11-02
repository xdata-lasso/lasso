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
INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (1, -55602865, 'swwqcgsk', '9n8c4pgu7v', 't1__2c823b', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw', 1908028688, 2122220075, 'p6luhvdlttil', 'n', 'rmdp', 'siie', '2025-06-27', -1209887326, -1399556171, 'expansion');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483647, 373262291, 'p5s5bbp', '02eutliqa11r', 'C', 2137741668, -525979501, 1898504886, 624571013, 1644911394, '9hl7', 1178636309, -1390245819, 'x14ji7zwau2d', 'yrq13p', 'u78d99r', 'jsl', '2024-09-13', -2031361952, 1649269347, 'p5qi2rkf9v');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483646, 1675430660, 'y9uxj4', 'wb', 'O', -1929953647, 1581736075, -261132974, -1264842910, -1052964641, 'qcx5', 580968159, -1245312912, 'rjtu', 'dz79fjg', '8n2f3', 'dqv0gcb98ozk', '2025-03-14', -2078052421, -512640349, 'kn6vck6ah0f8');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483645, -541746689, '7ryfdrz16n', 'jja', '_', -7597509, -1625552518, -1738458256, -1714354341, -458359144, '1afgogritsj', -197933860, 2111987706, 'p1q430', 'jh3den8', 'c68x8vacx7', 'f', '2023-07-08', 1371234901, -290314193, 'f77pzo72ctd');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483644, -1488156735, '1i', '2278', 'G', 2004147439, -691774480, -1523347137, 1582582341, 453836040, '6b', -1171104889, -29242208, '36c', 'bfkfoacd', '7z2zezj', '7wgx', '2020-07-27', 1999335832, -526612570, 'cmr0oz');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483643, -55240145, '8qs27p2r', '4gth2mnaj', 't2__f56db2', -1478011227, -2096405521, 1803796945, 872694102, 618058035, '2ne578', 1908593332, 697257217, '7zzbe8y', 'kv42q7', 'x58b4', 'pmaus3auvmkr', '2022-08-18', -1934017803, 1105964624, 'w5chn9m');

-- Inserting into table: set_translations --
INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483648, 'a9000t5c4eci', 't1__2c823b', 'gce376nium52');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483647, 'Japanese', 't1__2c823b', 'zbuo4nrqrof');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483646, 'x58pz', 'C', 'f8jegd2');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483645, 'sww', 'O', 'q7x');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483644, 't', '_', 'mfg62g0v5q8q');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483643, 'dgj5i', 'G', 'lq5lnpim');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (2, 'o705a9n0jxfo', 't2__f56db2', 'ws');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (3, 'do2zobb', 't2__f56db2', 'q0k32od');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (4, 'Japanese', 't1__2c823b', '5k5swwqcgs');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (5, '9n8', 't1__2c823b', '4');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (6, 'gu7v', 't1__2c823b', 'e4');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (7, 'hria2ypuzhs', 't1__2c823b', 'rwbbp6luhvd');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (8, 'tti', 't1__2c823b', 'bnp');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (9, 'mdpos', 't1__2c823b', 'ie5');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (10, 'nw6klf', 't1__2c823b', 'a9000t5c4eci');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (11, 'gce376nium52', 't1__2c823b', 'zbuo4nrqrof');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (12, 'qyp5s5bbp0', 't1__2c823b', '2eutliqa11r');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN T2.language = 'Japanese' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.id) FROM sets AS T1 INNER JOIN set_translations AS T2 ON T1.code = T2.setCode WHERE T1.type = 'expansion';

/*
Gold Result:
(18.181818181818183,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T1.language = 'Japanese' AND T2.type = 'expansion' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.language) FROM set_translations AS T1 INNER JOIN sets AS T2 ON T1.setCode = T2.code;

/*
Prediction Result:
(11.764705882352942,)
*/