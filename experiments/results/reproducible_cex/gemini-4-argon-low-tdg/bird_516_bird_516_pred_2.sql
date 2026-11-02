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
-- Tests basic positive match, multiple foreign_data rows for the same card (testing GROUP BY / DISTINCT),
-- wrong artist, wrong language, NULL values, and cards without foreign_data (testing INNER vs LEFT JOIN).
INSERT INTO cards (id, uuid, artist, name) VALUES (1, 'uuid-1', 'Volkan Baǵa', 'Card One');
INSERT INTO cards (id, uuid, artist, name) VALUES (2, 'uuid-2', 'Volkan Baǵa', 'Card One');
INSERT INTO cards (id, uuid, artist, name) VALUES (3, 'uuid-3', 'Volkan Baǵa', 'Card Three');
INSERT INTO cards (id, uuid, artist, name) VALUES (4, 'uuid-4', 'Volkan Baga', 'Card Four');
INSERT INTO cards (id, uuid, artist, name) VALUES (5, 'uuid-5', 'Other Artist', 'Card Five');
INSERT INTO cards (id, uuid, artist, name) VALUES (6, 'uuid-6', NULL, 'Card Six');
INSERT INTO cards (id, uuid, artist, name) VALUES (7, 'uuid-7', 'Volkan Baǵa', 'Card Seven');
INSERT INTO foreign_data (id, uuid, language, name) VALUES (1, 'uuid-1', 'French', 'Carte Un A');
INSERT INTO foreign_data (id, uuid, language, name) VALUES (2, 'uuid-1', 'French', 'Carte Un B');
INSERT INTO foreign_data (id, uuid, language, name) VALUES (3, 'uuid-1', 'German', 'Karte Eins');
INSERT INTO foreign_data (id, uuid, language, name) VALUES (4, 'uuid-2', 'French', 'Carte Deux');
INSERT INTO foreign_data (id, uuid, language, name) VALUES (5, 'uuid-3', 'German', 'Karte Drei');
INSERT INTO foreign_data (id, uuid, language, name) VALUES (6, 'uuid-3', NULL, 'Carte Null');
INSERT INTO foreign_data (id, uuid, language, name) VALUES (7, 'uuid-4', 'French', 'Carte Quatre');
INSERT INTO foreign_data (id, uuid, language, name) VALUES (8, 'uuid-5', 'French', 'Carte Cinq');
INSERT INTO foreign_data (id, uuid, language, name) VALUES (9, 'uuid-6', 'French', 'Carte Six');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T3.id) FROM (SELECT T1.id FROM cards AS T1 INNER JOIN foreign_data AS T2 ON T2.uuid = T1.uuid WHERE T1.artist = 'Volkan Baǵa' AND T2.language = 'French' GROUP BY T1.id) AS T3;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(*) FROM "cards" AS T1 INNER JOIN "foreign_data" AS T2 ON T1."uuid" = T2."uuid" WHERE T1."artist" = 'Volkan Baǵa' AND T2."language" = 'French';

/*
Prediction Result:
(3,)
*/