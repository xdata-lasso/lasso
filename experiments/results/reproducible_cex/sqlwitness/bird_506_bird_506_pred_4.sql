-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO sets (id, basesetsize, block, booster, code, isfoilonly, isforeignonly, isnonfoilonly, isonlineonly, ispartialpreview, keyrunecode, mcmid, mcmidextras, mcmname, mtgocode, name, parentcode, releasedate, tcgplayergroupid, totalsetsize, type) VALUES (-1, 99, 'default1', 'default2', 'default2', 0, 101, 101, 101, -1, 'default1', 101, NULL, 'default2', 'Japanese', NULL, 'default2', '2023-01-01', 0, 99, NULL), (0, 1, NULL, 'default1', 'Japanese', 99, 99, 101, 100, 101, 'default2', 0, 99, NULL, 'default1', 'default1', 'default1', NULL, 100, 2, 'Japanese'), (2, 2, NULL, 'default2', 'default1', 2, 0, 100, -1, 99, 'default1', 100, 101, 'default1', 'Japanese', NULL, 'default1', '2023-01-01', 0, 2, 'Japanese'), (101, 99, 'Japanese', 'default1', 'unique_3', 101, 101, -1, 99, 1, 'default1', 100, 2, 'Japanese', 'default1', NULL, 'default2', '2023-01-01', -1, NULL, 'default1'), (1, 101, NULL, 'default1', 'unique_4', 0, -1, 1, 1, 1, 'Japanese', 100, 2, 'default1', 'default2', NULL, 'Japanese', '2023-01-01', 99, NULL, 'default2'), (100, 101, 'Japanese', 'default1', 'unique_5', 100, 1, 2, 101, 99, 'Japanese', 101, 2, 'default2', 'default1', NULL, 'Japanese', '2023-01-01', 2, 1, NULL), (99, -1, 'Japanese', 'Japanese', 'unique_6', 99, 2, 101, 101, 0, 'default1', 99, 99, 'default1', 'Japanese', 'default2', 'Japanese', NULL, 2, -1, 'Japanese'), (3, 2, 'default1', 'default1', 'unique_7', 101, 101, 1, 1, 101, 'default1', NULL, 2, NULL, 'Japanese', 'default2', 'Japanese', '2023-01-02', 99, 2, 'default2'), (4, 1, 'default1', NULL, 'unique_8', 100, 101, 2, -1, -1, 'Japanese', 1, 0, 'default1', 'default2', 'default1', 'default2', '2023-01-02', -1, NULL, NULL), (5, 2, 'Japanese', 'default2', 'unique_9', 101, -1, 0, -1, 99, NULL, 100, 100, 'default2', 'default1', 'default1', 'Japanese', '2023-01-02', 100, 100, 'default2'), (6, 99, 'default1', 'Japanese', 'unique_10', 0, 99, 0, -1, 99, 'default1', 100, 99, 'Japanese', NULL, 'Japanese', NULL, '2023-01-02', NULL, -1, 'Japanese'), (7, 1, NULL, 'default1', 'unique_11', 2, 0, 101, 2, -1, NULL, 101, NULL, 'Japanese', 'default2', 'default2', NULL, '2023-01-01', 0, 99, NULL), (8, -1, NULL, 'default1', 'unique_12', 100, 2, 100, 1, -1, 'default2', 0, 2, 'Japanese', 'Japanese', NULL, 'default2', '2023-01-02', NULL, 2, 'default1'), (9, 2, 'Japanese', 'default1', 'unique_13', 100, 100, 100, 0, 2, NULL, NULL, 2, NULL, 'default1', 'Japanese', 'default1', '2023-01-01', 101, 101, 'default2'), (10, 101, 'Japanese', 'Japanese', 'unique_14', 0, 2, -1, 0, 101, NULL, NULL, 99, NULL, 'default2', 'Japanese', 'default2', NULL, -1, 101, 'default1');
INSERT INTO set_translations (id, setcode, language, translation) VALUES (0, 'unique_4', 'Japanese', 'default2'), (-1, 'unique_6', 'default1', 'default2'), (2, 'Japanese', 'default1', 'default2'), (99, 'default1', 'Japanese', 'Japanese'), (101, 'default1', 'Japanese', NULL), (1, 'default2', 'default1', NULL), (100, 'unique_8', 'default2', 'default2'), (3, 'unique_7', NULL, NULL), (4, 'unique_12', NULL, NULL), (5, 'default2', 'Japanese', 'default1'), (6, 'unique_9', 'default1', 'Japanese'), (7, 'unique_11', 'default2', 'Japanese');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN isNonFoilOnly = 1 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(id) FROM sets WHERE code IN (SELECT setCode FROM set_translations WHERE language = 'Japanese');

/*
Gold Result:
(33.333333333333336,)
*/

-- Prediction Query
SELECT (SUM(CASE WHEN s.isNonFoilOnly = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS percentage FROM sets AS s JOIN set_translations AS st ON s.code = st.setCode WHERE st.language = 'Japanese';

/*
Prediction Result:
(25.0,)
*/