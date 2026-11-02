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
INSERT INTO sets (id, code, releaseDate) VALUES (1, 'S1', '2011-12-31');
INSERT INTO sets (id, code, releaseDate) VALUES (2, 'S2', '2011-12-31');
INSERT INTO sets (id, code, releaseDate) VALUES (3, 'S3', '2011-12-31');
INSERT INTO sets (id, code, releaseDate) VALUES (5, 'S5', '2012-01-01');
INSERT INTO sets (id, code, releaseDate) VALUES (7, 'S7', '2012-01-01');
INSERT INTO sets (id, code, releaseDate) VALUES (10, 'S10', '2015-12-31');
INSERT INTO sets (id, code, releaseDate) VALUES (11, 'S11', '2016-01-01');
INSERT INTO sets (id, code, releaseDate) VALUES (12, 'S12', '2016-01-01');
INSERT INTO sets (id, code, releaseDate) VALUES (13, 'S13', '2016-01-01');
INSERT INTO set_translations (id, language, setCode, translation) VALUES (1, 'French', 'S1', 'T1');
INSERT INTO set_translations (id, language, setCode, translation) VALUES (2, 'German', 'S2', 'T2');
INSERT INTO set_translations (id, language, setCode, translation) VALUES (3, 'Italian', 'S3', 'T3');
INSERT INTO set_translations (id, language, setCode, translation) VALUES (5, 'Spanish', 'S10', 'T5');
INSERT INTO set_translations (id, language, setCode, translation) VALUES (7, 'Spanish', 'S10', 'T7');
INSERT INTO set_translations (id, language, setCode, translation) VALUES (10, 'Russian', 'S5', 'T10');
INSERT INTO set_translations (id, language, setCode, translation) VALUES (11, 'Korean', 'S11', 'T11');
INSERT INTO set_translations (id, language, setCode, translation) VALUES (12, 'Japanese', 'S12', 'T12');
INSERT INTO set_translations (id, language, setCode, translation) VALUES (13, 'Chinese', 'S13', 'T13');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT (CAST(SUM(T1.id) AS REAL) / COUNT(T1.id)) / 4, T2.language FROM sets AS T1 INNER JOIN set_translations AS T2 ON T1.id = T2.id WHERE T1.releaseDate BETWEEN '2012-01-01' AND '2015-12-31' GROUP BY T1.releaseDate ORDER BY COUNT(T2.language) DESC, (CAST(SUM(T1.id) AS REAL) / COUNT(T1.id)) / 4 NULLS LAST, T2.language NULLS LAST LIMIT 1;

/*
Gold Result:
(1.5, 'Spanish')
*/

-- Prediction Query
SELECT COUNT(*) / 4.0 AS annual_average_sets, (SELECT language FROM foreign_data GROUP BY language ORDER BY COUNT(*) DESC, language NULLS LAST LIMIT 1) AS most_common_language FROM sets WHERE releaseDate BETWEEN '2012-01-01' AND '2015-12-31';

/*
Prediction Result:
(0.75, None)
*/