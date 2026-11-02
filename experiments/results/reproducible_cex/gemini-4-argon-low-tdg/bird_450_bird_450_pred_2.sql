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
-- Comprehensive truth table for the 3 conditions (artist, cardKingdomFoilId, cardKingdomId) + duplicates + case sensitivity + substring checks.
-- Expected result: 2
INSERT INTO "cards" ("id", "artist", "cardKingdomFoilId", "cardKingdomId", "uuid") VALUES (1, 'Aaron Miller', '100', '200', 'uuid-1');
INSERT INTO "cards" ("id", "artist", "cardKingdomFoilId", "cardKingdomId", "uuid") VALUES (2, 'Aaron Miller', '100', '200', 'uuid-2');
INSERT INTO "cards" ("id", "artist", "cardKingdomFoilId", "cardKingdomId", "uuid") VALUES (3, 'Aaron Miller', NULL, '201', 'uuid-3');
INSERT INTO "cards" ("id", "artist", "cardKingdomFoilId", "cardKingdomId", "uuid") VALUES (4, 'Aaron Miller', '102', NULL, 'uuid-4');
INSERT INTO "cards" ("id", "artist", "cardKingdomFoilId", "cardKingdomId", "uuid") VALUES (5, 'Aaron Miller', NULL, NULL, 'uuid-5');
INSERT INTO "cards" ("id", "artist", "cardKingdomFoilId", "cardKingdomId", "uuid") VALUES (6, 'John Avon', '103', '203', 'uuid-6');
INSERT INTO "cards" ("id", "artist", "cardKingdomFoilId", "cardKingdomId", "uuid") VALUES (7, 'aaron miller', '104', '204', 'uuid-7');
INSERT INTO "cards" ("id", "artist", "cardKingdomFoilId", "cardKingdomId", "uuid") VALUES (8, 'Aaron Miller Jr.', '105', '205', 'uuid-8');
INSERT INTO "cards" ("id", "artist", "cardKingdomFoilId", "cardKingdomId", "uuid") VALUES (9, NULL, '106', '206', 'uuid-9');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(CASE WHEN artist = 'Aaron Miller' AND NOT cardKingdomFoilId IS NULL AND NOT cardKingdomId IS NULL THEN 1 ELSE 0 END) FROM cards;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(id) FROM cards WHERE artist = 'Aaron Miller' AND cardKingdomFoilId = cardKingdomId AND NOT cardKingdomId IS NULL;

/*
Prediction Result:
(0,)
*/