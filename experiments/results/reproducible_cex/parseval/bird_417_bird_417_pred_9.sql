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
INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (1, -55602865, 'swwqcgsk', '9n8c4pgu7v', 't1__0379a3', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw', 1908028688, 2122220075, 'p6luhvdlttil', 'n', 'rmdp', 'siie', '2025-06-27', -1209887326, -1399556171, 'expansion');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483647, 373262291, 'p5s5bbp', '02eutliqa11r', 'C', 2137741668, -525979501, 1898504886, 624571013, 1644911394, '9hl7', 1178636309, -1390245819, 'x14ji7zwau2d', 'yrq13p', 'u78d99r', 'jsl', '2024-09-13', -2031361952, 1649269347, 'p5qi2rkf9v');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483646, -1929953647, 'ph2', 'nd', 'O', -1052964641, -1245682094, -1660358170, -1106350634, -1509264256, '0dz79f', -1485777725, -1255130038, '3d', 'qv0gcb98ozk', 'zbilyrkn', '6vck6ah0f8js', '2023-11-21', -639539893, 1255343543, '7');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483645, -946046410, 'tsj3ayxp1q4', '01jh3den', 't2__27a0ea', 357330522, -683007527, 2035306060, 1523825314, 2078438287, '5w1of7', 76996700, -435350511, '72ctdctmfg62', '0v', 'q8qdjpe1', 'o22', '2025-10-23', 199672698, 2119806856, '7cvtjpttg6b');

-- Inserting into table: set_translations --
INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483648, 'a9000t5c4eci', 't1__0379a3', 'gce376nium52');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483647, 'Japanese', 't1__0379a3', 'zbuo4nrqrof');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483646, 'x58pz', 'C', 'f8jegd2');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483645, 'vy9uxj4', 'C', 'wb');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483644, '2fxa7ryfdrz', 'O', '16nijjai5dh');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483643, 'ogrgjd8y', 'O', 't1afgog');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (2, 'ou5z', 't2__27a0ea', '36c');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (3, 'bfkfoacd', 't2__27a0ea', '7z2zezj');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (4, 'Japanese', 't1__0379a3', '5k5swwqcgs');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (5, '9n8', 't1__0379a3', '4');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (6, 'gu7v', 't1__0379a3', 'e4');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (7, 'hria2ypuzhs', 't1__0379a3', 'rwbbp6luhvd');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (8, 'tti', 't1__0379a3', 'bnp');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (9, 'mdpos', 't1__0379a3', 'ie5');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (10, 'nw6klf', 't1__0379a3', 'a9000t5c4eci');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (11, 'gce376nium52', 't1__0379a3', 'zbuo4nrqrof');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (12, 'qyp5s5bbp0', 't1__0379a3', '2eutliqa11r');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN T2.language = 'Japanese' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.id) FROM sets AS T1 INNER JOIN set_translations AS T2 ON T1.code = T2.setCode WHERE T1.type = 'expansion';

/*
Gold Result:
(18.181818181818183,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN "sets"."type" = 'expansion' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT("set_translations"."language") FROM "sets" INNER JOIN "set_translations" ON "sets"."code" = "set_translations"."setcode" WHERE "set_translations"."language" = 'Japanese';

/*
Prediction Result:
(100.0,)
*/