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
-- Core logic, column confusion (cards vs foreign_data), and predicate boundary tests
INSERT INTO cards (id, uuid, name, asciiName, flavorName, flavorText, text, originalText) VALUES
(1, 'uuid-1', 'Ancestor''s Chosen', 'Ancestors Chosen', 'EngFlavorName1', 'English Flavor 1', 'English Text 1', 'Orig Text 1'),
(2, 'uuid-2', 'Other Card', 'Ancestor''s Chosen', 'Ancestor''s Chosen', 'English Flavor 2', 'English Text 2', 'Orig Text 2'),
(3, 'uuid-3', 'Ancestor''s Chosen', 'Ancestors Chosen', 'EngFlavorName3', 'English Flavor 3', 'English Text 3', 'Orig Text 3'),
(4, 'uuid-4', 'Ancestors Chosen', 'Ancestors Chosen', 'EngFlavorName4', 'English Flavor 4', 'English Text 4', 'Orig Text 4'),
(5, 'uuid-5', 'Ancestor''s Chosen Extra', 'Ancestors Chosen Extra', 'EngFlavorName5', 'English Flavor 5', 'English Text 5', 'Orig Text 5');
INSERT INTO foreign_data (id, uuid, name, language, flavorText, text) VALUES
(10, 'uuid-1', 'Prescelto dell''Antenato', 'Italian', 'Italian Flavor 1 (Target)', 'Italian Text 1'),
(20, 'uuid-1', 'Elu de l''ancetre', 'French', 'French Flavor 1', 'French Text 1'),
(30, 'uuid-2', 'Ancestor''s Chosen', 'Italian', 'Italian Flavor 2 (Wrong Card)', 'Italian Text 2'),
(40, 'uuid-3', 'Chosen German', 'German', 'German Flavor 3', 'German Text 3'),
(50, 'uuid-4', 'Chosen Italian No Apostrophe', 'Italian', 'Italian Flavor 4', 'Italian Text 4'),
(60, 'uuid-5', 'Chosen Extra Italian', 'Italian', 'Italian Flavor 5', 'Italian Text 5'),
(70, 'uuid-1', 'Chosen Italian Legacy', 'Italian Extra', 'Italian Extra Flavor', 'Italian Extra Text');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.flavorText FROM cards AS T1 INNER JOIN foreign_data AS T2 ON T2.uuid = T1.uuid WHERE T1.name = 'Ancestor''s Chosen' AND T2.language = 'Italian';

/*
Gold Result:
('Italian Flavor 1 (Target)',)
*/

-- Prediction Query
SELECT flavorText FROM foreign_data WHERE name = 'Ancestor''s Chosen' AND language = 'Italian';

/*
Prediction Result:
('Italian Flavor 2 (Wrong Card)',)
*/