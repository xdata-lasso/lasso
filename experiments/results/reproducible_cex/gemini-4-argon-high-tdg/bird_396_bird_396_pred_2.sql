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
INSERT INTO cards (id, uuid, name, frameVersion, availability, hasContentWarning, setCode, artist, flavorText, originalReleaseDate, isReserved, isAlternative, hasAlternativeDeckLimit, isPromo, isReprint, hasFoil, hasNonFoil, isOnlineOnly) VALUES (10, 'uuid-10', 'Card Match 1', '1993', 'paper', 1, 'ARN', NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 1, 0);
INSERT INTO cards (id, uuid, name, frameVersion, availability, hasContentWarning, setCode, artist, flavorText, originalReleaseDate, isReserved, isAlternative, hasAlternativeDeckLimit, isPromo, isReprint, hasFoil, hasNonFoil, isOnlineOnly) VALUES (25, 'uuid-25', 'Card Match 2', '1993', 'paper', 1, 'ARN', 'Artist A', 'Flavor A', '1993-12-17', 0, 0, 0, 0, 0, 0, 1, 0);
INSERT INTO cards (id, uuid, name, frameVersion, availability, hasContentWarning, setCode, artist, flavorText, originalReleaseDate, isReserved, isAlternative, hasAlternativeDeckLimit, isPromo, isReprint, hasFoil, hasNonFoil, isOnlineOnly) VALUES (30, 'uuid-30', 'Missing Warning', '1993', 'paper', 0, 'LEA', 'Artist B', 'Flavor B', '1993-08-05', 1, 1, 1, 1, 1, 1, 1, 0);
INSERT INTO cards (id, uuid, name, frameVersion, availability, hasContentWarning, setCode, artist, flavorText, originalReleaseDate, isReserved, isAlternative, hasAlternativeDeckLimit, isPromo, isReprint, hasFoil, hasNonFoil, isOnlineOnly) VALUES (40, 'uuid-40', 'Multi Availability', '1993', 'paper,mtgo', 1, 'LEA', 'Artist C', 'Flavor C', '1993-08-05', 0, 0, 0, 0, 0, 0, 1, 0);
INSERT INTO cards (id, uuid, name, frameVersion, availability, hasContentWarning, setCode, artist, flavorText, originalReleaseDate, isReserved, isAlternative, hasAlternativeDeckLimit, isPromo, isReprint, hasFoil, hasNonFoil, isOnlineOnly) VALUES (50, 'uuid-50', 'Wrong Availability', '1993', 'mtgo', 1, 'LEA', 'Artist D', 'Flavor D', '1993-08-05', 0, 0, 0, 0, 0, 0, 1, 1);
INSERT INTO cards (id, uuid, name, frameVersion, availability, hasContentWarning, setCode, artist, flavorText, originalReleaseDate, isReserved, isAlternative, hasAlternativeDeckLimit, isPromo, isReprint, hasFoil, hasNonFoil, isOnlineOnly) VALUES (60, 'uuid-60', 'Frame 1997', '1997', 'paper', 1, 'TMP', 'Artist E', 'Flavor E', '1993-08-05', 0, 0, 0, 0, 0, 0, 1, 0);
INSERT INTO cards (id, uuid, name, frameVersion, availability, hasContentWarning, setCode, artist, flavorText, originalReleaseDate, isReserved, isAlternative, hasAlternativeDeckLimit, isPromo, isReprint, hasFoil, hasNonFoil, isOnlineOnly) VALUES (70, 'uuid-70', 'Frame 1990', '1990', 'paper', 1, 'LEA', 'Artist F', 'Flavor F', '1990-01-01', 0, 0, 0, 0, 0, 0, 1, 0);
INSERT INTO cards (id, uuid, name, frameVersion, availability, hasContentWarning, setCode, artist, flavorText, originalReleaseDate, isReserved, isAlternative, hasAlternativeDeckLimit, isPromo, isReprint, hasFoil, hasNonFoil, isOnlineOnly) VALUES (80, 'uuid-80', 'Only Frame 1993', '1993', 'arena', 0, 'LEA', 'Artist G', 'Flavor G', '1993-08-05', 0, 0, 0, 0, 0, 0, 1, 1);
INSERT INTO cards (id, uuid, name, frameVersion, availability, hasContentWarning, setCode, artist, flavorText, originalReleaseDate, isReserved, isAlternative, hasAlternativeDeckLimit, isPromo, isReprint, hasFoil, hasNonFoil, isOnlineOnly) VALUES (90, 'uuid-90', 'Only Paper', '2003', 'paper', 0, 'MRD', 'Artist H', 'Flavor H', '2003-10-02', 0, 0, 0, 0, 0, 0, 1, 0);
INSERT INTO cards (id, uuid, name, frameVersion, availability, hasContentWarning, setCode, artist, flavorText, originalReleaseDate, isReserved, isAlternative, hasAlternativeDeckLimit, isPromo, isReprint, hasFoil, hasNonFoil, isOnlineOnly) VALUES (100, 'uuid-100', 'Only Warning', '2015', 'mtgo', 1, 'M15', 'Artist I', 'Flavor I', '2014-07-18', 0, 0, 0, 0, 0, 0, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(id) FROM cards WHERE frameVersion = 1993 AND availability = 'paper' AND hasContentWarning = 1;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT("id") FROM "cards" WHERE "frameversion" = '1993' AND "availability" LIKE '%paper%' AND "hascontentwarning" = 1;

/*
Prediction Result:
(3,)
*/