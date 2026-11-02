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
INSERT INTO sets (id, code, name, releaseDate, type) VALUES (1, 'SET1', 'Test Set One', '2020-01-01', 'expansion');
INSERT INTO set_translations (id, language, setCode, translation) VALUES (1, 'French', 'SET1', 'Ensemble Test Un');
INSERT INTO cards (id, artist, asciiName, convertedManaCost, edhrecRank, faceConvertedManaCost, faceName, flavorName, manaCost, name, number, setCode, side, uuid) VALUES (1, 'Wrong_Side_A', 'Ascii_1', 100.0, 10, 100.0, 'Face_1', 'Flavor_1', '{100}', 'Card_1', '1', 'SET1', 'a', 'uuid-1');
INSERT INTO cards (id, artist, asciiName, convertedManaCost, edhrecRank, faceConvertedManaCost, faceName, flavorName, manaCost, name, number, setCode, side, uuid) VALUES (2, 'Wrong_Empty_Side', 'Ascii_2', 90.0, 20, 90.0, 'Face_2', 'Flavor_2', '{90}', 'Card_2', '2', 'SET1', '', 'uuid-2');
INSERT INTO cards (id, artist, asciiName, convertedManaCost, edhrecRank, faceConvertedManaCost, faceName, flavorName, manaCost, name, number, setCode, side, uuid) VALUES (3, 'Wrong_Null_CMC', 'Ascii_3', NULL, 30, 80.0, 'Face_3', 'Flavor_3', '{0}', 'Card_3', '3', 'SET1', NULL, 'uuid-3');
INSERT INTO cards (id, artist, asciiName, convertedManaCost, edhrecRank, faceConvertedManaCost, faceName, flavorName, manaCost, name, number, setCode, side, uuid) VALUES (4, 'Wrong_Low_CMC_9', 'Ascii_4', 9.0, 40, 50.0, 'Face_4', 'Flavor_4', '{9}', 'Card_4', '4', 'SET1', NULL, 'uuid-4');
INSERT INTO cards (id, artist, asciiName, convertedManaCost, edhrecRank, faceConvertedManaCost, faceName, flavorName, manaCost, name, number, setCode, side, uuid) VALUES (5, 'Correct_Winner_Artist', 'Z_Ascii_5', 12.0, 500, 2.0, 'Z_Face_5', 'Z_Flavor_5', '{2}', 'Z_Card_5', '999', NULL, NULL, 'z-uuid-5');
INSERT INTO cards (id, artist, asciiName, convertedManaCost, edhrecRank, faceConvertedManaCost, faceName, flavorName, manaCost, name, number, setCode, side, uuid) VALUES (6, 'A_Wrong_Tie_Breaker', 'A_Ascii_6', 12.0, 1, 20.0, 'A_Face_6', 'A_Flavor_6', '{12}', 'A_Card_6', '001', 'SET1', NULL, 'a-uuid-6');
INSERT INTO foreign_data (id, language, name, text, type, uuid) VALUES (1, 'German', 'Karte 4', 'Text 4', 'Creature', 'uuid-4');
INSERT INTO legalities (id, format, status, uuid) VALUES (1, 'Commander', 'Legal', 'uuid-4');
INSERT INTO rulings (id, date, text, uuid) VALUES (1, '2020-02-01', 'Ruling for card 4', 'uuid-4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT artist FROM cards WHERE side IS NULL ORDER BY convertedManaCost DESC, cards.id NULLS LAST LIMIT 1;

/*
Gold Result:
('Correct_Winner_Artist',)
*/

-- Prediction Query
SELECT "artist" FROM "cards" WHERE "side" IS NULL AND "convertedmanacost" = (SELECT MAX("convertedmanacost") FROM "cards" WHERE "side" IS NULL);

/*
Prediction Result:
('Correct_Winner_Artist',)
('A_Wrong_Tie_Breaker',)
*/