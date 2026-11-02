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
INSERT INTO cards (id, uuid, name) VALUES (1, 'u1', 'Card A');
INSERT INTO cards (id, uuid, name) VALUES (2, 'u2', 'Card A');
INSERT INTO cards (id, uuid, name) VALUES (3, 'u3', 'Card B');
INSERT INTO cards (id, uuid, name) VALUES (4, 'u4', 'Card C');
INSERT INTO legalities (id, format, status, uuid) VALUES (1, 'Legacy', 'Banned', 'u1');
INSERT INTO legalities (id, format, status, uuid) VALUES (2, 'Legacy', 'Banned', 'u2');
INSERT INTO legalities (id, format, status, uuid) VALUES (3, 'Modern', 'Banned', 'u3');
INSERT INTO legalities (id, format, status, uuid) VALUES (4, 'Modern', 'Legal', 'u1');
INSERT INTO legalities (id, format, status, uuid) VALUES (5, 'Modern', 'Legal', 'u2');
INSERT INTO legalities (id, format, status, uuid) VALUES (6, 'Standard', 'Banned', 'u4');
INSERT INTO legalities (id, format, status, uuid) VALUES (7, 'Vintage', 'Banned', 'u1');
INSERT INTO legalities (id, format, status, uuid) VALUES (8, 'Vintage', 'Restricted', 'u2');
INSERT INTO legalities (id, format, status, uuid) VALUES (9, 'Vintage', 'Restricted', 'u3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.format, T1.name FROM cards AS T1 INNER JOIN legalities AS T2 ON T2.uuid = T1.uuid WHERE T2.status = 'Banned' GROUP BY T2.format ORDER BY COUNT(T2.status) DESC, T2.format NULLS LAST, T1.name NULLS LAST LIMIT 1;

/*
Gold Result:
('Legacy', 'Card A')
*/

-- Prediction Query
SELECT T1.format, GROUP_CONCAT(T2.name) FROM legalities AS T1 INNER JOIN cards AS T2 ON T1.uuid = T2.uuid WHERE T1.status = 'Banned' GROUP BY T1.format ORDER BY COUNT(T1.status) DESC, T1.format NULLS LAST, GROUP_CONCAT(T2.name) NULLS LAST LIMIT 1;

/*
Prediction Result:
('Legacy', 'Card A,Card A')
*/