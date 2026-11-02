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
-- 1. Floating-point division vs integer division (1 out of 3 = 33.333... vs 33).
-- 2. IN subquery vs INNER JOIN (Set S1 has multiple 'Portuguese (Brazil)' translation rows; a JOIN without DISTINCT would duplicate S1 and skew the ratio to 2/4 = 50%).
-- 3. Filtering by language = 'Portuguese (Brazil)' vs other languages (e.g., 'Portuguese', 'Spanish') or no translations.
-- 4. Correct column usage (sets.isOnlineOnly vs sets.isFoilOnly / sets.isForeignOnly).
INSERT INTO "sets" ("id", "code", "isOnlineOnly", "isFoilOnly", "isForeignOnly") VALUES (1, 'S1', 1, 0, 0);
INSERT INTO "sets" ("id", "code", "isOnlineOnly", "isFoilOnly", "isForeignOnly") VALUES (2, 'S2', 0, 1, 1);
INSERT INTO "sets" ("id", "code", "isOnlineOnly", "isFoilOnly", "isForeignOnly") VALUES (3, 'S3', 0, 0, 0);
INSERT INTO "sets" ("id", "code", "isOnlineOnly", "isFoilOnly", "isForeignOnly") VALUES (4, 'S4', 1, 1, 1);
INSERT INTO "sets" ("id", "code", "isOnlineOnly", "isFoilOnly", "isForeignOnly") VALUES (5, 'S5', 1, 0, 0);
INSERT INTO "set_translations" ("id", "language", "setCode", "translation") VALUES (1, 'Portuguese (Brazil)', 'S1', 'Trans 1A');
INSERT INTO "set_translations" ("id", "language", "setCode", "translation") VALUES (2, 'Portuguese (Brazil)', 'S1', 'Trans 1B');
INSERT INTO "set_translations" ("id", "language", "setCode", "translation") VALUES (3, 'Portuguese (Brazil)', 'S2', 'Trans 2');
INSERT INTO "set_translations" ("id", "language", "setCode", "translation") VALUES (4, 'Portuguese (Brazil)', 'S3', 'Trans 3');
INSERT INTO "set_translations" ("id", "language", "setCode", "translation") VALUES (5, 'Portuguese', 'S4', 'Trans 4');
INSERT INTO "set_translations" ("id", "language", "setCode", "translation") VALUES (6, 'Spanish', 'S4', 'Trans 4 ES');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN isOnlineOnly = 1 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(id) FROM sets WHERE code IN (SELECT setCode FROM set_translations WHERE language = 'Portuguese (Brazil)');

/*
Gold Result:
(33.333333333333336,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T2.isOnlineOnly = 1 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM foreign_data AS T1 INNER JOIN cards AS T2 ON T1.uuid = T2.uuid WHERE T1.language = 'Portuguese (Brazil)';

/*
Prediction Result:
(None,)
*/