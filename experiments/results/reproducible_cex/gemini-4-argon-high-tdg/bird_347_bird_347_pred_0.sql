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
INSERT INTO cards (id, uuid, artist, name, text, originalText, flavorText, hasContentWarning, hasAlternativeDeckLimit, hasFoil) VALUES (10, 'uuid-sd-1', 'Stephen Daniele', 'Force Shield', 'Card text for Force Shield', 'Original text 1', 'Flavor text 1', 1, 0, 0);
INSERT INTO cards (id, uuid, artist, name, text, originalText, flavorText, hasContentWarning, hasAlternativeDeckLimit, hasFoil) VALUES (20, 'uuid-sd-2', 'Stephen Daniele', 'Mana Matrix', 'Card text for Mana Matrix', 'Original text 2', 'Flavor text 2', 0, 1, 1);
INSERT INTO cards (id, uuid, artist, name, text, originalText, flavorText, hasContentWarning, hasAlternativeDeckLimit, hasFoil) VALUES (30, 'uuid-other-1', 'Christopher Rush', 'Lightning Bolt', 'Card text for Bolt', 'Original text 3', 'Flavor text 3', 1, 0, 1);
INSERT INTO rulings (id, uuid, date, text) VALUES (10, 'uuid-other-1', '2020-01-01', 'Ruling for Lightning Bolt with id 10');
INSERT INTO rulings (id, uuid, date, text) VALUES (20, 'uuid-other-1', '2020-01-02', 'Ruling for Lightning Bolt with id 20');
INSERT INTO rulings (id, uuid, date, text) VALUES (99, 'uuid-sd-1', '2020-05-01', 'Ruling text for Force Shield');
INSERT INTO rulings (id, uuid, date, text) VALUES (100, 'uuid-sd-2', '2020-06-01', 'Ruling text for Mana Matrix');
INSERT INTO foreign_data (id, uuid, language, name, text, flavorText) VALUES (1, 'uuid-sd-1', 'German', 'Kraftschild', 'Foreign text for Force Shield', 'Foreign flavor 1');
INSERT INTO foreign_data (id, uuid, language, name, text, flavorText) VALUES (2, 'uuid-sd-2', 'French', 'Matrice de mana', 'Foreign text for Mana Matrix', 'Foreign flavor 2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.id, T2.text, T1.hasContentWarning FROM cards AS T1 INNER JOIN rulings AS T2 ON T1.uuid = T2.uuid WHERE T1.artist = 'Stephen Daniele';

/*
Gold Result:
(10, 'Ruling text for Force Shield', 1)
(20, 'Ruling text for Mana Matrix', 0)
*/

-- Prediction Query
SELECT T1.name, T2.text, T1.hasContentWarning FROM cards AS T1 INNER JOIN rulings AS T2 ON T1.uuid = T2.uuid WHERE T1.artist = 'Stephen Daniele';

/*
Prediction Result:
('Force Shield', 'Ruling text for Force Shield', 1)
('Mana Matrix', 'Ruling text for Mana Matrix', 0)
*/