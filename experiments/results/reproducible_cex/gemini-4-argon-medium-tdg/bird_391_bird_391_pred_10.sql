-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
-- Tests:
-- 1. AND vs OR in WHERE clause (one card has originalType='Artifact' only, another has colors='B' only).
-- 2. Exact match vs LIKE / substring match on originalType ('Artifact Creature') and colors ('B, R', 'UB').
-- 3. NULL handling in originalType and colors.
INSERT INTO cards (id, uuid, name, originalType, colors) VALUES (1, 'uuid-1', 'Only Artifact', 'Artifact', 'W');
INSERT INTO cards (id, uuid, name, originalType, colors) VALUES (2, 'uuid-2', 'Only Black', 'Enchantment', 'B');
INSERT INTO cards (id, uuid, name, originalType, colors) VALUES (3, 'uuid-3', 'Substring Trap 1', 'Artifact Creature', 'B');
INSERT INTO cards (id, uuid, name, originalType, colors) VALUES (4, 'uuid-4', 'Substring Trap 2', 'Artifact', 'B, R');
INSERT INTO cards (id, uuid, name, originalType, colors) VALUES (5, 'uuid-5', 'Null Trap 1', NULL, 'B');
INSERT INTO cards (id, uuid, name, originalType, colors) VALUES (6, 'uuid-6', 'Null Trap 2', 'Artifact', NULL);
INSERT INTO cards (id, uuid, name, originalType, colors) VALUES (7, 'uuid-7', 'True Match', 'Artifact', 'B');
INSERT INTO foreign_data (id, uuid, name, language) VALUES (1, 'uuid-1', 'FD 1', 'German');
INSERT INTO foreign_data (id, uuid, name, language) VALUES (2, 'uuid-2', 'FD 2', 'German');
INSERT INTO foreign_data (id, uuid, name, language) VALUES (3, 'uuid-3', 'FD 3', 'German');
INSERT INTO foreign_data (id, uuid, name, language) VALUES (4, 'uuid-4', 'FD 4', 'German');
INSERT INTO foreign_data (id, uuid, name, language) VALUES (5, 'uuid-5', 'FD 5', 'German');
INSERT INTO foreign_data (id, uuid, name, language) VALUES (6, 'uuid-6', 'FD 6', 'German');
INSERT INTO foreign_data (id, uuid, name, language) VALUES (7, 'uuid-7', 'FD 7', 'German');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.name FROM cards AS T1 INNER JOIN foreign_data AS T2 ON T1.uuid = T2.uuid WHERE T1.originalType = 'Artifact' AND T1.colors = 'B';

/*
Gold Result:
('True Match',)
*/

-- Prediction Query
SELECT DISTINCT T1.name FROM cards AS T1 INNER JOIN foreign_data AS T2 ON T1.uuid = T2.uuid WHERE T1.originalType = 'Artifact' AND T1.colors LIKE '%B%' AND NOT T2.language IS NULL;

/*
Prediction Result:
('Substring Trap 2',)
('True Match',)
*/