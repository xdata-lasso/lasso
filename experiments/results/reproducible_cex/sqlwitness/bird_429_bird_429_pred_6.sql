-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO sets (id, basesetsize, block, booster, code, isfoilonly, isforeignonly, isnonfoilonly, isonlineonly, ispartialpreview, keyrunecode, mcmid, mcmidextras, mcmname, mtgocode, name, parentcode, releasedate, tcgplayergroupid, totalsetsize, type) VALUES (1, 0, NULL, 'default1', 'default2', 0, 205, 1, 207, 1, 'default2', 206, 205, 'default2', 'default2', 'default1', NULL, NULL, 205, 1, 'default1'), (0, 207, NULL, NULL, 'default1', 207, 206, 1, 205, 0, 'default1', 0, NULL, 'default1', 'default1', 'default1', 'default2', '2023-01-01', 1, 1, 'default1'), (206, 1, 'default2', NULL, 'unique_2', 1, 1, 1, 1, 205, 'default2', NULL, 0, 'default1', NULL, 'default1', NULL, NULL, 205, 1, 'default1'), (205, 1, 'default2', NULL, 'unique_3', 206, 1, 0, 207, 206, 'default2', 207, NULL, 'default2', 'default2', 'default1', NULL, '2023-01-02', 206, 207, 'default2'), (207, 207, 'default2', 'default2', 'unique_4', 0, 1, 205, 206, 207, 'default1', 206, 206, 'default1', 'default1', 'default2', 'default1', '2023-01-01', NULL, NULL, 'default2'), (2, 1, 'default1', 'default1', 'unique_5', 0, 1, 0, 205, 206, NULL, NULL, 205, 'default1', NULL, NULL, 'default2', '2023-01-02', 205, 206, 'default2'), (3, 206, NULL, 'default2', 'unique_6', 1, 207, 207, 207, 207, NULL, 0, NULL, 'default2', 'default1', 'default2', 'default2', '2023-01-02', 205, NULL, NULL);
INSERT INTO set_translations (id, setcode, language, translation) VALUES (0, 'unique_2', 'default1', 'default2'), (205, 'unique_6', 'default2', 'default2'), (1, 'unique_3', NULL, 'default1'), (207, 'unique_5', 'default1', 'default1'), (206, 'unique_5', NULL, 'default1'), (2, 'unique_4', 'default2', NULL), (3, 'unique_6', NULL, NULL), (4, 'unique_3', 'default1', NULL), (5, 'unique_2', NULL, 'default1'), (6, 'default2', NULL, 'default1'), (7, 'unique_2', NULL, 'default1'), (8, 'default2', NULL, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.language, T1.type FROM sets AS T1 INNER JOIN set_translations AS T2 ON T1.code = T2.setCode WHERE T2.id = 206;

/*
Gold Result:
(None, 'default2')
*/

-- Prediction Query
SELECT T1.translation, T2.type FROM set_translations AS T1 INNER JOIN sets AS T2 ON T1.setCode = T2.code WHERE T1.id = 206;

/*
Prediction Result:
('default1', 'default2')
*/