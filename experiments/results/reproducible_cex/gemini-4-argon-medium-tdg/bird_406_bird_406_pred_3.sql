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
INSERT INTO cards (id, types, type, uuid) VALUES (1, 'Creature', 'Summon', 'u1');
INSERT INTO cards (id, types, type, uuid) VALUES (2, 'Instant', 'Creature', 'u2');
INSERT INTO cards (id, types, type, uuid) VALUES (3, 'Creature — Elf', 'Creature', 'u3');
INSERT INTO cards (id, types, type, uuid) VALUES (4, 'Creature', 'Creature', 'u4');
INSERT INTO cards (id, types, type, uuid) VALUES (5, 'Creature', 'Creature', 'u5');
INSERT INTO rulings (id, text, uuid) VALUES (10, 'Ruling 1', 'u1');
INSERT INTO rulings (id, text, uuid) VALUES (20, 'Ruling 2', 'u2');
INSERT INTO rulings (id, text, uuid) VALUES (30, 'Ruling 3', 'u3');
INSERT INTO rulings (id, text, uuid) VALUES (50, 'Ruling 5', 'u5');
INSERT INTO legalities (id, format, status, uuid) VALUES (100, 'Standard', 'Legal', 'u1');
INSERT INTO legalities (id, format, status, uuid) VALUES (200, 'Standard', 'Legal', 'u2');
INSERT INTO legalities (id, format, status, uuid) VALUES (300, 'Standard', 'Legal', 'u3');
INSERT INTO legalities (id, format, status, uuid) VALUES (400, 'Standard', 'Legal', 'u4');
INSERT INTO legalities (id, format, status, uuid) VALUES (500, 'Legacy', 'Banned', 'u5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.id FROM cards AS T1 INNER JOIN rulings AS T2 ON T1.uuid = T2.uuid INNER JOIN legalities AS T3 ON T1.uuid = T3.uuid WHERE T3.status = 'Legal' AND T1.types = 'Creature';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT DISTINCT c.id FROM cards AS c JOIN legalities AS l ON c.uuid = l.uuid WHERE c.types LIKE '%Creature%' AND l.status = 'Legal';

/*
Prediction Result:
(1,)
(3,)
(4,)
*/