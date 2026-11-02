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
INSERT INTO sets (code, name) VALUES ('SET1', 'Set One');
INSERT INTO cards (uuid, artist, manaCost, convertedManaCost, faceConvertedManaCost, edhrecRank, setCode) VALUES ('uuid-1', 'Rob Alexander', '5', 1.0, 2.0, 10, 'SET1');
INSERT INTO cards (uuid, artist, manaCost, convertedManaCost, faceConvertedManaCost, edhrecRank, setCode) VALUES ('uuid-2', 'Rob Alexander', '5', 3.0, 4.0, 20, 'SET1');
INSERT INTO cards (uuid, artist, manaCost, convertedManaCost, faceConvertedManaCost, edhrecRank, setCode) VALUES ('uuid-3', 'Rob Alexander', '12', 8.0, 9.0, 30, 'SET1');
INSERT INTO cards (uuid, artist, manaCost, convertedManaCost, faceConvertedManaCost, edhrecRank, setCode) VALUES ('uuid-4', 'John Avon', '100', 50.0, 50.0, 40, 'SET1');
INSERT INTO cards (uuid, artist, manaCost, convertedManaCost, faceConvertedManaCost, edhrecRank, setCode) VALUES ('uuid-5', 'rob alexander', '200', 60.0, 60.0, 50, 'SET1');
INSERT INTO cards (uuid, artist, manaCost, convertedManaCost, faceConvertedManaCost, edhrecRank, setCode) VALUES ('uuid-6', 'Rob Alexander Jr.', '300', 70.0, 70.0, 60, 'SET1');
INSERT INTO cards (uuid, artist, manaCost, convertedManaCost, faceConvertedManaCost, edhrecRank, setCode) VALUES ('uuid-7', NULL, '400', 80.0, 80.0, 70, 'SET1');
INSERT INTO legalities (uuid, format, status) VALUES ('uuid-1', 'Standard', 'Legal');
INSERT INTO legalities (uuid, format, status) VALUES ('uuid-1', 'Modern', 'Legal');
INSERT INTO rulings (uuid, date, text) VALUES ('uuid-1', '2020-01-01', 'Ruling 1');
INSERT INTO rulings (uuid, date, text) VALUES ('uuid-1', '2020-01-02', 'Ruling 2');
INSERT INTO foreign_data (uuid, language, name) VALUES ('uuid-1', 'German', 'Name 1');
INSERT INTO foreign_data (uuid, language, name) VALUES ('uuid-1', 'French', 'Name 2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(manaCost) FROM cards WHERE artist = 'Rob Alexander';

/*
Gold Result:
(22,)
*/

-- Prediction Query
SELECT SUM(CAST(SUBSTRING(manaCost, 2, INSTR(manaCost, '}') - 2) AS REAL)) AS total_unconverted_mana FROM cards WHERE artist = 'Rob Alexander';

/*
Prediction Result:
(11.0,)
*/