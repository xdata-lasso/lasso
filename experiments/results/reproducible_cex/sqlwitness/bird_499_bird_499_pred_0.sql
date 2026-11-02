-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO sets (id, basesetsize, block, booster, code, isfoilonly, isforeignonly, isnonfoilonly, isonlineonly, ispartialpreview, keyrunecode, mcmid, mcmidextras, mcmname, mtgocode, name, parentcode, releasedate, tcgplayergroupid, totalsetsize, type) VALUES (0, 1, NULL, 'Salvat 2011', 'default2', 1, 0, 0, 0, 0, 'Salvat 2011', 1, NULL, NULL, NULL, 'default2', NULL, '2023-01-02', NULL, NULL, 'Salvat 2011'), (1, 0, 'Salvat 2011', 'default2', 'Salvat 2011', 0, 0, 0, 1, 1, 'default2', NULL, 0, 'Salvat 2011', 'Salvat 2011', NULL, NULL, '2023-01-02', 0, NULL, NULL), (2, 1, 'Salvat 2011', NULL, 'default1', 1, 1, 1, 1, 0, 'default1', 0, 0, 'Salvat 2011', NULL, 'Salvat 2011', 'Salvat 2011', NULL, 0, 0, 'default1'), (3, NULL, 'Salvat 2011', 'default2', 'unique_3', 1, 0, 0, 1, 0, 'default1', 0, 0, 'default1', 'default2', 'Salvat 2011', 'default1', '2023-01-01', 1, 1, 'Salvat 2011'), (4, 1, NULL, 'default2', 'unique_4', 0, 0, 0, 1, 1, 'Salvat 2011', 1, 0, 'default2', NULL, 'Salvat 2011', 'Salvat 2011', '2023-01-01', 0, 0, 'default1'), (5, NULL, 'default1', 'default2', 'unique_5', 0, 1, 0, 1, 0, NULL, 1, 1, 'default1', 'Salvat 2011', 'default2', 'default1', '2023-01-02', 0, 1, 'default1'), (6, 1, NULL, 'default1', 'unique_6', 1, 1, 0, 0, 0, NULL, 0, 1, NULL, 'Salvat 2011', 'default1', 'default2', NULL, NULL, 1, 'Salvat 2011'), (7, 0, 'Salvat 2011', 'Salvat 2011', 'unique_7', 1, 0, 0, 1, 0, 'Salvat 2011', NULL, 1, 'default1', 'Salvat 2011', 'default2', 'default2', '2023-01-01', 0, 1, 'Salvat 2011'), (8, 1, 'default1', NULL, 'unique_8', 0, 1, 0, 0, 1, 'Salvat 2011', 0, 1, 'Salvat 2011', 'default2', 'default1', NULL, NULL, NULL, 1, NULL), (9, 1, 'default1', 'default2', 'unique_9', 1, 1, 1, 1, 1, 'default1', NULL, NULL, 'default2', 'default2', NULL, 'default1', '2023-01-01', 0, 0, 'default2'), (10, 0, 'default1', 'Salvat 2011', 'unique_10', 0, 1, 0, 1, 0, 'default2', 1, 1, 'default1', 'Salvat 2011', 'default2', 'default2', NULL, 1, NULL, NULL), (11, NULL, 'default2', NULL, 'unique_11', 0, 0, 0, 1, 0, 'Salvat 2011', 1, 1, 'Salvat 2011', 'default1', 'default2', 'default2', '2023-01-02', 1, NULL, 'default2'), (12, 1, 'Salvat 2011', NULL, 'unique_12', 0, 1, 0, 1, 1, 'Salvat 2011', 0, NULL, 'default2', 'default2', NULL, NULL, '2023-01-02', 0, 1, 'default2'), (13, 1, 'Salvat 2011', 'Salvat 2011', 'unique_13', 1, 0, 1, 0, 0, 'default2', 0, 1, NULL, 'Salvat 2011', 'Salvat 2011', 'default1', '2023-01-01', 0, 0, 'default2'), (14, 1, NULL, 'default1', 'unique_14', 0, 0, 0, 0, 1, 'Salvat 2011', NULL, NULL, 'default1', 'default1', 'default1', NULL, '2023-01-02', 1, 0, NULL), (15, 0, 'Salvat 2011', NULL, 'unique_15', 1, 0, 1, 0, 0, NULL, NULL, NULL, 'Salvat 2011', 'Salvat 2011', 'default1', 'default2', NULL, 0, 0, NULL);
INSERT INTO set_translations (id, setcode, language, translation) VALUES (1, 'unique_14', 'default2', 'Salvat 2011'), (0, 'unique_12', 'default2', 'default2'), (2, 'Salvat 2011', 'default2', 'default1'), (3, 'unique_8', 'default1', 'default2'), (4, 'unique_8', 'default1', NULL), (5, 'unique_13', 'default2', 'default2'), (6, 'Salvat 2011', 'default2', NULL), (7, 'unique_13', 'default1', 'default2'), (8, 'unique_8', 'Salvat 2011', NULL), (9, 'unique_5', 'Salvat 2011', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T2.translation) FROM sets AS T1 INNER JOIN set_translations AS T2 ON T2.setCode = T1.code WHERE T1.name = 'Salvat 2011' AND NOT T2.translation IS NULL;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(T1.translation) FROM set_translations AS T1 INNER JOIN sets AS T2 ON T1.setCode = T2.code WHERE T2.name = 'Salvat 2011' AND NOT T1.translation IS NULL;

/*
Prediction Result:
(2,)
*/