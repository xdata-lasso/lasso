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
INSERT INTO cards (id, uuid, name, types, type, layout, borderColor, artist) VALUES (1, 'u1', 'English Name 1', 'Creature', 'Summon — Beast', 'normal', 'black', 'Matthew D. Wilson');
INSERT INTO cards (id, uuid, name, types, type, layout, borderColor, artist) VALUES (2, 'u2', 'English Name 2', 'Enchantment', 'Creature', 'normal', 'black', 'Matthew D. Wilson');
INSERT INTO cards (id, uuid, name, types, type, layout, borderColor, artist) VALUES (3, 'u3', 'English Name 3', 'Creature', 'Creature', 'split', 'black', 'Matthew D. Wilson');
INSERT INTO cards (id, uuid, name, types, type, layout, borderColor, artist) VALUES (4, 'u4', 'English Name 4', 'Creature', 'Creature', 'normal', 'white', 'Matthew D. Wilson');
INSERT INTO cards (id, uuid, name, types, type, layout, borderColor, artist) VALUES (5, 'u5', 'English Name 5', 'Creature', 'Creature', 'normal', 'black', 'Rebecca Guay');
INSERT INTO foreign_data (id, uuid, name, language, type) VALUES (1, 'u1', 'Nom Francais 1', 'French', 'Creature');
INSERT INTO foreign_data (id, uuid, name, language, type) VALUES (2, 'u1', 'Nombre Espanol 1', 'Spanish', 'Creature');
INSERT INTO foreign_data (id, uuid, name, language, type) VALUES (3, 'u2', 'Nom Francais 2', 'French', 'Enchantment');
INSERT INTO foreign_data (id, uuid, name, language, type) VALUES (4, 'u3', 'Nom Francais 3', 'French', 'Creature');
INSERT INTO foreign_data (id, uuid, name, language, type) VALUES (5, 'u4', 'Nom Francais 4', 'French', 'Creature');
INSERT INTO foreign_data (id, uuid, name, language, type) VALUES (6, 'u5', 'Nom Francais 5', 'French', 'Creature');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM foreign_data WHERE uuid IN (SELECT uuid FROM cards WHERE types = 'Creature' AND layout = 'normal' AND borderColor = 'black' AND artist = 'Matthew D. Wilson') AND language = 'French';

/*
Gold Result:
('Nom Francais 1',)
*/

-- Prediction Query
SELECT foreign_data.name FROM cards INNER JOIN foreign_data ON cards.uuid = foreign_data.uuid WHERE cards.type = 'Creature' AND cards.layout = 'normal' AND cards.borderColor = 'black' AND cards.artist = 'Matthew D. Wilson' AND foreign_data.language = 'French';

/*
Prediction Result:
('Nom Francais 2',)
*/