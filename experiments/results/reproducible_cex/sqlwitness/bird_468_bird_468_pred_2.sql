-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO sets (id, basesetsize, block, booster, code, isfoilonly, isforeignonly, isnonfoilonly, isonlineonly, ispartialpreview, keyrunecode, mcmid, mcmidextras, mcmname, mtgocode, name, parentcode, releasedate, tcgplayergroupid, totalsetsize, type) VALUES (1, NULL, 'Chinese Simplified', 'default1', 'Chinese Simplified', 0, 0, 1, 1, 1, 'Chinese Simplified', 1, 1, 'Chinese Simplified', 'Eighth Edition', 'Eighth Edition', 'default2', '2023-01-01', 0, 1, 'Chinese Simplified'), (0, NULL, 'default2', 'Eighth Edition', 'default1', 0, 0, 1, 1, 1, 'Chinese Simplified', NULL, 1, NULL, 'default1', 'Chinese Simplified', NULL, '2023-01-01', 1, 0, 'default1'), (2, 1, NULL, NULL, 'Eighth Edition', 1, 0, 1, 0, 1, 'default2', 0, 1, 'default1', 'default2', 'default1', 'default1', '2023-01-02', NULL, 1, 'Eighth Edition'), (3, NULL, NULL, NULL, 'default2', 0, 0, 0, 0, 0, 'Eighth Edition', NULL, NULL, 'default2', 'Chinese Simplified', 'default1', NULL, '2023-01-01', NULL, 1, 'default2'), (4, 0, 'default1', 'default1', 'unique_4', 1, 0, 0, 0, 0, NULL, 1, NULL, 'Chinese Simplified', 'Eighth Edition', NULL, 'default2', '2023-01-02', NULL, NULL, 'Eighth Edition'), (5, 0, 'Chinese Simplified', 'Eighth Edition', 'unique_5', 0, 0, 1, 1, 0, 'default1', 0, 0, NULL, 'default1', 'Chinese Simplified', 'Eighth Edition', NULL, 1, NULL, 'Eighth Edition'), (6, 0, NULL, 'Eighth Edition', 'unique_6', 1, 1, 0, 0, 0, NULL, NULL, NULL, 'Eighth Edition', 'default2', 'default1', NULL, '2023-01-02', 1, 0, NULL), (7, 0, 'default2', 'default1', 'unique_7', 1, 0, 0, 0, 0, 'default1', 1, 0, 'Chinese Simplified', NULL, 'Eighth Edition', 'default1', NULL, 0, 1, 'default2'), (8, NULL, 'Eighth Edition', 'Chinese Simplified', 'unique_8', 0, 0, 0, 0, 0, 'default2', 0, 1, NULL, 'Eighth Edition', 'default1', 'Chinese Simplified', '2023-01-02', 0, 0, 'Chinese Simplified'), (9, 1, 'Eighth Edition', 'default2', 'unique_9', 1, 0, 0, 1, 1, 'default2', 0, NULL, 'default2', 'default2', 'Eighth Edition', 'default2', '2023-01-01', NULL, 0, 'Eighth Edition'), (10, 0, 'Chinese Simplified', 'Eighth Edition', 'unique_10', 1, 0, 0, 1, 1, 'default2', 1, 0, 'Eighth Edition', 'default1', 'Chinese Simplified', 'Eighth Edition', NULL, 0, NULL, 'default2');
INSERT INTO set_translations (id, setcode, language, translation) VALUES (0, NULL, 'default2', NULL), (1, 'unique_8', NULL, 'Chinese Simplified'), (2, 'unique_10', 'Eighth Edition', 'Eighth Edition'), (3, 'default1', 'Chinese Simplified', 'default2'), (4, 'unique_4', 'Chinese Simplified', 'Chinese Simplified'), (5, 'Eighth Edition', 'default1', 'Chinese Simplified'), (6, 'unique_5', NULL, 'default2'), (7, 'Eighth Edition', 'Eighth Edition', 'default2'), (8, 'Chinese Simplified', 'Eighth Edition', 'Chinese Simplified'), (9, 'unique_8', 'default2', 'Chinese Simplified'), (10, 'unique_7', 'Eighth Edition', NULL), (11, 'Chinese Simplified', 'Chinese Simplified', NULL), (12, 'unique_9', 'Chinese Simplified', 'Eighth Edition'), (13, 'unique_8', 'default2', 'default2'), (14, NULL, 'default2', NULL), (15, 'unique_7', 'Chinese Simplified', 'default1'), (16, 'unique_9', NULL, 'Eighth Edition'), (17, 'unique_7', 'default1', NULL), (18, 'unique_5', 'Eighth Edition', 'default1'), (19, 'unique_4', 'Chinese Simplified', 'Chinese Simplified'), (20, 'unique_7', NULL, 'Eighth Edition'), (21, 'unique_7', 'default1', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.translation FROM sets AS T1 INNER JOIN set_translations AS T2 ON T2.setCode = T1.code WHERE T1.name = 'Eighth Edition' AND T2.language = 'Chinese Simplified';

/*
Gold Result:
(None,)
('Eighth Edition',)
('default1',)
*/

-- Prediction Query
SELECT translation FROM set_translations WHERE setCode = (SELECT code FROM sets WHERE name = 'Eighth Edition') AND language = 'Chinese Simplified';

/*
Prediction Result:
(None,)
*/