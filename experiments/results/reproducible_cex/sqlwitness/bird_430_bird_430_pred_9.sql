-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO sets (id, basesetsize, block, booster, code, isfoilonly, isforeignonly, isnonfoilonly, isonlineonly, ispartialpreview, keyrunecode, mcmid, mcmidextras, mcmname, mtgocode, name, parentcode, releasedate, tcgplayergroupid, totalsetsize, type) VALUES (0, 2, NULL, 'default1', 'Shadowmoor', 3, 1, 1, 1, 1, 'Shadowmoor', 1, 1, NULL, 'default2', 'Shadowmoor', NULL, '2023-01-01', 0, 1, 'Italian'), (3, 0, 'default2', 'Shadowmoor', 'default2', 2, 0, 2, 1, 1, 'Shadowmoor', NULL, 3, 'default2', 'Shadowmoor', 'default2', 'default1', '2023-01-01', NULL, 2, 'Shadowmoor'), (2, 0, 'default2', 'default1', 'default1', 1, 2, 3, 1, 0, 'Italian', 3, 0, NULL, NULL, 'Italian', 'Shadowmoor', '2023-01-02', 0, 0, 'default2'), (1, 1, 'default2', 'Italian', 'Italian', 0, 3, 3, 1, 1, 'Shadowmoor', 1, 1, 'Italian', NULL, NULL, 'Shadowmoor', NULL, 0, 3, 'Italian'), (4, 3, NULL, 'Shadowmoor', 'unique_4', 2, 2, 0, 2, 0, 'default1', 2, 2, 'default1', 'Shadowmoor', 'Italian', 'default2', NULL, 1, 3, 'default2'), (5, 3, 'default1', NULL, 'unique_5', 3, 2, 2, 2, 0, 'default2', 1, NULL, 'Italian', 'default1', 'Shadowmoor', 'Shadowmoor', NULL, 1, 0, 'default2'), (6, 1, 'Italian', 'Italian', 'unique_6', 0, 2, 0, 2, 3, 'default2', 1, NULL, 'default1', 'Italian', 'default1', 'default2', NULL, 2, 1, 'Italian'), (7, 2, 'Shadowmoor', 'Italian', 'unique_7', 1, 0, 3, 1, 0, 'default2', 3, 1, 'Italian', 'default2', 'Italian', 'Italian', '2023-01-01', 3, 0, 'default1'), (8, 2, NULL, 'default2', 'unique_8', 2, 2, 1, 0, 0, 'Shadowmoor', 2, 0, 'Italian', 'Shadowmoor', NULL, 'Shadowmoor', '2023-01-01', NULL, 1, 'default1'), (9, 0, 'default2', 'Shadowmoor', 'unique_9', 1, 1, 0, 0, 2, 'Shadowmoor', NULL, 3, 'Italian', 'default2', NULL, NULL, NULL, 1, 0, 'Shadowmoor'), (10, 0, 'default1', NULL, 'unique_10', 1, 0, 3, 0, 2, 'Shadowmoor', 1, 0, 'Shadowmoor', 'Shadowmoor', 'Shadowmoor', 'Shadowmoor', '2023-01-01', 0, 0, 'Shadowmoor'), (11, NULL, 'default1', 'Shadowmoor', 'unique_11', 3, 3, 3, 1, 2, 'Shadowmoor', 1, 3, 'default1', 'default2', 'Shadowmoor', 'default1', NULL, 0, 2, 'Italian'), (12, 0, 'Shadowmoor', 'Shadowmoor', 'unique_12', 2, 0, 3, 3, 1, 'default2', 1, 3, 'default2', 'default2', NULL, 'Shadowmoor', '2023-01-02', NULL, 2, 'Shadowmoor');
INSERT INTO set_translations (id, setcode, language, translation) VALUES (2, 'unique_9', 'default1', 'default2'), (1, 'unique_12', 'Italian', 'Shadowmoor'), (3, 'default1', 'default1', 'Italian'), (0, 'unique_10', 'Italian', NULL), (4, 'unique_4', 'Italian', 'default2'), (5, 'unique_7', 'default1', 'Shadowmoor'), (6, 'unique_7', 'Shadowmoor', 'Shadowmoor'), (7, 'unique_7', 'default2', 'Italian'), (8, 'unique_9', 'default2', 'Italian');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.name, T1.id FROM sets AS T1 INNER JOIN set_translations AS T2 ON T1.code = T2.setCode WHERE T1.block = 'Shadowmoor' AND T2.language = 'Italian' ORDER BY T1.id, T2.id NULLS LAST LIMIT 2;

/*
Gold Result:
(None, 12)
*/

-- Prediction Query
SELECT T1.id, T1.name FROM sets AS T1 INNER JOIN set_translations AS T2 ON T1.code = T2.setCode WHERE T2.language = 'Italian' AND T1.block = 'Shadowmoor' ORDER BY T1.name, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 2;

/*
Prediction Result:
(12, None)
*/