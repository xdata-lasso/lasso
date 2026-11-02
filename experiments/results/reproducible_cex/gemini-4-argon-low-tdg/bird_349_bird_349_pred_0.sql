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
INSERT INTO cards (id, uuid, name, artist, isPromo) VALUES (1, 'u1', 'Card A1', 'Artist A', 1);
INSERT INTO cards (id, uuid, name, artist, isPromo) VALUES (2, 'u2', 'Card A2', 'Artist A', 1);
INSERT INTO cards (id, uuid, name, artist, isPromo) VALUES (3, 'u3', 'Card B1', 'Artist B', 1);
INSERT INTO cards (id, uuid, name, artist, isPromo) VALUES (4, 'u4', 'Card C1', 'Artist C', 0);
INSERT INTO cards (id, uuid, name, artist, isPromo) VALUES (5, 'u5', 'Card C2', 'Artist C', 0);
INSERT INTO cards (id, uuid, name, artist, isPromo) VALUES (6, 'u6', 'Card C3', 'Artist C', 0);
INSERT INTO cards (id, uuid, name, artist, isPromo) VALUES (7, 'u7', 'Card D1', 'Artist D', 1);
INSERT INTO cards (id, uuid, name, artist, isPromo) VALUES (8, 'u8', 'Card D2', 'Artist D', 1);
INSERT INTO cards (id, uuid, name, artist, isPromo) VALUES (9, 'u9', 'Card D3', 'Artist D', 1);
INSERT INTO rulings (id, uuid, date, text) VALUES (1, 'u1', '2020-01-01', 'Ruling 1');
INSERT INTO rulings (id, uuid, date, text) VALUES (2, 'u2', '2020-01-02', 'Ruling 2');
INSERT INTO rulings (id, uuid, date, text) VALUES (3, 'u3', '2020-01-03', 'Ruling 3');
INSERT INTO rulings (id, uuid, date, text) VALUES (4, 'u3', '2020-01-04', 'Ruling 4');
INSERT INTO rulings (id, uuid, date, text) VALUES (5, 'u3', '2020-01-05', 'Ruling 5');
INSERT INTO rulings (id, uuid, date, text) VALUES (6, 'u4', '2020-01-06', 'Ruling 6');
INSERT INTO rulings (id, uuid, date, text) VALUES (7, 'u5', '2020-01-07', 'Ruling 7');
INSERT INTO rulings (id, uuid, date, text) VALUES (8, 'u6', '2020-01-08', 'Ruling 8');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.name, T1.artist, T1.isPromo FROM cards AS T1 INNER JOIN rulings AS T2 ON T1.uuid = T2.uuid WHERE T1.isPromo = 1 GROUP BY T1.artist ORDER BY COUNT(DISTINCT T1.uuid) DESC, T1.name NULLS LAST, T1.artist NULLS LAST, T1.isPromo NULLS LAST LIMIT 1;

/*
Gold Result:
('Card A1', 'Artist A', 1)
*/

-- Prediction Query
SELECT T1.name, T1.artist, T1.isPromo FROM cards AS T1 INNER JOIN rulings AS T2 ON T1.uuid = T2.uuid GROUP BY T1.name, T1.artist, T1.isPromo ORDER BY COUNT(T2.uuid) DESC, T1.name NULLS LAST, T1.artist NULLS LAST, T1.isPromo NULLS LAST LIMIT 1;

/*
Prediction Result:
('Card B1', 'Artist B', 1)
*/