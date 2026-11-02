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
INSERT INTO sets (id, code, name, releaseDate, type) VALUES (1, 'SET1', 'First Set', '2020-01-01', 'expansion');
INSERT INTO set_translations (id, language, setCode, translation) VALUES (1, 'French', 'SET1', 'Premier Set');
INSERT INTO cards (id, name, asciiName, faceName, flavorName, faceConvertedManaCost, convertedManaCost, edhrecRank, manaCost, number, power, toughness, setCode, side, rarity, uuid) VALUES (1, 'Card_Id1_HighFaceCMC', 'Ascii_1', 'Face_1', 'Flavor_1', 10.0, 1.0, 1, '{1}', '1', '1', '1', 'SET1', 'a', 'common', 'uuid-101');
INSERT INTO cards (id, name, asciiName, faceName, flavorName, faceConvertedManaCost, convertedManaCost, edhrecRank, manaCost, number, power, toughness, setCode, side, rarity, uuid) VALUES (2, 'Card_Id2_LowFaceCMC', 'Ascii_2', 'Face_2', 'Flavor_2', 2.0, 5.0, 100, '{5}', '99', '9', '9', 'NOSET', 'a', 'rare', 'uuid-102');
INSERT INTO cards (id, name, asciiName, faceName, flavorName, faceConvertedManaCost, convertedManaCost, edhrecRank, manaCost, number, power, toughness, setCode, side, rarity, uuid) VALUES (3, 'Card_Id3_MidFaceCMC', 'Ascii_3', 'Face_3', 'Flavor_3', 4.0, 0.0, 50, '{0}', '50', '2', '2', 'SET1', 'b', 'uncommon', 'uuid-103');
INSERT INTO foreign_data (id, language, name, text, type, uuid) VALUES (1, 'German', 'Karte_1', 'Text 1', 'Type 1', 'uuid-101');
INSERT INTO legalities (id, format, status, uuid) VALUES (1, 'standard', 'Legal', 'uuid-101');
INSERT INTO rulings (id, date, text, uuid) VALUES (1, '2020-02-01', 'Ruling 1', 'uuid-101');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM cards ORDER BY faceConvertedManaCost, cards.id NULLS LAST LIMIT 1;

/*
Gold Result:
('Card_Id2_LowFaceCMC',)
*/

-- Prediction Query
SELECT name FROM cards WHERE faceConvertedManaCost = (SELECT MAX(faceConvertedManaCost) FROM cards);

/*
Prediction Result:
('Card_Id1_HighFaceCMC',)
*/