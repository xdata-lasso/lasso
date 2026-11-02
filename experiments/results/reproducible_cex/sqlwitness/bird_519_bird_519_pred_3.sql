-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO sets (id, basesetsize, block, booster, code, isfoilonly, isforeignonly, isnonfoilonly, isonlineonly, ispartialpreview, keyrunecode, mcmid, mcmidextras, mcmname, mtgocode, name, parentcode, releasedate, tcgplayergroupid, totalsetsize, type) VALUES (1, 1, 'Battlebond', 'Battlebond', 'Battlebond', 1, 1, 1, 0, 0, 'default2', 0, 1, 'Battlebond', 'default1', 'default1', 'default1', '2023-01-02', 0, 0, 'default1'), (0, 0, NULL, 'default2', 'default2', 0, 0, 0, 0, 0, 'Battlebond', NULL, NULL, 'default2', 'default1', NULL, 'default2', NULL, 0, NULL, 'Battlebond'), (2, 1, 'default1', 'default1', 'default1', 1, 1, 0, 0, 1, NULL, 0, 0, NULL, 'default2', 'default2', 'default2', NULL, NULL, 0, 'default1'), (3, 0, 'default1', 'Battlebond', 'unique_3', 0, 1, 0, 0, 1, 'default1', 0, 0, 'Battlebond', 'Battlebond', 'Battlebond', 'default2', '2023-01-01', NULL, NULL, 'Battlebond'), (4, NULL, 'Battlebond', 'default2', 'unique_4', 1, 1, 0, 0, 0, 'default1', NULL, 1, 'default2', 'default2', 'default2', 'Battlebond', '2023-01-01', 0, NULL, 'default2'), (5, 0, NULL, 'Battlebond', 'unique_5', 1, 1, 1, 0, 0, NULL, 1, 0, NULL, 'Battlebond', 'default1', 'default1', '2023-01-02', 0, 0, NULL), (6, 1, 'default1', 'default2', 'unique_6', 1, 0, 1, 0, 1, 'default1', 0, NULL, 'default2', 'default1', NULL, NULL, '2023-01-01', NULL, 0, 'Battlebond'), (7, 0, 'Battlebond', 'default1', 'unique_7', 1, 1, 1, 1, 1, NULL, 1, 1, NULL, 'Battlebond', 'default1', NULL, '2023-01-01', 0, NULL, 'default2'), (8, 0, 'default2', 'default2', 'unique_8', 1, 1, 1, 1, 0, 'Battlebond', 1, 0, 'default1', 'default1', 'default2', 'Battlebond', '2023-01-01', 0, 0, 'default1'), (9, 1, 'Battlebond', NULL, 'unique_9', 1, 0, 0, 1, 1, NULL, 0, 1, 'default1', 'Battlebond', NULL, 'default2', '2023-01-01', 1, 0, 'default2'), (10, NULL, 'default2', 'default2', 'unique_10', 0, 1, 0, 1, 1, NULL, 0, 0, 'default2', NULL, 'default2', 'Battlebond', '2023-01-01', 1, 1, NULL), (11, 0, 'default1', 'default1', 'unique_11', 1, 0, 0, 1, 1, 'default1', NULL, 1, 'Battlebond', NULL, 'Battlebond', 'default2', '2023-01-02', 0, 1, NULL);
INSERT INTO set_translations (id, setcode, language, translation) VALUES (0, 'unique_5', 'default1', 'default1'), (1, 'unique_7', NULL, 'default1'), (2, 'unique_7', NULL, NULL), (3, 'Battlebond', NULL, 'Battlebond'), (4, 'Battlebond', NULL, 'default1'), (5, 'default2', 'default1', 'default1'), (6, 'unique_10', 'default1', NULL), (7, 'unique_4', 'default1', NULL), (8, 'default1', 'Battlebond', 'default2'), (9, 'unique_10', 'Battlebond', 'Battlebond');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT language FROM set_translations WHERE id IN (SELECT id FROM sets WHERE name = 'Battlebond');

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT T2.language FROM sets AS T1 INNER JOIN set_translations AS T2 ON T1.code = T2.setCode WHERE T1.name = 'Battlebond';

/*
Prediction Result:
*/