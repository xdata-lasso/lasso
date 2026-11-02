-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO sets (id, basesetsize, block, booster, code, isfoilonly, isforeignonly, isnonfoilonly, isonlineonly, ispartialpreview, keyrunecode, mcmid, mcmidextras, mcmname, mtgocode, name, parentcode, releasedate, tcgplayergroupid, totalsetsize, type) VALUES (11, 11, NULL, 'Italian', 'default1', 9, 0, 0, 1, 1, 'default2', 10, 11, NULL, 'default1', NULL, 'default1', '2023-01-01', 9, 1, 'default1'), (1, 9, 'default1', 'default1', 'Italian', 9, 11, 9, 11, 10, 'Italian', 10, NULL, 'default2', 'default1', 'Italian', 'default2', NULL, 11, 1, NULL), (0, 1, 'Italian', 'Italian', 'default2', 0, 9, 9, 10, 1, 'default2', 1, 1, 'default1', 'Italian', 'default1', 'default1', NULL, NULL, 1, 'default1'), (10, 11, 'default2', NULL, 'unique_3', 10, 10, 10, 0, 10, 'default1', 0, 10, NULL, NULL, NULL, 'default1', '2023-01-02', 11, 11, 'Italian'), (9, 0, 'default2', 'Italian', 'unique_4', 11, 1, 1, 10, 10, 'default2', 10, 0, 'default1', 'default1', 'default2', 'default2', NULL, 11, 11, 'default2'), (2, 0, 'default1', 'default2', 'unique_5', 10, 1, 9, 11, 9, 'Italian', 1, 10, 'default2', 'default1', 'default1', 'default1', '2023-01-01', 1, NULL, 'default1'), (3, 0, 'Italian', 'default2', 'unique_6', 0, 0, 1, 9, 10, 'default2', NULL, NULL, 'default2', 'default1', 'Italian', NULL, '2023-01-01', 10, 0, 'default2'), (4, 1, 'Italian', 'default2', 'unique_7', 9, 0, 10, 9, 10, NULL, 1, 1, NULL, NULL, 'default1', 'default1', '2023-01-01', NULL, 9, 'Italian'), (5, 1, 'Italian', 'Italian', 'unique_8', 10, 1, 1, 1, 9, NULL, 0, 9, NULL, 'Italian', 'default1', 'default2', '2023-01-01', NULL, 0, NULL), (6, 11, NULL, NULL, 'unique_9', 11, 11, 1, 0, 9, 'default1', 11, 0, 'default1', 'default1', 'default1', 'Italian', NULL, 0, 11, 'Italian'), (7, 10, NULL, 'default2', 'unique_10', 10, 0, 11, 1, 0, 'default1', 10, 9, NULL, 'default1', 'default1', 'Italian', NULL, 9, NULL, 'default2'), (8, 9, NULL, 'default1', 'unique_11', 9, 1, 0, 0, 9, 'Italian', 9, 11, 'default1', 'default1', 'default2', 'default2', NULL, 1, 9, NULL), (12, 11, 'default1', 'Italian', 'unique_12', 0, 9, 0, 0, 10, 'default2', 0, 0, 'Italian', 'Italian', 'default1', 'default2', NULL, 10, 11, 'default2'), (13, 0, 'Italian', NULL, 'unique_13', 1, 10, 0, 1, 9, 'Italian', 10, 0, 'default2', 'default2', NULL, 'Italian', NULL, 11, 10, 'Italian'), (14, 1, 'Italian', 'default2', 'unique_14', 1, 11, 0, 10, 11, 'Italian', 1, 11, 'default2', 'default2', NULL, 'default2', NULL, 9, 1, NULL);
INSERT INTO set_translations (id, setcode, language, translation) VALUES (1, 'unique_4', 'Italian', 'Italian'), (0, 'unique_12', 'default2', NULL), (10, NULL, NULL, 'default2'), (11, 'unique_14', 'Italian', NULL), (9, 'unique_13', 'default1', NULL), (2, 'default1', 'default2', 'default1'), (3, 'unique_13', 'default2', 'Italian'), (4, 'Italian', 'default2', NULL), (5, 'unique_5', 'default1', 'default2'), (6, 'default1', 'default2', 'default1'), (7, 'Italian', NULL, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.id) FROM sets AS T1 INNER JOIN set_translations AS T2 ON T2.setCode = T1.code WHERE NOT T2.translation IS NULL AND T1.baseSetSize < 10 AND T2.language = 'Italian';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(T2.setCode) FROM sets AS T1 INNER JOIN set_translations AS T2 ON T1.code = T2.setCode WHERE T2.language = 'Italian' AND T1.baseSetSize < 10;

/*
Prediction Result:
(2,)
*/