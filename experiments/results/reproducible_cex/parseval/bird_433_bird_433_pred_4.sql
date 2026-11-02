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
INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483648, -55602865, 'swwqcgsk', '9n8c4pgu7v', 't1__18ce34', -1865039888, 1160656988, -992890117, 1, 1914020640, 'ypuzhsrw', 1908028688, 2122220075, 'p6luhvdlttil', 'n', 'rmdp', 'siie', '2025-06-27', -1209887326, -1399556171, 'a9000t5c4eci');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483647, 743312762, 'eutliqa11r', 'ytoo3o9', 'A', -1666765085, 1178636309, -1390245819, 1, 1055976837, '4ji7zwa', 2123196517, 364869063, 'q13py', '78d99r', 'jsl', 'b4yp5qi', '2025-01-05', -975213201, -705985602, 'x58pz0f8je');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483646, 1196308825, 'd21vy9uxj4hw', 'd', 'C', -736979194, 2103044118, -1642259219, 1298861365, 1968874827, 'nqcx5h', -1245312912, 1575412235, 'jtu0d', '79fjgq8', 'n2f3dqv0gcb9', 'ozk3zbily', '2023-02-18', 1038566008, 32204797, 'k');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483645, -541746689, '7ryfdrz16n', 'jja', 'G', -7597509, -1625552518, -1738458256, -1714354341, -458359144, '1afgogritsj', -197933860, 2111987706, 'p1q430', 'jh3den8', 'c68x8vacx7', 'f', '2023-07-08', 1371234901, -290314193, 'f77pzo72ctd');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483644, -1488156735, '1i', '2278', 'O', 2004147439, -691774480, -1523347137, 1582582341, 453836040, '6b', -1171104889, -29242208, '36c', 'bfkfoacd', '7z2zezj', '7wgx', '2020-07-27', 1999335832, -526612570, 'cmr0oz');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483643, -55240145, '8qs27p2r', '4gth2mnaj', 't2__d41fb8', -1478011227, -2096405521, 1803796945, 1, 872694102, 'tmu2n', -1817527403, -1402164108, 'yz7zzb', '8y', 'kv42q7', 'x58b4', '2022-09-04', 319284352, 1164790775, 'auvmkrpd');

-- Inserting into table: set_translations --
INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483648, 'gce376nium52', 't1__18ce34', 'zbuo4nrqrof');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483647, 'Chinese Simplified', 't1__18ce34', 'qyp5s5bbp0');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483646, 'ah0f8jsww', 'C', 'q7x');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483645, 't', 'G', 'mfg62g0v5q8q');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483644, 'dgj5i', 'O', 'lq5lnpim');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (2, 'wzw', 't2__d41fb8', 'chn9mo70');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (3, 'a9n0jxfo', 't2__d41fb8', 'ws');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483641, 'do2zobb', 't1__18ce34', 'q0k32od');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483640, NULL, 't1__18ce34', 'cl5ams');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (4, 'Chinese Simplified', 't1__18ce34', '5k5swwqcgs');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (5, 'Chinese Simplified', 't1__18ce34', '5k5swwqcgs');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (6, 'Chinese Simplified', 't1__18ce34', '9n8');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (7, 'Chinese Simplified', 't1__18ce34', '4');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (8, 'Chinese Simplified', 't1__18ce34', 'gu7v');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (9, 'Chinese Simplified', 't1__18ce34', 'e4');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (10, 'Chinese Simplified', 't1__18ce34', 'hria2ypuzhs');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN T2.language = 'Chinese Simplified' AND T1.isOnlineOnly = 1 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM sets AS T1 INNER JOIN set_translations AS T2 ON T1.code = T2.setCode;

/*
Gold Result:
(50.0,)
*/

-- Prediction Query
SELECT SUM(CASE WHEN T2.language = 'Chinese Simplified' THEN 1 ELSE NULL END) * 100.0 / COUNT(T1.id) FROM cards AS T1 JOIN foreign_data AS T2 ON T1.uuid = T2.uuid WHERE T1.isOnlineOnly = 1;

/*
Prediction Result:
(None,)
*/