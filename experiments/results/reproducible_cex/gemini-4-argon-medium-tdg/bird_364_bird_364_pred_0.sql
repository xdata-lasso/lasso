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
-- 1. DISTINCT keyword (duplicate 'Legal' statuses across same and different printings of 'Cloudchaser Eagle')
-- 2. Join condition (T1.id != T2.id to kill join on id instead of uuid)
-- 3. Column selection (T2.format != T2.status to kill selecting format)
-- 4. WHERE clause filtering (ignores other card names, asciiName, faceName, flavorName, and foreign_data.name)
INSERT INTO cards (id, name, asciiName, faceName, flavorName, uuid) VALUES (1, 'Cloudchaser Eagle', 'Wrong Ascii', 'Wrong Face', 'Wrong Flavor', 'uuid-cce-1');
INSERT INTO cards (id, name, asciiName, faceName, flavorName, uuid) VALUES (2, 'Cloudchaser Eagle', 'Wrong Ascii 2', 'Wrong Face 2', 'Wrong Flavor 2', 'uuid-cce-2');
INSERT INTO cards (id, name, asciiName, faceName, flavorName, uuid) VALUES (3, 'Other Card', 'Cloudchaser Eagle', 'Cloudchaser Eagle', 'Cloudchaser Eagle', 'uuid-other-3');
INSERT INTO legalities (id, format, status, uuid) VALUES (10, 'commander', 'Legal', 'uuid-cce-1');
INSERT INTO legalities (id, format, status, uuid) VALUES (11, 'modern', 'Legal', 'uuid-cce-1');
INSERT INTO legalities (id, format, status, uuid) VALUES (12, 'standard', 'Not Legal', 'uuid-cce-1');
INSERT INTO legalities (id, format, status, uuid) VALUES (13, 'legacy', 'Legal', 'uuid-cce-2');
INSERT INTO legalities (id, format, status, uuid) VALUES (14, 'vintage', 'Restricted', 'uuid-cce-2');
INSERT INTO legalities (id, format, status, uuid) VALUES (1, 'brawl', 'Banned', 'uuid-other-3');
INSERT INTO foreign_data (id, name, language, uuid) VALUES (1, 'Cloudchaser Eagle', 'English', 'uuid-other-3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.status FROM cards AS T1 INNER JOIN legalities AS T2 ON T1.uuid = T2.uuid WHERE T1.name = 'Cloudchaser Eagle';

/*
Gold Result:
('Legal',)
('Not Legal',)
('Restricted',)
*/

-- Prediction Query
SELECT T2.status FROM cards AS T1 INNER JOIN legalities AS T2 ON T1.uuid = T2.uuid WHERE T1.name = 'Cloudchaser Eagle';

/*
Prediction Result:
('Legal',)
('Legal',)
('Not Legal',)
('Legal',)
('Restricted',)
*/