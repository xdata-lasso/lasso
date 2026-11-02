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
INSERT INTO sets (id, code, name) VALUES (1, 'CSP', 'Coldsnap');
INSERT INTO sets (id, code, name) VALUES (2, 'ICE', 'Ice Age');
INSERT INTO cards (id, uuid, name, setCode, convertedManaCost, faceConvertedManaCost, edhrecRank, manaCost) VALUES (1, 'uuid-1', 'Card Low CMC', 'CSP', 2.0, 20.0, 100, '{2}');
INSERT INTO cards (id, uuid, name, setCode, convertedManaCost, faceConvertedManaCost, edhrecRank, manaCost) VALUES (2, 'uuid-2', 'Card Mid CMC', 'CSP', 5.0, 15.0, 50, '{5}');
INSERT INTO cards (id, uuid, name, setCode, convertedManaCost, faceConvertedManaCost, edhrecRank, manaCost) VALUES (3, 'uuid-3', 'Card High CMC', 'CSP', 11.0, 1.0, 10, '{11}');
INSERT INTO cards (id, uuid, name, setCode, convertedManaCost, faceConvertedManaCost, edhrecRank, manaCost) VALUES (4, 'uuid-4', 'Card Wrong Set High CMC', 'ICE', 15.0, 15.0, 1, '{15}');
INSERT INTO cards (id, uuid, name, setCode, convertedManaCost, faceConvertedManaCost, edhrecRank, manaCost) VALUES (5, 'uuid-5', 'Card Wrong Lang High CMC', 'CSP', 14.0, 14.0, 2, '{14}');
INSERT INTO cards (id, uuid, name, setCode, convertedManaCost, faceConvertedManaCost, edhrecRank, manaCost) VALUES (6, 'uuid-6', 'Card No Foreign High CMC', 'CSP', 16.0, 16.0, 3, '{16}');
INSERT INTO foreign_data (id, uuid, language, name) VALUES (1, 'uuid-1', 'Italian', 'Carta Bassa');
INSERT INTO foreign_data (id, uuid, language, name) VALUES (2, 'uuid-2', 'Italian', 'Carta Media');
INSERT INTO foreign_data (id, uuid, language, name) VALUES (3, 'uuid-3', 'Italian', 'Carta Alta');
INSERT INTO foreign_data (id, uuid, language, name) VALUES (4, 'uuid-4', 'Italian', 'Carta Set Sbagliato');
INSERT INTO foreign_data (id, uuid, language, name) VALUES (5, 'uuid-5', 'Spanish', 'Carta Idioma Incorrecto');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.name FROM foreign_data AS T1 INNER JOIN cards AS T2 ON T2.uuid = T1.uuid INNER JOIN sets AS T3 ON T3.code = T2.setCode WHERE T3.name = 'Coldsnap' AND T1.language = 'Italian' ORDER BY T2.convertedManaCost DESC, T1.id NULLS LAST, T2.id NULLS LAST, T3.id NULLS LAST LIMIT 1;

/*
Gold Result:
('Card High CMC',)
*/

-- Prediction Query
SELECT fd.name FROM cards AS c JOIN foreign_data AS fd ON c.uuid = fd.uuid JOIN sets AS s ON c.setCode = s.code WHERE s.name = 'Coldsnap' AND fd.language = 'Italian' AND c.convertedManaCost = (SELECT MAX(convertedManaCost) FROM cards AS c2 JOIN sets AS s2 ON c2.setCode = s2.code WHERE s2.name = 'Coldsnap');

/*
Prediction Result:
*/