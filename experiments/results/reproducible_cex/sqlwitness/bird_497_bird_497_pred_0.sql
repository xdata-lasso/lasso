-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO sets (id, basesetsize, block, booster, code, isfoilonly, isforeignonly, isnonfoilonly, isonlineonly, ispartialpreview, keyrunecode, mcmid, mcmidextras, mcmname, mtgocode, name, parentcode, releasedate, tcgplayergroupid, totalsetsize, type) VALUES (0, 1, 'default1', 'default1', 'default1', 0, 0, 1, 1, 0, 'default2', NULL, NULL, 'Huitième édition', NULL, 'default1', 'default2', '2023-01-01', 1, 1, 'default1'), (1, 1, 'Huitième édition', NULL, 'default2', 0, 1, 0, 1, 0, 'Huitième édition', NULL, NULL, NULL, 'default2', 'default2', NULL, '2023-01-01', 1, 0, 'default2'), (2, NULL, NULL, 'Huitième édition', 'Huitième édition', 0, 0, 1, 1, 1, 'default2', 0, 0, 'Huitième édition', 'Huitième édition', 'default1', 'default2', NULL, 0, NULL, 'Huitième édition'), (3, 1, 'Huitième édition', NULL, 'unique_3', 0, 0, 0, 0, 1, 'default1', 1, 1, 'Huitième édition', 'Huitième édition', 'default2', 'default2', '2023-01-02', 0, 0, 'Huitième édition'), (4, NULL, 'default2', 'Huitième édition', 'unique_4', 0, 0, 1, 1, 0, 'Huitième édition', NULL, 0, 'Huitième édition', NULL, 'default1', 'default2', '2023-01-01', 1, 1, 'default2'), (5, 0, 'default2', 'default1', 'unique_5', 1, 1, 0, 1, 1, 'default2', 1, NULL, 'default2', 'Huitième édition', 'default2', 'default2', '2023-01-01', 1, NULL, 'default1'), (6, 1, 'Huitième édition', 'default2', 'unique_6', 0, 1, 1, 0, 0, 'Huitième édition', 1, 0, 'default1', 'Huitième édition', NULL, NULL, NULL, 1, 1, 'Huitième édition'), (7, 0, NULL, 'Huitième édition', 'unique_7', 0, 0, 1, 0, 0, 'Huitième édition', NULL, 1, 'default2', 'default1', 'Huitième édition', 'default2', '2023-01-01', NULL, 0, 'default2'), (8, NULL, 'default1', 'default2', 'unique_8', 1, 1, 1, 0, 1, NULL, NULL, NULL, 'Huitième édition', NULL, 'Huitième édition', NULL, '2023-01-02', 1, 1, 'default2'), (9, NULL, NULL, 'Huitième édition', 'unique_9', 0, 1, 0, 0, 1, 'default2', NULL, NULL, 'Huitième édition', 'default1', 'Huitième édition', 'Huitième édition', '2023-01-02', NULL, 0, 'default1'), (10, NULL, 'Huitième édition', NULL, 'unique_10', 0, 1, 1, 0, 0, 'default1', 0, 1, 'default1', NULL, 'Huitième édition', NULL, '2023-01-02', NULL, NULL, 'default1'), (11, NULL, NULL, 'default1', 'unique_11', 1, 1, 1, 1, 0, 'default2', NULL, 1, 'default2', NULL, NULL, NULL, '2023-01-01', NULL, 1, 'default2'), (12, 0, 'default2', 'Huitième édition', 'unique_12', 0, 1, 1, 0, 1, 'default1', 1, 1, 'default1', NULL, 'default1', 'default1', NULL, 1, 0, 'default2'), (13, NULL, 'Huitième édition', 'default1', 'unique_13', 0, 1, 0, 1, 0, 'default1', 0, NULL, 'Huitième édition', 'default1', 'default2', 'default2', NULL, 0, 0, NULL), (14, NULL, 'Huitième édition', NULL, 'unique_14', 0, 1, 1, 1, 1, 'Huitième édition', 1, NULL, 'Huitième édition', 'Huitième édition', 'default1', NULL, NULL, NULL, 1, 'default2'), (15, NULL, 'default1', 'default2', 'unique_15', 0, 1, 0, 0, 1, 'default2', 1, 0, 'default1', 'default2', 'Huitième édition', 'default2', '2023-01-01', 0, 1, 'default2'), (16, 0, 'default1', NULL, 'unique_16', 1, 0, 1, 1, 0, 'default1', 0, 0, NULL, 'default1', 'default1', 'default1', '2023-01-02', 1, NULL, 'default1'), (17, 1, NULL, 'default2', 'unique_17', 0, 1, 1, 1, 1, 'Huitième édition', 0, 1, 'Huitième édition', NULL, 'default1', NULL, '2023-01-01', 0, 0, 'default1');
INSERT INTO set_translations (id, setcode, language, translation) VALUES (1, 'unique_7', 'Huitième édition', NULL), (0, 'unique_17', 'Huitième édition', 'Huitième édition'), (2, 'unique_11', 'default1', 'default2'), (3, 'Huitième édition', 'Huitième édition', 'default1'), (4, 'unique_10', NULL, 'Huitième édition'), (5, 'unique_5', 'default1', 'default2'), (6, 'unique_5', NULL, NULL), (7, 'unique_13', 'default2', 'Huitième édition'), (8, 'unique_13', NULL, 'default1'), (9, 'unique_4', 'default2', 'default1'), (10, 'unique_6', 'default1', 'Huitième édition'), (11, 'unique_7', 'default2', 'default2'), (12, 'unique_13', 'default2', 'default1'), (13, 'unique_13', 'Huitième édition', 'default1'), (14, 'Huitième édition', 'Huitième édition', NULL), (15, 'unique_13', 'default2', 'default1'), (16, 'unique_15', NULL, 'Huitième édition'), (17, 'unique_12', 'default2', NULL), (18, 'default2', 'Huitième édition', 'Huitième édition'), (19, 'unique_17', NULL, 'Huitième édition'), (20, 'default1', 'Huitième édition', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT type FROM sets WHERE code IN (SELECT setCode FROM set_translations WHERE translation = 'Huitième édition');

/*
Gold Result:
('default2',)
('default1',)
(None,)
('default2',)
('default1',)
('Huitième édition',)
*/

-- Prediction Query
SELECT T1.type FROM sets AS T1 INNER JOIN set_translations AS T2 ON T1.code = T2.setCode WHERE T2.translation = 'Huitième édition';

/*
Prediction Result:
('default1',)
('default1',)
(None,)
('Huitième édition',)
('default2',)
('default2',)
('default1',)
*/