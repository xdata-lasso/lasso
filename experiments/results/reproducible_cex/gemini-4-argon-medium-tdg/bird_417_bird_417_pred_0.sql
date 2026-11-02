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
-- General comprehensive dataset testing:
-- 1. Floating-point division vs integer division (1 Japanese out of 4 joined expansion rows = 25.0, or 1 out of 3 = 33.333...)
-- 2. COUNT(T1.id) vs COUNT(DISTINCT T1.id) (one expansion set has multiple translations)
-- 3. INNER JOIN vs LEFT JOIN (an expansion set with no translations at all)
-- 4. WHERE T1.type = 'expansion' filter (non-expansion sets with Japanese and non-Japanese translations, plus NULL type)
-- 5. T2.language = 'Japanese' case sensitivity and NULL handling
-- 6. Confusion with foreign_data table (cards and foreign_data populated with misleading language counts)
INSERT INTO sets (id, code, name, type) VALUES (1, 'EXP1', 'Expansion One', 'expansion');
INSERT INTO sets (id, code, name, type) VALUES (2, 'EXP2', 'Expansion Two', 'expansion');
INSERT INTO sets (id, code, name, type) VALUES (3, 'EXP3_NO_TR', 'Expansion Three No Translation', 'expansion');
INSERT INTO sets (id, code, name, type) VALUES (4, 'CORE1', 'Core Set One', 'core');
INSERT INTO sets (id, code, name, type) VALUES (5, 'NULL_TYPE', 'Null Type Set', NULL);
-- EXP1 has 2 translations (1 Japanese, 1 French) -> tests COUNT(T1.id) vs COUNT(DISTINCT T1.id)
INSERT INTO set_translations (id, language, setCode, translation) VALUES (1, 'Japanese', 'EXP1', 'JP_EXP1');
INSERT INTO set_translations (id, language, setCode, translation) VALUES (2, 'French', 'EXP1', 'FR_EXP1');
-- EXP2 has 1 translation (German) and 1 NULL language -> total joined expansion rows = 3 (or 4 with NULL)
INSERT INTO set_translations (id, language, setCode, translation) VALUES (3, 'German', 'EXP2', 'DE_EXP2');
INSERT INTO set_translations (id, language, setCode, translation) VALUES (4, NULL, 'EXP2', 'NULL_EXP2');
-- CORE1 (non-expansion) has Japanese translations -> tests WHERE T1.type = 'expansion'
INSERT INTO set_translations (id, language, setCode, translation) VALUES (5, 'Japanese', 'CORE1', 'JP_CORE1');
INSERT INTO set_translations (id, language, setCode, translation) VALUES (6, 'Japanese', 'CORE1', 'JP_CORE1_ALT');
-- NULL_TYPE has Japanese translation -> tests NULL handling in WHERE T1.type = 'expansion'
INSERT INTO set_translations (id, language, setCode, translation) VALUES (7, 'Japanese', 'NULL_TYPE', 'JP_NULL');
-- Distractor rows in cards and foreign_data to kill mutants querying foreign_data instead of set_translations
INSERT INTO cards (id, uuid, name, setCode) VALUES (1, 'uuid-1', 'Card 1', 'EXP1');
INSERT INTO foreign_data (id, language, name, uuid) VALUES (1, 'Japanese', 'JP Card 1', 'uuid-1');
INSERT INTO foreign_data (id, language, name, uuid) VALUES (2, 'Japanese', 'JP Card 2', 'uuid-1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN T2.language = 'Japanese' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.id) FROM sets AS T1 INNER JOIN set_translations AS T2 ON T1.code = T2.setCode WHERE T1.type = 'expansion';

/*
Gold Result:
(25.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T1.language = 'Japanese' AND T2.type = 'expansion' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.language) FROM set_translations AS T1 INNER JOIN sets AS T2 ON T1.setCode = T2.code;

/*
Prediction Result:
(16.666666666666668,)
*/