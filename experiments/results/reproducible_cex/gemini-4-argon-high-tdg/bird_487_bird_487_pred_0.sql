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
INSERT INTO sets (id, code, name, mcmName, block, baseSetSize, totalSetSize) VALUES (1, 'Coldsnap', 'Ice Age', 'Coldsnap', 'Coldsnap', 10, 10);
INSERT INTO sets (id, code, name, mcmName, block, baseSetSize, totalSetSize) VALUES (10, 'CSP', 'Coldsnap', 'OtherName', 'Ice Age', 155, 155);
INSERT INTO cards (id, uuid, name, setCode, cardKingdomFoilId, cardKingdomId, mtgoFoilId, mtgoId, hasFoil, hasNonFoil) VALUES (1, 'u-1', 'Card 1', 'CSP', '101', '201', NULL, NULL, 0, 0);
INSERT INTO cards (id, uuid, name, setCode, cardKingdomFoilId, cardKingdomId, mtgoFoilId, mtgoId, hasFoil, hasNonFoil) VALUES (2, 'u-2', 'Card 2', 'CSP', '102', '202', NULL, NULL, 0, 0);
INSERT INTO cards (id, uuid, name, setCode, cardKingdomFoilId, cardKingdomId, mtgoFoilId, mtgoId, hasFoil, hasNonFoil) VALUES (3, 'u-3', 'Card 3', 'CSP', '103', NULL, '303', '403', 1, 1);
INSERT INTO cards (id, uuid, name, setCode, cardKingdomFoilId, cardKingdomId, mtgoFoilId, mtgoId, hasFoil, hasNonFoil) VALUES (4, 'u-4', 'Card 4', 'CSP', NULL, '204', '304', '404', 1, 1);
INSERT INTO cards (id, uuid, name, setCode, cardKingdomFoilId, cardKingdomId, mtgoFoilId, mtgoId, hasFoil, hasNonFoil) VALUES (5, 'u-5', 'Card 5', 'CSP', NULL, '205', '305', '405', 1, 1);
INSERT INTO cards (id, uuid, name, setCode, cardKingdomFoilId, cardKingdomId, mtgoFoilId, mtgoId, hasFoil, hasNonFoil) VALUES (6, 'u-6', 'Card 6', 'CSP', NULL, '206', '306', '406', 1, 1);
INSERT INTO cards (id, uuid, name, setCode, cardKingdomFoilId, cardKingdomId, mtgoFoilId, mtgoId, hasFoil, hasNonFoil) VALUES (7, 'u-7', 'Card 7', 'CSP', NULL, '207', '307', '407', 1, 1);
INSERT INTO cards (id, uuid, name, setCode, cardKingdomFoilId, cardKingdomId, mtgoFoilId, mtgoId, hasFoil, hasNonFoil) VALUES (8, 'u-8', 'Card 8', 'CSP', NULL, NULL, '308', '408', 1, 1);
INSERT INTO cards (id, uuid, name, setCode, cardKingdomFoilId, cardKingdomId, mtgoFoilId, mtgoId, hasFoil, hasNonFoil) VALUES (9, 'u-9', 'Card 9', 'CSP', NULL, NULL, '309', '409', 1, 1);
INSERT INTO cards (id, uuid, name, setCode, cardKingdomFoilId, cardKingdomId, mtgoFoilId, mtgoId, hasFoil, hasNonFoil) VALUES (10, 'u-10', 'Card 10', 'CSP', NULL, NULL, '310', '410', 1, 1);
INSERT INTO cards (id, uuid, name, setCode, cardKingdomFoilId, cardKingdomId, mtgoFoilId, mtgoId, hasFoil, hasNonFoil) VALUES (11, 'u-11', 'Card 11', 'CSP', NULL, NULL, '311', '411', 1, 1);
INSERT INTO cards (id, uuid, name, setCode, cardKingdomFoilId, cardKingdomId, mtgoFoilId, mtgoId, hasFoil, hasNonFoil) VALUES (12, 'u-12', 'Card 12', 'CSP', NULL, NULL, '312', '412', 1, 1);
INSERT INTO cards (id, uuid, name, setCode, cardKingdomFoilId, cardKingdomId, mtgoFoilId, mtgoId, hasFoil, hasNonFoil) VALUES (13, 'u-13', 'Card 13', 'CSP', NULL, NULL, '313', '413', 1, 1);
INSERT INTO cards (id, uuid, name, setCode, cardKingdomFoilId, cardKingdomId, mtgoFoilId, mtgoId, hasFoil, hasNonFoil) VALUES (14, 'u-14', 'Card 14', 'CSP', NULL, NULL, '314', '414', 1, 1);
INSERT INTO cards (id, uuid, name, setCode, cardKingdomFoilId, cardKingdomId, mtgoFoilId, mtgoId, hasFoil, hasNonFoil) VALUES (15, 'u-15', 'Card 15', 'CSP', NULL, NULL, '315', '415', 1, 1);
INSERT INTO cards (id, uuid, name, setCode, cardKingdomFoilId, cardKingdomId, mtgoFoilId, mtgoId, hasFoil, hasNonFoil) VALUES (16, 'u-16', 'Card 16', 'CSP', NULL, NULL, '316', '416', 1, 1);
INSERT INTO cards (id, uuid, name, setCode, cardKingdomFoilId, cardKingdomId, mtgoFoilId, mtgoId, hasFoil, hasNonFoil) VALUES (17, 'u-17', 'Card 17', 'CSP', NULL, NULL, '317', '417', 1, 1);
INSERT INTO cards (id, uuid, name, setCode, cardKingdomFoilId, cardKingdomId, mtgoFoilId, mtgoId, hasFoil, hasNonFoil) VALUES (18, 'u-18', 'Coldsnap', 'Coldsnap', '991', '992', '993', '994', 1, 1);
INSERT INTO cards (id, uuid, name, setCode, cardKingdomFoilId, cardKingdomId, mtgoFoilId, mtgoId, hasFoil, hasNonFoil) VALUES (19, 'u-19', 'Coldsnap', 'Coldsnap', '995', '996', '997', '998', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN NOT T1.cardKingdomFoilId IS NULL AND NOT T1.cardKingdomId IS NULL THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.id) FROM cards AS T1 INNER JOIN sets AS T2 ON T2.code = T1.setCode WHERE T2.name = 'Coldsnap';

/*
Gold Result:
(11.764705882352942,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T1.cardKingdomFoilId = T1.cardKingdomId AND NOT T1.cardKingdomId IS NULL THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.name) FROM cards AS T1 INNER JOIN sets AS T2 ON T1.setCode = T2.code WHERE T2.name = 'Coldsnap';

/*
Prediction Result:
(0.0,)
*/