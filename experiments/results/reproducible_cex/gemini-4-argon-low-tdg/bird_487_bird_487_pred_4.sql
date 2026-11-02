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
-- 1. Multiple sets named 'Coldsnap' with different codes (catches GROUP BY T2.code or GROUP BY T2.id mutants which would return multiple rows instead of a single scalar aggregate).
-- 2. HasFoil / HasNonFoil flags set opposite to cardKingdomFoilId / cardKingdomId presence (catches mutants that check hasFoil = 1 AND hasNonFoil = 1 instead of the ID columns).
-- 3. Auxiliary tables populated with multiple rows per card (catches unnecessary joins to legalities, rulings, or foreign_data that would multiply row counts).
INSERT INTO "sets" (id, code, name) VALUES (1, 'CSP_A', 'Coldsnap');
INSERT INTO "sets" (id, code, name) VALUES (2, 'CSP_B', 'Coldsnap');
INSERT INTO "cards" (id, uuid, setCode, cardKingdomFoilId, cardKingdomId, hasFoil, hasNonFoil) VALUES (1, 'u-1', 'CSP_A', 'F1', 'R1', 0, 0);
INSERT INTO "cards" (id, uuid, setCode, cardKingdomFoilId, cardKingdomId, hasFoil, hasNonFoil) VALUES (2, 'u-2', 'CSP_B', NULL, 'R2', 1, 1);
INSERT INTO "cards" (id, uuid, setCode, cardKingdomFoilId, cardKingdomId, hasFoil, hasNonFoil) VALUES (3, 'u-3', 'CSP_B', NULL, NULL, 1, 1);
INSERT INTO "legalities" (id, format, status, uuid) VALUES (1, 'Modern', 'Legal', 'u-1');
INSERT INTO "legalities" (id, format, status, uuid) VALUES (2, 'Legacy', 'Legal', 'u-1');
INSERT INTO "rulings" (id, date, text, uuid) VALUES (1, '2006-07-21', 'Ruling 1', 'u-1');
INSERT INTO "rulings" (id, date, text, uuid) VALUES (2, '2006-07-22', 'Ruling 2', 'u-1');
INSERT INTO "foreign_data" (id, language, name, uuid) VALUES (1, 'German', 'Kaelteeinbruch', 'u-1');
INSERT INTO "set_translations" (id, language, setCode, translation) VALUES (1, 'German', 'CSP_A', 'Kaelteeinbruch');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN NOT T1.cardKingdomFoilId IS NULL AND NOT T1.cardKingdomId IS NULL THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.id) FROM cards AS T1 INNER JOIN sets AS T2 ON T2.code = T1.setCode WHERE T2.name = 'Coldsnap';

/*
Gold Result:
(33.333333333333336,)
*/

-- Prediction Query
SELECT (CAST(COUNT(*) FILTER(WHERE NOT cardKingdomFoilId IS NULL AND NOT cardKingdomId IS NULL) AS REAL) * 100.0 / CAST(COUNT(*) AS REAL)) AS percentage_incredibly_powerful FROM cards WHERE setCode = (SELECT code FROM sets WHERE name = 'Coldsnap');

/*
Prediction Result:
(100.0,)
*/