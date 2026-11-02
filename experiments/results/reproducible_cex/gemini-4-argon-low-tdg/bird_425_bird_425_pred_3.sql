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
-- Core truth table for (subtypes = 'Angel,Wizard') AND (side IS NULL), plus string literal variations (spacing, ordering, case, superstrings, substrings) and NULL vs non-NULL variations for side.
INSERT INTO "cards" ("id", "subtypes", "side", "type", "types", "supertypes", "uuid") VALUES (1, 'Angel,Wizard', NULL, 'Creature — Angel Wizard', 'Creature', NULL, 'uuid-101');
INSERT INTO "cards" ("id", "subtypes", "side", "type", "types", "supertypes", "uuid") VALUES (2, 'Angel,Wizard', 'a', 'Creature — Angel Wizard', 'Creature', NULL, 'uuid-102');
INSERT INTO "cards" ("id", "subtypes", "side", "type", "types", "supertypes", "uuid") VALUES (3, 'Angel,Wizard', '', 'Creature — Angel Wizard', 'Creature', NULL, 'uuid-103');
INSERT INTO "cards" ("id", "subtypes", "side", "type", "types", "supertypes", "uuid") VALUES (4, 'Angel,Wizard', 'NULL', 'Creature — Angel Wizard', 'Creature', NULL, 'uuid-104');
INSERT INTO "cards" ("id", "subtypes", "side", "type", "types", "supertypes", "uuid") VALUES (5, 'Angel', NULL, 'Creature — Angel', 'Creature', NULL, 'uuid-105');
INSERT INTO "cards" ("id", "subtypes", "side", "type", "types", "supertypes", "uuid") VALUES (6, 'Wizard', NULL, 'Creature — Wizard', 'Creature', NULL, 'uuid-106');
INSERT INTO "cards" ("id", "subtypes", "side", "type", "types", "supertypes", "uuid") VALUES (7, 'Angel, Wizard', NULL, 'Creature — Angel Wizard', 'Creature', NULL, 'uuid-107');
INSERT INTO "cards" ("id", "subtypes", "side", "type", "types", "supertypes", "uuid") VALUES (8, 'Wizard,Angel', NULL, 'Creature — Wizard Angel', 'Creature', NULL, 'uuid-108');
INSERT INTO "cards" ("id", "subtypes", "side", "type", "types", "supertypes", "uuid") VALUES (9, 'angel,wizard', NULL, 'Creature — Angel Wizard', 'Creature', NULL, 'uuid-109');
INSERT INTO "cards" ("id", "subtypes", "side", "type", "types", "supertypes", "uuid") VALUES (10, 'Angel,Wizard,Warrior', NULL, 'Creature — Angel Wizard Warrior', 'Creature', NULL, 'uuid-110');
INSERT INTO "cards" ("id", "subtypes", "side", "type", "types", "supertypes", "uuid") VALUES (11, NULL, NULL, 'Creature', 'Creature', NULL, 'uuid-111');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id FROM cards WHERE subtypes = 'Angel,Wizard' AND side IS NULL;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT number FROM cards WHERE faceName IS NULL AND subtypes LIKE '%Angel%' AND subtypes LIKE '%Wizard%';

/*
Prediction Result:
(None,)
(None,)
(None,)
(None,)
(None,)
(None,)
(None,)
(None,)
*/