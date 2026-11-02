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
-- Tests basic positive cases (both LIKE '%*%' and IS NULL), negative power cases (normal number, empty string), boundary conditions for convertedManaCost (5, 5.5, 6, NULL), and set name filtering.
INSERT INTO sets (id, code, name) VALUES (1, 'CSP', 'Coldsnap');
INSERT INTO sets (id, code, name) VALUES (2, 'ICE', 'Ice Age');
-- Valid Coldsnap cards with convertedManaCost > 5 and matching power
INSERT INTO cards (id, uuid, setCode, convertedManaCost, power) VALUES (1, 'uuid-1', 'CSP', 6.0, '*');
INSERT INTO cards (id, uuid, setCode, convertedManaCost, power) VALUES (2, 'uuid-2', 'CSP', 7.0, '1+*');
INSERT INTO cards (id, uuid, setCode, convertedManaCost, power) VALUES (3, 'uuid-3', 'CSP', 5.5, '*+1');
INSERT INTO cards (id, uuid, setCode, convertedManaCost, power) VALUES (4, 'uuid-4', 'CSP', 8.0, '2*2');
INSERT INTO cards (id, uuid, setCode, convertedManaCost, power) VALUES (5, 'uuid-5', 'CSP', 6.0, NULL);
-- Valid Coldsnap cards with convertedManaCost > 5, but non-matching power (should contribute 0 to SUM, testing COUNT(*) vs SUM)
INSERT INTO cards (id, uuid, setCode, convertedManaCost, power) VALUES (6, 'uuid-6', 'CSP', 6.0, '4');
INSERT INTO cards (id, uuid, setCode, convertedManaCost, power) VALUES (7, 'uuid-7', 'CSP', 9.0, '');
-- Boundary conditions on convertedManaCost for Coldsnap (should be filtered out by WHERE)
INSERT INTO cards (id, uuid, setCode, convertedManaCost, power) VALUES (8, 'uuid-8', 'CSP', 5.0, '*');
INSERT INTO cards (id, uuid, setCode, convertedManaCost, power) VALUES (9, 'uuid-9', 'CSP', 5.0, NULL);
INSERT INTO cards (id, uuid, setCode, convertedManaCost, power) VALUES (10, 'uuid-10', 'CSP', 4.0, '*');
INSERT INTO cards (id, uuid, setCode, convertedManaCost, power) VALUES (11, 'uuid-11', 'CSP', NULL, '*');
-- Wrong set (Ice Age) with matching convertedManaCost and power (tests set name filter and JOIN condition)
INSERT INTO cards (id, uuid, setCode, convertedManaCost, power) VALUES (12, 'uuid-12', 'ICE', 6.0, '*');
INSERT INTO cards (id, uuid, setCode, convertedManaCost, power) VALUES (13, 'uuid-13', 'ICE', 7.0, NULL);
-- Unmatched setCode / NULL setCode (tests INNER JOIN vs LEFT JOIN)
INSERT INTO cards (id, uuid, setCode, convertedManaCost, power) VALUES (14, 'uuid-14', NULL, 6.0, '*');
INSERT INTO cards (id, uuid, setCode, convertedManaCost, power) VALUES (15, 'uuid-15', 'NONEXISTENT', 6.0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(CASE WHEN T1.power LIKE '%*%' OR T1.power IS NULL THEN 1 ELSE 0 END) FROM cards AS T1 INNER JOIN sets AS T2 ON T2.code = T1.setCode WHERE T2.name = 'Coldsnap' AND T1.convertedManaCost > 5;

/*
Gold Result:
(5,)
*/

-- Prediction Query
SELECT COUNT(T1.id) FROM cards AS T1 INNER JOIN sets AS T2 ON T1.setCode = T2.code WHERE T2.name = 'Coldsnap' AND T1.convertedManaCost > 5 AND (T1.power = '*' OR T1.power IS NULL);

/*
Prediction Result:
(2,)
*/