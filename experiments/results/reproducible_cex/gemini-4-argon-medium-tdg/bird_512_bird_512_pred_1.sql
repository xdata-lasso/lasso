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
-- Comprehensive dataset testing WHERE clause boundaries, CASE conditions, wildcards, NULLs, and joins
INSERT INTO sets (id, code, name) VALUES (1, 'SET1', 'Set One');
-- Matches WHERE (hasFoil=0, duelDeck='a') and CASE via power = '*' (exact)
INSERT INTO cards (id, uuid, setCode, hasFoil, duelDeck, power) VALUES (1, 'u1', 'SET1', 0, 'a', '*');
-- Matches WHERE (hasFoil=0, duelDeck='a') and CASE via power = '1+*' (suffix wildcard)
INSERT INTO cards (id, uuid, setCode, hasFoil, duelDeck, power) VALUES (2, 'u2', 'SET1', 0, 'a', '1+*');
-- Matches WHERE (hasFoil=0, duelDeck='a') and CASE via power = '*2' (prefix wildcard)
INSERT INTO cards (id, uuid, setCode, hasFoil, duelDeck, power) VALUES (3, 'u3', 'SET1', 0, 'a', '*2');
-- Matches WHERE (hasFoil=0, duelDeck='a') and CASE via power = '2*3' (infix wildcard)
INSERT INTO cards (id, uuid, setCode, hasFoil, duelDeck, power) VALUES (4, 'u4', 'SET1', 0, 'a', '2*3');
-- Matches WHERE (hasFoil=0, duelDeck='a') and CASE via power IS NULL
INSERT INTO cards (id, uuid, setCode, hasFoil, duelDeck, power) VALUES (5, 'u5', 'SET1', 0, 'a', NULL);
-- Matches WHERE (hasFoil=0, duelDeck='a'), fails CASE (numeric string power)
INSERT INTO cards (id, uuid, setCode, hasFoil, duelDeck, power) VALUES (6, 'u6', 'SET1', 0, 'a', '4');
-- Matches WHERE (hasFoil=0, duelDeck='a'), fails CASE (empty string vs NULL)
INSERT INTO cards (id, uuid, setCode, hasFoil, duelDeck, power) VALUES (7, 'u7', 'SET1', 0, 'a', '');
-- Fails WHERE (hasFoil=1), would match CASE
INSERT INTO cards (id, uuid, setCode, hasFoil, duelDeck, power) VALUES (8, 'u8', 'SET1', 1, 'a', '*');
INSERT INTO cards (id, uuid, setCode, hasFoil, duelDeck, power) VALUES (9, 'u9', 'SET1', 1, 'a', NULL);
-- Fails WHERE (duelDeck='b'), would match CASE
INSERT INTO cards (id, uuid, setCode, hasFoil, duelDeck, power) VALUES (10, 'u10', 'SET1', 0, 'b', '1+*');
INSERT INTO cards (id, uuid, setCode, hasFoil, duelDeck, power) VALUES (11, 'u11', 'SET1', 0, 'b', NULL);
-- Fails WHERE (duelDeck='A' case sensitivity), would match CASE
INSERT INTO cards (id, uuid, setCode, hasFoil, duelDeck, power) VALUES (12, 'u12', 'SET1', 0, 'A', '*');
-- Fails WHERE (duelDeck IS NULL), would match CASE
INSERT INTO cards (id, uuid, setCode, hasFoil, duelDeck, power) VALUES (13, 'u13', 'SET1', 0, NULL, '*');
-- Child rows with multiple entries per card to kill unnecessary JOINs that multiply rows
INSERT INTO rulings (id, date, text, uuid) VALUES (1, '2020-01-01', 'Ruling 1', 'u1');
INSERT INTO rulings (id, date, text, uuid) VALUES (2, '2020-01-02', 'Ruling 2', 'u1');
INSERT INTO foreign_data (id, language, name, uuid) VALUES (1, 'German', 'Name 1', 'u1');
INSERT INTO foreign_data (id, language, name, uuid) VALUES (2, 'French', 'Name 2', 'u1');
INSERT INTO legalities (id, format, status, uuid) VALUES (1, 'Standard', 'Legal', 'u1');
INSERT INTO legalities (id, format, status, uuid) VALUES (2, 'Modern', 'Legal', 'u1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(CASE WHEN power LIKE '%*%' OR power IS NULL THEN 1 ELSE 0 END) FROM cards WHERE hasFoil = 0 AND duelDeck = 'a';

/*
Gold Result:
(5,)
*/

-- Prediction Query
SELECT COUNT(id) FROM cards WHERE (power IS NULL OR power = '*') AND hasFoil = 0 AND duelDeck = 'a';

/*
Prediction Result:
(2,)
*/