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
-- 1. DISTINCT keyword (duplicate manaCost for 'Ancestor''s Chosen').
-- 2. Column confusions for name (asciiName, faceName, flavorName) and manaCost (convertedManaCost, faceConvertedManaCost).
-- 3. String matching edge cases (case sensitivity, missing apostrophe, prefix/suffix, NULL name).
-- 4. Unnecessary INNER JOINs with child tables (by leaving foreign_data, legalities, rulings, sets empty).
INSERT INTO cards (id, uuid, name, asciiName, faceName, flavorName, manaCost, convertedManaCost, faceConvertedManaCost) VALUES
(1, 'uuid-1', 'Ancestor''s Chosen', 'Ancestor''s Chosen', 'Ancestor''s Chosen', 'Ancestor''s Chosen', '{5}{W}{W}', 7.0, 7.0),
(2, 'uuid-2', 'Ancestor''s Chosen', 'Ancestor''s Chosen', 'Ancestor''s Chosen', 'Ancestor''s Chosen', '{5}{W}{W}', 7.0, 7.0),
(3, 'uuid-3', 'Other Card', 'Ancestor''s Chosen', 'Ancestor''s Chosen', 'Ancestor''s Chosen', '{1}{U}', 2.0, 2.0),
(4, 'uuid-4', 'Ancestors Chosen', 'Ancestors Chosen', 'Ancestors Chosen', 'Ancestors Chosen', '{2}{B}', 3.0, 3.0),
(5, 'uuid-5', 'ancestor''s chosen', 'ancestor''s chosen', 'ancestor''s chosen', 'ancestor''s chosen', '{3}{R}', 4.0, 4.0),
(6, 'uuid-6', 'Ancestor''s Chosen One', 'Ancestor''s Chosen One', 'Ancestor''s Chosen One', 'Ancestor''s Chosen One', '{4}{G}', 5.0, 5.0),
(7, 'uuid-7', NULL, 'Ancestor''s Chosen', 'Ancestor''s Chosen', 'Ancestor''s Chosen', '{X}', 0.0, 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT manaCost FROM cards WHERE name = 'Ancestor''s Chosen';

/*
Gold Result:
('{5}{W}{W}',)
*/

-- Prediction Query
SELECT manaCost FROM cards WHERE name = "Ancestor's Chosen";

/*
Prediction Result:
('{5}{W}{W}',)
('{5}{W}{W}',)
*/