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
-- Tests:
-- 1. INNER JOIN vs LEFT JOIN (Artist_No_Legality has 0 legalities, would have COUNT=1 or 0 in LEFT JOIN and win ASC).
-- 2. COUNT(T1.id) vs COUNT(DISTINCT T1.id) (Artist_1Card_3Leg has 1 card but 3 legalities -> COUNT=3; Artist_2Cards_1Leg has 2 cards, 1 legality each -> COUNT=2).
-- 3. ORDER BY COUNT(T1.id) ASC vs DESC (Artist_Many has 4 legalities).
-- 4. LIMIT 1 vs no limit (multiple artist groups exist).
INSERT INTO cards (id, artist, uuid) VALUES (1, 'Artist_No_Legality', 'u1');
INSERT INTO cards (id, artist, uuid) VALUES (2, 'Artist_1Card_3Leg', 'u2');
INSERT INTO cards (id, artist, uuid) VALUES (3, 'Artist_2Cards_1Leg', 'u3');
INSERT INTO cards (id, artist, uuid) VALUES (4, 'Artist_2Cards_1Leg', 'u4');
INSERT INTO cards (id, artist, uuid) VALUES (5, 'Artist_Many', 'u5');
INSERT INTO legalities (id, format, status, uuid) VALUES (1, 'Standard', 'Legal', 'u2');
INSERT INTO legalities (id, format, status, uuid) VALUES (2, 'Modern', 'Legal', 'u2');
INSERT INTO legalities (id, format, status, uuid) VALUES (3, 'Legacy', 'Legal', 'u2');
INSERT INTO legalities (id, format, status, uuid) VALUES (4, 'Vintage', 'Legal', 'u3');
INSERT INTO legalities (id, format, status, uuid) VALUES (5, 'Vintage', 'Legal', 'u4');
INSERT INTO legalities (id, format, status, uuid) VALUES (6, 'Commander', 'Legal', 'u5');
INSERT INTO legalities (id, format, status, uuid) VALUES (7, 'Historic', 'Legal', 'u5');
INSERT INTO legalities (id, format, status, uuid) VALUES (8, 'Pioneer', 'Legal', 'u5');
INSERT INTO legalities (id, format, status, uuid) VALUES (9, 'Brawl', 'Legal', 'u5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.artist, T2.format FROM cards AS T1 INNER JOIN legalities AS T2 ON T2.uuid = T1.uuid GROUP BY T1.artist ORDER BY COUNT(T1.id) ASC, T1.artist NULLS LAST, T2.format NULLS LAST LIMIT 1;

/*
Gold Result:
('Artist_2Cards_1Leg', 'Vintage')
*/

-- Prediction Query
SELECT T1.artist, T3.format FROM cards AS T1 LEFT JOIN foreign_data AS T2 ON T1.uuid = T2.uuid LEFT JOIN legalities AS T3 ON T1.uuid = T3.uuid GROUP BY T1.artist HAVING COUNT(T1.artist) = (SELECT COUNT(artist) FROM cards GROUP BY artist ORDER BY COUNT(artist) ASC LIMIT 1);

/*
Prediction Result:
('Artist_No_Legality', None)
*/