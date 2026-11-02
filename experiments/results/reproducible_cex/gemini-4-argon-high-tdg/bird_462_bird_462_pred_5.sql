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
INSERT INTO sets (id, code, name, mtgoCode, keyruneCode, parentCode) VALUES (10, '10E', 'Tenth Edition', '10E_MTGO', '10E_KR', 'UMA');
INSERT INTO sets (id, code, name, mtgoCode, keyruneCode, parentCode) VALUES (20, 'JUD', 'Judgment', 'JUD_MTGO', 'JUD_KR', 'ODY');
INSERT INTO sets (id, code, name, mtgoCode, keyruneCode, parentCode) VALUES (30, 'UMA', 'Ultimate Masters', 'UMA_MTGO', 'UMA_KR', '10E');
INSERT INTO cards (id, uuid, name, asciiName, faceName, flavorName, setCode) VALUES (1, 'uuid-1', 'Ancestor''s Chosen', 'Ancestors Chosen', 'Other Face', 'Other Flavor', '10E');
INSERT INTO cards (id, uuid, name, asciiName, faceName, flavorName, setCode) VALUES (2, 'uuid-2', 'Wrath of God', 'Ancestor''s Chosen', 'Ancestor''s Chosen', 'Ancestor''s Chosen', 'JUD');
INSERT INTO cards (id, uuid, name, asciiName, faceName, flavorName, setCode) VALUES (3, 'uuid-3', 'Ancestor''s Chosen One', 'Ancestor''s Chosen One', 'Face 3', 'Flavor 3', 'UMA');
INSERT INTO set_translations (id, language, setCode, translation) VALUES (100, 'Italian', '10E', 'Decima Edizione');
INSERT INTO set_translations (id, language, setCode, translation) VALUES (101, 'French', '10E', 'Dixieme Edition');
INSERT INTO set_translations (id, language, setCode, translation) VALUES (102, 'Italian', 'JUD', 'Giudizio');
INSERT INTO set_translations (id, language, setCode, translation) VALUES (103, 'Italian', 'UMA', 'Ultimate Masters IT');
INSERT INTO foreign_data (id, language, name, text, uuid) VALUES (50, 'Italian', 'Prescelto dell''Antenato', 'Testo italiano', 'uuid-1');
INSERT INTO foreign_data (id, language, name, text, uuid) VALUES (51, 'Italian', 'Ancestor''s Chosen', 'Testo due', 'uuid-2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT translation FROM set_translations WHERE setCode IN (SELECT setCode FROM cards WHERE name = 'Ancestor''s Chosen') AND language = 'Italian';

/*
Gold Result:
('Decima Edizione',)
*/

-- Prediction Query
SELECT st.translation FROM cards AS c INNER JOIN sets AS s ON c.printings LIKE '%' || s.code || '%' INNER JOIN set_translations AS st ON s.code = st.setcode WHERE c.name = 'Ancestor''s Chosen' AND st.language = 'Italian';

/*
Prediction Result:
*/