-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
-- Tests multiple matching rows and duplicate IDs/names to kill DISTINCT mutants, MAX/MIN/AVG mutants, and Join-multiplying mutants.
-- Gold query returns 3.
INSERT INTO sets (code, name) VALUES ('SET1', 'Set One');
INSERT INTO cards (uuid, artist, cardKingdomFoilId, cardKingdomId, hasFoil, hasNonFoil, name, setCode) VALUES ('u3-1', 'Aaron Miller', 'foil-dup', 'id-dup', 0, 0, 'Duplicate Card', 'SET1');
INSERT INTO cards (uuid, artist, cardKingdomFoilId, cardKingdomId, hasFoil, hasNonFoil, name, setCode) VALUES ('u3-2', 'Aaron Miller', 'foil-dup', 'id-dup', 0, 0, 'Duplicate Card', 'SET1');
INSERT INTO cards (uuid, artist, cardKingdomFoilId, cardKingdomId, hasFoil, hasNonFoil, name, setCode) VALUES ('u3-3', 'Aaron Miller', 'foil-unique', 'id-unique', 1, 1, 'Unique Card', 'SET1');
INSERT INTO cards (uuid, artist, cardKingdomFoilId, cardKingdomId, hasFoil, hasNonFoil, name, setCode) VALUES ('u3-4', 'Aaron Miller', 'foil-only', NULL, 1, 1, 'Foil Only Card', 'SET1');
INSERT INTO cards (uuid, artist, cardKingdomFoilId, cardKingdomId, hasFoil, hasNonFoil, name, setCode) VALUES ('u3-5', 'Aaron Miller', NULL, 'id-only', 1, 1, 'NonFoil Only Card', 'SET1');
INSERT INTO cards (uuid, artist, cardKingdomFoilId, cardKingdomId, hasFoil, hasNonFoil, name, setCode) VALUES ('u3-6', 'John Avon', 'foil-3', 'id-3', 1, 1, 'Other Artist Card', 'SET1');
INSERT INTO legalities (uuid, format, status) VALUES ('u3-1', 'Standard', 'Legal');
INSERT INTO legalities (uuid, format, status) VALUES ('u3-1', 'Modern', 'Legal');
INSERT INTO rulings (uuid, date, text) VALUES ('u3-1', '2020-01-01', 'Ruling 1');
INSERT INTO rulings (uuid, date, text) VALUES ('u3-1', '2020-01-02', 'Ruling 2');
INSERT INTO foreign_data (uuid, language, name) VALUES ('u3-1', 'German', 'Deutscher Name');
INSERT INTO foreign_data (uuid, language, name) VALUES ('u3-1', 'French', 'Nom Francais');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(CASE WHEN artist = 'Aaron Miller' AND NOT cardKingdomFoilId IS NULL AND NOT cardKingdomId IS NULL THEN 1 ELSE 0 END) FROM cards;

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM cards WHERE artist = 'Aaron Miller' AND cardKingdomFoilId = cardKingdomId AND NOT cardKingdomId IS NULL;

/*
Prediction Result:
(0,)
*/