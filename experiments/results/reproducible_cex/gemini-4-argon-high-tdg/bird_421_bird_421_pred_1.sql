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
INSERT INTO cards (id, uuid, name, asciiName, faceName, flavorName, power, toughness, promoTypes, isPromo) VALUES (1, 'u1', 'AAA_OrPrecedence1', 'Asc1', 'Face1', 'Flav1', NULL, '1', 'judgegift', 1);
INSERT INTO cards (id, uuid, name, asciiName, faceName, flavorName, power, toughness, promoTypes, isPromo) VALUES (2, 'u2', 'AAA_OrPrecedence2', 'Asc2', 'Face2', 'Flav2', NULL, '1', NULL, 1);
INSERT INTO cards (id, uuid, name, asciiName, faceName, flavorName, power, toughness, promoTypes, isPromo) VALUES (3, 'u3', 'AAA_WrongPowerNum', 'Asc3', 'Face3', 'Flav3', '4', '*', 'arenaleague', 1);
INSERT INTO cards (id, uuid, name, asciiName, faceName, flavorName, power, toughness, promoTypes, isPromo) VALUES (4, 'u4', 'AAA_EmptyPower', 'Asc4', 'Face4', 'Flav4', '', '*', 'arenaleague', 1);
INSERT INTO cards (id, uuid, name, asciiName, faceName, flavorName, power, toughness, promoTypes, isPromo) VALUES (5, 'u5', 'AAA_PromoLike', 'Asc5', 'Face5', 'Flav5', '*', '*', 'arenaleague,fnm', 1);
INSERT INTO cards (id, uuid, name, asciiName, faceName, flavorName, power, toughness, promoTypes, isPromo) VALUES (6, 'u6', 'Epsilon', 'Asc6', 'Face6', 'Flav6', '*', '1', 'arenaleague', 0);
INSERT INTO cards (id, uuid, name, asciiName, faceName, flavorName, power, toughness, promoTypes, isPromo) VALUES (7, 'u7', 'Delta', 'Asc7', 'Face7', 'Flav7', '1*2', '2', 'arenaleague', 1);
INSERT INTO cards (id, uuid, name, asciiName, faceName, flavorName, power, toughness, promoTypes, isPromo) VALUES (8, 'u8', 'Gamma', 'Asc8', 'Face8', 'Flav8', '*+1', '3', 'arenaleague', 0);
INSERT INTO cards (id, uuid, name, asciiName, faceName, flavorName, power, toughness, promoTypes, isPromo) VALUES (9, 'u9', 'Beta', 'Asc9', 'Face9', 'Flav9', '1+*', '4', 'arenaleague', 1);
INSERT INTO cards (id, uuid, name, asciiName, faceName, flavorName, power, toughness, promoTypes, isPromo) VALUES (10, 'u10', 'Alpha', 'Asc10', 'Face10', 'Flav10', NULL, '5', 'arenaleague', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM cards WHERE (power IS NULL OR power LIKE '%*%') AND promoTypes = 'arenaleague' ORDER BY name, cards.id NULLS LAST LIMIT 3;

/*
Gold Result:
('Alpha',)
('Beta',)
('Delta',)
*/

-- Prediction Query
SELECT "name" FROM "cards" WHERE ("power" IS NULL OR "power" = '*') AND "promotypes" LIKE '%arenaleague%' ORDER BY "name" ASC, cards.id NULLS LAST LIMIT 3;

/*
Prediction Result:
('AAA_PromoLike',)
('Alpha',)
('Epsilon',)
*/