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
INSERT INTO sets (id, code, name) VALUES (1, 'SET1', 'Set One');
INSERT INTO cards (id, uuid, name, isTextless, layout, setCode, text, isFullArt, isPromo) VALUES (1, 'u1', 'Card 1', 1, 'normal', 'SET1', NULL, 1, 1);
INSERT INTO cards (id, uuid, name, isTextless, layout, setCode, text, isFullArt, isPromo) VALUES (2, 'u2', 'Card 2', 1, 'normal', 'SET1', '', 0, 1);
INSERT INTO cards (id, uuid, name, isTextless, layout, setCode, text, isFullArt, isPromo) VALUES (3, 'u3', 'Card 3', 1, 'split', 'SET1', NULL, 1, 0);
INSERT INTO cards (id, uuid, name, isTextless, layout, setCode, text, isFullArt, isPromo) VALUES (4, 'u4', 'Card 4', 1, NULL, 'SET1', NULL, 0, 0);
INSERT INTO cards (id, uuid, name, isTextless, layout, setCode, text, isFullArt, isPromo) VALUES (5, 'u5', 'Card 5', 0, 'normal', 'SET1', 'Some text', 1, 1);
INSERT INTO cards (id, uuid, name, isTextless, layout, setCode, text, isFullArt, isPromo) VALUES (6, 'u6', 'Card 6', 0, 'normal', 'SET1', NULL, 0, 0);
INSERT INTO cards (id, uuid, name, isTextless, layout, setCode, text, isFullArt, isPromo) VALUES (7, 'u7', 'Card 7', 0, 'transform', 'SET1', 'Transform text', 0, 0);
INSERT INTO foreign_data (id, uuid, name, language) VALUES (1, 'u1', 'Carte 1', 'French');
INSERT INTO foreign_data (id, uuid, name, language) VALUES (2, 'u1', 'Karte 1', 'German');
INSERT INTO legalities (id, uuid, format, status) VALUES (1, 'u1', 'Standard', 'Legal');
INSERT INTO legalities (id, uuid, format, status) VALUES (2, 'u1', 'Modern', 'Legal');
INSERT INTO rulings (id, uuid, date, text) VALUES (1, 'u1', '2020-01-01', 'Ruling 1');
INSERT INTO rulings (id, uuid, date, text) VALUES (2, 'u1', '2020-01-02', 'Ruling 2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN isTextless = 1 AND layout = 'normal' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM cards;

/*
Gold Result:
(28.571428571428573,)
*/

-- Prediction Query
SELECT CAST(COUNT(CASE WHEN isTextless = 1 AND layout = 'normal' THEN 1 END) AS REAL) * 100.0 / COUNT(CASE WHEN isTextless = 1 THEN 1 END) AS proportion FROM cards;

/*
Prediction Result:
(50.0,)
*/