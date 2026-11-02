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
INSERT INTO cards (id, uuid, name, edhrecRank, frameVersion) VALUES (10, 'uuid-10', 'Card Rank 99 Frame 2015', 99, '2015');
INSERT INTO cards (id, uuid, name, edhrecRank, frameVersion) VALUES (20, 'uuid-20', 'Card Rank 1 Frame 2015', 1, '2015');
INSERT INTO cards (id, uuid, name, edhrecRank, frameVersion) VALUES (30, 'uuid-30', 'Card Rank 0 Frame 2015', 0, '2015');
INSERT INTO cards (id, uuid, name, edhrecRank, frameVersion) VALUES (40, 'uuid-40', 'Card Rank 100 Frame 2015', 100, '2015');
INSERT INTO cards (id, uuid, name, edhrecRank, frameVersion) VALUES (50, 'uuid-50', 'Card Rank 101 Frame 2015', 101, '2015');
INSERT INTO cards (id, uuid, name, edhrecRank, frameVersion) VALUES (60, 'uuid-60', 'Card Rank NULL Frame 2015', NULL, '2015');
INSERT INTO cards (id, uuid, name, edhrecRank, frameVersion) VALUES (70, 'uuid-70', 'Card Rank 50 Frame 2003', 50, '2003');
INSERT INTO cards (id, uuid, name, edhrecRank, frameVersion) VALUES (80, 'uuid-80', 'Card Rank 50 Frame 1997', 50, '1997');
INSERT INTO cards (id, uuid, name, edhrecRank, frameVersion) VALUES (90, 'uuid-90', 'Card Rank 50 Frame future', 50, 'future');
INSERT INTO cards (id, uuid, name, edhrecRank, frameVersion) VALUES (100, 'uuid-100', 'Card Rank 50 Frame NULL', 50, NULL);
INSERT INTO cards (id, uuid, name, edhrecRank, frameVersion) VALUES (110, 'uuid-110', 'Card Rank 200 Frame 2003', 200, '2003');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id FROM cards WHERE edhrecRank < 100 AND frameVersion = 2015;

/*
Gold Result:
(10,)
(20,)
(30,)
*/

-- Prediction Query
SELECT name FROM cards WHERE frameVersion = '2015' AND edhrecRank < 100;

/*
Prediction Result:
('Card Rank 99 Frame 2015',)
('Card Rank 1 Frame 2015',)
('Card Rank 0 Frame 2015',)
*/