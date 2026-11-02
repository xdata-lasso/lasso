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
-- Tests basic positive match, boundary conditions on baseSetSize (308, 309, 310, NULL),
-- totalSetSize confusion (totalSetSize = 309 when baseSetSize != 309),
-- sets without translations (kills LEFT JOIN on T1),
-- and translations with NULL setCode (kills RIGHT JOIN on T2).
INSERT INTO sets (id, code, baseSetSize, totalSetSize, keyruneCode, mtgoCode, parentCode, name) VALUES (1, 'SET_A', 309, 350, 'KEY_A', 'MTGO_A', 'PAR_A', 'Alpha Set');
INSERT INTO sets (id, code, baseSetSize, totalSetSize, keyruneCode, mtgoCode, parentCode, name) VALUES (2, 'SET_B', 308, 309, 'SET_A', 'SET_A', 'SET_A', 'Beta Set');
INSERT INTO sets (id, code, baseSetSize, totalSetSize, keyruneCode, mtgoCode, parentCode, name) VALUES (3, 'SET_C', 310, 309, 'KEY_C', 'MTGO_C', 'PAR_C', 'Gamma Set');
INSERT INTO sets (id, code, baseSetSize, totalSetSize, keyruneCode, mtgoCode, parentCode, name) VALUES (4, 'SET_D', NULL, 309, 'KEY_D', 'MTGO_D', 'PAR_D', 'Delta Set');
INSERT INTO sets (id, code, baseSetSize, totalSetSize, keyruneCode, mtgoCode, parentCode, name) VALUES (5, 'SET_E', 309, 309, 'KEY_E', 'MTGO_E', 'PAR_E', 'Epsilon Set No Trans');
INSERT INTO set_translations (id, language, setCode, translation) VALUES (1, 'French', 'SET_A', 'Traduction A');
INSERT INTO set_translations (id, language, setCode, translation) VALUES (2, 'German', 'SET_B', 'Traduction B');
INSERT INTO set_translations (id, language, setCode, translation) VALUES (3, 'Spanish', 'SET_C', 'Traduction C');
INSERT INTO set_translations (id, language, setCode, translation) VALUES (4, 'Italian', 'SET_D', 'Traduction D');
INSERT INTO set_translations (id, language, setCode, translation) VALUES (5, 'Russian', NULL, 'Traduction Null');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.language FROM sets AS T1 INNER JOIN set_translations AS T2 ON T1.code = T2.setCode WHERE T1.baseSetSize = 309;

/*
Gold Result:
('French',)
*/

-- Prediction Query
SELECT T2.translation FROM sets AS T1 INNER JOIN set_translations AS T2 ON T1.code = T2.setCode WHERE T1.baseSetSize = 309;

/*
Prediction Result:
('Traduction A',)
*/