-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO sets (id, basesetsize, block, booster, code, isfoilonly, isforeignonly, isnonfoilonly, isonlineonly, ispartialpreview, keyrunecode, mcmid, mcmidextras, mcmname, mtgocode, name, parentcode, releasedate, tcgplayergroupid, totalsetsize, type) VALUES (11, NULL, NULL, 'default2', 'Italian', 11, 1, 99, 10, 100, 'default2', 1, 0, 'default2', 'Italian', 'default2', 'default2', NULL, 10, 10, 'Italian'), (1, 10, 'Italian', 'default2', 'default1', 1, 101, 1, 100, 100, 'default1', 10, 9, NULL, 'default2', 'Italian', 'Italian', '2023-01-01', 9, 101, 'default2'), (101, 9, 'default1', 'default2', 'default2', 100, 99, 10, 11, 1, NULL, 101, 10, NULL, 'default1', NULL, 'default1', '2023-01-01', 0, 11, NULL), (100, 0, 'Italian', 'default1', 'unique_3', 10, 10, 0, 1, 1, NULL, 101, 10, 'Italian', NULL, 'default1', 'default2', '2023-01-02', 10, NULL, 'Italian'), (10, 99, 'Italian', 'default1', 'unique_4', 9, 9, 100, 9, 9, 'default2', 0, NULL, 'default2', 'default1', 'Italian', NULL, '2023-01-02', 0, 11, 'Italian');
INSERT INTO set_translations (id, setcode, language, translation) VALUES (9, 'unique_3', 'default1', NULL), (10, 'Italian', 'Italian', 'default1'), (1, 'unique_4', 'default2', 'default1'), (101, 'unique_3', 'default1', 'Italian'), (0, 'default2', 'default2', 'default2'), (11, 'Italian', 'default2', 'default1'), (100, 'default1', 'Italian', 'default1'), (99, 'unique_3', 'default1', 'Italian'), (2, 'unique_4', 'default1', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.id) FROM sets AS T1 INNER JOIN set_translations AS T2 ON T2.setCode = T1.code WHERE NOT T2.translation IS NULL AND T1.baseSetSize < 10 AND T2.language = 'Italian';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(*) FROM sets AS T1 JOIN set_translations AS T2 ON T1.code = T2.setCode WHERE T2.language LIKE 'Italian' AND T1.baseSetSize < 100;

/*
Prediction Result:
(1,)
*/