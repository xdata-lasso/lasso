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
INSERT INTO sets (id, baseSetSize, block, booster, code, isFoilOnly, isForeignOnly, isNonFoilOnly, isOnlineOnly, isPartialPreview, keyruneCode, mcmId, mcmIdExtras, mcmName, mtgoCode, name, parentCode, releaseDate, tcgplayerGroupId, totalSetSize, type) VALUES (1, 50, 'Block_A', 'Booster_A', 'C3', 0, 0, 0, 0, 0, 'KR3', 103, 203, 'M2', NULL, 'D_Set', 'P3', '2020-02-01', 303, 200, 'expansion');
INSERT INTO sets (id, baseSetSize, block, booster, code, isFoilOnly, isForeignOnly, isNonFoilOnly, isOnlineOnly, isPartialPreview, keyruneCode, mcmId, mcmIdExtras, mcmName, mtgoCode, name, parentCode, releaseDate, tcgplayerGroupId, totalSetSize, type) VALUES (2, 30, 'Block_B', 'Booster_B', 'C5', 0, 0, 0, 0, 0, 'KR5', 105, 205, 'M4', NULL, 'A_Set', 'P5', '2020-04-01', 305, 400, 'core');
INSERT INTO sets (id, baseSetSize, block, booster, code, isFoilOnly, isForeignOnly, isNonFoilOnly, isOnlineOnly, isPartialPreview, keyruneCode, mcmId, mcmIdExtras, mcmName, mtgoCode, name, parentCode, releaseDate, tcgplayerGroupId, totalSetSize, type) VALUES (3, 40, 'Block_C', 'Booster_C', 'C1', 0, 0, 0, 0, 0, 'KR1', 101, 201, 'M5', NULL, 'E_Set', 'P1', '2020-01-01', 301, 100, 'masters');
INSERT INTO sets (id, baseSetSize, block, booster, code, isFoilOnly, isForeignOnly, isNonFoilOnly, isOnlineOnly, isPartialPreview, keyruneCode, mcmId, mcmIdExtras, mcmName, mtgoCode, name, parentCode, releaseDate, tcgplayerGroupId, totalSetSize, type) VALUES (4, 10, 'Block_D', 'Booster_D', 'C2', 0, 0, 0, 0, 0, 'KR2', 102, 202, 'M1', NULL, 'C_Set', 'P2', '2020-05-01', 302, 500, 'commander');
INSERT INTO sets (id, baseSetSize, block, booster, code, isFoilOnly, isForeignOnly, isNonFoilOnly, isOnlineOnly, isPartialPreview, keyruneCode, mcmId, mcmIdExtras, mcmName, mtgoCode, name, parentCode, releaseDate, tcgplayerGroupId, totalSetSize, type) VALUES (5, 20, 'Block_E', 'Booster_E', 'C4', 0, 0, 0, 0, 0, 'KR4', 104, 204, 'M3', NULL, 'B_Set', 'P4', '2020-03-01', 304, 300, 'draft_innovation');
INSERT INTO sets (id, baseSetSize, block, booster, code, isFoilOnly, isForeignOnly, isNonFoilOnly, isOnlineOnly, isPartialPreview, keyruneCode, mcmId, mcmIdExtras, mcmName, mtgoCode, name, parentCode, releaseDate, tcgplayerGroupId, totalSetSize, type) VALUES (6, NULL, NULL, NULL, 'C0', 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 'MTGO1', '00_NonNullMtgo', NULL, NULL, NULL, NULL, NULL);
INSERT INTO sets (id, baseSetSize, block, booster, code, isFoilOnly, isForeignOnly, isNonFoilOnly, isOnlineOnly, isPartialPreview, keyruneCode, mcmId, mcmIdExtras, mcmName, mtgoCode, name, parentCode, releaseDate, tcgplayerGroupId, totalSetSize, type) VALUES (7, 15, 'Block_F', 'Booster_F', 'C6', 0, 0, 0, 0, 0, 'KR6', 106, 206, 'M0', '', '01_EmptyMtgo', 'P6', '2019-01-01', 306, 50, 'core');
INSERT INTO sets (id, baseSetSize, block, booster, code, isFoilOnly, isForeignOnly, isNonFoilOnly, isOnlineOnly, isPartialPreview, keyruneCode, mcmId, mcmIdExtras, mcmName, mtgoCode, name, parentCode, releaseDate, tcgplayerGroupId, totalSetSize, type) VALUES (8, 25, 'Block_G', 'Booster_G', 'C7', 0, 0, 0, 0, 0, 'KR7', 107, 207, 'M00', 'NULL', '02_NullStringMtgo', 'P7', '2019-06-01', 307, 60, 'core');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM sets WHERE mtgoCode IS NULL ORDER BY name, sets.id NULLS LAST LIMIT 3;

/*
Gold Result:
('A_Set',)
('B_Set',)
('C_Set',)
*/

-- Prediction Query
SELECT name FROM sets WHERE mtgoCode IS NULL OR mtgoCode = '' ORDER BY name ASC, sets.id NULLS LAST LIMIT 3;

/*
Prediction Result:
('01_EmptyMtgo',)
('A_Set',)
('B_Set',)
*/