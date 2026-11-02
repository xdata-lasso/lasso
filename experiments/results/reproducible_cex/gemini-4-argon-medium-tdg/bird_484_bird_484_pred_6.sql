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
-- Tests basic filtering (set name 'Coldsnap', language 'Italian'), DESC ordering on convertedManaCost, LIMIT 1, and selecting T2.name vs T1.name/T3.name.
INSERT INTO "sets" (id, code, name) VALUES (1, 'CSP', 'Coldsnap');
INSERT INTO "sets" (id, code, name) VALUES (2, 'ICE', 'Ice Age');
INSERT INTO "cards" (id, uuid, name, setCode, convertedManaCost, faceConvertedManaCost) VALUES (1, 'uuid-1', 'Card Low CMC', 'CSP', 2.0, 20.0);
INSERT INTO "cards" (id, uuid, name, setCode, convertedManaCost, faceConvertedManaCost) VALUES (2, 'uuid-2', 'Card High CMC', 'CSP', 8.0, 1.0);
INSERT INTO "cards" (id, uuid, name, setCode, convertedManaCost, faceConvertedManaCost) VALUES (3, 'uuid-3', 'Card Wrong Set', 'ICE', 15.0, 15.0);
INSERT INTO "cards" (id, uuid, name, setCode, convertedManaCost, faceConvertedManaCost) VALUES (4, 'uuid-4', 'Card Wrong Lang', 'CSP', 12.0, 12.0);
INSERT INTO "cards" (id, uuid, name, setCode, convertedManaCost, faceConvertedManaCost) VALUES (5, 'uuid-5', 'Card No Foreign', 'CSP', 20.0, 20.0);
INSERT INTO "foreign_data" (id, uuid, name, language) VALUES (1, 'uuid-1', 'Italian Low CMC', 'Italian');
INSERT INTO "foreign_data" (id, uuid, name, language) VALUES (2, 'uuid-2', 'Italian High CMC', 'Italian');
INSERT INTO "foreign_data" (id, uuid, name, language) VALUES (3, 'uuid-3', 'Italian Wrong Set', 'Italian');
INSERT INTO "foreign_data" (id, uuid, name, language) VALUES (4, 'uuid-4', 'French High CMC', 'French');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.name FROM foreign_data AS T1 INNER JOIN cards AS T2 ON T2.uuid = T1.uuid INNER JOIN sets AS T3 ON T3.code = T2.setCode WHERE T3.name = 'Coldsnap' AND T1.language = 'Italian' ORDER BY T2.convertedManaCost DESC, T1.id NULLS LAST, T2.id NULLS LAST, T3.id NULLS LAST LIMIT 1;

/*
Gold Result:
('Card High CMC',)
*/

-- Prediction Query
SELECT T3.name AS ItalianTranslatedName FROM cards AS T3 INNER JOIN set_translations AS T4 ON T3.setCode = T4.setCode INNER JOIN sets AS T2 ON T2.code = T4.setCode WHERE T2.name = 'Coldsnap' AND T4.language = 'Italian' ORDER BY T3.convertedManaCost DESC, T3.id NULLS LAST, T4.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Prediction Result:
*/