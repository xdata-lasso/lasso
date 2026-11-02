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
-- 1. All 4 combinations of NULL / NOT NULL for (cardKingdomFoilId, cardKingdomId) within 'Coldsnap' (catches AND vs OR, missing NOT, checking only one column).
-- 2. Floating-point division (2 out of 7 = 28.5714...%) vs integer division (200 / 7 = 28 or 2 / 7 = 0).
-- 3. Duplicate values in cardKingdomFoilId and cardKingdomId to catch COUNT(DISTINCT ...) mutants.
-- 4. Different id vs set.id to catch wrong join condition (e.g., T1.id = T2.id).
-- 5. Filtering by T2.name = 'Coldsnap' vs other set names or no WHERE clause.
-- 6. Unmatched cards (NULL or non-existent setCode) and unmatched sets to catch LEFT/RIGHT JOIN mutants.
INSERT INTO "sets" (id, code, name) VALUES (10, 'CSP', 'Coldsnap');
INSERT INTO "sets" (id, code, name) VALUES (20, 'ICE', 'Ice Age');
INSERT INTO "sets" (id, code, name) VALUES (30, 'EMPTY', 'Coldsnap');
INSERT INTO "cards" (id, uuid, setCode, cardKingdomFoilId, cardKingdomId) VALUES (1, 'uuid-1', 'CSP', 'F100', 'R100');
INSERT INTO "cards" (id, uuid, setCode, cardKingdomFoilId, cardKingdomId) VALUES (2, 'uuid-2', 'CSP', 'F100', 'R100');
INSERT INTO "cards" (id, uuid, setCode, cardKingdomFoilId, cardKingdomId) VALUES (3, 'uuid-3', 'CSP', 'F200', NULL);
INSERT INTO "cards" (id, uuid, setCode, cardKingdomFoilId, cardKingdomId) VALUES (4, 'uuid-4', 'CSP', 'F300', NULL);
INSERT INTO "cards" (id, uuid, setCode, cardKingdomFoilId, cardKingdomId) VALUES (5, 'uuid-5', 'CSP', NULL, 'R200');
INSERT INTO "cards" (id, uuid, setCode, cardKingdomFoilId, cardKingdomId) VALUES (6, 'uuid-6', 'CSP', NULL, NULL);
INSERT INTO "cards" (id, uuid, setCode, cardKingdomFoilId, cardKingdomId) VALUES (7, 'uuid-7', 'CSP', NULL, NULL);
INSERT INTO "cards" (id, uuid, setCode, cardKingdomFoilId, cardKingdomId) VALUES (10, 'uuid-10', 'ICE', 'F999', 'R999');
INSERT INTO "cards" (id, uuid, setCode, cardKingdomFoilId, cardKingdomId) VALUES (20, 'uuid-20', NULL, 'F888', 'R888');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN NOT T1.cardKingdomFoilId IS NULL AND NOT T1.cardKingdomId IS NULL THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.id) FROM cards AS T1 INNER JOIN sets AS T2 ON T2.code = T1.setCode WHERE T2.name = 'Coldsnap';

/*
Gold Result:
(28.571428571428573,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T1.cardKingdomFoilId = T1.cardKingdomId AND NOT T1.cardKingdomId IS NULL THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.name) FROM cards AS T1 INNER JOIN sets AS T2 ON T1.setCode = T2.code WHERE T2.name = 'Coldsnap';

/*
Prediction Result:
(None,)
*/