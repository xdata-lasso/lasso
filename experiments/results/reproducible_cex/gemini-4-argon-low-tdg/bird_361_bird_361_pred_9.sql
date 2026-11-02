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
-- 1. Missing DISTINCT (card 10 has two 'Restricted' legalities)
-- 2. Wrong join condition on id instead of uuid (card 10 matches legality id 20, while card 20 is textless)
-- 3. Counting a nullable column like T1.name instead of T1.id
-- 4. Filtering on T1.isTextless = 0 vs = 1 vs missing filter
-- 5. Filtering on T2.status = 'Restricted' vs 'Banned' vs NULL vs case sensitivity ('restricted')
-- 6. INNER JOIN vs LEFT JOIN (card 40 has no legalities)
-- 7. AND vs OR in WHERE clause
INSERT INTO cards (id, uuid, isTextless, name, text) VALUES (10, 'uuid-10', 0, NULL, 'Some card text');
INSERT INTO cards (id, uuid, isTextless, name, text) VALUES (20, 'uuid-20', 1, 'Card Twenty', NULL);
INSERT INTO cards (id, uuid, isTextless, name, text) VALUES (30, 'uuid-30', 0, 'Card Thirty', 'Some text');
INSERT INTO cards (id, uuid, isTextless, name, text) VALUES (40, 'uuid-40', 0, 'Card Forty', 'Some text');
INSERT INTO cards (id, uuid, isTextless, name, text) VALUES (50, 'uuid-50', 0, 'Card Fifty', 'Some text');
INSERT INTO legalities (id, uuid, format, status) VALUES (1, 'uuid-10', 'vintage', 'Restricted');
INSERT INTO legalities (id, uuid, format, status) VALUES (20, 'uuid-10', 'pauper', 'Restricted');
INSERT INTO legalities (id, uuid, format, status) VALUES (10, 'uuid-20', 'vintage', 'Restricted');
INSERT INTO legalities (id, uuid, format, status) VALUES (2, 'uuid-30', 'legacy', 'Banned');
INSERT INTO legalities (id, uuid, format, status) VALUES (3, 'uuid-30', 'modern', NULL);
INSERT INTO legalities (id, uuid, format, status) VALUES (4, 'uuid-50', 'vintage', 'restricted');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.id) FROM cards AS T1 INNER JOIN legalities AS T2 ON T1.uuid = T2.uuid WHERE T2.status = 'Restricted' AND T1.isTextless = 0;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM legalities AS l JOIN cards AS c ON l.uuid = c.uuid WHERE l.status = 'Restricted' AND c.isTextless = 0;

/*
Prediction Result:
(2,)
*/