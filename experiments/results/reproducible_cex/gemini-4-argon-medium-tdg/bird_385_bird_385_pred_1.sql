-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests DISTINCT vs ALL (duplicate ruling texts across different printings/rulings), Join on id vs uuid, and wrong table selection (foreign_data vs rulings).
INSERT INTO cards (id, name, asciiName, flavorName, faceName, text, uuid) VALUES (10, 'Beacon of Immortality', 'Other Name', 'Other Name', 'Other Name', 'Card text 1', '100');
INSERT INTO cards (id, name, asciiName, flavorName, faceName, text, uuid) VALUES (20, 'Beacon of Immortality', 'Other Name', 'Other Name', 'Other Name', 'Card text 2', '200');
INSERT INTO cards (id, name, asciiName, flavorName, faceName, text, uuid) VALUES (30, 'Fake Card', 'Beacon of Immortality', 'Beacon of Immortality', 'Beacon of Immortality', 'Card text 3', '10');
INSERT INTO rulings (id, date, text, uuid) VALUES (10, '2007-07-15', 'Duplicate Ruling Text', '100');
INSERT INTO rulings (id, date, text, uuid) VALUES (20, '2008-01-01', 'Duplicate Ruling Text', '200');
INSERT INTO rulings (id, date, text, uuid) VALUES (30, '2009-01-01', 'Unique Ruling Text', '100');
INSERT INTO rulings (id, date, text, uuid) VALUES (100, '2010-01-01', 'Wrong Join Condition Ruling (id=uuid)', '10');
INSERT INTO foreign_data (id, name, text, language, uuid) VALUES (1, 'Beacon of Immortality', 'Foreign text instead of ruling', 'Spanish', '100');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.text FROM cards AS T1 INNER JOIN rulings AS T2 ON T1.uuid = T2.uuid WHERE T1.name = 'Beacon of Immortality';

/*
Gold Result:
('Duplicate Ruling Text',)
('Duplicate Ruling Text',)
('Unique Ruling Text',)
*/

-- Prediction Query
SELECT DISTINCT T2.text FROM cards AS T1 INNER JOIN rulings AS T2 ON T1.uuid = T2.uuid WHERE T1.name = 'Beacon of Immortality';

/*
Prediction Result:
('Duplicate Ruling Text',)
('Unique Ruling Text',)
*/