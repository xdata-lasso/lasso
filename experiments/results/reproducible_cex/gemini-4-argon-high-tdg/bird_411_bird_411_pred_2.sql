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
INSERT INTO cards (id, artist, flavorText, name, text, uuid) VALUES (1, 'Artist Alpha', 'English flavor text', 'Alpha Card 1', 'Card rules text', 'uuid-1');
INSERT INTO cards (id, artist, flavorText, name, text, uuid) VALUES (2, 'Artist Alpha', 'Second English flavor', 'Alpha Card 2', 'More rules text', 'uuid-2');
INSERT INTO cards (id, artist, flavorText, name, text, uuid) VALUES (10, 'Wrong Artist ID Join', 'DAS perfekte Gegenmittel zu einer dichten Formation', 'Decoy Card', 'DAS perfekte Gegenmittel zu einer dichten Formation', 'uuid-3');
INSERT INTO foreign_data (id, flavorText, language, multiverseid, name, text, type, uuid) VALUES (10, '"DAS perfekte Gegenmittel zu einer dichten Formation." — General', 'German', 1001, 'Alpha Karte 1 DE', 'German rules', 'Instant', 'uuid-1');
INSERT INTO foreign_data (id, flavorText, language, multiverseid, name, text, type, uuid) VALUES (11, 'DAS perfekte Gegenmittel zu einer dichten Formation', 'French', 1002, 'Alpha Karte 1 FR', 'French rules', 'Instant', 'uuid-1');
INSERT INTO foreign_data (id, flavorText, language, multiverseid, name, text, type, uuid) VALUES (12, 'Prefix DAS perfekte Gegenmittel zu einer dichten Formation Suffix', 'German', 1003, 'Alpha Karte 2 DE', 'German rules 2', 'Sorcery', 'uuid-2');
INSERT INTO foreign_data (id, flavorText, language, multiverseid, name, text, type, uuid) VALUES (1, 'Unrelated foreign flavor text', 'German', 1004, 'Decoy Karte DE', 'DAS perfekte Gegenmittel zu einer dichten Formation', 'Creature', 'uuid-3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.artist FROM cards AS T1 INNER JOIN foreign_data AS T2 ON T1.uuid = T2.uuid WHERE T2.flavorText LIKE '%DAS perfekte Gegenmittel zu einer dichten Formation%';

/*
Gold Result:
('Artist Alpha',)
*/

-- Prediction Query
SELECT "artist" FROM "cards" WHERE "uuid" IN (SELECT "uuid" FROM "foreign_data" WHERE "text" LIKE '%Das perfekte Gegenmittel zu einer dichten Formation%');

/*
Prediction Result:
('Wrong Artist ID Join',)
*/