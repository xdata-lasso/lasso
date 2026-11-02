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
INSERT INTO cards (id, artist, text, hasContentWarning, hasAlternativeDeckLimit, uuid) VALUES (1, 'Stephen Daniele', 'Card Oracle Text 1', 1, 0, 'uuid-1');
INSERT INTO cards (id, artist, text, hasContentWarning, hasAlternativeDeckLimit, uuid) VALUES (2, 'Stephen Daniele', 'Card Oracle Text 2', 0, 1, 'uuid-2');
INSERT INTO cards (id, artist, text, hasContentWarning, hasAlternativeDeckLimit, uuid) VALUES (3, 'Stephen Daniele', 'Card Oracle Text 3', 1, 0, 'uuid-3');
INSERT INTO cards (id, artist, text, hasContentWarning, hasAlternativeDeckLimit, uuid) VALUES (4, 'Other Artist', 'Card Oracle Text 4', 1, 0, 'uuid-4');
INSERT INTO cards (id, artist, text, hasContentWarning, hasAlternativeDeckLimit, uuid) VALUES (5, NULL, 'Card Oracle Text 5', 0, 0, 'uuid-5');
INSERT INTO rulings (id, date, text, uuid) VALUES (10, '2020-01-01', 'Ruling Text A', 'uuid-1');
INSERT INTO rulings (id, date, text, uuid) VALUES (11, '2020-01-02', 'Ruling Text A', 'uuid-1');
INSERT INTO rulings (id, date, text, uuid) VALUES (12, '2020-01-03', 'Ruling Text B', 'uuid-2');
INSERT INTO rulings (id, date, text, uuid) VALUES (13, '2020-01-04', 'Ruling Text C', 'uuid-4');
INSERT INTO rulings (id, date, text, uuid) VALUES (14, '2020-01-05', 'Ruling Text D', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.id, T2.text, T1.hasContentWarning FROM cards AS T1 INNER JOIN rulings AS T2 ON T1.uuid = T2.uuid WHERE T1.artist = 'Stephen Daniele';

/*
Gold Result:
(1, 'Ruling Text A', 1)
(1, 'Ruling Text A', 1)
(2, 'Ruling Text B', 0)
*/

-- Prediction Query
SELECT T1.name, T2.text, T1.hasContentWarning FROM cards AS T1 INNER JOIN rulings AS T2 ON T1.uuid = T2.uuid WHERE T1.artist = 'Stephen Daniele';

/*
Prediction Result:
(None, 'Ruling Text A', 1)
(None, 'Ruling Text A', 1)
(None, 'Ruling Text B', 0)
*/