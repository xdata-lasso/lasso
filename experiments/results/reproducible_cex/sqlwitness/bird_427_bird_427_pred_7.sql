-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO sets (id, basesetsize, block, booster, code, isfoilonly, isforeignonly, isnonfoilonly, isonlineonly, ispartialpreview, keyrunecode, mcmid, mcmidextras, mcmname, mtgocode, name, parentcode, releasedate, tcgplayergroupid, totalsetsize, type) VALUES (1, NULL, 'Archenemy', 'ARC', 'ARC', 0, 1, 1, 1, 1, NULL, 1, NULL, 'Archenemy', NULL, 'default2', 'default2', NULL, NULL, 1, 'default1'), (0, NULL, NULL, 'default1', 'default2', 0, 1, 1, 1, 1, 'Archenemy', 1, 0, 'ARC', 'default2', 'ARC', 'default2', NULL, 0, 1, 'ARC'), (2, 0, 'default2', NULL, 'Archenemy', 0, 1, 0, 1, 1, 'Archenemy', 0, 0, 'default2', 'Archenemy', 'ARC', 'ARC', '2023-01-01', 0, 0, 'ARC'), (3, 0, 'Archenemy', 'default2', 'default1', 1, 0, 0, 0, 0, 'ARC', 0, 0, NULL, 'ARC', 'Archenemy', 'default1', '2023-01-02', 1, 0, NULL), (4, NULL, 'Archenemy', 'Archenemy', 'unique_4', 1, 0, 1, 1, 0, 'default1', 1, 0, NULL, 'default1', NULL, NULL, '2023-01-02', NULL, 0, 'default2'), (5, 1, 'default1', 'default1', 'unique_5', 0, 0, 1, 1, 0, NULL, NULL, 0, 'default1', 'default1', 'default1', 'Archenemy', '2023-01-01', NULL, 0, 'Archenemy'), (6, 1, NULL, 'ARC', 'unique_6', 1, 0, 0, 0, 0, 'default1', NULL, 1, 'ARC', 'ARC', 'ARC', 'default2', '2023-01-02', 1, 0, 'default1'), (7, 0, 'Archenemy', 'default1', 'unique_7', 1, 0, 0, 1, 0, 'default2', 0, NULL, NULL, 'Archenemy', 'ARC', 'default2', '2023-01-02', NULL, NULL, 'ARC'), (8, 0, 'Archenemy', NULL, 'unique_8', 1, 0, 1, 1, 0, 'ARC', 0, 0, 'Archenemy', 'ARC', 'ARC', 'Archenemy', NULL, 1, 1, 'default1'), (9, 1, 'ARC', 'Archenemy', 'unique_9', 0, 0, 0, 0, 0, 'default2', 0, 1, 'default2', 'default2', 'Archenemy', 'default2', NULL, NULL, NULL, 'ARC'), (10, 1, 'Archenemy', NULL, 'unique_10', 1, 1, 1, 0, 0, 'ARC', 1, 1, 'Archenemy', 'Archenemy', NULL, NULL, NULL, 0, 0, 'default1'), (11, 0, 'default2', 'default2', 'unique_11', 0, 1, 1, 0, 1, 'ARC', NULL, NULL, 'Archenemy', 'Archenemy', 'default2', NULL, '2023-01-02', 1, 0, 'default2'), (12, 1, 'default2', NULL, 'unique_12', 1, 1, 0, 0, 0, 'ARC', NULL, 1, 'default2', 'default1', NULL, NULL, '2023-01-01', NULL, 1, 'default1');
INSERT INTO set_translations (id, setcode, language, translation) VALUES (0, NULL, 'ARC', NULL), (1, 'Archenemy', 'default1', 'default2'), (2, 'unique_10', 'default2', 'default2'), (3, 'default1', 'ARC', NULL), (4, 'default2', 'Archenemy', 'default2'), (5, 'ARC', 'default1', 'Archenemy'), (6, 'default2', 'default1', 'default1'), (7, 'Archenemy', 'default1', 'default1'), (8, 'unique_10', 'default2', 'default2'), (9, 'unique_4', 'Archenemy', 'default1'), (10, 'default1', 'default2', 'default1'), (11, 'unique_10', 'default2', 'Archenemy'), (12, NULL, 'default1', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.language FROM sets AS T1 INNER JOIN set_translations AS T2 ON T1.code = T2.setCode WHERE T1.mcmName = 'Archenemy' AND T2.setCode = 'ARC';

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT T2.translation FROM sets AS T1 INNER JOIN set_translations AS T2 ON T1.code = T2.setCode WHERE T1.name = 'Archenemy' AND T1.code = 'ARC';

/*
Prediction Result:
*/