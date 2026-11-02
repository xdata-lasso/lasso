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
INSERT INTO cards (id, uuid, name, manaCost, convertedManaCost, duelDeck) VALUES (1, 'u1', 'Card K', '{1}', 1.0, NULL);
INSERT INTO cards (id, uuid, name, manaCost, convertedManaCost, duelDeck) VALUES (2, 'u2', 'Card J', '{10}', 10.0, NULL);
INSERT INTO cards (id, uuid, name, manaCost, convertedManaCost, duelDeck) VALUES (3, 'u3', 'Card I', '{2}', 2.0, NULL);
INSERT INTO cards (id, uuid, name, manaCost, convertedManaCost, duelDeck) VALUES (4, 'u4', 'Card H', '{3}', 3.0, NULL);
INSERT INTO cards (id, uuid, name, manaCost, convertedManaCost, duelDeck) VALUES (5, 'u5', 'Card G', '{4}', 4.0, NULL);
INSERT INTO cards (id, uuid, name, manaCost, convertedManaCost, duelDeck) VALUES (6, 'u6', 'Card F', '{5}', 5.0, NULL);
INSERT INTO cards (id, uuid, name, manaCost, convertedManaCost, duelDeck) VALUES (7, 'u7', 'Card E', '{6}', 6.0, NULL);
INSERT INTO cards (id, uuid, name, manaCost, convertedManaCost, duelDeck) VALUES (8, 'u8', 'Card D', '{7}', 7.0, NULL);
INSERT INTO cards (id, uuid, name, manaCost, convertedManaCost, duelDeck) VALUES (9, 'u9', 'Card C', '{8}', 8.0, NULL);
INSERT INTO cards (id, uuid, name, manaCost, convertedManaCost, duelDeck) VALUES (10, 'u10', 'Card B', '{8}', 8.0, NULL);
INSERT INTO cards (id, uuid, name, manaCost, convertedManaCost, duelDeck) VALUES (11, 'u11', 'Card A', '{9}', 9.0, NULL);
INSERT INTO cards (id, uuid, name, manaCost, convertedManaCost, duelDeck) VALUES (12, 'u12', 'Card A', '{9}', 9.0, NULL);
INSERT INTO cards (id, uuid, name, manaCost, convertedManaCost, duelDeck) VALUES (13, 'u13', 'Card L', '{0}', 0.0, NULL);
INSERT INTO cards (id, uuid, name, manaCost, convertedManaCost, duelDeck) VALUES (14, 'u14', 'Not Duel Card', '{9}{9}', 18.0, 'duel');
INSERT INTO cards (id, uuid, name, manaCost, convertedManaCost, duelDeck) VALUES (15, 'u15', 'Unlisted Card', '{9}{9}', 18.0, 'duel');
INSERT INTO legalities (id, uuid, format, status) VALUES (1, 'u1', 'duel', 'Legal');
INSERT INTO legalities (id, uuid, format, status) VALUES (2, 'u2', 'duel', 'Banned');
INSERT INTO legalities (id, uuid, format, status) VALUES (3, 'u3', 'duel', 'Restricted');
INSERT INTO legalities (id, uuid, format, status) VALUES (4, 'u4', 'duel', NULL);
INSERT INTO legalities (id, uuid, format, status) VALUES (5, 'u5', 'duel', 'Legal');
INSERT INTO legalities (id, uuid, format, status) VALUES (6, 'u6', 'duel', 'Legal');
INSERT INTO legalities (id, uuid, format, status) VALUES (7, 'u7', 'duel', 'Legal');
INSERT INTO legalities (id, uuid, format, status) VALUES (8, 'u8', 'duel', 'Legal');
INSERT INTO legalities (id, uuid, format, status) VALUES (9, 'u9', 'duel', 'Legal');
INSERT INTO legalities (id, uuid, format, status) VALUES (10, 'u10', 'duel', 'Legal');
INSERT INTO legalities (id, uuid, format, status) VALUES (11, 'u11', 'duel', 'Legal');
INSERT INTO legalities (id, uuid, format, status) VALUES (12, 'u11', 'duel', 'Banned');
INSERT INTO legalities (id, uuid, format, status) VALUES (13, 'u12', 'duel', 'Legal');
INSERT INTO legalities (id, uuid, format, status) VALUES (14, 'u13', 'duel', 'Legal');
INSERT INTO legalities (id, uuid, format, status) VALUES (15, 'u14', 'commander', 'Legal');
INSERT INTO legalities (id, uuid, format, status) VALUES (16, 'u14', 'Duel', 'Legal');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name FROM cards WHERE uuid IN (SELECT uuid FROM legalities WHERE format = 'duel') ORDER BY manaCost DESC, name NULLS LAST LIMIT 10 OFFSET 0;

/*
Gold Result:
('Card A',)
('Card B',)
('Card C',)
('Card D',)
('Card E',)
('Card F',)
('Card G',)
('Card H',)
('Card I',)
('Card K',)
*/

-- Prediction Query
SELECT T1.name FROM cards AS T1 INNER JOIN legalities AS T2 ON T1.uuid = T2.uuid WHERE T2.format = 'duel' AND NOT T1.manaCost IS NULL ORDER BY T1.convertedManaCost DESC, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 10;

/*
Prediction Result:
('Card J',)
('Card A',)
('Card A',)
('Card A',)
('Card C',)
('Card B',)
('Card D',)
('Card E',)
('Card F',)
('Card G',)
*/