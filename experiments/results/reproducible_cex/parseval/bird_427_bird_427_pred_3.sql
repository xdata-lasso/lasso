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
INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483648, -55602865, 'swwqcgsk', '9n8c4pgu7v', 'ARC', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw', 1908028688, 2122220075, 'Archenemy', 'p6luhvdlttil', 'n', 'rmdp', '2022-07-21', -918961358, -1602639011, 'unw6klfa');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483647, -1683203397, 'e376nium52', 'zbuo4nrqrof', 'code_2', 373262291, -472966518, -921187550, -2070843029, 328305758, 'tliqa1', 2074205376, 274769912, 'Archenemy', 'oo3o9', 'l7', 'klex14ji', '2025-11-18', -453362185, 481163439, '2dwyrq');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483646, 1649269347, 'p5qi2rkf9v', 'x58pz', '@', -1529584866, 1196308825, 910894705, -283454505, 233994589, 'j4hwbd', -736979194, 2103044118, 'Archenemy', 'h2gndqwnqcx5', 'hncprjtu0dz', '9fjgq8n2f', '2025-02-11', 806170397, 513454646, '0gcb98');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483645, 138842628, 'wwlq7', 'xb72fxa7ryfd', 't1__51a92d', 564390026, -1259474148, 2011234363, -1483100200, -7597509, 'h5ogrgjd8yz', 1250290042, -1717646459, 'Archenemy', 'ri', 'tsj3ayxp1q4', '01jh3den', '2020-07-09', -683007527, 2035306060, 'x7afu5w1of77');

-- Inserting into table: set_translations --
INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483648, 't2__8b0371', 'ARC', '9000t5c4ec');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (2, 't2__8b0371', 'ARC', '3pyu78d');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (3, 't2__8b0371', 'ARC', '9rljsl0b4');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483645, 't2__8b0371', 'ARC', 'zk3z');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483644, 't2__8b0371', 'ARC', 'i');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483643, 't2__8b0371', 'ARC', 'yrk');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483642, 't2__8b0371', 'ARC', 'n6vck6ah0f');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483641, 't2__8b0371', 't1__51a92d', 'zo72');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483640, NULL, 'ARC', 'ctdctmfg62g0');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (4, '5sw', 't1__51a92d', 'qcgsk9');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (5, '8c4pgu7vfe', 'code_2', 'hria2ypu');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (6, 'sr', 't1__51a92d', 'wbbp6luhvdlt');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (7, 'lbn', '@', 'rmdp');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (8, 'siie5unw6k', 'code_2', 'fa9');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (9, '00t5c4ecigc', 't1__51a92d', 'e376nium52');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (10, 'u', 't1__51a92d', '4nrq');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (11, 'fqyp', '@', 's5bbp02e');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (12, 'liqa1', '@', 'ryytoo3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.language FROM sets AS T1 INNER JOIN set_translations AS T2 ON T1.code = T2.setCode WHERE T1.mcmName = 'Archenemy' AND T2.setCode = 'ARC';

/*
Gold Result:
('t2__8b0371',)
('t2__8b0371',)
('t2__8b0371',)
('t2__8b0371',)
('t2__8b0371',)
(None,)
('t2__8b0371',)
('t2__8b0371',)
*/

-- Prediction Query
SELECT T2.translation FROM sets AS T1 INNER JOIN set_translations AS T2 ON T1.code = T2.setCode WHERE T1.name = 'Archenemy' AND T1.code = 'ARC';

/*
Prediction Result:
*/