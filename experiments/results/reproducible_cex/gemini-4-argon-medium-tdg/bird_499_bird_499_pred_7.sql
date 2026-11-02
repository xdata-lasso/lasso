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
-- Tests:
-- 1. DISTINCT on T2.translation vs COUNT(*) or COUNT(T2.translation) (duplicate translations for the same set)
-- 2. NULL handling in T2.translation (ensuring NULLs are not counted by COUNT(*) or IS NULL mutants)
-- 3. Filtering on T1.name = 'Salvat 2011' (other sets, substrings like 'Salvat 2011 Extra', case sensitivity, NULL name)
-- 4. JOIN condition T2.setCode = T1.code vs cross join or wrong join columns (e.g., T1.id = T2.id)
INSERT INTO sets (id, code, name) VALUES (1, 'S11', 'Salvat 2011');
INSERT INTO sets (id, code, name) VALUES (2, 'S05', 'Salvat 2005');
INSERT INTO sets (id, code, name) VALUES (3, 'S11X', 'Salvat 2011 Extra');
INSERT INTO sets (id, code, name) VALUES (4, 'S11L', 'salvat 2011');
INSERT INTO sets (id, code, name) VALUES (5, 'NUL', NULL);
INSERT INTO set_translations (id, language, setCode, translation) VALUES (10, 'French', 'S11', 'Salvat 2011 FR');
INSERT INTO set_translations (id, language, setCode, translation) VALUES (11, 'Canadian French', 'S11', 'Salvat 2011 FR');
INSERT INTO set_translations (id, language, setCode, translation) VALUES (12, 'Spanish', 'S11', 'Salvat 2011 ES');
INSERT INTO set_translations (id, language, setCode, translation) VALUES (13, 'German', 'S11', NULL);
INSERT INTO set_translations (id, language, setCode, translation) VALUES (1, 'Italian', 'S05', 'Salvat 2005 IT');
INSERT INTO set_translations (id, language, setCode, translation) VALUES (2, 'Spanish', 'S05', 'Salvat 2005 ES');
INSERT INTO set_translations (id, language, setCode, translation) VALUES (3, 'French', 'S11X', 'Salvat 2011 Extra FR');
INSERT INTO set_translations (id, language, setCode, translation) VALUES (4, 'French', 'S11L', 'salvat 2011 fr');
INSERT INTO set_translations (id, language, setCode, translation) VALUES (5, 'French', 'NUL', 'Null Set FR');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T2.translation) FROM sets AS T1 INNER JOIN set_translations AS T2 ON T2.setCode = T1.code WHERE T1.name = 'Salvat 2011' AND NOT T2.translation IS NULL;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(T2.translation) FROM sets AS T1 INNER JOIN set_translations AS T2 ON T1.code = T2.setCode WHERE T1.name = 'Tenth Edition';

/*
Prediction Result:
(0,)
*/