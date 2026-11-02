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
-- Tests COUNT(DISTINCT T1.uuid) vs COUNT(*), INNER JOIN vs LEFT JOIN, and WHERE T1.isPromo = 1 vs 0/NULL
INSERT INTO cards (id, name, artist, isPromo, uuid) VALUES (1, 'Card A', 'Artist 1', 1, 'u1');
INSERT INTO cards (id, name, artist, isPromo, uuid) VALUES (2, 'Card B', 'Artist 2', 1, 'u2');
INSERT INTO cards (id, name, artist, isPromo, uuid) VALUES (3, 'Card B', 'Artist 2', 1, 'u3');
INSERT INTO cards (id, name, artist, isPromo, uuid) VALUES (4, 'Card C', 'Artist 3', 1, 'u4');
INSERT INTO cards (id, name, artist, isPromo, uuid) VALUES (5, 'Card C', 'Artist 3', 1, 'u5');
INSERT INTO cards (id, name, artist, isPromo, uuid) VALUES (6, 'Card C', 'Artist 3', 1, 'u6');
INSERT INTO cards (id, name, artist, isPromo, uuid) VALUES (7, 'Card D', 'Artist 4', 0, 'u7');
INSERT INTO cards (id, name, artist, isPromo, uuid) VALUES (8, 'Card D', 'Artist 4', 0, 'u8');
INSERT INTO cards (id, name, artist, isPromo, uuid) VALUES (9, 'Card D', 'Artist 4', 0, 'u9');
INSERT INTO rulings (id, date, text, uuid) VALUES (1, '2020-01-01', 'Ruling 1', 'u1');
INSERT INTO rulings (id, date, text, uuid) VALUES (2, '2020-01-02', 'Ruling 2', 'u1');
INSERT INTO rulings (id, date, text, uuid) VALUES (3, '2020-01-03', 'Ruling 3', 'u1');
INSERT INTO rulings (id, date, text, uuid) VALUES (4, '2020-01-04', 'Ruling 4', 'u1');
INSERT INTO rulings (id, date, text, uuid) VALUES (5, '2020-01-01', 'Ruling 1', 'u2');
INSERT INTO rulings (id, date, text, uuid) VALUES (6, '2020-01-01', 'Ruling 1', 'u3');
INSERT INTO rulings (id, date, text, uuid) VALUES (7, '2020-01-01', 'Ruling 1', 'u7');
INSERT INTO rulings (id, date, text, uuid) VALUES (8, '2020-01-01', 'Ruling 1', 'u8');
INSERT INTO rulings (id, date, text, uuid) VALUES (9, '2020-01-01', 'Ruling 1', 'u9');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.name, T1.artist, T1.isPromo FROM cards AS T1 INNER JOIN rulings AS T2 ON T1.uuid = T2.uuid WHERE T1.isPromo = 1 GROUP BY T1.artist ORDER BY COUNT(DISTINCT T1.uuid) DESC, T1.name NULLS LAST, T1.artist NULLS LAST, T1.isPromo NULLS LAST LIMIT 1;

/*
Gold Result:
('Card B', 'Artist 2', 1)
*/

-- Prediction Query
SELECT T2.name, T2.artist, T2.isPromo FROM rulings AS T1 INNER JOIN cards AS T2 ON T1.uuid = T2.uuid GROUP BY T2.uuid ORDER BY COUNT(T1.uuid) DESC, T2.name NULLS LAST, T2.artist NULLS LAST, T2.isPromo NULLS LAST LIMIT 1;

/*
Prediction Result:
('Card A', 'Artist 1', 1)
*/