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
INSERT INTO cards (id, uuid, name, types, type, layout, borderColor, artist) VALUES (1, 'uuid-1', 'EngName1', 'Creature', 'Creature — Elf', 'normal', 'black', 'Matthew D. Wilson');
INSERT INTO cards (id, uuid, name, types, type, layout, borderColor, artist) VALUES (2, 'uuid-2', 'EngName2', 'Artifact', 'Creature', 'normal', 'black', 'Matthew D. Wilson');
INSERT INTO cards (id, uuid, name, types, type, layout, borderColor, artist) VALUES (3, 'uuid-3', 'EngName3', 'Creature', 'Creature', 'split', 'black', 'Matthew D. Wilson');
INSERT INTO cards (id, uuid, name, types, type, layout, borderColor, artist) VALUES (4, 'uuid-4', 'EngName4', 'Creature', 'Creature', 'normal', 'white', 'Matthew D. Wilson');
INSERT INTO cards (id, uuid, name, types, type, layout, borderColor, artist) VALUES (5, 'uuid-5', 'EngName5', 'Creature', 'Creature', 'normal', 'black', 'John Avon');
INSERT INTO foreign_data (id, uuid, name, language) VALUES (1, 'uuid-1', 'FrName1', 'French');
INSERT INTO foreign_data (id, uuid, name, language) VALUES (2, 'uuid-1', 'DeName1', 'German');
INSERT INTO foreign_data (id, uuid, name, language) VALUES (3, 'uuid-2', 'FrName2', 'French');
INSERT INTO foreign_data (id, uuid, name, language) VALUES (4, 'uuid-3', 'FrName3', 'French');
INSERT INTO foreign_data (id, uuid, name, language) VALUES (5, 'uuid-4', 'FrName4', 'French');
INSERT INTO foreign_data (id, uuid, name, language) VALUES (6, 'uuid-5', 'FrName5', 'French');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM foreign_data WHERE uuid IN (SELECT uuid FROM cards WHERE types = 'Creature' AND layout = 'normal' AND borderColor = 'black' AND artist = 'Matthew D. Wilson') AND language = 'French';

/*
Gold Result:
('FrName1',)
*/

-- Prediction Query
SELECT foreign_data.name FROM cards INNER JOIN foreign_data ON cards.uuid = foreign_data.uuid WHERE cards.artist = 'Matthew D. Wilson' AND cards.borderColor = 'black' AND cards.layout = 'normal' AND foreign_data.language = 'French';

/*
Prediction Result:
('FrName1',)
('FrName2',)
*/