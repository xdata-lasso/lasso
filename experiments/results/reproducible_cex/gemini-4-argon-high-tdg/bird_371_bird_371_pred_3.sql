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
INSERT INTO sets (id, code, name) VALUES (1, 'DOM', 'Dominaria');
INSERT INTO set_translations (id, language, setCode, translation) VALUES (1, 'German', 'DOM', 'Dominaria');
INSERT INTO set_translations (id, language, setCode, translation) VALUES (2, 'Spanish', 'DOM', 'Dominaria');
INSERT INTO cards (id, name, isStorySpotlight, setCode, uuid) VALUES (10, 'Spotlight One', 1, 'DOM', 'uuid-s1');
INSERT INTO cards (id, name, isStorySpotlight, setCode, uuid) VALUES (20, 'Spotlight Two', 1, 'DOM', 'uuid-s2');
INSERT INTO cards (id, name, isStorySpotlight, setCode, uuid) VALUES (30, 'Spotlight Three', 1, 'DOM', 'uuid-s3');
INSERT INTO cards (id, name, isStorySpotlight, setCode, uuid) VALUES (40, 'Spotlight No Foreign', 1, 'DOM', 'uuid-s4');
INSERT INTO cards (id, name, isStorySpotlight, setCode, uuid) VALUES (50, 'Regular One', 0, 'DOM', 'uuid-r1');
INSERT INTO cards (id, name, isStorySpotlight, setCode, uuid) VALUES (60, 'Regular Two', 0, 'DOM', 'uuid-r2');
INSERT INTO foreign_data (id, language, multiverseid, name, uuid) VALUES (1, 'French', 1001, 'Spotlight Un', 'uuid-s1');
INSERT INTO foreign_data (id, language, multiverseid, name, uuid) VALUES (2, 'German', 1002, 'Spotlight Eins', 'uuid-s1');
INSERT INTO foreign_data (id, language, multiverseid, name, uuid) VALUES (3, 'Spanish', 1003, 'Spotlight Uno', 'uuid-s1');
INSERT INTO foreign_data (id, language, multiverseid, name, uuid) VALUES (4, 'French', 1004, 'Spotlight Deux', 'uuid-s2');
INSERT INTO foreign_data (id, language, multiverseid, name, uuid) VALUES (5, 'Japanese', 1005, 'Spotlight Ni', 'uuid-s2');
INSERT INTO foreign_data (id, language, multiverseid, name, uuid) VALUES (6, 'Italian', 1006, 'Spotlight Due', 'uuid-s2');
INSERT INTO foreign_data (id, language, multiverseid, name, uuid) VALUES (7, 'French', 1007, 'Spotlight Trois', 'uuid-s3');
INSERT INTO foreign_data (id, language, multiverseid, name, uuid) VALUES (8, 'Russian', 1008, 'Spotlight Tri', 'uuid-s3');
INSERT INTO foreign_data (id, language, multiverseid, name, uuid) VALUES (9, 'French', 1009, 'Regulier Un', 'uuid-r1');
INSERT INTO foreign_data (id, language, multiverseid, name, uuid) VALUES (10, 'French', 1010, 'Regulier Deux', 'uuid-r2');
INSERT INTO foreign_data (id, language, multiverseid, name, uuid) VALUES (11, 'German', 1011, 'Regulaer Zwei', 'uuid-r2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN T2.language = 'French' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.id) FROM cards AS T1 INNER JOIN foreign_data AS T2 ON T1.uuid = T2.uuid WHERE T1.isStorySpotlight = 1;

/*
Gold Result:
(37.5,)
*/

-- Prediction Query
SELECT (SELECT COUNT(*) FROM foreign_data AS fd JOIN cards AS c ON fd.uuid = c.uuid WHERE fd.language = 'French' AND c.isStorySpotlight = 1) * 100.0 / (SELECT COUNT(*) FROM cards WHERE isStorySpotlight = 1) AS percentage;

/*
Prediction Result:
(75.0,)
*/