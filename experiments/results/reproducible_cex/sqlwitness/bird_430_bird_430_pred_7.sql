-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO sets (id, basesetsize, block, booster, code, isfoilonly, isforeignonly, isnonfoilonly, isonlineonly, ispartialpreview, keyrunecode, mcmid, mcmidextras, mcmname, mtgocode, name, parentcode, releasedate, tcgplayergroupid, totalsetsize, type) VALUES (0, NULL, 'default1', 'default1', 'default2', 1, 3, 2, 3, 1, 'default1', 0, 1, 'Shadowmoor', NULL, NULL, 'Italian', '2023-01-02', 0, 0, 'default1'), (2, NULL, NULL, 'Shadowmoor', 'Shadowmoor', 1, 2, 1, 2, 3, 'default1', 0, 0, 'Italian', NULL, 'Italian', 'Italian', '2023-01-01', 1, 0, NULL), (1, 2, 'Shadowmoor', 'default1', 'Italian', 0, 3, 3, 2, 1, 'default2', 0, 3, NULL, 'Shadowmoor', 'Italian', 'Shadowmoor', '2023-01-02', 3, 1, 'Shadowmoor'), (3, 3, 'default2', 'Shadowmoor', 'default1', 0, 2, 0, 0, 0, NULL, NULL, NULL, 'default2', 'Shadowmoor', 'default2', 'default2', NULL, NULL, 0, 'Italian'), (4, NULL, 'default2', 'Italian', 'unique_4', 2, 1, 3, 0, 1, NULL, 1, 3, 'Italian', 'Italian', 'Italian', 'Italian', '2023-01-02', 0, 1, NULL);
INSERT INTO set_translations (id, setcode, language, translation) VALUES (2, 'unique_4', 'Shadowmoor', 'default2'), (1, 'default1', 'Shadowmoor', 'Shadowmoor'), (0, 'default1', NULL, 'Shadowmoor'), (3, 'default1', NULL, 'default1'), (4, 'unique_4', 'Italian', 'default2'), (5, 'default2', NULL, 'Italian'), (6, 'Italian', 'Italian', NULL), (7, 'Italian', 'default2', 'default2'), (8, 'unique_4', 'default1', 'Italian'), (9, 'default2', NULL, 'default2'), (10, 'default2', 'default2', 'default1'), (11, NULL, 'default2', NULL), (12, 'unique_4', 'default2', NULL), (13, 'Shadowmoor', 'default2', 'Shadowmoor');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.name, T1.id FROM sets AS T1 INNER JOIN set_translations AS T2 ON T1.code = T2.setCode WHERE T1.block = 'Shadowmoor' AND T2.language = 'Italian' ORDER BY T1.id, T2.id NULLS LAST LIMIT 2;

/*
Gold Result:
('Italian', 1)
*/

-- Prediction Query
SELECT sets.id, sets.name FROM set_translations INNER JOIN sets ON set_translations.setcode = sets.code WHERE set_translations.language = 'Italian' AND sets.block = 'Shadowmoor' ORDER BY sets.name ASC, set_translations.id NULLS LAST, sets.id NULLS LAST LIMIT 2;

/*
Prediction Result:
(1, 'Italian')
*/