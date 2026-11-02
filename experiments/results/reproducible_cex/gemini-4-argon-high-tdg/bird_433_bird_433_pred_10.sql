-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO sets (id, code, name, isOnlineOnly, isFoilOnly, isForeignOnly, isNonFoilOnly, isPartialPreview, parentCode, mtgoCode, keyruneCode) VALUES (10, 'SET_A', 'Set Alpha', 1, 0, 0, 0, 0, 'SET_B', 'SET_B', 'SET_B');
INSERT INTO sets (id, code, name, isOnlineOnly, isFoilOnly, isForeignOnly, isNonFoilOnly, isPartialPreview, parentCode, mtgoCode, keyruneCode) VALUES (20, 'SET_B', 'Set Beta', 1, 0, 0, 0, 0, 'SET_C', 'SET_C', 'SET_C');
INSERT INTO sets (id, code, name, isOnlineOnly, isFoilOnly, isForeignOnly, isNonFoilOnly, isPartialPreview, parentCode, mtgoCode, keyruneCode) VALUES (30, 'SET_C', 'Set Gamma', 0, 1, 1, 1, 1, 'SET_A', 'SET_A', 'SET_A');
INSERT INTO sets (id, code, name, isOnlineOnly, isFoilOnly, isForeignOnly, isNonFoilOnly, isPartialPreview, parentCode, mtgoCode, keyruneCode) VALUES (40, 'SET_D', 'Set Delta', 0, 1, 1, 1, 1, 'SET_A', 'SET_A', 'SET_A');
INSERT INTO sets (id, code, name, isOnlineOnly, isFoilOnly, isForeignOnly, isNonFoilOnly, isPartialPreview, parentCode, mtgoCode, keyruneCode) VALUES (50, 'SET_E', 'Set Epsilon', 1, 0, 0, 0, 0, NULL, NULL, NULL);
INSERT INTO sets (id, code, name, isOnlineOnly, isFoilOnly, isForeignOnly, isNonFoilOnly, isPartialPreview, parentCode, mtgoCode, keyruneCode) VALUES (60, 'SET_F', 'Set Zeta', 0, 0, 0, 0, 0, NULL, NULL, NULL);
INSERT INTO set_translations (id, language, setCode, translation) VALUES (1, 'Chinese Simplified', 'SET_A', 'Alpha CS');
INSERT INTO set_translations (id, language, setCode, translation) VALUES (2, 'Chinese Traditional', 'SET_A', 'Alpha CT');
INSERT INTO set_translations (id, language, setCode, translation) VALUES (3, 'Chinese Simplified', 'SET_B', 'Beta CS');
INSERT INTO set_translations (id, language, setCode, translation) VALUES (4, 'Chinese Simplified', 'SET_C', 'Gamma CS');
INSERT INTO set_translations (id, language, setCode, translation) VALUES (5, 'French', 'SET_C', NULL);
INSERT INTO set_translations (id, language, setCode, translation) VALUES (6, 'Chinese Simplified', 'SET_D', 'Delta CS');
INSERT INTO set_translations (id, language, setCode, translation) VALUES (7, NULL, 'SET_D', NULL);
INSERT INTO set_translations (id, language, setCode, translation) VALUES (8, 'Chinese Simplified', NULL, 'Orphan CS');
INSERT INTO cards (id, uuid, name, setCode, isOnlineOnly) VALUES (1, 'uuid-1', 'Card One', 'SET_A', 1);
INSERT INTO cards (id, uuid, name, setCode, isOnlineOnly) VALUES (2, 'uuid-2', 'Card Two', 'SET_C', 1);
INSERT INTO foreign_data (id, language, name, uuid) VALUES (1, 'Chinese Simplified', 'Card One CS', 'uuid-1');
INSERT INTO foreign_data (id, language, name, uuid) VALUES (2, 'Chinese Simplified', 'Card Two CS', 'uuid-2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN T2.language = 'Chinese Simplified' AND T1.isOnlineOnly = 1 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM sets AS T1 INNER JOIN set_translations AS T2 ON T1.code = T2.setCode;

/*
Gold Result:
(28.571428571428573,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T1.isOnlineOnly = 1 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM sets AS T1 INNER JOIN set_translations AS T2 ON T1.code = T2.setCode WHERE T2.language = 'Chinese Simplified';

/*
Prediction Result:
(50.0,)
*/