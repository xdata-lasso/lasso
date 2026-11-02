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
-- Tests basic WHERE conditions (rarity='mythic', originalReleaseDate IS NOT NULL, status='Legal') and basic ASC ordering on originalReleaseDate.
-- Includes decoy rows that have earlier dates (or NULL dates) to ensure mutants dropping predicates fail.
INSERT INTO "cards" (id, uuid, rarity, originalReleaseDate) VALUES (1, 'u_rare_early', 'rare', '2000-01-01');
INSERT INTO "cards" (id, uuid, rarity, originalReleaseDate) VALUES (2, 'u_mythic_null_date', 'mythic', NULL);
INSERT INTO "cards" (id, uuid, rarity, originalReleaseDate) VALUES (3, 'u_mythic_banned_early', 'mythic', '2005-01-01');
INSERT INTO "cards" (id, uuid, rarity, originalReleaseDate) VALUES (4, 'u_mythic_valid_late', 'mythic', '2015-01-01');
INSERT INTO "cards" (id, uuid, rarity, originalReleaseDate) VALUES (5, 'u_mythic_valid_early', 'mythic', '2010-01-01');
INSERT INTO "legalities" (id, uuid, format, status) VALUES (1, 'u_rare_early', 'standard', 'Legal');
INSERT INTO "legalities" (id, uuid, format, status) VALUES (2, 'u_mythic_null_date', 'pioneer', 'Legal');
INSERT INTO "legalities" (id, uuid, format, status) VALUES (3, 'u_mythic_banned_early', 'modern', 'Banned');
INSERT INTO "legalities" (id, uuid, format, status) VALUES (4, 'u_mythic_valid_late', 'legacy', 'Legal');
INSERT INTO "legalities" (id, uuid, format, status) VALUES (5, 'u_mythic_valid_early', 'vintage', 'Legal');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.originalReleaseDate, T2.format FROM cards AS T1 INNER JOIN legalities AS T2 ON T1.uuid = T2.uuid WHERE T1.rarity = 'mythic' AND NOT T1.originalReleaseDate IS NULL AND T2.status = 'Legal' ORDER BY T1.originalReleaseDate, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Gold Result:
('2010-01-01', 'vintage')
*/

-- Prediction Query
SELECT c.originalReleaseDate, l.format FROM cards AS c INNER JOIN legalities AS l ON c.uuid = l.uuid WHERE c.rarity = 'mythic' ORDER BY c.originalReleaseDate ASC, c.id NULLS LAST, l.id NULLS LAST LIMIT 1;

/*
Prediction Result:
(None, 'pioneer')
*/