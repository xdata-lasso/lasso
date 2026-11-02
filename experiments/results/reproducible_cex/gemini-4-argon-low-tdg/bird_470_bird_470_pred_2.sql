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
-- 1. DISTINCT vs non-DISTINCT (multiple cards with 'Ancestor's Chosen' in the same set, and in different sets sharing the same releaseDate).
-- 2. WHERE filter on T1.name (exact match vs LIKE/prefix/case-insensitivity/other cards).
-- 3. Wrong column references (T1.originalReleaseDate vs T2.releaseDate, T1.asciiName/faceName vs T1.name, T2.name vs T1.name).
-- 4. Join conditions (INNER JOIN vs LEFT/RIGHT JOIN with unmatched cards and unmatched sets, or joining on id instead of code=setCode).
INSERT INTO sets (id, code, name, releaseDate) VALUES (1, 'JUD', 'Judgment', '2002-05-27');
INSERT INTO sets (id, code, name, releaseDate) VALUES (2, '10E', 'Tenth Edition', '2007-07-13');
INSERT INTO sets (id, code, name, releaseDate) VALUES (3, 'UMA', 'Ultimate Masters', '2007-07-13');
INSERT INTO sets (id, code, name, releaseDate) VALUES (4, 'UNM', 'Ancestor''s Chosen', '2020-01-01');
INSERT INTO sets (id, code, name, releaseDate) VALUES (5, 'OTH', 'Other Set', '1999-12-31');
INSERT INTO cards (id, uuid, name, asciiName, faceName, setCode, originalReleaseDate) VALUES (10, 'uuid-1', 'Ancestor''s Chosen', 'Ancestors Chosen', 'Other Face', 'JUD', '1990-01-01');
INSERT INTO cards (id, uuid, name, asciiName, faceName, setCode, originalReleaseDate) VALUES (11, 'uuid-2', 'Ancestor''s Chosen', 'Ancestors Chosen', 'Other Face', '10E', '1990-01-02');
INSERT INTO cards (id, uuid, name, asciiName, faceName, setCode, originalReleaseDate) VALUES (12, 'uuid-3', 'Ancestor''s Chosen', 'Ancestors Chosen', 'Other Face', '10E', '1990-01-03');
INSERT INTO cards (id, uuid, name, asciiName, faceName, setCode, originalReleaseDate) VALUES (13, 'uuid-4', 'Ancestor''s Chosen', 'Ancestors Chosen', 'Other Face', 'UMA', '1990-01-04');
INSERT INTO cards (id, uuid, name, asciiName, faceName, setCode, originalReleaseDate) VALUES (14, 'uuid-5', 'Ancestor''s Chosen', 'Ancestors Chosen', 'Other Face', 'MISSING_SET', '1990-01-05');
INSERT INTO cards (id, uuid, name, asciiName, faceName, setCode, originalReleaseDate) VALUES (15, 'uuid-6', 'Ancestor''s Chosen', 'Ancestors Chosen', 'Other Face', NULL, '1990-01-06');
INSERT INTO cards (id, uuid, name, asciiName, faceName, setCode, originalReleaseDate) VALUES (1, 'uuid-7', 'Not Ancestor''s Chosen', 'Ancestor''s Chosen', 'Ancestor''s Chosen', 'OTH', '1990-01-07');
INSERT INTO cards (id, uuid, name, asciiName, faceName, setCode, originalReleaseDate) VALUES (16, 'uuid-8', 'ancestor''s chosen', 'Ancestor''s Chosen', 'Ancestor''s Chosen', 'OTH', '1990-01-08');
INSERT INTO cards (id, uuid, name, asciiName, faceName, setCode, originalReleaseDate) VALUES (17, 'uuid-9', 'Ancestor''s Chosen Extra', 'Ancestor''s Chosen', 'Ancestor''s Chosen', 'OTH', '1990-01-09');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.releaseDate FROM cards AS T1 INNER JOIN sets AS T2 ON T2.code = T1.setCode WHERE T1.name = 'Ancestor''s Chosen';

/*
Gold Result:
('2002-05-27',)
('2007-07-13',)
*/

-- Prediction Query
SELECT "sets"."releasedate" FROM "cards" INNER JOIN "sets" ON "cards"."setcode" = "sets"."code" WHERE "cards"."name" = 'Ancestor''s Chosen';

/*
Prediction Result:
('2002-05-27',)
('2007-07-13',)
('2007-07-13',)
('2007-07-13',)
*/