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
-- Tests basic join, subquery filtering, CASE WHEN condition ('Legal' vs 'Banned' vs NULL), and INNER JOIN vs LEFT/RIGHT JOIN (card without legalities)
INSERT INTO sets (id, code, name) VALUES (1, 'HOU', 'Hour of Devastation');
INSERT INTO sets (id, code, name) VALUES (2, 'AKH', 'Amonkhet');
INSERT INTO cards (id, uuid, name, setCode) VALUES (1, 'u1', 'The Scarab God', 'HOU');
INSERT INTO cards (id, uuid, name, setCode) VALUES (2, 'u2', 'Abrade', 'HOU');
INSERT INTO cards (id, uuid, name, setCode) VALUES (3, 'u3', 'Nicol Bolas, God-Pharaoh', 'HOU');
INSERT INTO cards (id, uuid, name, setCode) VALUES (4, 'u4', 'Glorybringer', 'AKH');
INSERT INTO cards (id, uuid, name, setCode) VALUES (5, 'u5', 'Orphan Card', NULL);
INSERT INTO legalities (id, uuid, format, status) VALUES (1, 'u1', 'Commander', 'Legal');
INSERT INTO legalities (id, uuid, format, status) VALUES (2, 'u2', 'Standard', 'Banned');
INSERT INTO legalities (id, uuid, format, status) VALUES (3, 'u2', 'Modern', NULL);
INSERT INTO legalities (id, uuid, format, status) VALUES (4, 'u4', 'Standard', 'Legal');
INSERT INTO legalities (id, uuid, format, status) VALUES (5, 'u5', 'Legacy', 'Legal');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.name, CASE WHEN T1.status = 'Legal' THEN T1.format ELSE NULL END FROM legalities AS T1 INNER JOIN cards AS T2 ON T2.uuid = T1.uuid WHERE T2.setCode IN (SELECT code FROM sets WHERE name = 'Hour of Devastation');

/*
Gold Result:
('The Scarab God', 'Commander')
('Abrade', None)
*/

-- Prediction Query
SELECT c.name AS card_name, l.format AS legal_format FROM cards AS c INNER JOIN legalities AS l ON c.uuid = l.uuid INNER JOIN sets AS s ON c.setCode = s.code WHERE s.name = 'Hour of Devastation' AND l.status = 'Legal';

/*
Prediction Result:
('The Scarab God', 'Commander')
*/